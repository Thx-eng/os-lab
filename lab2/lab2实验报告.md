# 实验二：物理内存管理

## 说明
本文件为报告内容。代码实现已在 `kern/mm/best_fit_pmm.c``kern/mm/buddy_pmm.c` 中完成，默认实现位于 `kern/mm/default_pmm.c`（First-Fit）。测试由内置自检函数（pmm_manager->check）完成，可通过 `make qemu` 运行。

---

### 练习1：理解 first-fit 连续物理内存分配算法（四个函数分析）

1. default_init
- 功能：初始化 pmm 的管理结构，初始化空闲链表（free_list）并将空闲页计数 nr_free 置 0。
- 作用点：在 pmm 管理器选定并启动时被调用，准备数据结构以接受内存区间注册。

2. default_init_memmap(struct Page *base, size_t n)
- 功能：把一段连续的 Page 区间构造成一个空闲块：
  - 对区间内每页清除 Reserved/Property 标志并将 ref 置 0（变为可分配）。
  - 在区间起始页设置 property = n 并标记为 PageProperty。
  - 按物理地址顺序把该空闲块插入 free_list，更新 nr_free += n。
- 作用点：在 page_init 中为检测到的可用物理内存区间调用，建立初始空闲块表。

3. default_alloc_pages(size_t n)
- 功能：按 First-Fit 策略分配连续 n 页：
  - 从 free_list 头部顺序扫描，找到第一个 p->property >= n 的空闲块。
  - 从链表中删除该空闲块；若块大于请求则在分割点创建剩余空闲块并插回链表，更新其 property。
  - 减少 nr_free，清除分配块的 PageProperty，返回分配块起始 Page 指针；找不到则返回 NULL。
- 作用点：为上层提供连续页分配服务（alloc_pages / alloc_page 宏）。

4. default_free_pages(struct Page *base, size_t n)
- 功能：释放一段连续页并尝试合并相邻空闲块：
  - 对释放区间每页清零 flags、ref；在 base 处设置 property = n 并标记 PageProperty，将其按地址顺序插入 free_list，nr_free += n。
  - 尝试与前驱和后继块按物理地址连续性合并，合并时更新 property、清除被吸收块的 PageProperty 并从链表删除。
- 作用点：回收内存并减少碎片（通过合并相邻空闲块）。

改进空间（First-Fit）
- 查找效率：First-Fit 需要可能遍历长链表，Worst-case O(m)。可引入按大小分级的 free lists、平衡树或索引结构提高查找速度。
- 碎片控制：First-Fit 易在链表前端产生小残余块，增加外部碎片。可考虑 Best-Fit、Buddy、分级分配或 slab 层来降低碎片。
- 分割策略：引入最小分割阈值避免产生过小块或延迟合并。
- 并发扩展：增加锁/每 CPU 缓存以支持多核并发分配。

---

### 练习2：实现 Best-Fit 连续物理内存分配算法（实验综述）

实验目标
- 在现有 first-fit 框架上实现 Best-Fit 策略：分配时遍历所有空闲块，选择满足大小且剩余最小的块，保留分割逻辑与释放合并逻辑一致。

实现要点（代码位置：kern/mm/best_fit_pmm.c）
- init / init_memmap：与 default 相同，按地址顺序把空闲块插入 free_list，并设置 base->property、nr_free。
- alloc_pages(n)：
  - 遍历 free_list，记录满足 p->property >= n 且 p->property 最小的候选块（若找到 property == n 的完美匹配可早停）。
  - 从链表中删除候选块；若候选块大于 n，则在候选块后创建剩余空闲块（rem = candidate + n），设置 rem->property 并插回链表（保持地址顺序）。
  - nr_free -= n，ClearPageProperty(candidate)，返回 candidate。
- free_pages(base, n)：
  - 恢复每页 flags/ref，设置 base->property = n 并 SetPageProperty(base)，nr_free += n。
  - 将 base 按地址顺序插入 free_list，然后尝试与前驱和后继合并（更新 property、清除被吸收块的 PageProperty 并删除链表节点）。
- 内置自检：和默认一样，basic_check 和 best_fit_check 用于验证分配/释放/分割/合并的正确性（这些检查会在 pmm_init 的 check_alloc_page 中被调用）。

默认实现（default）分析
- 策略：First-Fit；在 free_list 头部顺序扫描第一个满足请求的块，若超出请求则分割并把剩余块插回链表。
- 优势：实现简单、分配快速（通常能较早找到合适块）。
- 缺点：可能在链表前端留下许多小碎片，长期导致外部碎片增加；查找仍可能线性时间。

