## 练习1: 完成读文件操作的实现

### 一、实现目标

在 `kern/fs/sfs/sfs_inode.c` 的 `sfs_io_nolock()` 中补全读写文件的核心逻辑，正确处理任意偏移、跨块读写，并维护 inode 的 `size/blocks/dirty` 等状态。

### 二、设计思路

1. **参数校验与范围裁剪**  
   - 检查 `offset/endpos` 是否越界、读路径裁剪到实际文件大小。
   - 根据 `write` 选择读/写回调：`sfs_buf_op`（块内偏移）和 `sfs_block_op`（整块）。
2. **首块未对齐处理**  
   - 计算 `blkoff = offset % SFS_BLKSIZE`，若不为 0，先定位首块 `blkno`，通过 `sfs_bmap_load_nolock` 获取物理块号 `ino`，使用 `sfs_buf_op` 读/写 `size = min(首块剩余, 请求长度)`。
3. **中间对齐整块批量处理**  
   - 循环处理 `nblks`，每次预读连续物理块（若下一个 `ino_next != ino + nstep` 则停止聚合），用 `sfs_block_op` 一次读/写多个整块，提高效率。
4. **尾块未对齐处理**  
   - 若仍有尾部字节，重新用 `sfs_bmap_load_nolock` 获取最后一块，`sfs_buf_op` 处理尾段。
5. **长度与大小维护**  
   - 用 `alen` 累加实际读/写字节数并返回给上层；若写入导致 `start + alen` 大于原 `size`，更新 `din->size` 并标记 `dirty`。

### 三、关键调用

- `sfs_bmap_load_nolock`：按逻辑块号创建/获取物理块。
- `sfs_rbuf` / `sfs_wbuf`：块内带偏移读写。
- `sfs_rblock` / `sfs_wblock`：整块/多块顺序读写。

### 四、代码实现

```c
blkoff = offset % SFS_BLKSIZE;

if (blkoff != 0) {
    size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
    if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) goto out;
    if ((ret = sfs_buf_op(sfs, buf, size, ino, blkoff)) != 0) goto out;
    offset += size, alen += size;
    buf = (char *)buf + size, blkno ++;
    if (nblks != 0) nblks --;
}

while (nblks != 0) {
    if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) goto out;
    uint32_t nstep = 1, ino_next;
    while (nstep < nblks) {
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno + nstep, &ino_next)) != 0) goto out;
        if (ino_next != ino + nstep) break;
        nstep ++;
    }
    if ((ret = sfs_block_op(sfs, buf, ino, nstep)) != 0) goto out;
    size = SFS_BLKSIZE * nstep;
    offset += size, alen += size;
    buf = (char *)buf + size, blkno += nstep, nblks -= nstep;
}

if (offset != endpos) {
    size = endpos - offset;
    if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) goto out;
    if ((ret = sfs_buf_op(sfs, buf, size, ino, 0)) != 0) goto out;
    alen += size;
}

```

这段逻辑把 `[offset, endpos]` 拆成最多三部分处理：

1. **头部非对齐零碎（partial head）**：如果 `offset` 不在块边界上，先处理当前块剩余部分。
2. **中间整块区间（full blocks）**：对齐后尽可能按整块处理，并进一步把连续物理块合并成一次大 I/O（`nstep`）。
3. **尾部零碎（partial tail）**：如果最后还剩不足一块的字节，用 `sfs_buf_op` 处理。

这是一种典型的“先对齐、再批量、最后扫尾”的文件系统读写实现方式。

---

### 五、逐段详解

####  1.头部零碎：处理块内偏移 `blkoff != 0`

```c
blkoff = offset % SFS_BLKSIZE;

if (blkoff != 0) {
    size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);
    ...
    sfs_buf_op(..., size, ino, blkoff)
    ...
}
```

**目的**：当起始 `offset` 落在块中间时，先把这个“起始块剩余部分”处理掉，使后续进入块对齐状态。

* `size` 的计算分两种情况：

  * `nblks != 0`：说明后面还有整块要处理，则头部零碎最多补齐到块末尾：`SFS_BLKSIZE - blkoff`
  * `nblks == 0`：说明整个请求都在同一个块内（没有整块区间），那头部零碎其实就是全部剩余：`endpos - offset`

**状态更新**：

