# 练习1 - 时钟中断处理

## 一、实验目标

本次实验的核心目标是深入理解操作系统中的中断处理机制，特别是时钟中断。具体要求如下：

- 在 `kern/trap/trap.c` 中，完善 `interrupt_handler` 函数。
- 实现对 `IRQ_S_TIMER`（Supervisor 模式时钟中断）的处理逻辑。
- 每当操作系统累计接收到 100 次时钟中断时，调用 `print_ticks()` 函数，在控制台输出一行 "100 ticks"。
- 在累计输出 10 行 "100 ticks" 后，调用 `sbi.h` 中定义的 `sbi_shutdown()` 函数，关闭系统。

## 二、实现过程与代码说明

为了实现上述目标，主要修改了 `kern/trap/trap.c` 文件。

### 1. 定位修改点

修改的核心代码位于 `interrupt_handler` 函数的 `switch` 语句中，针对 `case IRQ_S_TIMER:` 分支进行填充。

### 2. 引入必要的头文件

由于需要调用关机函数 `sbi_shutdown()`，首先在文件顶部添加了 SBI 的头文件：

```
#include <sbi.h>
```

### 3. 编写时钟中断处理逻辑

在 `case IRQ_S_TIMER:` 分支中，添加了如下代码。为了解决在 `case` 标签下直接定义变量的 C 语言语法限制，整个逻辑块被包含在一对花括号 `{}` 中。

```
case IRQ_S_TIMER: {
    // 1. 定义一个静态变量来记录打印次数
    static int print_count = 0;

    // 2. 设置下一次时钟中断事件
    clock_set_next_event();

    // 3. 增加全局时钟中断计数器
    ticks++;

    // 4. 判断是否达到100次中断
    if (ticks % TICK_NUM == 0) {
        // 调用子程序打印信息
        print_ticks();
        // 打印次数计数器加一
        print_count++;

        // 5. 判断是否已打印10次
        if (print_count >= 10) {
            // 调用SBI关机函数
            sbi_shutdown();
        }
    }
    break;
}
```

**代码逻辑详解：**

- `static int print_count = 0;`：我们需要一个计数器来记录 "100 ticks" 这行信息被打印了多少次。中断处理函数每次被调用时，它的局部变量都会被销毁。为了让 `print_count` 的值能在多次中断调用之间保持不变，我们必须将其声明为 `static` 静态变量。它只在第一次进入该代码块时被初始化为 0。
- `clock_set_next_event();`：这是中断处理中至关重要的一步。在响应当前中断后，必须立即设置下一次定时器触发的时间点。这样才能保证时钟中断能够以固定的频率持续、周期性地发生。
- `ticks++;`：`ticks` 是在 `clock.c` 中定义的全局变量，用于记录系统启动以来发生的时钟中断总次数。我们在这里将其递增。
- `if (ticks % TICK_NUM == 0)`：通过取模运算，我们判断 `ticks` 是否是 `TICK_NUM`（宏定义为 100）的整数倍。如果是，则意味着又经过了 100 次时钟中断。
- `print_ticks(); print_count++;`：在满足条件时，调用题目要求的 `print_ticks` 函数，并增加我们自己的打印次数计数器。
- `if (print_count >= 10)`：每次增加 `print_count` 后，立刻检查其值是否已经达到 10。如果达到，说明任务已经完成。
- `sbi_shutdown();`：调用 SBI 接口函数，通知底层固件关闭系统，实验流程结束。

## 三、定时器中断处理流程

操作系统处理一次定时器中断的完整流程如下：

1. **硬件触发**：由 `clock_init` 初始化的 CPU 定时器到达了 `clock_set_next_event` 所设定的时间点，硬件自动向 CPU 发送一个中断请求。
2. **CPU 响应与模式切换**：CPU 检测到中断信号后，会立即暂停当前正在执行的指令。硬件自动完成以下操作：
   - 将当前的程序计数器（PC）保存到 `sepc` 寄存器。
   - 将当前的特权级等状态保存到 `sstatus` 寄存器。
   - 根据中断来源设置 `scause` 寄存器（此处为 `IRQ_S_TIMER`）。
   - CPU 从 Supervisor-Mode（或 User-Mode）切换到 Supervisor-Mode。
   - 从 `stvec` 寄存器中读取中断向量表的基地址，并跳转到该地址执行。在我们的实验中，该地址指向 `kern/trap/trapentry.S` 中的 `__alltraps`。