Best-Fit 实现分析
- 策略：遍历所有空闲块，选择 property >= n 且 property 最小的块，目标是最小化剩余碎片。
- 优势：在许多分配模式下能降低剩余碎片，尤其是当请求尺寸多样时更能紧凑利用空间。
- 缺点：分配时必须遍历全部空闲块，查找开销更高（线性且常常更长于 first-fit）；仍可能产生碎片，且实现复杂度略高。
- 兼容性：分割与释放合并逻辑与 default 保持一致，便于替换测试。

实验结果
- 修改后代码make test结果：
```bash
jmlcsr@LAPTOP-B8VAHGJN:/mnt/d/OScode/labcode/labcode/lab2$ make test
+ cc kern/init/entry.S
+ cc kern/init/init.c
+ cc kern/libs/stdio.c
+ cc kern/debug/panic.c
+ cc kern/driver/console.c
+ cc kern/driver/dtb.c
+ cc kern/mm/best_fit_pmm.c
+ cc kern/mm/default_pmm.c
+ cc kern/mm/pmm.c
+ cc libs/printfmt.c
+ cc libs/readline.c
+ cc libs/sbi.c
+ cc libs/string.c
+ ld bin/kernel
riscv64-unknown-elf-objcopy bin/kernel --strip-all -O binary bin/ucore.img

OpenSBI v0.4 (Jul  2 2019 11:53:53)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : QEMU Virt Machine
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 8
Current Hart           : 0
Firmware Base          : 0x80000000
Firmware Size          : 112 KB
Runtime SBI Version    : 0.1

PMP0: 0x0000000080000000-0x000000008001ffff (A)
PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
DTB Init
HartID: 0
DTB Address: 0x82200000
Physical Memory from DTB:
  Base: 0x0000000080000000
  Size: 0x0000000008000000 (128 MB)
  End:  0x0000000087ffffff
DTB init completed
(THU.CST) os is loading ...
Special kernel symbols:
  entry  0xffffffffc02000d6 (virtual)
  etext  0xffffffffc02016ae (virtual)
  edata  0xffffffffc0206018 (virtual)
  end    0xffffffffc0206078 (virtual)
Kernel executable memory footprint: 24KB
memory management: best_fit_pmm_manager
physcial memory map:
  memory: 0x0000000008000000, [0x0000000080000000, 0x0000000087ffffff].
grading: 1 / 6 points
grading: 2 / 6 points
grading: 3 / 6 points
grading: 4 / 6 points
grading: 5 / 6 points
grading: 6 / 6 points
check_alloc_page() succeeded!
satp virtual address: 0xffffffffc0205000
satp physical address: 0x0000000080205000
QEMU: Terminated
jmlcsr@LAPTOP-B8VAHGJN:/mnt/d/OScode/labcode/labcode/lab2$ 
```

- 修改后代码make grade结果：
```bash
jmlcsr@LAPTOP-B8VAHGJN:/mnt/d/OScode/labcode/labcode/lab2$ make grade
>>>>>>>>>> here_make>>>>>>>>>>>
gmake[1]: Entering directory '/mnt/d/OScode/labcode/labcode/lab2' + cc kern/init/entry.S + cc kern/init/init.c + cc kern/libs/stdio.c + cc kern/debug/panic.c + cc kern/driver/console.c + cc kern/driver/dtb.c + cc kern/mm/best_fit_pmm.c + cc kern/mm/default_pmm.c + cc kern/mm/pmm.c + cc libs/printfmt.c + cc libs/readline.c + cc libs/sbi.c + cc libs/string.c + ld bin/kernel riscv64-unknown-elf-objcopy bin/kernel --strip-all -O binary bin/ucore.img gmake[1]: Leaving directory '/mnt/d/OScode/labcode/labcode/lab2'
>>>>>>>>>> here_make>>>>>>>>>>>
<<<<<<<<<<<<<<< here_run_qemu <<<<<<<<<<<<<<<<<<
try to run qemu
qemu pid=1835
<<<<<<<<<<<<<<< here_run_check <<<<<<<<<<<<<<<<<<
  -check physical_memory_map_information:    OK
  -check_best_fit:                           OK
Total Score: 25/25
jmlcsr@LAPTOP-B8VAHGJN:/mnt/d/OScode/labcode/labcode/lab2$ 
```
可以看到25/25全部通过

## 扩展练习Challenge1：buddy system（伙伴系统）分配算法

### 概述
伙伴系统（Buddy System）是一种经典的内存分配算法，其核心优势在于能够高效地管理连续内存块的分配与释放，并通过 “伙伴合并” 机制有效减少内存碎片。本模块基于伙伴系统算法实现了物理内存管理（PMM），适配操作系统内核的内存分配需求，支持以页为单位的连续内存申请与释放，具备自动向上取整为 2 的幂、空闲块合并等核心功能。
### 设计思路
**一、核心设计理念**