* `offset += size`、`alen += size`
* `buf` 指针前移 `size`
* `blkno++`：因为头部零碎处理完，逻辑块推进到下一个块
* 若 `nblks != 0`，则 `nblks--`：因为“当前块的剩余部分”如果补齐到了块末尾，等价于消耗了一个整块的“块跨度”（虽然操作是 partial，但逻辑上推进了一块）。

---

#### 2.中间整块：`while (nblks != 0)`

```c
while (nblks != 0) {
    sfs_bmap_load_nolock(..., blkno, &ino);
    uint32_t nstep = 1, ino_next;
    while (nstep < nblks) {
        sfs_bmap_load_nolock(..., blkno + nstep, &ino_next);
        if (ino_next != ino + nstep) break;
        nstep ++;
    }
    sfs_block_op(..., ino, nstep);
    size = SFS_BLKSIZE * nstep;
    ...
}
```

**目的**：对齐后按“整块”读写，但进一步优化：

* 连续逻辑块不一定对应连续物理块（可能碎片化）。
* 这里通过检查 `ino_next == ino + nstep` 来发现**物理连续区间**，把它们合并成一次 `sfs_block_op`，减少 I/O 次数和映射开销。

**关键点：nstep（run 合并）**

* 初始 `nstep = 1`，至少处理 1 个块。
* 向后探测（lookahead）直到：

  * 达到 `nblks` 上限，或
  * 发现下一块物理号不连续（碎片化），则停止合并。

**性能意义**：

* 若文件在磁盘上是连续分配（或局部连续），该循环可将多个块合并为一次操作，显著减少系统调用/磁盘请求次数。
* 代价是：每次批量前需要多次调用 `sfs_bmap_load_nolock` 做探测。

**状态更新**：

* `size = SFS_BLKSIZE * nstep`
* `offset/buf/blkno/nblks` 同步推进 `nstep` 个块。

---

#### 3.尾部零碎：`if (offset != endpos)`

```c
if (offset != endpos) {
    size = endpos - offset;
    sfs_bmap_load_nolock(..., blkno, &ino);
    sfs_buf_op(..., size, ino, 0);
    alen += size;
}
```

**目的**：处理中间整块处理完后剩下的“最后不足一块”部分。

* 此时一定是在一个新块的开头，所以 `blkoff` 为 `0`，因此 `sfs_buf_op(..., blkoff=0)`。
* 只更新 `alen`，没有再更新 `offset`（代码末尾不再使用 `offset`，但这点风格上不完全一致；不过逻辑上不影响返回值时使用 `alen`）。

---

#### 4.覆盖的边界情况

* **请求完全在一个块内**：
  `blkoff != 0` 且 `nblks == 0`，头部零碎一次性处理 `endpos - offset`，后续两个阶段都不会执行。
* **请求刚好对齐**：
  `blkoff == 0`，跳过头部零碎，直接进入整块处理/尾部处理。
* **请求长度是块大小整数倍**：
  尾部 `offset == endpos`，不会进入尾部零碎分支。
* **存在物理碎片**：
  `ino_next != ino + nstep` 时停止合并，保证不会跨越不连续的物理块做一次 block_op（避免读写错误块）。

---

## 练习2：基于文件系统的执行程序机制

### 1. 目标

- 让 `SYS_exec` 能从 SFS 文件系统中打开可执行文件（ELF），并把其内容装载到当前进程的用户态地址空间中，然后切换到用户态从入口地址开始执行。
- 预期现象：`make qemu` 后进入 `sh`，并可在 `sh` 中执行 `hello`、`exit` 等位于文件系统中的用户程序。

### 2. 实现位置与关键思路

本实验的核心在进程执行路径：

- 系统调用分发：`SYS_exec -> sys_exec -> do_execve`
- 从文件系统读 ELF 并装载：`do_execve -> load_icode (fd, argc, kargv)`
- 为 `load_icode` 提供“随机读”：`load_icode_read` 通过 `sysfile_seek + sysfile_read` 从 fd 读取指定偏移

实现上遵循了 lab5 中“从内存镜像装载用户程序”的逻辑，但把“读取源”换成了文件描述符 fd。

### 3. 代码流程（结合实现）

#### 3.1 do_execve：参数处理 + 打开文件 + 回收旧地址空间

