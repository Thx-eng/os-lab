#include <defs.h>
#include <list.h>
#include <pmm.h>
#include <stdio.h>
#include <string.h>
#include <slub.h>
#include <mmu.h>
#include <assert.h>

// Slab的元数据，存放在每个Slab页的起始位置
struct slab_meta {
    struct kmem_cache *cache; // 指向该Slab所属的缓存池
    void *freelist;           // Slab内空闲对象的链表头
    size_t inuse;             // 已分配对象数量
    list_entry_t slab_link;   // 用于链接到cache的链表节点
};

// 描述一类特定大小对象的缓存池
struct kmem_cache {
    const char *name;
    size_t obj_size;
    size_t obj_per_slab;
    size_t slab_pages; // 为简化，我们总是设为1

    list_entry_t slabs_full;
    list_entry_t slabs_partial;
    list_entry_t slabs_free;
};

// 将page结构体转换为内核虚拟地址
// PADDR(kva) = kva - va_pa_offset  => kva = pa + va_pa_offset
static void *page_to_kva(struct Page *page) {
    return (void *)(page2pa(page) + va_pa_offset);
}

// ---------- kmalloc 通用缓存池定义 ----------
#define KMALLOC_MIN_SIZE 8
#define KMALLOC_MAX_SIZE 4096
#define CACHE_COUNT 10 // 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096

static struct kmem_cache g_kmalloc_caches[CACHE_COUNT];
static char *cache_names[CACHE_COUNT] = {
    "kmalloc-8", "kmalloc-16", "kmalloc-32", "kmalloc-64", "kmalloc-128",
    "kmalloc-256", "kmalloc-512", "kmalloc-1024", "kmalloc-2048", "kmalloc-4096"
};
static bool slub_inited = false;

// ---------- 内部辅助函数 ----------

// 初始化一个kmem_cache
static void kmem_cache_init(struct kmem_cache *cache, const char *name, size_t size) {
    cache->name = name;
    cache->obj_size = size;
    cache->slab_pages = 1; // 简化实现，每个slab就是一个物理页
    // 计算每个slab能放多少个对象
    cache->obj_per_slab = (PGSIZE - sizeof(struct slab_meta)) / size;
    list_init(&(cache->slabs_full));
    list_init(&(cache->slabs_partial));
    list_init(&(cache->slabs_free));
}

// 为一个kmem_cache分配并初始化一个新的slab
static bool kmem_cache_grow(struct kmem_cache *cache) {
    // 1. 从底层PMM申请一个物理页
    struct Page *page = alloc_page();
    if (page == NULL) {
        cprintf("kmem_cache_grow: failed to alloc page\n");
        return false;
    }

    // 2. 获取该页的内核虚拟地址
    void *kva = page_to_kva(page);
    
    // 3. 在页的头部设置slab_meta
    struct slab_meta *meta = (struct slab_meta *)kva;
    meta->cache = cache;
    meta->inuse = 0;
    meta->freelist = NULL;

    // 4. 将页的剩余部分格式化为空闲对象链表
    void *obj_start = (void *)(meta + 1);
    for (int i = 0; i < cache->obj_per_slab; ++i) {
        void *obj = obj_start + i * cache->obj_size;
        // 将obj的头部当做next指针
        *((void **)obj) = meta->freelist;
        meta->freelist = obj;
    }

    // 5. 将新的slab加入cache的空闲链表
    list_add(&(cache->slabs_free), &(meta->slab_link));
    return true;
}

// ---------- SLUB 对外接口实现 ----------

void slub_init(void) {
    size_t size = KMALLOC_MIN_SIZE;
    for (int i = 0; i < CACHE_COUNT; ++i) {
        kmem_cache_init(&g_kmalloc_caches[i], cache_names[i], size);
        size *= 2;
    }
    slub_inited = true;
    cprintf("slub_init: SLUB allocator initialized.\n");
}