3. **上下文保存**：`__alltraps` 中的汇编代码负责将所有通用寄存器的当前值（即被中断前的程序现场）压入内核栈中，形成一个 `trapframe` 结构体。
4. **调用 C 处理函数**：汇编代码将指向 `trapframe` 的指针作为参数，调用 C 语言实现的 `trap()` 函数。
5. **中断分发**：`trap()` 函数调用 `trap_dispatch()`，该函数通过检查 `trapframe` 中的 `cause` 值来判断中断/异常的具体类型。因为时钟中断的 `cause` 是一个负数，它会调用 `interrupt_handler()`。
6. **执行中断服务例程**：`interrupt_handler()` 使用 `switch-case` 语句，根据 `cause` 值精确匹配到 `case IRQ_S_TIMER:` 分支，执行我们在上一节编写的具体处理逻辑。
7. **中断返回与上下文恢复**：C 函数执行完毕并返回后，控制权回到 `trapentry.S`。汇编代码从内核栈上的 `trapframe` 中恢复所有通用寄存器的值。
8. **特权级返回**：最后，执行 `sret` 指令。该指令会原子地完成以下操作：
   - 将 `sepc` 的值恢复到程序计数器 PC。
   - 恢复 `sstatus` 寄存器中的状态，使 CPU 退回到中断前的特权级。
   - 程序从被中断的指令处继续往下执行，仿佛什么都没有发生过。

## 四、实验结果与验证

将修改后的代码编译并运行 `make qemu`，观察到控制台输出如下：

```
... (省略系统启动信息)
++ setup timer interrupts
... (省略可能存在的异常测试输出)
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
100 ticks
```

控制台准确地输出了 10 行 "100 ticks"，大约每秒输出一次。在第 10 行输出后，QEMU 模拟器自动退出，返回到命令行提示符。

**结论**：实验结果与预期完全一致，证明时钟中断处理逻辑已正确实现，成功完成了计数、打印和关机的全部要求。

# 扩展练习 Challenge1：描述与理解中断流程

## 1. 中断异常处理流程

### 异常/中断触发：

- 当 CPU 执行指令时，可能会遇到异常（如非法指令、断点指令）或接收到外部设备的中断（如时钟中断）。
- CPU 会根据当前模式（用户模式或内核模式）和异常类型，跳转到异常向量表中指定的入口地址。

### 进入 `__alltraps`：

- 异常向量表中的入口地址指向 `__alltraps`，这是一个汇编实现的异常处理入口。
- `__alltraps` 的作用是保存当前 CPU 的上下文（寄存器状态）到内核栈中。

### 保存上下文（`SAVE_ALL` 宏）：

- `SAVE_ALL` 宏会将所有通用寄存器（如 `x0` 到 `x31`）和部分控制寄存器（如 `sstatus`、`sepc`、`stval`、`scause`）保存到内核栈中。
- 保存的顺序和位置由 `SAVE_ALL` 宏中的代码决定。

### 调用 C 语言的 `trap` 函数：

- `__alltraps` 保存上下文后，会调用 C 语言实现的 `trap` 函数。
- `trap` 函数的作用是根据异常类型分发到具体的处理函数（`interrupt_handler` 或 `exception_handler`）。

### 处理中断或异常：

- 如果是中断，调用 `interrupt_handler`，处理时钟中断、外部中断等。
- 如果是异常，调用 `exception_handler`，处理非法指令、断点等。

### 恢复上下文（`RESTORE_ALL` 宏）：

- 异常或中断处理完成后，`trap` 函数返回到 `__alltraps`。
- `__alltraps` 使用 `RESTORE_ALL` 宏恢复之前保存的寄存器状态。

### 返回到异常发生前的代码：

- 恢复上下文后，CPU 执行 `sret` 指令，返回到异常发生前的代码继续执行。