- 在 `do_execve` 中先对 `argc` 做合法性检查（`1..EXEC_MAX_ARG_NUM`）。
- 使用 `copy_string` 把 `name` 拷贝到内核缓冲 `local_name`，用于最后更新进程名；使用 `copy_kargv` 把用户态 `argv[i]` 的字符串拷贝到内核缓冲 `kargv[i]`。
- 这里有一个实现细节：`path = argv[0]` 使用的是“用户态指针”，而不是 `kargv[0]`。
  - 原因：`sysfile_open` 内部会 `copy_path`，它会用 `current->mm` 对传入指针做用户内存合法性检查并 `copy_string`。
  - 如果把内核指针 `kargv[0]` 传给 `sysfile_open`，会被当成用户指针检查失败。
- `files_closeall(current->filesp)` 关闭当前进程已打开的文件。
- `fd = sysfile_open(path, O_RDONLY)` 从文件系统打开可执行文件。
- 如果当前进程已有旧 `mm`：先 `lsatp(boot_pgdir_pa)` 切回内核页表，再对旧 `mm` 做引用计数减少与释放（`exit_mmap/put_pgdir/mm_destroy`），避免仍在旧页表上执行时释放自身地址空间。
- 之后调用 `load_icode(fd, argc, kargv)` 进行新程序装载。

#### 3.2 load_icode：从 fd 装载 ELF 段 + 建栈 + 设置 trapframe

装载过程按 ELF 规范与内存映射需求执行：

1) 创建并初始化地址空间

- `mm = mm_create()` 创建新的 `mm_struct`。
- `setup_pgdir(mm)` 分配并初始化页目录（拷贝内核映射）。

2) 读取并校验 ELF 头

- 通过 `load_icode_read(fd, &elf, sizeof(elf), 0)` 读取 `elfhdr`。
- 检查 `elf.e_magic == ELF_MAGIC`，否则返回 `-E_INVAL_ELF`。

3) 遍历 Program Header，装载所有 `ELF_PT_LOAD` 段

- 对每个可装载段：
  - 校验 `p_filesz <= p_memsz`，并校验 `USER_ACCESS(p_va, p_va + p_memsz)`。
  - 根据 `p_flags` 计算 `vm_flags`（`VM_READ/VM_WRITE/VM_EXEC`）以及 PTE 权限位（`PTE_U|PTE_V` + `PTE_R/W/X`）。
  - `mm_map(mm, la, la_end-la, vm_flags, NULL)` 建立 VMA。
  - 逐页 `pgdir_alloc_page(mm->pgdir, la, perm)` 分配物理页：
    - 文件覆盖区：用 `load_icode_read` 把文件内容读到该页对应的内核映射地址 `page2kva(page)+pageoff`。
    - BSS / 余下部分：`memset` 清零。

4) 建立用户栈

- `mm_map(mm, USTACKTOP-USTACKSIZE, USTACKSIZE, VM_READ|VM_WRITE|VM_STACK, NULL)`。
- 对栈区逐页分配 `pgdir_alloc_page(..., PTE_U|PTE_R|PTE_W)`。

5) 安装新地址空间并切换页表

- `current->mm = mm; current->pgdir = PADDR(mm->pgdir); lsatp(current->pgdir);`

6) 把参数压入用户栈并设置 a0/a1

- 从 `sp = USTACKTOP` 开始逆序拷贝每个 `kargv[i]` 字符串到用户栈。
- `uargv[i]` 记录每个参数字符串在用户栈中的地址；按 16 字节对齐 `sp`。
- 再把 `uargv` 数组本身拷贝到用户栈，并令：
  - `tf->gpr.a0 = argc`
  - `tf->gpr.a1 = sp`（指向用户栈上的 `argv` 数组）

7) 初始化 trapframe，准备从用户态入口执行

- `tf->epc = elf.e_entry` 设置用户态入口。
- `tf->status = (read_csr(sstatus) & ~(SSTATUS_SPP | SSTATUS_SIE)) | SSTATUS_SPIE`：
  - 清除 SPP，保证 `sret` 回到 U-mode；
  - 关 SIE（避免在内核态错误打开中断）；
  - 开 SPIE，使得进入用户态后中断可用。

8) 清理