1. **内存块的幂次管理**：所有分配的内存块大小均为 2 的幂，当申请的内存大小非 2 的幂时，自动向上取整为最近的 2 的幂，简化分配与合并逻辑。
2. **二叉树索引结构**：采用完全二叉树维护空闲内存块信息，树中每个节点代表一个内存块，节点值表示该块的最大可用连续页数，通过父子、左右子节点关系快速定位 “伙伴块”。
3. **元数据与数据分离**：从待管理的内存区域中划分出专门的元数据区，用于存储伙伴系统的控制信息（二叉树节点等），剩余区域作为实际可分配的内存块，确保内存利用率的平衡。
4. **高效的伙伴合并**：释放内存块时，自动检查其 “伙伴块”（地址相邻、大小相同的空闲块），若伙伴块也空闲则合并为更大的内存块，递归向上更新二叉树节点信息，减少内存碎片。

**二、关键设计决策**
1. **单区域管理**：当前实现聚焦于单块连续内存区域的管理，确保核心算法的简洁性，可通过扩展全局状态支持多区域管理。
2. **元数据动态适配**：初始化时自动计算所需的元数据页数，确保元数据区大小能够容纳伙伴二叉树，同时最大化可分配内存的规模。
3. **页级粒度控制**：基于操作系统的页大小（PGSIZE）进行内存管理，所有操作均以 “页” 为基本单位，与内核的内存管理模型保持一致。
### 具体实现

**一、数据结构定义**
1. 伙伴系统核心结构体
```c
struct buddy {
    unsigned size;         
    unsigned longest[1]; 
};
```
size:伙伴系统管理的总页数（2 的幂），即二叉树的 “叶子节点数”。

longest：变长数组，作为伙伴二叉树的存储载体，每个元素表示对应节点所代表内存块的最大可用连续页数。

2. 全局状态变量
```c
static struct buddy *global_buddy;        /* 指向伙伴系统元数据的虚拟地址 */
static struct Page *buddy_meta_page;     /* 元数据区的起始页面指针 */
static struct Page *buddy_base_page;     /* 可分配内存区的起始页面指针 */
static unsigned managed_npages;           /* 实际可分配的总页数 */
static unsigned buddy_size;               /* 伙伴系统管理的总页数（2的幂） */
static unsigned nr_free_pages_buddy;      /* 当前空闲页面数 */
```
**二、核心辅助函数**
1. 幂次相关工具函数
- next_pow2(unsigned x)：计算大于等于x的最小 2 的幂，用于将非标准大小的申请转换为幂次大小。
- fixsize(unsigned size)：封装next_pow2，统一处理内存块大小的标准化。
- IS_POWER_OF_2(x)：判断x是否为 2 的幂，用于验证内存块大小的合法性。
2. 二叉树索引宏
```c
#define LEFT(i)  ((i) * 2 + 1)    /* 左子节点索引 */
#define RIGHT(i) ((i) * 2 + 2)    /* 右子节点索引 */
#define PARENT(i) (((i) + 1) / 2 - 1) /* 父节点索引 */
#define MAX(a,b) (( (a) > (b) ) ? (a) : (b)) /* 取最大值 */
```
通过索引宏快速定位二叉树中的父子节点，避免复杂的指针操作，提升效率。

**三、初始化流程**
1. 模块初始化（buddy_init）
初始化全局状态变量为默认值，为后续内存映射初始化做准备。
2. 内存映射初始化（buddy_init_memmap）
核心流程如下：
- **元数据区与可分配区划分**：遍历可能的元数据页数，计算当前页数下可容纳伙伴二叉树的最大可分配页数，确定最优的元数据区大小（meta_pages）和伙伴系统管理规模（buddy_size）。
- **元数据区初始化**：将元数据区页面标记为 “保留”（不可分配），并清零初始化。
- **伙伴二叉树构建**：
  - 叶子节点初始化：可分配范围内的叶子节点设为 1（表示 1 页可用），超出范围的设为 0。
  - 内部节点初始化：从叶子节点向上递归计算，若左右子节点可用页数相同则合并（值为子节点的 2 倍），否则取最大值。
- **可分配区页面初始化**：设置可分配页面的状态（引用计数、属性等），初始化空闲页面计数。

**四、 内存分配实现（buddy_alloc_pages）**

1. **参数校验与标准化**：检查申请页数的合法性，将非 2 的幂的申请大小向上取整为最近的 2 的幂。
2. **二叉树查找空闲块**：调用buddy_alloc_block从根节点开始遍历二叉树，优先选择左子节点（若满足需求），找到匹配大小的空闲块。
3. **标记内存块为已分配**：将找到的节点值设为 0（标记为已分配），并向上更新父节点的longest值。
4. **页面状态更新**：将分配的页面标记为 “保留”，更新空闲页面计数，返回起始页面指针。