---

## 2. `mov a0, sp` 的目的

在 `__alltraps` 中，`mov a0, sp` 的作用是将当前栈指针（`sp`）的值传递给 `trap` 函数的第一个参数 `a0`。

### 原因：

- `sp` 指向保存了当前上下文（寄存器状态）的内核栈。
- `trap` 函数需要访问这些上下文信息（如 `sstatus`、`sepc`、`scause` 等），因此需要将 `sp` 传递给 `trap`。

### 作用：

- `trap` 函数通过 `sp` 访问保存的上下文信息，判断异常类型并进行处理。

---

## 3. `SAVE_ALL` 中寄存器保存位置的确定

在 `SAVE_ALL` 宏中，寄存器保存的位置由栈指针 `sp` 和偏移量确定。例如：

### 保存顺序：

- 通用寄存器（`x0` 到 `x31`）按照编号顺序保存。
- 控制寄存器（如 `sstatus`、`sepc`）按照固定偏移量保存。

### 位置确定的依据：

- 每个寄存器占用 `REGBYTES`（通常为 8 字节）。
- 保存顺序和偏移量由 `SAVE_ALL` 宏的实现决定。

---

## 4. 是否需要保存所有寄存器？

### 答案：

- 不一定需要保存所有寄存器，具体取决于中断或异常的类型。
- 例如：
  - 如果是时钟中断，可能只需要保存部分寄存器。
  - 如果是异常（如非法指令），通常需要保存所有寄存器。

### 原因：

- 保存寄存器的目的是保护当前上下文，防止中断或异常处理过程中破坏原有状态。
- 对于某些中断（如时钟中断），可以只保存必要的寄存器，减少开销。

### uCore 的实现：

- `SAVE_ALL` 默认保存所有寄存器，以确保通用性和安全性。
- 如果需要优化，可以根据中断类型选择性保存寄存器。

# 扩展练习 Challenge2：理解上下文切换机制

### **csrw sscratch, sp；csrrw s0, sscratch, x0 的操作与目的**

1. **指令功能解析**

- **csrw sscratch, sp**：将当前栈指针（sp）的值写入 sscratch 寄存器。
  - 若中断发生在用户态，sp 是用户栈指针；若发生在内核态，sp 是内核栈指针。这条指令的作用是 “暂存当前栈指针”。
- **csrrw s0, sscratch, x0**：csrrw 是 “原子交换” 指令，将 sscratch 的值（即上一步保存的 sp）读取到 s0 中，同时将 x0（0）写入 sscratch。
  - 结果：s0 保存了中断发生时的原始栈指针（用户栈或内核栈），sscratch 被重置为 0。

2. **核心目的：实现栈切换与状态标识**

- **栈切换**：中断处理需要使用内核栈（而非用户栈，避免用户态数据污染内核）。通过上述指令，原始栈指针（可能是用户栈）被保存到 s0 中，后续可以通过 sscratch 或内核预设的栈指针切换到内核栈，确保中断处理在安全的内核栈中执行。
- **状态标识**：sscratch 被重置为 0 后，可作为 “当前处于中断处理（内核态）” 的标识。后续在中断返回时，可通过 sscratch 的值判断原始栈是否为用户栈，从而正确恢复 sp。

### **保存 stval/scause 但不还原的原因**

1. **保存 stval/scause 的意义**

   stval 和 scause 是记录中断 / 异常关键信息的 CSR 寄存器：

- scause：记录中断 / 异常的类型（如时钟中断 IRQ_S_TIMER、非法指令 CAUSE_ILLEGAL_INSTRUCTION）。

- stval：记录与异常相关的附加信息（如内存访问异常的地址、非法指令的二进制值）。

  中断处理函数（如 trap.c 中的 interrupt_handler 或 exception_handler）需要这些信息来判断中断原因并执行对应逻辑（例如：时钟中断需要计数，非法指令需要打印异常地址）。保存到栈中是为了在处理函数中能够安全访问这些信息，避免被后续操作覆盖。

2. **不还原的原因**

   stval 和 scause 是 “一次性有效” 的寄存器，仅对当前中断 / 异常有意义：