- 成功路径 `sysfile_close(fd)`。
- 失败路径按阶段回收：`exit_mmap -> put_pgdir -> mm_destroy`，并关闭 fd。

### 4. 运行与验证（建议写法）

- `make qemu` 进入 `sh` 交互界面。
- 在 `sh` 中执行：
  - `hello`：验证能从文件系统装载并执行用户程序。
  - `exit`：验证退出与控制流返回。

### 5. 关键点总结

- “从文件系统读取 ELF”通过 `load_icode_read(fd, buf, len, off)` 实现，本质是 `seek + read` 组合提供随机访问。
- `do_execve` 打开可执行文件时必须传入“用户态指针”给 `sysfile_open`，否则会因用户内存检查失败。
- 装载完成后必须正确设置 `trapframe`（`epc/sp/a0/a1/status`），才能顺利 `sret` 到用户态。

## 扩展练习 Challenge1：完成基于“UNIX的PIPE机制”的设计方案

下面给出在 ucore 中加入 UNIX 匿名管道的概要设计，强调数据结构、接口语义以及同步互斥处理。

### 目标与语义

- 半双工字节流；`pipe(fds)` 返回读端 `fds[0]`、写端 `fds[1]`。
- `read`：缓冲空且写端仍在 → 阻塞；缓冲空且写端全关 → 返回 0 (EOF)。
- `write`：缓冲满且读端仍在 → 阻塞；读端全关 → 返回 `-EPIPE`。
- `close`：关闭对应端并唤醒对端。

### 数据结构示例

```c
#define PIPE_BUFSIZE 4096

struct pipe {
    char buf[PIPE_BUFSIZE];
    size_t rpos, wpos;      // 环形缓冲读写位置
    size_t count;           // 当前字节数
    int readers, writers;   // 打开的读/写端计数
    semaphore_t sem_read;   // 等待非空
    semaphore_t sem_write;  // 等待非满
    spinlock_t lock;        // 保护上述状态
    struct file *rf;        // 读端 file*
    struct file *wf;        // 写端 file*
};

static const struct fileops pipe_ops = {
    .read  = pipe_read,
    .write = pipe_write,
    .close = pipe_close,
    // 其他如 seek/poll 可按需实现或返回不支持
};
```

### 接口及语义

- `int pipe_create(struct pipe **pstore, struct file **rf, struct file **wf);`  
  分配并初始化 `pipe`，创建两个绑定 `pipe_ops` 的 `file`，设定读/写权限和引用计数。
- `ssize_t pipe_read(struct file *f, void *buf, size_t n);`  
  加锁；`count==0 && writers>0` → 释放锁阻塞在 `sem_read`；`count==0 && writers==0` → 返回 0；否则复制 `min(n, count)`，更新 `rpos/count`，解锁并 `up(sem_write)` 唤醒写端。
- `ssize_t pipe_write(struct file *f, const void *buf, size_t n);`  
  加锁；若 `readers==0` 直接 `-EPIPE`。缓冲满 (`count==PIPE_BUFSIZE`) 且读端在 → 释放锁阻塞在 `sem_write`；若唤醒后读端已关 → `-EPIPE`。否则写入 `min(n, free)`，更新 `wpos/count`，解锁并 `up(sem_read)` 唤醒读端。
- `int pipe_close(struct file *f);`  
  判定关闭读端或写端，持锁递减 `readers/writers`。若读端计数为 0，唤醒所有写端（让其返回 `-EPIPE`）；若写端计数为 0，唤醒所有读端（若缓冲空则读到 EOF）。
- `int sys_pipe(int fds[2]);`  
  内核创建 `pipe`/`file`，注册到进程的 `files_struct` 并返回两个 fd。

### 同步互斥处理

- **互斥**：用 `spinlock` 保护缓冲区和计数；阻塞前必须释放锁。
- **阻塞/唤醒**：生产者-消费者模式，`sem_read` 等待“非空”，`sem_write` 等待“非满”；唤醒后需重新检查条件以防虚假唤醒。
- **端关闭**：读端关 → 写端写返回 `-EPIPE`；写端关且缓冲空 → 读端读返回 0；关闭动作要唤醒对端。
- **复制/继承**：`fork` 时管道的 `file` 像普通 fd 一样增加引用计数，关闭时减少计数并同步更新 `readers/writers`。

### 集成要点