**五、内存释放实现（buddy_free_pages）**
1. **计算偏移量**：根据释放页面的起始地址，计算其相对于可分配区起始地址的偏移量。
2. **查找对应二叉树节点**：通过偏移量定位到二叉树中的对应叶子节点，递归向上找到实际分配的块节点。
3. **标记内存块为空闲**：将节点值恢复为块大小，检查其伙伴块是否空闲，若空闲则合并，并向上递归更新父节点的longest值。
4. **页面状态更新**：清除页面的 “保留” 标记，更新空闲页面计数。

**六、空闲页面计数（buddy_nr_free_pages）**
直接返回全局变量nr_free_pages_buddy，提供当前空闲页面的快速查询。
### 测试思路
1. **测试目标**：验证伙伴系统的核心功能正确性、边界条件处理能力以及合并机制的有效性，确保内存分配与释放的一致性和稳定性。
2. **测试用例设计：**
- **基础功能测试**
  - **单页分配与释放**：验证 1 页内存的申请和释放是否正常，空闲页面计数是否准确更新。
  - **多页分配与释放**：测试 2、4、8 等 2 的幂次页数的申请与释放，确保大块内存的管理正确性。
  - **非 2 的幂分配**：申请 3、5 等非标准大小的内存，验证是否自动向上取整为最近的 2 的幂，且释放后能正确恢复空闲状态。
-  **边界条件测试**
 - **零页申请**：验证申请 0 页内存时返回NULL，避免无效操作。
 - **超出可用内存申请**：申请超过当前空闲页面数的内存，验证返回NULL，确保不会出现内存越界。
- **伙伴合并逻辑验证**
  - **连续伙伴块合并**：申请两个相邻的 2 页内存块，释放后验证是否合并为 4 页的大块，空闲计数是否正确。
  - **非连续块释放**：申请 4 个 1 页内存块，释放其中不连续的两块，验证空闲计数正确且未错误合并；后续释放剩余两块后，验证能否合并为完整的 4 页块。
3. **测试结果判断**
   通过检查空闲页面计数的一致性、内存块分配 / 释放的返回值有效性，以及合并逻辑是否符合预期，判断测试是否通过。若存在任何一项不符合预期，直接触发断言（panic），提示具体的错误类型。

    make qemu结果：
    ```bash
      + cc kern/mm/buddy_pmm.c
      + ld bin/kernel
      riscv64-unknown-elf-objcopy bin/kernel --strip-all -O binary bin/ucore.img
   
      OpenSBI v0.4 (Jul  2 2019 11:53:53)
        ____                    _____ ____ _____
        / __ \                  / ____|  _ \_   _|
      | |  | |_ __   ___ _ __ | (___ | |_) || |
      | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
      | |__| | |_) |  __/ | | |____) | |_) || |_
        \____/| .__/ \___|_| |_|_____/|____/_____|
              | |
              |_|
   
      Platform Name          : QEMU Virt Machine
      Platform HART Features : RV64ACDFIMSU
      Platform Max HARTs     : 8
      Current Hart           : 0
      Firmware Base          : 0x80000000
      Firmware Size          : 112 KB
      Runtime SBI Version    : 0.1
   
      PMP0: 0x0000000080000000-0x000000008001ffff (A)
      PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
      DTB Init
      HartID: 0
      DTB Address: 0x82200000
      Physical Memory from DTB:
        Base: 0x0000000080000000
        Size: 0x0000000008000000 (128 MB)
        End:  0x0000000087ffffff
      DTB init completed
      (THU.CST) os is loading ...
      Special kernel symbols:
        entry  0xffffffffc02000d6 (virtual)
        etext  0xffffffffc0201442 (virtual)
        edata  0xffffffffc0206018 (virtual)
        end    0xffffffffc0206088 (virtual)
      Kernel executable memory footprint: 24KB
      memory management:buddy_pmm_manager
      physcial memory map:
        memory: 0x0000000008000000, [0x0000000080000000, 0x0000000087ffffff].
      buddy_pmm: init_memmap ok: total_pages=31929 meta_pages=64 managed=31865 buddy_size=32768
      buddy_pmm: starting full check, free pages=31865
      Test 1: basic allocation/free
      Single page allocation/free passed
      Multi-page allocation/free test passed
      Non-power-of-2 allocation test passed
      Test 2: boundary conditions
      Boundary condition tests passed
      Test 3: buddy merge verification
      Buddy merge logic test passed
      buddy_pmm: all tests passed, free pages=31865
      check_alloc_page() succeeded!
      satp virtual address: 0xffffffffc0205000
      satp physical address: 0x0000000080205000
    ```
    可以看到各项测试均已通过并且测试前后空闲页的数目一样。

    也可以make grade:
    ```bash
    >>>>>>>>>> here_make>>>>>>>>>>>
    gmake[1]: Entering directory '/root/labcode/lab2' + cc kern/init/entry.S + cc kern/init/init.c + cc kern/libs/stdio.c + cc kern/debug/panic.c + cc kern/driver/console.c + cc kern/driver/dtb.c + cc kern/mm/best_fit_pmm.c + cc kern/mm/buddy_pmm.c + cc kern/mm/default_pmm.c + cc kern/mm/pmm.c + cc libs/printfmt.c + cc libs/readline.c + cc libs/sbi.c + cc libs/string.c + ld bin/kernel riscv64-unknown-elf-objcopy bin/kernel --strip-all -O binary bin/ucore.img gmake[1]: Leaving directory '/root/labcode/lab2'
    >>>>>>>>>> here_make>>>>>>>>>>>
    <<<<<<<<<<<<<<< here_run_qemu <<<<<<<<<<<<<<<<<<
    try to run qemu
    qemu pid=92030
    <<<<<<<<<<<<<<< here_run_check <<<<<<<<<<<<<<<<<<
      -check physical_memory_map_information:    OK
      -check buddy init success:                 OK
      -check buddy basic alloc/free:             OK
      -check buddy boundary conditions:          OK
      -check buddy merge logic:                  OK
      -check buddy full test pass:               OK
      -check buddy address translation:          OK
      -check buddy core alloc:                   OK
    Total Score: 90/90
    ```
   测试成功。

