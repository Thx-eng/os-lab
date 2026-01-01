#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <default_sched.h>

/*
 * RR_init initializes the run-queue rq with correct assignment for
 * member variables, including:
 *
 *   - run_list: should be an empty list after initialization.
 *   - proc_num: set to 0
 *   - max_time_slice: no need here, the variable would be assigned by the caller.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
static void
RR_init(struct run_queue *rq)
{
    // LAB6: 2311995
    // 初始化运行队列的链表头
    list_init(&(rq->run_list));
    // 初始化进程计数为0
    rq->proc_num = 0;
}

/*
 * RR_enqueue inserts the process ``proc'' into the tail of run-queue
 * ``rq''. The procedure should verify/initialize the relevant members
 * of ``proc'', and then put the ``run_link'' node into the queue.
 * The procedure should also update the meta data in ``rq'' structure.
 *
 * proc->time_slice denotes the time slices allocation for the
 * process, which should set to rq->max_time_slice.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
static void
RR_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2311995
    assert(list_empty(&(proc->run_link)));
    // 将进程的run_link节点插入队列尾部（即run_list之前）
    list_add_before(&(rq->run_list), &(proc->run_link));
    // 如果时间片为0或超过最大时间片，重置为最大时间片
    if (proc->time_slice == 0 || proc->time_slice > rq->max_time_slice)
    {
        proc->time_slice = rq->max_time_slice;
    }
    // 设置进程所属的运行队列
    proc->rq = rq;
    // 更新运行队列中的进程计数
    rq->proc_num++;
}

/*
 * RR_dequeue removes the process ``proc'' from the front of run-queue
 * ``rq'', the operation would be finished by the list_del_init operation.
 * Remember to update the ``rq'' structure.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
static void
RR_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2311995
    assert(!list_empty(&(proc->run_link)));
    // 将进程从运行队列中删除，并重新初始化其run_link
    list_del_init(&(proc->run_link));
    // 更新运行队列中的进程计数
    rq->proc_num--;
}

/*
 * RR_pick_next picks the element from the front of ``run-queue'',
 * and returns the corresponding process pointer. The process pointer
 * would be calculated by macro le2proc, see kern/process/proc.h
 * for definition. Return NULL if there is no process in the queue.
 *
 * hint: see libs/list.h for routines of the list structures.
 */
static struct proc_struct *
RR_pick_next(struct run_queue *rq)
{
    // LAB6: 2311995
    // 获取队列头部的第一个元素
    list_entry_t *le = list_next(&(rq->run_list));
    // 如果队列不为空，返回对应的进程结构体
    if (le != &(rq->run_list))
    {
        return le2proc(le, run_link);
    }
    // 队列为空，返回NULL
    return NULL;
}

/*
 * RR_proc_tick works with the tick event of current process. You
 * should check whether the time slices for current process is
 * exhausted and update the proc struct ``proc''. proc->time_slice
 * denotes the time slices left for current process. proc->need_resched
 * is the flag variable for process switching.
 */
static void
RR_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    // LAB6: 2311995
    // 如果进程时间片大于0，则减一
    if (proc->time_slice > 0)
    {
        proc->time_slice--;
    }
    // 如果时间片耗尽，设置need_resched标志，触发重新调度
    if (proc->time_slice == 0)
    {
        proc->need_resched = 1;
    }
}

struct sched_class default_sched_class = {
    .name = "RR_scheduler",
    .init = RR_init,
    .enqueue = RR_enqueue,
    .dequeue = RR_dequeue,
    .pick_next = RR_pick_next,
    .proc_tick = RR_proc_tick,
};
