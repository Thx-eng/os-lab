# uCore Lab6 实验报告

- **学号**: 2311995
- **实验名称**: 进程调度

---

## 一、实验目的

- 理解操作系统的调度器框架
- 掌握Round Robin调度算法的实现
- 理解进程调度的时机和流程

---

## 二、练习0: 填写已有实验

已将Lab2/3/4/5的代码填入Lab6相应位置，主要包括：

| 文件 | 函数 | 修改内容 |
|------|------|----------|
| `kern/process/proc.c` | `alloc_proc` | 进程控制块初始化（含Lab6调度字段） |
| `kern/process/proc.c` | `proc_run` | 进程切换 |
| `kern/process/proc.c` | `do_fork` | 进程创建 |
| `kern/process/proc.c` | `load_icode` | 用户态trapframe设置 |
| `kern/mm/pmm.c` | `copy_range` | 页面复制 |
| `kern/trap/trap.c` | `IRQ_S_TIMER` | 时钟中断处理+调度器调用 |

Lab6新增的调度相关字段初始化：
```c
proc->rq = NULL;                             // 运行队列指针
list_init(&(proc->run_link));                // 运行队列链表节点
proc->time_slice = 0;                        // 时间片
proc->lab6_run_pool.left = proc->lab6_run_pool.right = proc->lab6_run_pool.parent = NULL;
proc->lab6_stride = 0;                       // stride值
proc->lab6_priority = 1;                     // 优先级（默认1避免除0）
```

---

## 三、练习1: 理解调度器框架的实现

### 3.1 sched_class 结构体分析

```c
struct sched_class {
    const char *name;                                           // 调度器名称
    void (*init)(struct run_queue *rq);                        // 初始化运行队列
    void (*enqueue)(struct run_queue *rq, struct proc_struct *proc);  // 进程入队
    void (*dequeue)(struct run_queue *rq, struct proc_struct *proc);  // 进程出队
    struct proc_struct *(*pick_next)(struct run_queue *rq);    // 选择下一个进程
    void (*proc_tick)(struct run_queue *rq, struct proc_struct *proc); // 处理时钟tick
};
```

**各函数指针的作用和调用时机：**

| 函数指针 | 作用 | 调用时机 |
|----------|------|----------|
| `init` | 初始化运行队列数据结构 | 系统启动时`sched_init()`调用 |
| `enqueue` | 将进程加入就绪队列 | `wakeup_proc()`唤醒进程、`schedule()`中当前进程重新入队 |
| `dequeue` | 将进程从就绪队列移除 | `schedule()`中选中进程后出队 |
| `pick_next` | 选择下一个要运行的进程 | `schedule()`中进行调度决策 |
| `proc_tick` | 处理时钟中断 | 每次时钟中断时`sched_class_proc_tick()`调用 |

**为什么使用函数指针而非直接实现？**

1. **多态性实现**：不同调度算法（RR、Stride、MLFQ等）可以有不同的实现，但对外提供统一接口
2. **可扩展性**：添加新调度算法只需实现一个新的`sched_class`实例，无需修改核心框架代码
3. **运行时可切换**：理论上可以在运行时动态切换调度算法
4. **解耦合设计**：调度框架与具体调度算法分离，符合开闭原则

### 3.2 run_queue 结构体分析

**Lab5 vs Lab6 对比：**

| 特性 | Lab5 | Lab6 |
|------|------|------|
| 头文件 | 简单声明（11行） | 完整定义（54行） |
| 运行队列 | 无显式定义 | `struct run_queue`结构体 |
| 数据结构 | 使用`proc_list` | 链表 + 斜堆 |
| 调度类 | 无 | `sched_class`结构体 |

**Lab6的run_queue结构：**
```c
struct run_queue {
    list_entry_t run_list;          // 链表头（用于RR调度）
    unsigned int proc_num;          // 队列中进程数量
    int max_time_slice;             // 最大时间片
    skew_heap_entry_t *lab6_run_pool; // 斜堆根节点（用于Stride调度）
};
```