## 扩展练习Challenge2:SLUB 二级内存分配架构设计

### 1. 核心目标

在 ucore 现有的页式物理内存管理器（PMM）之上，实现一个二级内存分配架构。

* **第一层 (Slab层)**: 从 PMM 获取整页内存，并将其作为 Slab 进行管理。
* **第二层 (对象层)**: 在 Slab 内部为任意大小的小块内存请求（对象）提供快速分配和释放。

### 2. 核心数据结构

我们将设计两个核心数据结构，分别位于 `slub.c` 中：

### struct slab_meta

由于我们不能修改内核已有的 `struct Page` 结构，我们将每个 Slab（物理页）的开头部分划出来，用于存放其元数据。

```c
struct slab_meta {
    struct kmem_cache *cache; // 指向该Slab所属的缓存池
    void *freelist;           // 指向Slab内第一个空闲对象的指针
    size_t inuse;             // 当前Slab中已分配对象的数量
    list_entry_t slab_link;   // 用于将该Slab链入缓存池的三种链表之一
};
```

### struct kmem_cache

这是 SLUB 算法的核心，用于管理一类特定大小的对象。系统中将为不同大小（如 8 字节, 16 字节, 32 字节...）的对象创建多个 `kmem_cache` 实例。

```c
struct kmem_cache {
    const char *name;         // 缓存池的名称，便于调试
    size_t obj_size;          // 该缓存池中每个对象的大小
    size_t obj_per_slab;      // 每个Slab能容纳的对象数量

    list_entry_t slabs_full;    // 全满Slab链表
    list_entry_t slabs_partial; // 部分分配的Slab链表
    list_entry_t slabs_free;    // 完全空闲的Slab链表
};
```

### 3. 算法流程

#### 初始化 (slub_init)

在内核启动时，创建并初始化一个 `kmem_cache` 数组，用于管理一系列固定大小的对象（例如，8, 16, 32, ... , 4096 字节）。
每个 `kmem_cache` 的三个链表（`slabs_full`, `slabs_partial`, `slabs_free`）都被初始化为空。

#### 内存分配 (kmalloc)

1. 根据请求的 size，找到最合适的 `kmem_cache`（例如，请求 20 字节，则使用 32 字节的缓存池）。
2. 优先在 `slabs_partial` 链表中寻找有空闲空间的 Slab。
3. 如果 `slabs_partial` 为空，则在 `slabs_free` 链表中寻找一个完全空闲的 Slab。找到后，将其移至 `slabs_partial` 链表。
4. 如果 `slabs_partial` 和 `slabs_free` 都为空，则调用底层 PMM 的 `alloc_pages(1)` 来申请一个新的物理页。
5. 对新页进行初始化：在其头部建立 `slab_meta`，并将页内剩余空间格式化为一个由空闲对象组成的链式栈（`freelist`）。然后将这个新的 Slab 加入 `slabs_free` 链表，并重复步骤 3。
6. 从选定的 Slab 的 `freelist` 中弹出一个对象，`inuse` 计数加一，并返回该对象的指针。
7. 如果分配后 Slab 变满，则将其从 `slabs_partial` 移至 `slabs_full` 链表。

#### 内存释放 (kfree)