- 在 `fs/sysfile.c` 增加 `sys_pipe` 系统调用。
- `struct file` 支持一种管道类型（如 `FD_PIPE`），绑定 `pipe_ops`。
- 复用内核已有的信号量/等待队列实现阻塞唤醒；用户态无需特殊处理，直接通过常规 `read/write/close` 操作。

### UNIX 管道机制概要实现方案

- 核心对象：`pipe` 结构持有环形缓冲区、读写位置/计数、读写端数量以及 `sem_read/sem_write` 与自旋锁，两端 `file` 共享同一实例。
- 创建：`pipe_create` 分配并初始化 `pipe`，生成绑定 `pipe_ops` 的读/写 `file`，填写权限和引用计数，`sys_pipe` 注册到进程 fd 表。
- 读：`count==0 && writers>0` 释放锁并等待 `sem_read`；`writers==0` 返回 0；否则按可读长度搬运数据，推进 `rpos/count`，唤醒 `sem_write`。
- 写：若 `readers==0` 直接 `-EPIPE`；`count==PIPE_BUFSIZE` 时等待 `sem_write`，醒来后若无读端也返回 `-EPIPE`；有空闲则写入、更新 `wpos/count` 并唤醒 `sem_read`。
- 关闭：递减对应计数；读端清零唤醒写端让其感知 `-EPIPE`，写端清零唤醒读端让其在缓冲空时读到 EOF；两端计数皆 0 时释放 `pipe`。


## Challenge2：UNIX 软链接与硬链接机制设计方案

### 1. 需求与语义

#### 1.1 硬链接（hard link）

- 本质：在目录中新增一个“名字 -> 同一 inode” 的目录项。
- 语义：多个目录项共享同一 inode；inode 的 `nlinks`（链接计数）记录有多少个目录项引用它。
- 删除规则：`unlink` 删除一个目录项并使 `nlinks--`；当 `nlinks==0` 且没有任何打开引用（如 `inode/refcount` 或 `file` 引用）时，才真正释放 inode 及其数据块。
- 通常限制：不能对目录创建硬链接（避免目录环），或仅允许受控行为（如 `.`/`..`）。

#### 1.2 软链接（symbolic link）

- 本质：创建一种特殊类型 inode（symlink），其“文件内容”是目标路径字符串。
- 语义：路径解析时遇到 symlink，默认把它替换为其目标路径继续解析（可设置最大跳转层数防止循环）。
- `readlink`：读取 symlink 存储的目标路径文本，不进行继续解析。

### 2. 数据结构设计（示例）

下面给出“最小可行”的结构扩展设计，尽量复用 ucore 当前的 VFS/inode 框架。

#### 2.1 inode 扩展（内存态）

```c
// 内存态 inode（抽象层）可增加/显式化以下字段
struct inode {
		// ... existing fields ...
		uint32_t i_mode;        // 文件类型/权限（也可复用现有 type）
		uint32_t i_nlinks;      // 硬链接计数（对应磁盘 inode 的 nlinks）
		uint32_t i_ref;         // 打开引用计数（已有机制也可复用）
};
```

说明：现在的 SFS 磁盘 inode 已包含 `nlinks` 字段（在 `load_inode` 时会断言 `din->nlinks != 0`），因此硬链接主要是把“目录项新增/删除”与“nlinks 增减/回收时机”串起来。

#### 2.2 SFS 磁盘 inode/目录项扩展（磁盘态）

```c
// 目录项：硬链接复用现有 (name, ino)
struct sfs_disk_entry {
		uint32_t ino;
		char name[SFS_MAX_FNAME_LEN + 1];
};

// 磁盘 inode：增加一种类型表示 symlink
// 方案A：用“文件数据块”存放目标路径（最通用）
// type = SFS_TYPE_LINK, size = strlen(target)
```

软链接的两种存储方案：

- 方案A（推荐，简单且通用）：symlink 的目标路径作为该 inode 的普通文件内容存放（支持任意长度，受文件大小限制）。
- 方案B（优化，小路径）：在 disk inode 中新增一个小数组直接存目标路径（fast symlink），超长则回退到方案A。

### 3. 接口设计（系统调用 + VFS + FS层）

#### 3.1 用户态系统调用（语义）