**为何需要支持两种数据结构？**

1. **RR调度**：使用链表实现FIFO队列，O(1)入队出队
2. **Stride调度**：使用斜堆实现优先级队列，O(log n)选择最小stride进程
3. **灵活性**：不同调度算法可以选择最适合的数据结构

### 3.3 调度器框架函数分析

**Lab5 vs Lab6 差异：**

| 函数 | Lab5 | Lab6 |
|------|------|------|
| `sched_init` | 无 | 初始化调度类和运行队列 |
| `wakeup_proc` | 仅设置状态 | 设置状态 + 调用`enqueue` |
| `schedule` | 遍历`proc_list` | 调用调度类的`pick_next/dequeue` |

**Lab6中schedule()的实现：**
```c
void schedule(void) {
    current->need_resched = 0;
    if (current->state == PROC_RUNNABLE) {
        sched_class_enqueue(current);   // 当前进程重新入队
    }
    next = sched_class_pick_next();      // 选择下一个进程
    if (next != NULL) {
        sched_class_dequeue(next);       // 被选中进程出队
    }
    if (next == NULL) {
        next = idleproc;                 // 无可运行进程则选idle
    }
    if (next != current) {
        proc_run(next);                  // 切换进程
    }
}
```

**解耦设计优势**：
- 核心调度函数不依赖具体调度算法
- 通过`sched_class`接口调用具体实现
- 添加新算法不需要修改`sched.c`

### 3.4 调度类初始化流程

```
kern_init()
    └── sched_init()
            ├── list_init(&timer_list)        // 初始化定时器列表
            ├── sched_class = &default_sched_class  // 设置调度类
            ├── rq = &__rq                    // 设置运行队列
            ├── rq->max_time_slice = MAX_TIME_SLICE  // 设置最大时间片(5)
            └── sched_class->init(rq)         // 调用RR_init初始化队列
```

### 3.5 进程调度流程图

```
┌─────────────────┐
│   时钟中断      │
│  IRQ_S_TIMER    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│clock_set_next_  │
│event() + ticks++│
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│sched_class_     │
│proc_tick()      │
│  └── RR_proc_   │
│      tick()     │
│      time_slice-│    ┌──────────────────┐
│      if 0:      │───▶│need_resched = 1  │
│                 │    └──────────────────┘
└────────┬────────┘
         │
         ▼ (trap返回时检查)
┌─────────────────┐
│if need_resched  │
│  schedule()     │
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────────────┐
│ schedule() 执行流程:                    │
│ 1. current->need_resched = 0            │
│ 2. sched_class_enqueue(current)         │
│    └── RR_enqueue(): 加入队列尾部       │
│ 3. next = sched_class_pick_next()       │
│    └── RR_pick_next(): 返回队首进程     │
│ 4. sched_class_dequeue(next)            │
│    └── RR_dequeue(): 从队列移除         │
│ 5. proc_run(next): 切换到新进程         │
└─────────────────────────────────────────┘
```

**need_resched标志的作用**：
- 延迟调度决策：时钟中断设置标志，但不立即调度
- 避免中断嵌套：在trap返回用户态时才检查并调度
- 减少调度开销：只有标志被设置时才执行调度

### 3.6 调度算法切换机制

**添加新调度算法需要：**

1. 创建新的调度实现文件（如`stride_sched.c`）
2. 实现`sched_class`的5个函数
3. 定义新的`sched_class`实例
4. 修改`sched_init()`中的赋值（或使用编译选项选择）

**示例：**
```c
// stride_sched.c
struct sched_class stride_sched_class = {
    .name = "stride_scheduler",
    .init = stride_init,
    .enqueue = stride_enqueue,
    .dequeue = stride_dequeue,
    .pick_next = stride_pick_next,
    .proc_tick = stride_proc_tick,
};
```

**设计优势**：
- 仅需修改一行代码即可切换调度算法
- 不影响其他内核模块
- 符合策略与机制分离原则

---