void *kmalloc(size_t size) {
    if (!slub_inited || size == 0) return NULL;

    // 1. 根据size找到最合适的cache
    struct kmem_cache *cache = NULL;
    size_t current_size = KMALLOC_MIN_SIZE;
    for (int i = 0; i < CACHE_COUNT; ++i) {
        if (size <= current_size) {
            cache = &g_kmalloc_caches[i];
            break;
        }
        current_size *= 2;
    }
    if (cache == NULL) { // 请求的size太大了
        cprintf("kmalloc: requested size %d too large.\n", size);
        return NULL;
    }

    // 2. 寻找可用的slab
    list_entry_t *le = NULL;
    if (!list_empty(&(cache->slabs_partial))) {
        le = list_next(&(cache->slabs_partial));
    } else {
        if (list_empty(&(cache->slabs_free))) {
            // 没有空闲slab了，需要创建一个新的
            if (!kmem_cache_grow(cache)) {
                return NULL;
            }
        }
        // 从空闲链表取一个
        le = list_next(&(cache->slabs_free));
    }

    // 3. 从slab中分配一个对象
    struct slab_meta *meta = to_struct(le, struct slab_meta, slab_link);
    void *obj = meta->freelist;
    meta->freelist = *((void **)obj); // 更新freelist指针
    meta->inuse++;

    // 4. 更新slab所在的链表
    list_del(le);
    if (meta->inuse == cache->obj_per_slab) {
        // 变满了，移到full链表
        list_add(&(cache->slabs_full), le);
    } else {
        // 移到partial链表
        list_add(&(cache->slabs_partial), le);
    }
    
    return obj;
}

void kfree(void *obj) {
    if (obj == NULL) return;

    // 1. 根据对象地址找到slab的起始地址
    void *slab_start = (void *)ROUNDDOWN(obj, PGSIZE);
    struct slab_meta *meta = (struct slab_meta *)slab_start;
    struct kmem_cache *cache = meta->cache;

    // 2. 将对象归还到slab的freelist
    *((void **)obj) = meta->freelist;
    meta->freelist = obj;
    meta->inuse--;

    // 3. 更新slab所在的链表
    list_del(&(meta->slab_link));
    if (meta->inuse == 0) {
        // 完全空闲了，移到free链表
        list_add(&(cache->slabs_free), &(meta->slab_link));
    } else {
        // 移到partial链表
        list_add(&(cache->slabs_partial), &(meta->slab_link));
    }
}

// ---------- 测试用例 ----------
// void slub_test(void) {
//     cprintf("---- SLUB Allocator Test ----\n");
    
//     // 测试1: 基本分配和释放
//     cprintf("Test 1: Basic allocation and deallocation...\n");
//     void *p1 = kmalloc(10);
//     assert(p1 != NULL);
//     cprintf("  kmalloc(10) returned 0x%016lx\n", (uintptr_t)p1);
//     kfree(p1);
//     cprintf("  kfree(p1) done.\n");
//     cprintf("Test 1 PASSED.\n\n");

//     // 测试2: 分配直到耗尽一个slab，触发新slab创建
//     cprintf("Test 2: Allocate until a new slab is created...\n");
//     struct kmem_cache *cache32 = &g_kmalloc_caches[2]; // kmalloc-32
//     size_t count = cache32->obj_per_slab;
//     cprintf("  Cache '%s' has %d objects per slab.\n", cache32->name, count);
//     void **pointers = kmalloc(sizeof(void*) * (count + 5));
//     for(int i = 0; i < count + 5; i++) {
//         pointers[i] = kmalloc(32);
//         assert(pointers[i] != NULL);
//     }
//     cprintf("  Allocated %d objects of size 32. This should trigger new slab creation.\n", count + 5);
//     assert(!list_empty(&cache32->slabs_full));
//     assert(!list_empty(&cache32->slabs_partial));

//     // 释放
//     for(int i = 0; i < count + 5; i++) {
//         kfree(pointers[i]);
//     }
//     kfree(pointers);
//     cprintf("  Freed all objects.\n");
//     assert(list_empty(&cache32->slabs_full));
//     assert(list_empty(&cache32->slabs_partial));
//     assert(!list_empty(&cache32->slabs_free));
//     cprintf("Test 2 PASSED.\n\n");

//     // 测试3: 不同大小的内存分配
//     cprintf("Test 3: Allocating objects of various sizes...\n");
//     void *p_small = kmalloc(8);
//     void *p_medium = kmalloc(120);
//     void *p_large = kmalloc(1000);
//     assert(p_small != NULL && p_medium != NULL && p_large != NULL);
//     cprintf("  kmalloc(8) returned 0x%016lx\n", (uintptr_t)p_small);
//     cprintf("  kmalloc(120) returned 0x%016lx\n", (uintptr_t)p_medium);
//     cprintf("  kmalloc(1000) returned 0x%016lx\n", (uintptr_t)p_large);
//     kfree(p_small);
//     kfree(p_medium);
//     kfree(p_large);
//     cprintf("  Freed all objects.\n");
//     cprintf("Test 3 PASSED.\n\n");
    
//     cprintf("---- SLUB Allocator Test Finished ----\n");
// }