- 处理完当前中断后，这些信息已被消费（例如：时钟中断已计数，异常已打印），后续无需保留。

- 下一次中断 / 异常发生时，硬件会自动更新 stval 和 scause 为新的信息，旧值已无意义。

  若强行还原，会导致下一次中断处理读取到错误的旧信息，干扰正常逻辑。因此，保存是为了当前处理，不还原是因为后续无需复用。

### **总结**

- 栈相关指令的核心是实现用户栈与内核栈的安全切换，同时保存原始栈状态以便返回。
- 保存 stval/scause 是为了给中断处理函数提供必要的异常信息，不还原是因为这些信息仅对当前中断有效，后续会被新中断覆盖。

# **扩展练习 Challenge3 ： 完善异常处理**

#### **一、 实验目标**

本挑战练习的目标是扩展实验一中建立的中断处理框架，使其能够处理两种特定的同步异常（Exceptions）：非法指令异常和断点异常。具体要求如下：

1. 在内核启动代码中，主动触发一条非法指令异常和一条断点异常。
2. 在kern/trap/trap.c的exception_handler函数中，为这两种异常编写处理逻辑。
3. 处理逻辑需要能够识别异常类型，并打印出异常类型和触发异常的指令地址。
4. 在处理完异常后，系统必须能够继续正常执行，而不是崩溃或陷入死循环。

#### **二、 实验原理**

**1. 异常与中断的区别**

- **中断 (Interrupt)**: 通常是来自外部硬件的**异步**事件（如时钟、I/O设备），与CPU当前执行的指令无关。
- **异常 (Exception)**: 是CPU在执行指令过程中，由于指令本身的问题（如除以零、非法指令）而产生的**同步**事件。

**2. 异常处理机制**
当一个异常发生时，RISC-V CPU的硬件处理流程与中断非常相似：它会暂停当前执行，保存关键寄存器（sepc, scause等），切换到S模式，并跳转到stvec指定的地址。我们的trap机制会捕获到这个事件。通过检查scause寄存器的值，我们可以区分出具体的异常类型，例如CAUSE_ILLEGAL_INSTRUCTION (值为2) 和 CAUSE_BREAKPOINT (值为3)。

**3. 关键挑战：指令长度与epc更新**
在处理完一个异常后，为了让程序能继续执行，我们必须手动更新sepc（在我们的trapframe中体现为tf->epc），使其指向下一条合法的指令。如果不更新，sret返回后会再次执行导致异常的指令，从而陷入无限的异常循环。

RISC-V指令集包含一个标准的"C"扩展，即压缩指令集。这意味着指令可以是标准的32位（4字节）长，也可以是压缩的16位（2字节）长。**这是一个关键点**：我们不能想当然地认为所有指令都是4字节长，并简单地执行tf->epc += 4;。这样做在遇到2字节长的压缩指令（如c.ebreak）时，会导致epc跳过头，指向下一条指令的中间，从而引发新的非法指令异常。

解决方案是：在处理异常时，读取异常指令地址（tf->epc）处的内容，通过指令编码来判断其长度。RISC-V规范规定：

- 所有16位压缩指令的最低两位（bit 1-0）**不**是11。
- 所有32位（或更长）指令的最低两位**必须**是11。
  我们可以利用此规则来决定epc应该增加2还是4。

#### **三、 实现过程与代码说明**

**1. 触发异常 (kern/init/init.c)**
为了测试我们的处理函数，需要在内核中主动制造异常。我们在kern_init函数的主循环前加入了内联汇编代码：

```
// ... 在 intr_enable() 之后 ...
cprintf("Now going to trigger an illegal instruction exception...\n");
// 插入一个全零的字，这在RISC-V中被定义为非法指令
asm volatile(".word 0x00000000"); 

cprintf("Now going to trigger a breakpoint exception...\n");
// 插入一条ebreak指令，用于触发断点异常
asm volatile("ebreak");

cprintf("Exception handling test complete.\n");
// ...
```

这三段代码确保了在系统进入时钟中断循环前，会依次触发非法指令和断点异常。Exception handling test complete.这行打印是检验我们是否成功处理并从异常中恢复的关键。