1. 根据待释放对象的指针 `objp`，通过 `ROUNDDOWN(objp, PGSIZE)` 计算出它所在的 Slab 的起始地址。
2. 通过 Slab 起始地址获取 `slab_meta`，并从中找到它所属的 `kmem_cache`。
3. 将被释放的对象压回 Slab 的 `freelist` 链式栈中，`inuse` 计数减一。
4. 如果 Slab 原先在 `slabs_full` 链表中，现在则将其移至 `slabs_partial`。
5. 如果 Slab 的 `inuse` 计数变为 0，说明它已完全空闲，则将其移至 `slabs_free` 链表，以备后用。

### 4. 测试样例

- **基本分配与释放**：测试 `kmalloc` / `kfree` 的基础功能，确保分配地址非空、释放操作正常。  
- **Slab 扩展验证**：连续分配对象直至填满当前 slab，触发新 slab 创建，并检查 `slabs_full`、`slabs_partial`、`slabs_free` 链表状态是否正确。  
- **多尺寸对象分配**：测试不同大小（如 8B、128B、1KB 等）对象的分配与释放，验证多种缓存池协同工作的正确性和内存状态恢复情况。<br>

在终端输入make qemu输出结果如下，可以看到编译成功，并且三个测试样例全部通过！


```bash
thx@DESKTOP-9C1D6D7:~/labcode/lab2$ make qemu

OpenSBI v0.4 (Jul  2 2019 11:53:53)
   ____                    _____ ____ _____
  / __ \                  / ____|  _ \_   _|
 | |  | |_ __   ___ _ __ | (___ | |_) || |
 | |  | | '_ \ / _ \ '_ \ \___ \|  _ < | |
 | |__| | |_) |  __/ | | |____) | |_) || |_
  \____/| .__/ \___|_| |_|_____/|____/_____|
        | |
        |_|

Platform Name          : QEMU Virt Machine
Platform HART Features : RV64ACDFIMSU
Platform Max HARTs     : 8
Current Hart           : 0
Firmware Base          : 0x80000000
Firmware Size          : 112 KB
Runtime SBI Version    : 0.1

PMP0: 0x0000000080000000-0x000000008001ffff (A)
PMP1: 0x0000000000000000-0xffffffffffffffff (A,R,W,X)
DTB Init
HartID: 0
DTB Address: 0x82200000
Physical Memory from DTB:
  Base: 0x0000000080000000
  Size: 0x0000000008000000 (128 MB)
  End:  0x0000000087ffffff
DTB init completed
(THU.CST) os is loading ...
Special kernel symbols:
  entry  0xffffffffc02000d8 (virtual)
  etext  0xffffffffc0201c7a (virtual)
  edata  0xffffffffc0206018 (virtual)
  end    0xffffffffc020639c (virtual)
Kernel executable memory footprint: 25KB
memory management: default_pmm_manager
physcial memory map:
  memory: 0x0000000008000000, [0x0000000080000000, 0x0000000087ffffff].
check_alloc_page() succeeded!
satp virtual address: 0xffffffffc0205000
satp physical address: 0x0000000080205000
slub_init: SLUB allocator initialized.
---- SLUB Allocator Test ----
Test 1: Basic allocation and deallocation...
  kmalloc(10) returned 0xffffffffc0347fe8
  kfree(p1) done.
Test 1 PASSED.

Test 2: Allocate until a new slab is created...
  Cache 'kmalloc-32' has 126 objects per slab.
  Allocated 131 objects of size 32. This should trigger new slab creation.
  Freed all objects.
Test 2 PASSED.

Test 3: Allocating objects of various sizes...
  kmalloc(8) returned 0xffffffffc034bff8
  kmalloc(120) returned 0xffffffffc034cf28
  kmalloc(1000) returned 0xffffffffc034d828
  Freed all objects.
Test 3 PASSED.

---- SLUB Allocator Test Finished ----
```

### 5. 简化与权衡

相对于 Linux 内核完整的 SLUB 实现，本设计做了以下简化，以体现核心思想并降低实现复杂度：

* **无 Per-CPU 缓存**: 不为每个 CPU 核心维护独立的缓存，简化了并发控制逻辑。
* **不考虑 NUMA**: 所有的内存和 Slab 都在一个单一的节点上管理。
* **Slab 回收策略简化**: 空闲的 Slab 不会立即归还给 PMM，而是保留在 `slabs_free` 链表中。一个更完整的实现会包含在内存压力大时回收这些空闲 Slab 的策略。
## 扩展练习Challenge3：硬件的可用物理内存范围的获取方法

在操作系统无法提前知晓硬件可用物理内存范围的情况下，核心解决思路是 **依赖硬件提供的标准化信息接口、执行内存探测算法，或结合固件 / 引导程序的辅助**，逐步识别出哪些物理地址是可读写的（即 “可用内存”）。以下是几种主流且可靠的实现方案，按实用性和标准化程度排序：

