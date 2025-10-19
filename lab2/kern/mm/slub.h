#ifndef __KERN_MM_SLUB_H__
#define __KERN_MM_SLUB_H__

#include <defs.h>

// 初始化SLUB分配器
void slub_init(void);

// 分配指定大小的内存
void *kmalloc(size_t size);

// 释放之前分配的内存
void kfree(void *obj);

// 用于测试SLUB分配器功能的函数
void slub_test(void);

#endif /* !__KERN_MM_SLUB_H__ */