```c
// 创建硬链接 newpath 指向 oldpath 的 inode
int sys_link(const char *oldpath, const char *newpath);

// 删除一个目录项
int sys_unlink(const char *path);

// 创建软链接：linkpath 是新建的 symlink 文件名，内容为 target
int sys_symlink(const char *target, const char *linkpath);

// 读取软链接内容（不跟随）
ssize_t sys_readlink(const char *path, char *buf, size_t bufsz);
```

当前代码中已经存在 `sysfile_link/sysfile_unlink` 并下沉到 `vfs_link/vfs_unlink`，因此硬链接的“系统调用通路”基本具备，主要工作是让具体文件系统（如 SFS）实现对应 VFS 操作并维护 `nlinks`。

#### 3.2 VFS 层 vnode/inode 操作（语义）

```c
// 在目录 dir 下创建一个名字 name，指向目标 inode（硬链接）
int vop_link(struct inode *dir, const char *name, struct inode *target);

// 在目录 dir 下删除名字 name
int vop_unlink(struct inode *dir, const char *name);

// 创建软链接 inode 并写入 target 路径
int vop_symlink(struct inode *dir, const char *name, const char *target);

// 读取软链接内容
int vop_readlink(struct inode *node, struct iobuf *iob);
```

同时需要在路径解析中支持：

- `vfs_lookup` 遇到 symlink：若允许跟随，则读取其 target 并继续解析；
- 增加跳转上限（如 8 或 16）防止 `a -> b -> a` 循环；
- 支持 `O_NOFOLLOW`（或在接口参数里带一个 follow 标志）。

#### 3.3 SFS 层实现要点（语义）

- `sfs_link(dir, name, target_ino)`
  - 检查 `name` 不存在；在目录数据中分配一个空目录项写入 `(name, target_ino)`；
  - 读取 target inode，将 `nlinks++` 并标记 dirty，最后 `fsync`。
- `sfs_unlink(dir, name)`
  - 找到目录项得到 `target_ino`，清空该目录项；
  - 读取 target inode，`nlinks--`；若 `nlinks==0` 则释放其数据块与 inode 块（但要考虑“仍被打开”的引用）。
- `sfs_symlink(dir, name, target_path)`
  - 分配新 inode，type=LINK；写入目标路径到其数据块；再在 dir 中新增目录项指向该 inode。
- `sfs_readlink(node)`
  - 读取该 inode 的文件内容返回给用户。

### 4. 同步互斥与一致性设计

该部分是实现链接机制时最容易出错的点（竞争条件/死锁/崩溃后不一致）。建议策略：

1) 锁粒度

- 目录操作需要锁住父目录 inode（防止并发创建/删除同名 entry）。
- 修改 target inode 的 `nlinks` 需要锁住 target inode。
- 文件系统全局位图/超级块更新使用 FS 全局锁（你现有 SFS 已有 `lock_sfs_fs` 一类的保护）。

2) 锁顺序（避免死锁）

- 推荐固定顺序：先锁父目录 inode，再锁目标 inode；若需要同时锁两个 inode，按 inode 号从小到大排序加锁。

3) 原子性与崩溃一致性（简化版）

- `link` 的关键原子组：
  - 写目录项（新增名字） + `nlinks++`。
- `unlink` 的关键原子组：
  - 清目录项（移除名字） + `nlinks--` +（可能的）释放数据块/释放 inode。
- 在没有日志（journaling）的前提下，至少要保证：
  - 先写入“目录项变化”或“nlinks变化”中的一种，并在 fsync 时把相关 inode/目录块/位图都刷盘，避免出现“目录项指向已释放 inode”这类更严重的不一致。

4) 打开引用与延迟删除

- 需要区分 `nlinks`（目录引用）与 `refcount`（打开引用）。
- 当 `nlinks==0` 但仍有打开引用时：
  - 仅做“目录不可达”，并把 inode 标记为待删除；
  - 在最后一个 `close/reclaim` 时再真正释放数据块与 inode。

### 5. 小结

- 硬链接：复用目录项 `(name, ino)`，核心在 `nlinks` 的维护与“何时真正回收”。
- 软链接：新增一种 inode 类型，把目标路径当作内容存储；路径解析时支持跟随与防环。
- 同步互斥：目录/目标 inode/全局位图三类共享状态必须有一致的锁策略与锁顺序。