### 一、依赖固件 / 引导程序提供的内存映射 
现代计算机系统的固件（如 BIOS、UEFI）或引导加载程序（如 GRUB、U-Boot）会提前探测硬件内存，并将内存布局信息以标准化格式传递给操作系统内核。这是最常用、最可靠的方式，避免内核重复实现复杂的硬件探测逻辑。

例如：UEFI 固件的内存映射（现代系统首选）

UEFI（统一可扩展固件接口）是替代传统 BIOS 的标准，它提供了专门的系统调用（GetMemoryMap），可以返回详细的内存区域信息，包括：
- 每个内存区域的起始物理地址、大小；
- 区域类型（如 “可用内存”“保留内存”“ACPI 表内存”“固件代码内存” 等）。

**OS 处理流程：**
- 内核启动时，通过 UEFI 提供的系统调用获取内存映射表；
- 过滤出类型为 “可用内存”（EfiConventionalMemory）的区域，作为内核可管理的物理内存；
- 保留其他类型的区域（如固件、ACPI 表占用的内存），避免非法访问。
### 二、执行内存探测算法
如果系统没有提供标准化的内存映射（如嵌入式系统、定制硬件），内核需要自行执行内存探测，通过 “写入 - 读取 - 验证” 的方式判断物理地址是否可用。

**基础探测逻辑**

核心思想：对一段可能的物理地址范围，尝试写入一个特定值，再读取验证。若读写一致，说明该地址对应的物理内存存在且可用；若读写失败（如触发异常），则标记为不可用。

**步骤细节**
1. **确定探测范围**：根据硬件手册或架构特性，确定可能的物理内存地址区间（如 RISC-V 系统通常从 0x80000000 开始，x86 系统可能从 0x00000000 开始）；
2. **按页粒度探测**：以页（如 4KB）为单位，避免单个字节的探测开销过大；
3. **安全写入验证**：
- 保存该地址的原始值（若后续需要恢复，避免破坏已有数据，如固件代码）；
- 写入一个测试值;
- 读取该地址，若与写入值一致，则标记为可用；
- 恢复原始值。
4. **处理异常**：若读写过程中触发内存访问异常（如缺页中断、总线错误），则说明该地址无对应的物理内存，标记为不可用。
### 三、解析设备树
在嵌入式系统中（如 RISC-V、ARM），硬件配置信息通常存储在 设备树（Device Tree Blob, DTB） 中，其中包含了物理内存的范围描述。内核可通过解析 DTB 获取可用内存。

**核心流程**
1. 获取 DTB 地址：引导程序（如 U-Boot）会将 DTB 的物理地址传递给内核；
2. 解析 DTB 中的内存节点：DTB 中存在专门的 memory 节点，格式如下：
```
memory@80000000 {
    device_type = "memory";
    reg = <0x0 0x80000000 0x0 0x8000000>;  // 起始地址 0x80000000，大小 128MB
};
其中 reg 属性的前两个值是内存的起始物理地址，后两个值是内存大小；
```
3. **提取可用内存范围**：内核解析 memory 节点的 reg 属性，即可获取可用物理内存的起始地址和大小。
### 四、方案比较
| 方案                                 | 适用场景                                  | 优点                                         | 缺点                                         |
|--------------------------------------|-------------------------------------------|----------------------------------------------|----------------------------------------------|
| 固件/引导程序内存映射（UEFI/E820/Multiboot） | 桌面机、服务器、标准化嵌入式系统          | 可靠、无需内核实现复杂探测、支持区分内存类型   | 依赖固件/引导程序支持                         |
| 内存探测算法                         | 无标准化固件的定制硬件、嵌入式系统        | 不依赖外部组件、通用性强                     | 可能误判（如只读内存）、存在性能开销、需处理异常 |
| 设备树解析                           | 嵌入式 RISC-V/ARM 系统                    | 符合嵌入式标准、配置灵活                     | 仅适用于支持设备树的系统                     |


###  本实验重要知识点与 OS 原理的对应分析

---

#### 1. 页式物理内存管理 (Page Frame Management)

**实验知识点：**  
通过 `struct Page` 数组为每个物理页帧（Page Frame）建立描述符。  
使用 `free_area_t` 结构（内部是双向链表）管理所有空闲物理页。  
最终提供 `alloc_pages()` 和 `free_pages()` 接口来申请和释放一或多个连续物理页。

**对应 OS 原理：**  
物理内存管理（Physical Memory Management），特别是 **空闲空间管理（Free-Space Management）**。

**理解与阐述：**

- **含义：**  
  操作系统必须知道整个物理内存中哪些部分正在被使用、哪些部分是空闲的。  
  常见的空闲管理方法包括位图（Bitmap）和空闲链表（Free List）。

- **实验：**  
  实验采用空闲链表法。  
  `struct Page` 数组是对整个物理内存的元数据化，  
  而 `free_area_t` 是链表头与计数器，将所有空闲的 `Page` 节点链接成一个可分配资源池。

