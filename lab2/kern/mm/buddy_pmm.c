#include <defs.h>
#include <list.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <pmm.h>
#include "buddy_pmm.h"

/* 一个可以变长的结构体，longest 实际大小为 2 * size - 1 */
struct buddy {
    unsigned size;          /* 管理的页面单元（必须是 2 的幂） */
    /* 注意：实际分配时，我们把 enough space 放在 managed region 前端；
       这里保留 1 个元素作为占位，真实大小为 (2*size -1) */
    unsigned longest[1];
};

#define LEFT(i)  ((i) * 2 + 1)
#define RIGHT(i) ((i) * 2 + 2)
#define PARENT(i) (((i) + 1) / 2 - 1)
#define MAX(a,b) (( (a) > (b) ) ? (a) : (b))
#define IS_POWER_OF_2(x) (((x) & ((x) - 1)) == 0)

static unsigned next_pow2(unsigned x) {
    if (x == 0) return 1;
    unsigned p = 1;
    while (p < x) p <<= 1;
    return p;
}
static unsigned fixsize(unsigned size) {
    return next_pow2(size);
}

/* 辅助函数：将 struct Page* 转换为该页框的内核虚拟地址 */
static inline void *page2kva_for_page(struct Page *page) {
    return (void *)(page2pa(page) + va_pa_offset);
}

/* -------- 全局状态（单区域实现） -------- */
static struct buddy *global_buddy = NULL;      /* 指向 metadata 的虚拟地址（位于 managed region 前端） */
static struct Page *buddy_meta_page = NULL;     /* metadata 起始 struct Page*（位于 base）*/
static struct Page *buddy_base_page = NULL;     /* 管理区的第一个可分配页面（base + meta_pages） */
static unsigned managed_npages = 0;             /* 实际被管理的可分配页数量（不含 meta pages） */
static unsigned buddy_size = 0;                 /* 内部 buddy size（2 的幂） */
static unsigned nr_free_pages_buddy = 0;        /* 当前 free 页数量 */

static void buddy_init(void) {
    global_buddy = NULL;
    buddy_meta_page = NULL;
    buddy_base_page = NULL;
    managed_npages = 0;
    buddy_size = 0;
    nr_free_pages_buddy = 0;
}

    /* 
    我们将伙伴系统的元数据存储在 'base' 内存区域的前 npages 个页面中。
    内存布局：
    base [0 .. meta_pages-1] => 用于存储 struct buddy 结构体和 longest 数组
    base [meta_pages .. meta_pages+managed_npages-1] => 实际被管理的可分配页面
    */