## 四、练习2: 实现Round Robin调度算法

### 4.1 Lab5与Lab6函数对比

**`wakeup_proc()`函数对比：**

```c
// Lab5
void wakeup_proc(struct proc_struct *proc) {
    if (proc->state != PROC_RUNNABLE) {
        proc->state = PROC_RUNNABLE;
        proc->wait_state = 0;
        // 仅设置状态，不加入队列
    }
}

// Lab6
void wakeup_proc(struct proc_struct *proc) {
    if (proc->state != PROC_RUNNABLE) {
        proc->state = PROC_RUNNABLE;
        proc->wait_state = 0;
        if (proc != current) {
            sched_class_enqueue(proc);  // 新增：加入运行队列
        }
    }
}
```

**为何需要此改动？**
- Lab5直接遍历`proc_list`找可运行进程，不需要专门队列
- Lab6使用独立运行队列，唤醒时必须加入队列才能被调度
- 不做此改动会导致唤醒的进程不在运行队列中，永远不会被调度

### 4.2 RR调度函数实现

#### RR_init - 初始化运行队列
```c
static void RR_init(struct run_queue *rq) {
    // LAB6: 2311995
    list_init(&(rq->run_list));  // 初始化循环双链表
    rq->proc_num = 0;            // 进程计数归零
}
```

#### RR_enqueue - 进程入队
```c
static void RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    // LAB6: 2311995
    assert(list_empty(&(proc->run_link)));  // 确保进程不在其他队列
    list_add_before(&(rq->run_list), &(proc->run_link));  // 插入队尾
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice) {
        proc->time_slice = rq->max_time_slice;  // 重置时间片
    }
    proc->rq = rq;
    rq->proc_num++;
}
```

**选择`list_add_before`的原因**：
- `run_list`是哨兵节点，`list_add_before`在其之前插入即为队尾
- 保证FIFO顺序：先入队的进程在队首，先被选中

#### RR_dequeue - 进程出队
```c
static void RR_dequeue(struct run_queue *rq, struct proc_struct *proc) {
    // LAB6: 2311995
    assert(!list_empty(&(proc->run_link)));  // 确保进程在队列中
    list_del_init(&(proc->run_link));        // 删除并重新初始化
    rq->proc_num--;
}
```

**使用`list_del_init`的原因**：
- 删除后重新初始化`run_link`
- 使下次`RR_enqueue`的assert检查能通过

#### RR_pick_next - 选择下一个进程
```c
static struct proc_struct *RR_pick_next(struct run_queue *rq) {
    // LAB6: 2311995
    list_entry_t *le = list_next(&(rq->run_list));  // 获取队首
    if (le != &(rq->run_list)) {
        return le2proc(le, run_link);  // 转换为进程结构体
    }
    return NULL;  // 空队列返回NULL
}
```

**边界处理**：
- 队列为空时返回NULL，由`schedule()`选择`idleproc`

#### RR_proc_tick - 时钟tick处理
```c
static void RR_proc_tick(struct run_queue *rq, struct proc_struct *proc) {
    // LAB6: 2311995
    if (proc->time_slice > 0) {
        proc->time_slice--;
    }
    if (proc->time_slice == 0) {
        proc->need_resched = 1;  // 触发重新调度
    }
}
```

**设置need_resched的原因**：
- 延迟调度：在中断处理中不直接调度，避免复杂性
- 在trap返回时检查标志并执行调度
- 确保调度发生在安全的时机

### 4.3 make grade 结果

```
priority:                (3.1s)
  -check result:                             OK
  -check output:                             OK
Total Score: 50/50
```

✅ **测试全部通过**

### 4.4 QEMU中观察到的调度现象

```
sched class: RR_scheduler
kernel_execve: pid = 2, name = "priority".
main: fork ok,now need to wait pids.
child pid 3, acc 808000, time 2010
child pid 4, acc 796000, time 2010
child pid 5, acc 804000, time 2010
child pid 6, acc 800000, time 2010
child pid 7, acc 800000, time 2010
sched result: 1 1 1 1 1
```