**2. 捕获与处理异常 (kern/trap/trap.c)**
核心修改位于exception_handler函数中。我们为CAUSE_ILLEGAL_INSTRUCTION和CAUSE_BREAKPOINT添加了处理逻辑。

```
void exception_handler(struct trapframe *tf) {
    switch (tf->cause) {
        case CAUSE_ILLEGAL_INSTRUCTION:
            cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
            cprintf("Exception type:Illegal instruction\n");
            {
                // 读取指令的前2个字节
                uint16_t insn = *(uint16_t *)tf->epc;
                // 检查最低两位来判断指令长度
                if ((insn & 0x3) == 0x3) {
                    tf->epc += 4; // 32位指令
                } else {
                    tf->epc += 2; // 16位指令
                }
            }
            break;

        case CAUSE_BREAKPOINT:
            cprintf("ebreak caught at 0x%08x\n", tf->epc);
            cprintf("Exception type: breakpoint\n");
            {
                // 同样需要检查指令长度
                uint16_t insn = *(uint16_t *)tf->epc;
                if ((insn & 0x3) == 0x3) {
                    tf->epc += 4; // 32位指令
                } else {
                    tf->epc += 2; // 16位指令
                }
            }
            break;

        // ... 其他 case ...
    }
}
```

**代码逻辑详解：**

- 我们首先根据tf->epc打印出题目要求的异常类型和地址。
- 然后，通过uint16_t insn = *(uint16_t *)tf->epc;这行代码，我们将epc指向的地址强制转换为一个16位无符号整数指针，并解引用，从而读取到指令的前16位（2字节）。
- if ((insn & 0x3) == 0x3) 这行代码是关键。它对读取到的指令码进行按位与操作，检查其最低两位是否为11。
- 根据判断结果，我们将tf->epc相应地增加4或2，确保它能精确地指向下一条指令的开头。
- 这段逻辑对两种异常都适用，保证了处理的健壮性。

#### **四、 实验结果与验证**

将修改后的代码编译并运行make qemu，观察到控制台输出如下：

```
... (省略系统启动信息)
++ setup timer interrupts
Now going to trigger an illegal instruction exception...
Illegal instruction caught at 0xc02000a8
Exception type:Illegal instruction
Now going to trigger a breakpoint exception...
ebreak caught at 0xc02000b8
Exception type: breakpoint
Exception handling test complete.
100 ticks
... (时钟中断继续)
```

**结果分析：**

1. 程序按预期打印了Now going to trigger an illegal instruction exception...。
2. 随后，系统成功捕获了非法指令异常，并打印出Illegal instruction caught at 0xc02000a8和Exception type:Illegal instruction，地址也正确。
3. 程序从异常中恢复，继续执行并打印了Now going to trigger a breakpoint exception...。
4. 紧接着，系统又成功捕获了断点异常，并打印出ebreak caught at 0xc02000b8和Exception type: breakpoint。
5. 最关键的是，程序再次从异常中恢复，并成功打印了 **Exception handling test complete.**。这证明我们对epc的更新是正确的，程序流没有被中断，也没有陷入异常循环。
6. 之后，系统正常进入时钟中断处理阶段，开始打印 "100 ticks"。

**结论**：实验结果与预期完全一致，证明我们已经成功实现了对非法指令和断点异常的捕获、处理和恢复。

# 实验中的重要知识点及其与OS原理的对应关系

## 1. 中断与异常处理 

### 实验中的知识点
- **中断向量与分发**：  
  通过 `idt_init` 函数设置 `stvec` 寄存器，将所有中断、异常的入口点统一指向 `__alltraps`。  
  在 `trap_dispatch` 函数中，通过判断 `tf->cause` 的值来区分中断（负值）和异常（正值），并调用不同的处理函数（`interrupt_handler` 或 `exception_handler`）。

- **中断服务例程 (ISR)**：  
  为时钟中断 `IRQ_S_TIMER`、非法指令和断点异常编写了具体的处理代码。