static void buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    if (global_buddy) {
        panic("buddy_pmm: init_memmap called more than once not supported\n");
    }

    unsigned total_pages = (unsigned)n;

    // 找到合适的 meta_pages 和 buddy_size
    size_t chosen_meta_pages = 0;
    unsigned chosen_buddy_size = 0;
    for (size_t meta = 1; meta < total_pages; ++meta) {
        unsigned managed = total_pages - (unsigned)meta;
        if (managed == 0) continue;
        unsigned bsize = fixsize(managed); // 向上取 2 的幂
        size_t nodes = 2 * (size_t)bsize - 1;
        size_t bytes = sizeof(struct buddy) + (nodes - 1) * sizeof(unsigned);
        size_t pages_needed = (bytes + PGSIZE - 1) / PGSIZE;
        if (pages_needed <= meta) {
            chosen_meta_pages = meta;
            chosen_buddy_size = bsize;
            break;
        }
    }

    if (!chosen_meta_pages) {
        panic("buddy_pmm: insufficient memory for metadata (total_pages=%u)\n", total_pages);
    }

    size_t meta_pages = chosen_meta_pages;
    buddy_meta_page = base;
    buddy_base_page = base + meta_pages;
    managed_npages = total_pages - (unsigned)meta_pages;
    buddy_size = chosen_buddy_size;

    // 清零 metadata 页并标记保留
    void *meta_kva = page2kva_for_page(buddy_meta_page);
    memset(meta_kva, 0, meta_pages * PGSIZE);
    for (size_t i = 0; i < meta_pages; ++i) {
        struct Page *mp = buddy_meta_page + i;
        SetPageReserved(mp);
        set_page_ref(mp, 0);
        ClearPageProperty(mp);
    }

    // 构建 buddy 树
    size_t node_count = 2 * (size_t)buddy_size - 1;
    global_buddy = (struct buddy *)meta_kva;
    global_buddy->size = buddy_size;

    size_t leaf_start = buddy_size - 1;
    // 初始化叶子节点
    for (unsigned i = 0; i < buddy_size; ++i) {
        unsigned idx = (unsigned)(leaf_start + i);
        if (i < managed_npages)
            global_buddy->longest[idx] = 1; // 可分配
        else
            global_buddy->longest[idx] = 0; // 超出管理范围
    }

    // 从叶子向上初始化内部节点，longest表示最大连续可分配页数
    for (int idx = (int)leaf_start - 1; idx >= 0; --idx) {
        unsigned l = LEFT(idx);
        unsigned r = RIGHT(idx);
        unsigned left_longest = global_buddy->longest[l];
        unsigned right_longest = global_buddy->longest[r];

        if (left_longest == right_longest)
            global_buddy->longest[idx] = left_longest * 2; // 两个 buddy 连续，可合并
        else
            global_buddy->longest[idx] = MAX(left_longest, right_longest); // 不能合并，只能取最大连续块
    }

    // 初始化可分配区域的每个页面状态
    for (struct Page *p = buddy_base_page; p < buddy_base_page + managed_npages; ++p) {
        p->flags = 0;
        set_page_ref(p, 0);
        ClearPageProperty(p);
    }

    buddy_base_page->property = managed_npages;
    SetPageProperty(buddy_base_page);
    nr_free_pages_buddy = managed_npages;

    cprintf("buddy_pmm: init_memmap ok: total_pages=%u meta_pages=%u managed=%u buddy_size=%u\n",
            total_pages, (unsigned)meta_pages, managed_npages, buddy_size);
}

    /* 内部的伙伴分配 / 释放操作在内存中的最长块树（longest tree）上进行
    以页为单位进行操作
    分配一个 2 的幂大小的块（以页为单位）
    返回相对于伙伴管理基地址的偏移量（以页为单位），失败时返回 - 1
    */

static int buddy_alloc_block(struct buddy *b, unsigned need) {
    if (!b) return -1;
    if (need == 0) return -1;
    if (!IS_POWER_OF_2(need)) need = fixsize(need);
    unsigned idx = 0;
    unsigned node_size = b->size;
    if (b->longest[idx] < need) return -1;
    /* 向下遍历二叉树，寻找合适的内存块 */
    while (node_size != need) {
        unsigned l = LEFT(idx);
        if (b->longest[l] >= need)
            idx = l;
        else
            idx = RIGHT(idx);
        node_size /= 2;
    }
  
    b->longest[idx] = 0;
    /* 计算偏移量：(索引 + 1)* 节点大小 - 总大小 */
    unsigned offset = (idx + 1) * node_size - b->size;
    /* 更新祖先节点 */
    while (idx) {
        idx = PARENT(idx);
        b->longest[idx] = MAX(b->longest[LEFT(idx)], b->longest[RIGHT(idx)]);
    }
    return (int)offset;
}