- **关系：**  
  实验中的 `pmm.c` 是 OS 原理中空闲空间管理思想的具体实现。  
  它是后续所有内存操作（页表映射、SLUB 动态分配、用户内存分配）的物理内存来源。

- **差异：**  
  - **简化：** 实验假设物理内存连续，不考虑空洞或硬件保留区。  
  - **抽象层次：** 理论讲策略（位图 vs 链表），实验实现细节（`ref`、`flags` 字段、`le2page` 宏等）。

---

#### 2. 分页机制与地址转换 (Paging and Address Translation)

**实验知识点：**  
在 RISC-V 架构下，使用 **Sv39 三级页表结构**。  
通过设置页表项标志（如 `PTE_V`, `PTE_R`, `PTE_W`, `PTE_X`）实现访问控制。  
最后将页表基地址写入 `satp` 寄存器以开启 MMU。

**对应 OS 原理：**  
分页式内存管理（Paging）与地址空间（Address Space）。

**理解与阐述：**

- **含义：**  
  分页允许进程的物理地址空间非连续，通过页表记录虚拟页到物理页帧的映射关系。

- **实验：**  
  构建内核的页表，将高虚拟地址（`KERNBASE` 开始）映射到物理地址（如 `0x80200000` 起）。  
  相当于“亲手填写”了页表，完成了理论中虚拟到物理的映射。

- **关系：**  
  实验是原理的实例化：理论讲“页表”概念，实验中实际操作页表项。  
  修改 `PTE` 权限位直接体现内存保护机制。

- **差异：**  
  - **关注点：** 实验仅实现内核的线性映射，未涉及多进程隔离。  
  - **动态性：** 实验中页表基本静态，而真实系统页表是动态变化的。

---

#### 3. 页面分配算法 (Page Allocation Algorithm)

**实验知识点：**  
在 `default_pmm.c` 与 `best_fit_pmm.c` 中实现页面分配策略。  
如 **First-Fit**（首次适应）和 **Best-Fit**（最佳适应）算法。

**对应 OS 原理：**  
动态存储分配（Dynamic Storage Allocation）中的经典算法：First-Fit、Best-Fit、Worst-Fit 等。

**理解与阐述：**

- **含义：**  
  当为进程分配内存时，如何选择合适的空闲块是一个经典算法问题。

- **实验：**  
  `default_pmm_alloc_pages()` 函数的逻辑即为这些算法的直接代码实现。

- **关系：**  
  实验代码将理论算法应用于实际的空闲链表结构，展示算法对内存分配效率与碎片的影响。

- **差异：**  
  实验的分配单位是页（4KB）整数倍，结构较为规整，而理论讨论更通用于任意大小块的分配问题。

---

#### 4. 快表 (TLB - Translation Lookaside Buffer)

**实验知识点：**  
`flush_tlb()` 函数（RISC-V 的 `sfence.vma` 指令）用于在修改页表后刷新 TLB 缓存。

**对应 OS 原理：**  
转译后备缓冲区（Translation Lookaside Buffer, TLB）。

**理解与阐述：**

- **含义：**  
  TLB 是 CPU 内部的缓存，用于快速保存近期虚拟页到物理页帧的映射，加快地址转换。

- **实验：**  
  虽未“实现”TLB，但必须“管理”它。  
  调用 `flush_tlb()` 即是在页表更新后通知硬件刷新映射缓存。

- **关系：**  
  展现了操作系统控制硬件的能力，是软硬件协同的典型例子。

- **差异：**  
  理论课程讲解 TLB 的结构与命中机制，实验仅在使用层面体现其存在。

---

###  OS 原理中未覆盖的部分

本实验为内存管理奠定基础，但距离完整的虚拟内存系统仍有以下差距：

- **按需分页（Demand Paging）**  
  进程仅在访问到某页时才加载该页（缺页中断机制），本实验中所有页均预先映射。

- **页面置换算法（Page Replacement）**  
  在内存不足时，OS 需将部分页面换出，如 FIFO、LRU、Clock 等，本实验未涉及。

- **写时复制（Copy-on-Write, COW）**  
  `fork()` 时父子进程共享只读页面，写入时才复制。本实验未实现进程级内存共享。

- **多进程独立地址空间**  
  本实验仅构建了内核态地址空间，尚未支持用户进程的私有虚拟内存。

- **内存映射文件（Memory-Mapped Files）**  
  允许将文件直接映射至虚拟内存以加速文件 I/O，本实验未涉及。

- **用户态堆内存管理**  
  用户态的 `malloc` 依赖内核的 `sbrk` 或 `mmap` 系统调用申请堆空间，本实验仅实现了内核态的 `kmalloc`。

---