- **上下文保存与恢复**：  
  虽然未直接编写，但 `trapentry.S` 中的 `__alltraps` 负责将所有通用寄存器保存在 `trapframe` 结构体中，并在处理结束后通过 `sret` 指令恢复现场。这是机制正常运行的基石。

### 对应的 OS 原理知识点
- **中断驱动**：  
  现代操作系统的核心工作模式。OS 不再轮询设备状态，而是等待硬件通过中断信号通知事件发生，从而提高 CPU 利用率。

- **双模式与特权级转换 **：  
  当中断或异常发生时，CPU 会自动从用户态切换到内核态（RISC-V 中是从 U/S 模式切换到 S/M 模式），并将控制权交给内核代码。这是 OS 保护和管理硬件资源的前提。

### 我的理解
- **关系**：  
  实验中的 Trap 处理机制，是 OS “中断驱动” 与 “特权级转换” 两大核心原理的工程化体现。  
  `trapframe` 是上下文（Context）的实体化；`stvec` 的设置是中断向量表的初始化；`interrupt_handler` 是中断服务例程。  
  从硬件触发 → `__alltraps` → C 函数处理，完整展示了 OS 如何从硬件手中接管控制权。

- **差异**：  
  实验中处理简化。例如时钟中断仅计数与打印；真实 OS 中，时钟中断会触发调度器（Scheduler）以决定下一个运行进程。  
  异常处理部分也仅打印信息，而真实 OS 会发送信号（如 `SIGILL`）、或进行调试操作。

---

## 2. 系统调用接口 

### 实验中的知识点
- **SBI 调用**：  
  使用 `sbi.h` 中的函数，如 `sbi_set_timer()` 和 `sbi_shutdown()`。  
  它们通过 `ecall` 指令，从 Supervisor 模式陷入 Machine 模式，请求 M 模式固件（Firmware）服务。

### 对应的 OS 原理知识点
- **系统调用·**：  
  操作系统为用户程序提供的访问内核服务的唯一接口。  
  用户程序通过特殊指令（x86 的 `int 0x80`，RISC-V 的 `ecall`）主动陷入内核，请求执行高权限操作（如文件读写、内存申请等）。

### 我的理解
- **关系与类比**：  
  实验中的 SBI 调用与系统调用机制相同：都通过 `ecall` 实现从低特权级到高特权级的受控转换，并通过寄存器传递服务编号。  
  在实验中，运行于 M 模式的 SBI 固件相当于“微型底层 OS”，而运行在 S 模式的内核相当于其“用户程序”。

- **差异**：  
  SBI 调用服务于内核与底层固件之间（如定时器、关机）；  
  系统调用则服务于用户程序与操作系统之间（如 `open`, `read`, `fork` 等）。

---

# OS 原理中重要但在本实验中未体现的知识点

## 1. 进程与线程管理 

- **原理**：  
  OS 负责管理多个同时运行的程序（进程），包括创建、销毁、调度与通信。线程是进程内的执行单元，支持并发。

- **实验缺失**：  
  实验内核仅有单一执行流，无进程/线程抽象，无 `fork()`、`exec()`、PCB 等结构。  
  时钟中断仅计数，无调度算法（如 FIFO、RR、Priority Scheduling）。

---

## 2. 虚拟内存管理 

- **原理**：  
  OS 为每个进程提供独立的虚拟地址空间，通过分页（Paging）将虚拟地址映射到物理内存，实现隔离与保护。

- **实验缺失**：  
  尽管存在 `pmm.c`（物理内存管理器），但只负责页帧分配与释放。  
  无页表建立、虚拟地址映射或缺页异常处理。  
  地址映射采用简单的直接映射，而非动态按需分配。

---

## 3. 并发与同步 

- **原理**：  
  多进程或多线程访问共享资源时，需使用同步机制（锁、信号量）避免竞争条件，保证数据一致性。

- **实验缺失**：  
  无多任务并发，自然也无共享资源访问与同步原语的需求。

---

## 4. 文件系统 

- **原理**：  
  文件系统管理持久化存储，将数据组织为文件和目录，提供创建、读写、删除等接口。

- **实验缺失**：  
  实验系统完全运行于内存中，无磁盘交互与文件概念。关机后所有状态丢失。