/* 释放位于偏移量处的块（相对于管理基地址） */
static void buddy_free_block(struct buddy *b, unsigned offset) {
    assert(b && offset < b->size);
    unsigned idx = offset + b->size - 1;
    unsigned node_size = 1;
    /* 找到 longest 字段为 0 的节点索引（即已分配的节点），每向上遍历一层就将节点大小（node_size）乘以 2 */
    for (; b->longest[idx] != 0; idx = PARENT(idx)) {
        node_size *= 2;
        if (idx == 0) return; /* 已处于空闲状态或数据已损坏 */
    }
    b->longest[idx] = node_size;

    while (idx) {
        idx = PARENT(idx);
        node_size *= 2;
        unsigned left = b->longest[LEFT(idx)];
        unsigned right = b->longest[RIGHT(idx)];
        if (left + right == node_size)
            b->longest[idx] = node_size;
        else
            b->longest[idx] = MAX(left, right);
    }
}

/* 物理内存管理器接口封装 ：将伙伴系统的内部操作适配为内核统一的PMM接口*/
/* 分配连续的 n 个页面。注意：会向上取整为 2 的幂并分配相应数量的页面 */
static struct Page *buddy_alloc_pages(size_t n) {
    if (!global_buddy || n == 0) return NULL;
    if ((unsigned)n > nr_free_pages_buddy) return NULL;

    unsigned need = (unsigned)n;
    unsigned unit = IS_POWER_OF_2(need) ? need : fixsize(need);

    int off = buddy_alloc_block(global_buddy, unit);
    if (off < 0) return NULL;

    /* 分配的页面范围是 buddy_base_page + off 到 buddy_base_page + off + unit - 1 */
    struct Page *p = buddy_base_page + (unsigned)off;
    /* 标记页面为保留状态，并清除属性和引用计数 */
    for (unsigned i = 0; i < unit; ++i) {
        struct Page *q = p + i;
        ClearPageProperty(q);
        SetPageReserved(q);
        set_page_ref(q, 0);
    }
    nr_free_pages_buddy -= unit;
    return p;
}

/* 释放页面：base 是之前由 alloc_pages 返回的 struct Page* 指针 */
static void buddy_free_pages(struct Page *base, size_t n) {
    assert(base != NULL && global_buddy != NULL);
    /* 计算相对于 buddy_base_page 的偏移量 */
    unsigned offset = (unsigned)(base - buddy_base_page);
    assert(offset < buddy_size);

    /* 从索引 = offset + size - 1 开始查找已分配的节点 */
    unsigned idx = offset + global_buddy->size - 1;
    unsigned node_size = 1;
    for (; idx < (2 * global_buddy->size - 1) && global_buddy->longest[idx] != 0; idx = PARENT(idx)) {
        node_size *= 2;
        if (idx == 0) {
            panic("buddy_pmm: free_pages: cannot find allocated node for offset %u\n", offset);
            return;
        }
    }
    /* node_size 是已分配块的页数 /
    / 标记页面为空闲（清除保留状态） */
    struct Page *p = base;
    for (unsigned i = 0; i < node_size; ++i) {
        struct Page *q = p + i;
        ClearPageReserved(q);
        set_page_ref(q, 0);
        /* 清除页面属性（ClearPageProperty (q)）的操作将在下方针对头部页面处理 */
    }
    /* 标记头部页面的属性 */
    p->property = node_size;
    SetPageProperty(p);

    /* 更新伙伴树 */
    buddy_free_block(global_buddy, offset);

    nr_free_pages_buddy += node_size;
}

/* 空闲页数量 */
static size_t buddy_nr_free_pages(void) {
    return (size_t)nr_free_pages_buddy;
}