**现象分析**：
- 所有子进程的`acc`值非常接近（~800000）
- 运行时间相同（2010）
- 调度结果`1 1 1 1 1`表示各进程获得均等的CPU时间
- 符合RR调度的预期行为：不考虑优先级，公平轮转

### 4.5 RR调度算法的优缺点

**优点：**
1. **公平性**：所有进程获得相等的CPU时间
2. **实现简单**：只需FIFO队列，O(1)时间复杂度
3. **响应性好**：交互式进程能及时获得CPU

**缺点：**
1. **不支持优先级**：紧急任务无法优先执行
2. **时间片选择困难**：
   - 过大：响应时间变长
   - 过小：上下文切换开销增加
3. **I/O密集型进程不利**：频繁阻塞导致CPU利用率低

**时间片大小优化**：
- 当前设置：`MAX_TIME_SLICE = 5`（5个tick）
- 交互式系统：较小时间片（10-20ms）提高响应性
- 批处理系统：较大时间片（100-200ms）减少切换开销

### 4.6 拓展思考

#### 优先级RR调度修改

需要修改的内容：
1. `RR_enqueue`：根据优先级选择插入位置（高优先级靠前）
2. `RR_pick_next`：保持不变（总是选队首）
3. 或使用多个队列，每个优先级一个队列

```c
// 简单实现：按优先级排序插入
static void Priority_RR_enqueue(struct run_queue *rq, struct proc_struct *proc) {
    list_entry_t *le = &(rq->run_list);
    while ((le = list_next(le)) != &(rq->run_list)) {
        struct proc_struct *p = le2proc(le, run_link);
        if (proc->lab6_priority > p->lab6_priority) {
            break;  // 找到合适位置
        }
    }
    list_add_before(le, &(proc->run_link));
    // 其他代码不变...
}
```

#### 多核调度支持

**当前不支持多核的原因：**
- 只有一个全局运行队列`rq`
- 没有CPU亲和性处理
- 没有负载均衡机制

**改进方案：**
1. **每CPU运行队列**：每个CPU核心一个`run_queue`
2. **负载均衡**：定期在CPU间迁移进程
3. **锁机制**：队列访问需要自旋锁保护
4. **CPU亲和性**：进程尽量在同一CPU上运行

```c
// 多核支持的结构
struct run_queue per_cpu_rq[MAX_CPUS];

static void schedule(void) {
    int cpu = get_cpu_id();
    struct run_queue *rq = &per_cpu_rq[cpu];
    spin_lock(&rq->lock);
    // 调度逻辑...
    spin_unlock(&rq->lock);
}
```

---

## 五、重要知识点

### 5.1 实验中的重要知识点

| 知识点 | 对应OS原理 | 关系与差异 |
|--------|------------|------------|
| `sched_class`框架 | 调度器抽象 | 实验实现了策略与机制分离的设计模式 |
| 时间片管理 | 时间片轮转 | 实验中固定时间片，原理中可动态调整 |
| `need_resched`标志 | 延迟调度 | 保证调度发生在安全点（trap返回时） |
| 运行队列 | 就绪队列 | 实验使用链表+斜堆，原理中可能有更多实现 |
| 上下文切换 | 进程切换 | 实验涉及寄存器保存/恢复、页表切换 |

### 5.2 原理重要但实验未涉及的知识点

1. **多级反馈队列(MLFQ)**：动态调整优先级的复杂调度
2. **实时调度**：硬实时和软实时调度算法
3. **公平共享调度**：如Linux CFS的虚拟运行时间
4. **SMP负载均衡**：多核系统的进程迁移
5. **调度延迟分析**：最坏情况响应时间的计算

---

## 六、实验总结

通过本次实验，我深入理解了：
1. 操作系统调度器的框架设计
2. Round Robin算法的实现细节
3. 时间片管理和调度时机的控制
4. 策略与机制分离的软件设计原则

实验结果表明RR调度正确实现，`make grade`获得满分50/50。
