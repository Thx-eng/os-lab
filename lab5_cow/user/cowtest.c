#include <stdio.h>
#include <ulib.h>
#include <string.h>

volatile int global_cnt = 0;

int main(void) {
    cprintf("COW TEST: Start\n");

    int pid = fork();
    
    if (pid == 0) {
        // --- 子进程 ---
        cprintf("COW TEST: Child process created (pid %d)\n", getpid());
        
        // 1. 读取变量（此时应共享物理页，不触发 COW）
        cprintf("COW TEST: Child read global_cnt = %d (Address shared)\n", global_cnt);
        
        // 2. 尝试修改变量（此时应触发页表写异常 -> 内核执行 COW -> 分配新页）
        cprintf("COW TEST: Child attempting to write global_cnt...\n");
        global_cnt = 100; 
        
        cprintf("COW TEST: Child modified global_cnt = %d\n", global_cnt);
        cprintf("COW TEST: Child exit\n");
        exit(0);
    } 
    else {
        // --- 父进程 ---
        cprintf("COW TEST: Parent waiting for child...\n");
        
        // 等待子进程结束
        waitpid(pid, NULL);
        
        // 3. 检查父进程的值（如果 COW 正确，父进程的值不应被子进程改变）
        cprintf("COW TEST: Parent read global_cnt = %d (Should be 0)\n", global_cnt);
        
        if (global_cnt == 0) {
            cprintf("COW TEST: RESULT: PASSED (Parent memory was protected)\n");
        } else {
            cprintf("COW TEST: RESULT: FAILED (Parent memory was modified!)\n");
        }
    }
    return 0;
}