static void buddy_check(void) {
    if (!global_buddy) {
        cprintf("buddy_pmm: not initialized, skip check\n");
        return;
    }

    unsigned old_free = nr_free_pages_buddy;
    int failed = 0;

    cprintf("buddy_pmm: starting full check, free pages=%u\n", old_free);

    /* ---------- 3.1 基础功能测试 ---------- */
    cprintf("Test 1: 基础功能测试\n");

    // 单页分配与释放
    struct Page *p1 = buddy_alloc_pages(1);
    if (!p1) {
        cprintf("Failed: single page allocation returned NULL\n");
        failed = 1;
    } else if (nr_free_pages_buddy != old_free - 1) {
        cprintf("Failed: single page free count mismatch\n");
        failed = 1;
    } else {
        buddy_free_pages(p1, 1);
        if (nr_free_pages_buddy != old_free) {
            cprintf("Failed: single page free did not restore count\n");
            failed = 1;
        } else {
            cprintf("单页分配与释放测试通过\n");
        }
    }

    // 多页分配与释放
    unsigned pages[] = {2, 4, 8};
    for (int i = 0; i < 3; ++i) {
        unsigned n = pages[i];
        struct Page *p = buddy_alloc_pages(n);
        if (!p) {
            cprintf("Failed: allocation of %u pages returned NULL\n", n);
            failed = 1;
        } else if (nr_free_pages_buddy != old_free - n) {
            cprintf("Failed: allocation of %u pages free count mismatch\n", n);
            failed = 1;
        }
        buddy_free_pages(p, n);
        if (nr_free_pages_buddy != old_free) {
            cprintf("Failed: free of %u pages did not restore count\n", n);
            failed = 1;
        }
    }
    cprintf("多页分配与释放测试通过\n");

    // 非 2 的幂分配
    struct Page *p3 = buddy_alloc_pages(3); // 应向上取整 4
    if (!p3) {
        cprintf("Failed: allocation of 3 pages returned NULL\n");
        failed = 1;
    } else if (nr_free_pages_buddy != old_free - 4) {
        cprintf("Failed: allocation of 3 pages (rounded) free count mismatch\n");
        failed = 1;
    }
    buddy_free_pages(p3, 3);
    if (nr_free_pages_buddy != old_free) {
        cprintf("Failed: free of 3 pages did not restore count\n");
        failed = 1;
    }
    cprintf("非 2 的幂分配测试通过\n");

    /* ---------- 3.2 边界条件测试 ---------- */
    cprintf("Test 2: 边界条件测试\n");

    // 零页分配
    struct Page *pz = buddy_alloc_pages(0);
    if (pz != NULL) {
        cprintf("Failed: zero page allocation should return NULL\n");
        failed = 1;
    }

    // 超出可用页
    struct Page *po = buddy_alloc_pages(managed_npages + 1);
    if (po != NULL) {
        cprintf("Failed: over-allocation should return NULL\n");
        failed = 1;
    }
    cprintf("边界条件测试通过\n");

    /* ---------- 3.3 合并逻辑验证 ---------- */
    cprintf("Test 3: 合并逻辑验证\n");

    // 左右 buddy 合并
    struct Page *x = buddy_alloc_pages(2);
    struct Page *y = buddy_alloc_pages(2);
    buddy_free_pages(x, 2); // free first
    buddy_free_pages(y, 2); // free second, should merge
    if (nr_free_pages_buddy != old_free) {
        cprintf("Failed: buddy merge free count mismatch\n");
        failed = 1;
    }

    // 分配小块，释放非连续块
    struct Page *s[4];
    for (int i = 0; i < 4; ++i) s[i] = buddy_alloc_pages(1);
    buddy_free_pages(s[1], 1);
    buddy_free_pages(s[3], 1);
    // 释放两个非连续块，nr_free_pages_buddy 应该增加 2
    size_t expected_free = old_free - 4 + 2; 
    if (nr_free_pages_buddy != expected_free) {
        cprintf("Failed: non-contiguous free merge mismatch\n");
        failed = 1;
    } else {
        cprintf("合并逻辑验证通过\n");
    }
    // 释放剩余
    buddy_free_pages(s[0], 1);
    buddy_free_pages(s[2], 1);

    /* ---------- 结果总结 ---------- */
    if (failed) {
        panic("buddy_pmm: full check failed!");
    } else {
        cprintf("buddy_pmm: all tests passed, free pages=%u\n", nr_free_pages_buddy);
    }
}

/* exported manager */
const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
