
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	00007297          	auipc	t0,0x7
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0207000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	00007297          	auipc	t0,0x7
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0207008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)

    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c02062b7          	lui	t0,0xc0206
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c0206137          	lui	sp,0xc0206

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 1. 使用临时寄存器 t1 计算栈顶的精确地址
    lui t1, %hi(bootstacktop)
ffffffffc0200040:	c0206337          	lui	t1,0xc0206
    addi t1, t1, %lo(bootstacktop)
ffffffffc0200044:	00030313          	mv	t1,t1
    # 2. 将精确地址一次性地、安全地传给 sp
    mv sp, t1
ffffffffc0200048:	811a                	mv	sp,t1
    # 现在栈指针已经完美设置，可以安全地调用任何C函数了
    # 然后跳转到 kern_init (不再返回)
    lui t0, %hi(kern_init)
ffffffffc020004a:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc020004e:	05428293          	addi	t0,t0,84 # ffffffffc0200054 <kern_init>
    jr t0
ffffffffc0200052:	8282                	jr	t0

ffffffffc0200054 <kern_init>:
void grade_backtrace(void);

int kern_init(void) {
    extern char edata[], end[];
    // 先清零 BSS，再读取并保存 DTB 的内存信息，避免被清零覆盖（为了解释变化 正式上传时我觉得应该删去这句话）
    memset(edata, 0, end - edata);
ffffffffc0200054:	00007517          	auipc	a0,0x7
ffffffffc0200058:	fd450513          	addi	a0,a0,-44 # ffffffffc0207028 <free_area>
ffffffffc020005c:	00007617          	auipc	a2,0x7
ffffffffc0200060:	44460613          	addi	a2,a2,1092 # ffffffffc02074a0 <end>
int kern_init(void) {
ffffffffc0200064:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc0200066:	8e09                	sub	a2,a2,a0
ffffffffc0200068:	4581                	li	a1,0
int kern_init(void) {
ffffffffc020006a:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc020006c:	777010ef          	jal	ra,ffffffffc0201fe2 <memset>
    dtb_init();
ffffffffc0200070:	438000ef          	jal	ra,ffffffffc02004a8 <dtb_init>
    cons_init();  // init the console
ffffffffc0200074:	426000ef          	jal	ra,ffffffffc020049a <cons_init>
    const char *message = "(THU.CST) os is loading ...\0";
    //cprintf("%s\n\n", message);
    cputs(message);
ffffffffc0200078:	00002517          	auipc	a0,0x2
ffffffffc020007c:	01850513          	addi	a0,a0,24 # ffffffffc0202090 <etext+0x9c>
ffffffffc0200080:	0ba000ef          	jal	ra,ffffffffc020013a <cputs>

    print_kerninfo();
ffffffffc0200084:	106000ef          	jal	ra,ffffffffc020018a <print_kerninfo>

    // grade_backtrace();
    idt_init();  // init interrupt descriptor table
ffffffffc0200088:	7dc000ef          	jal	ra,ffffffffc0200864 <idt_init>

    pmm_init();  // init physical memory management
ffffffffc020008c:	7da010ef          	jal	ra,ffffffffc0201866 <pmm_init>

    idt_init();  // init interrupt descriptor table
ffffffffc0200090:	7d4000ef          	jal	ra,ffffffffc0200864 <idt_init>

    clock_init();   // init clock interrupt
ffffffffc0200094:	3c4000ef          	jal	ra,ffffffffc0200458 <clock_init>
    intr_enable();  // enable irq interrupt
ffffffffc0200098:	7c0000ef          	jal	ra,ffffffffc0200858 <intr_enable>

    // --- 开始测试异常处理 ---
    cprintf("Now going to trigger an illegal instruction exception...\n");
ffffffffc020009c:	00002517          	auipc	a0,0x2
ffffffffc02000a0:	f5c50513          	addi	a0,a0,-164 # ffffffffc0201ff8 <etext+0x4>
ffffffffc02000a4:	05e000ef          	jal	ra,ffffffffc0200102 <cprintf>
ffffffffc02000a8:	0000                	unimp
ffffffffc02000aa:	0000                	unimp
    asm volatile(".word 0x00000000"); // 插入一条非法指令

    cprintf("Now going to trigger a breakpoint exception...\n");
ffffffffc02000ac:	00002517          	auipc	a0,0x2
ffffffffc02000b0:	f8c50513          	addi	a0,a0,-116 # ffffffffc0202038 <etext+0x44>
ffffffffc02000b4:	04e000ef          	jal	ra,ffffffffc0200102 <cprintf>
    asm volatile("ebreak"); // 插入一条断点指令
ffffffffc02000b8:	9002                	ebreak

    cprintf("Exception handling test complete.\n");
ffffffffc02000ba:	00002517          	auipc	a0,0x2
ffffffffc02000be:	fae50513          	addi	a0,a0,-82 # ffffffffc0202068 <etext+0x74>
ffffffffc02000c2:	040000ef          	jal	ra,ffffffffc0200102 <cprintf>
    // --- 异常处理测试结束 ---

    /* do nothing */
    while (1)
ffffffffc02000c6:	a001                	j	ffffffffc02000c6 <kern_init+0x72>

ffffffffc02000c8 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
ffffffffc02000c8:	1141                	addi	sp,sp,-16
ffffffffc02000ca:	e022                	sd	s0,0(sp)
ffffffffc02000cc:	e406                	sd	ra,8(sp)
ffffffffc02000ce:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc02000d0:	3cc000ef          	jal	ra,ffffffffc020049c <cons_putc>
    (*cnt) ++;
ffffffffc02000d4:	401c                	lw	a5,0(s0)
}
ffffffffc02000d6:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
ffffffffc02000d8:	2785                	addiw	a5,a5,1
ffffffffc02000da:	c01c                	sw	a5,0(s0)
}
ffffffffc02000dc:	6402                	ld	s0,0(sp)
ffffffffc02000de:	0141                	addi	sp,sp,16
ffffffffc02000e0:	8082                	ret

ffffffffc02000e2 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000e2:	1101                	addi	sp,sp,-32
ffffffffc02000e4:	862a                	mv	a2,a0
ffffffffc02000e6:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000e8:	00000517          	auipc	a0,0x0
ffffffffc02000ec:	fe050513          	addi	a0,a0,-32 # ffffffffc02000c8 <cputch>
ffffffffc02000f0:	006c                	addi	a1,sp,12
vcprintf(const char *fmt, va_list ap) {
ffffffffc02000f2:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc02000f4:	c602                	sw	zero,12(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc02000f6:	1bd010ef          	jal	ra,ffffffffc0201ab2 <vprintfmt>
    return cnt;
}
ffffffffc02000fa:	60e2                	ld	ra,24(sp)
ffffffffc02000fc:	4532                	lw	a0,12(sp)
ffffffffc02000fe:	6105                	addi	sp,sp,32
ffffffffc0200100:	8082                	ret

ffffffffc0200102 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
ffffffffc0200102:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200104:	02810313          	addi	t1,sp,40 # ffffffffc0206028 <boot_page_table_sv39+0x28>
cprintf(const char *fmt, ...) {
ffffffffc0200108:	8e2a                	mv	t3,a0
ffffffffc020010a:	f42e                	sd	a1,40(sp)
ffffffffc020010c:	f832                	sd	a2,48(sp)
ffffffffc020010e:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc0200110:	00000517          	auipc	a0,0x0
ffffffffc0200114:	fb850513          	addi	a0,a0,-72 # ffffffffc02000c8 <cputch>
ffffffffc0200118:	004c                	addi	a1,sp,4
ffffffffc020011a:	869a                	mv	a3,t1
ffffffffc020011c:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
ffffffffc020011e:	ec06                	sd	ra,24(sp)
ffffffffc0200120:	e0ba                	sd	a4,64(sp)
ffffffffc0200122:	e4be                	sd	a5,72(sp)
ffffffffc0200124:	e8c2                	sd	a6,80(sp)
ffffffffc0200126:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc0200128:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc020012a:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
ffffffffc020012c:	187010ef          	jal	ra,ffffffffc0201ab2 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc0200130:	60e2                	ld	ra,24(sp)
ffffffffc0200132:	4512                	lw	a0,4(sp)
ffffffffc0200134:	6125                	addi	sp,sp,96
ffffffffc0200136:	8082                	ret

ffffffffc0200138 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
    cons_putc(c);
ffffffffc0200138:	a695                	j	ffffffffc020049c <cons_putc>

ffffffffc020013a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
ffffffffc020013a:	1101                	addi	sp,sp,-32
ffffffffc020013c:	e822                	sd	s0,16(sp)
ffffffffc020013e:	ec06                	sd	ra,24(sp)
ffffffffc0200140:	e426                	sd	s1,8(sp)
ffffffffc0200142:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
ffffffffc0200144:	00054503          	lbu	a0,0(a0)
ffffffffc0200148:	c51d                	beqz	a0,ffffffffc0200176 <cputs+0x3c>
ffffffffc020014a:	0405                	addi	s0,s0,1
ffffffffc020014c:	4485                	li	s1,1
ffffffffc020014e:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc0200150:	34c000ef          	jal	ra,ffffffffc020049c <cons_putc>
    while ((c = *str ++) != '\0') {
ffffffffc0200154:	00044503          	lbu	a0,0(s0)
ffffffffc0200158:	008487bb          	addw	a5,s1,s0
ffffffffc020015c:	0405                	addi	s0,s0,1
ffffffffc020015e:	f96d                	bnez	a0,ffffffffc0200150 <cputs+0x16>
    (*cnt) ++;
ffffffffc0200160:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc0200164:	4529                	li	a0,10
ffffffffc0200166:	336000ef          	jal	ra,ffffffffc020049c <cons_putc>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc020016a:	60e2                	ld	ra,24(sp)
ffffffffc020016c:	8522                	mv	a0,s0
ffffffffc020016e:	6442                	ld	s0,16(sp)
ffffffffc0200170:	64a2                	ld	s1,8(sp)
ffffffffc0200172:	6105                	addi	sp,sp,32
ffffffffc0200174:	8082                	ret
    while ((c = *str ++) != '\0') {
ffffffffc0200176:	4405                	li	s0,1
ffffffffc0200178:	b7f5                	j	ffffffffc0200164 <cputs+0x2a>

ffffffffc020017a <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
ffffffffc020017a:	1141                	addi	sp,sp,-16
ffffffffc020017c:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc020017e:	326000ef          	jal	ra,ffffffffc02004a4 <cons_getc>
ffffffffc0200182:	dd75                	beqz	a0,ffffffffc020017e <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200184:	60a2                	ld	ra,8(sp)
ffffffffc0200186:	0141                	addi	sp,sp,16
ffffffffc0200188:	8082                	ret

ffffffffc020018a <print_kerninfo>:
/* *
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void) {
ffffffffc020018a:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020018c:	00002517          	auipc	a0,0x2
ffffffffc0200190:	f2450513          	addi	a0,a0,-220 # ffffffffc02020b0 <etext+0xbc>
void print_kerninfo(void) {
ffffffffc0200194:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200196:	f6dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  entry  0x%016lx (virtual)\n", kern_init);
ffffffffc020019a:	00000597          	auipc	a1,0x0
ffffffffc020019e:	eba58593          	addi	a1,a1,-326 # ffffffffc0200054 <kern_init>
ffffffffc02001a2:	00002517          	auipc	a0,0x2
ffffffffc02001a6:	f2e50513          	addi	a0,a0,-210 # ffffffffc02020d0 <etext+0xdc>
ffffffffc02001aa:	f59ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  etext  0x%016lx (virtual)\n", etext);
ffffffffc02001ae:	00002597          	auipc	a1,0x2
ffffffffc02001b2:	e4658593          	addi	a1,a1,-442 # ffffffffc0201ff4 <etext>
ffffffffc02001b6:	00002517          	auipc	a0,0x2
ffffffffc02001ba:	f3a50513          	addi	a0,a0,-198 # ffffffffc02020f0 <etext+0xfc>
ffffffffc02001be:	f45ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  edata  0x%016lx (virtual)\n", edata);
ffffffffc02001c2:	00007597          	auipc	a1,0x7
ffffffffc02001c6:	e6658593          	addi	a1,a1,-410 # ffffffffc0207028 <free_area>
ffffffffc02001ca:	00002517          	auipc	a0,0x2
ffffffffc02001ce:	f4650513          	addi	a0,a0,-186 # ffffffffc0202110 <etext+0x11c>
ffffffffc02001d2:	f31ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  end    0x%016lx (virtual)\n", end);
ffffffffc02001d6:	00007597          	auipc	a1,0x7
ffffffffc02001da:	2ca58593          	addi	a1,a1,714 # ffffffffc02074a0 <end>
ffffffffc02001de:	00002517          	auipc	a0,0x2
ffffffffc02001e2:	f5250513          	addi	a0,a0,-174 # ffffffffc0202130 <etext+0x13c>
ffffffffc02001e6:	f1dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc02001ea:	00007597          	auipc	a1,0x7
ffffffffc02001ee:	6b558593          	addi	a1,a1,1717 # ffffffffc020789f <end+0x3ff>
ffffffffc02001f2:	00000797          	auipc	a5,0x0
ffffffffc02001f6:	e6278793          	addi	a5,a5,-414 # ffffffffc0200054 <kern_init>
ffffffffc02001fa:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02001fe:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200202:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200204:	3ff5f593          	andi	a1,a1,1023
ffffffffc0200208:	95be                	add	a1,a1,a5
ffffffffc020020a:	85a9                	srai	a1,a1,0xa
ffffffffc020020c:	00002517          	auipc	a0,0x2
ffffffffc0200210:	f4450513          	addi	a0,a0,-188 # ffffffffc0202150 <etext+0x15c>
}
ffffffffc0200214:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200216:	b5f5                	j	ffffffffc0200102 <cprintf>

ffffffffc0200218 <print_stackframe>:
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void) {
ffffffffc0200218:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc020021a:	00002617          	auipc	a2,0x2
ffffffffc020021e:	f6660613          	addi	a2,a2,-154 # ffffffffc0202180 <etext+0x18c>
ffffffffc0200222:	04d00593          	li	a1,77
ffffffffc0200226:	00002517          	auipc	a0,0x2
ffffffffc020022a:	f7250513          	addi	a0,a0,-142 # ffffffffc0202198 <etext+0x1a4>
void print_stackframe(void) {
ffffffffc020022e:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc0200230:	1cc000ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc0200234 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200234:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200236:	00002617          	auipc	a2,0x2
ffffffffc020023a:	f7a60613          	addi	a2,a2,-134 # ffffffffc02021b0 <etext+0x1bc>
ffffffffc020023e:	00002597          	auipc	a1,0x2
ffffffffc0200242:	f9258593          	addi	a1,a1,-110 # ffffffffc02021d0 <etext+0x1dc>
ffffffffc0200246:	00002517          	auipc	a0,0x2
ffffffffc020024a:	f9250513          	addi	a0,a0,-110 # ffffffffc02021d8 <etext+0x1e4>
mon_help(int argc, char **argv, struct trapframe *tf) {
ffffffffc020024e:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc0200250:	eb3ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
ffffffffc0200254:	00002617          	auipc	a2,0x2
ffffffffc0200258:	f9460613          	addi	a2,a2,-108 # ffffffffc02021e8 <etext+0x1f4>
ffffffffc020025c:	00002597          	auipc	a1,0x2
ffffffffc0200260:	fb458593          	addi	a1,a1,-76 # ffffffffc0202210 <etext+0x21c>
ffffffffc0200264:	00002517          	auipc	a0,0x2
ffffffffc0200268:	f7450513          	addi	a0,a0,-140 # ffffffffc02021d8 <etext+0x1e4>
ffffffffc020026c:	e97ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
ffffffffc0200270:	00002617          	auipc	a2,0x2
ffffffffc0200274:	fb060613          	addi	a2,a2,-80 # ffffffffc0202220 <etext+0x22c>
ffffffffc0200278:	00002597          	auipc	a1,0x2
ffffffffc020027c:	fc858593          	addi	a1,a1,-56 # ffffffffc0202240 <etext+0x24c>
ffffffffc0200280:	00002517          	auipc	a0,0x2
ffffffffc0200284:	f5850513          	addi	a0,a0,-168 # ffffffffc02021d8 <etext+0x1e4>
ffffffffc0200288:	e7bff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    }
    return 0;
}
ffffffffc020028c:	60a2                	ld	ra,8(sp)
ffffffffc020028e:	4501                	li	a0,0
ffffffffc0200290:	0141                	addi	sp,sp,16
ffffffffc0200292:	8082                	ret

ffffffffc0200294 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
ffffffffc0200294:	1141                	addi	sp,sp,-16
ffffffffc0200296:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc0200298:	ef3ff0ef          	jal	ra,ffffffffc020018a <print_kerninfo>
    return 0;
}
ffffffffc020029c:	60a2                	ld	ra,8(sp)
ffffffffc020029e:	4501                	li	a0,0
ffffffffc02002a0:	0141                	addi	sp,sp,16
ffffffffc02002a2:	8082                	ret

ffffffffc02002a4 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
ffffffffc02002a4:	1141                	addi	sp,sp,-16
ffffffffc02002a6:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc02002a8:	f71ff0ef          	jal	ra,ffffffffc0200218 <print_stackframe>
    return 0;
}
ffffffffc02002ac:	60a2                	ld	ra,8(sp)
ffffffffc02002ae:	4501                	li	a0,0
ffffffffc02002b0:	0141                	addi	sp,sp,16
ffffffffc02002b2:	8082                	ret

ffffffffc02002b4 <kmonitor>:
kmonitor(struct trapframe *tf) {
ffffffffc02002b4:	7115                	addi	sp,sp,-224
ffffffffc02002b6:	ed5e                	sd	s7,152(sp)
ffffffffc02002b8:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002ba:	00002517          	auipc	a0,0x2
ffffffffc02002be:	f9650513          	addi	a0,a0,-106 # ffffffffc0202250 <etext+0x25c>
kmonitor(struct trapframe *tf) {
ffffffffc02002c2:	ed86                	sd	ra,216(sp)
ffffffffc02002c4:	e9a2                	sd	s0,208(sp)
ffffffffc02002c6:	e5a6                	sd	s1,200(sp)
ffffffffc02002c8:	e1ca                	sd	s2,192(sp)
ffffffffc02002ca:	fd4e                	sd	s3,184(sp)
ffffffffc02002cc:	f952                	sd	s4,176(sp)
ffffffffc02002ce:	f556                	sd	s5,168(sp)
ffffffffc02002d0:	f15a                	sd	s6,160(sp)
ffffffffc02002d2:	e962                	sd	s8,144(sp)
ffffffffc02002d4:	e566                	sd	s9,136(sp)
ffffffffc02002d6:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc02002d8:	e2bff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc02002dc:	00002517          	auipc	a0,0x2
ffffffffc02002e0:	f9c50513          	addi	a0,a0,-100 # ffffffffc0202278 <etext+0x284>
ffffffffc02002e4:	e1fff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    if (tf != NULL) {
ffffffffc02002e8:	000b8563          	beqz	s7,ffffffffc02002f2 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc02002ec:	855e                	mv	a0,s7
ffffffffc02002ee:	756000ef          	jal	ra,ffffffffc0200a44 <print_trapframe>
ffffffffc02002f2:	00002c17          	auipc	s8,0x2
ffffffffc02002f6:	ff6c0c13          	addi	s8,s8,-10 # ffffffffc02022e8 <commands>
        if ((buf = readline("K> ")) != NULL) {
ffffffffc02002fa:	00002917          	auipc	s2,0x2
ffffffffc02002fe:	fa690913          	addi	s2,s2,-90 # ffffffffc02022a0 <etext+0x2ac>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200302:	00002497          	auipc	s1,0x2
ffffffffc0200306:	fa648493          	addi	s1,s1,-90 # ffffffffc02022a8 <etext+0x2b4>
        if (argc == MAXARGS - 1) {
ffffffffc020030a:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020030c:	00002b17          	auipc	s6,0x2
ffffffffc0200310:	fa4b0b13          	addi	s6,s6,-92 # ffffffffc02022b0 <etext+0x2bc>
        argv[argc ++] = buf;
ffffffffc0200314:	00002a17          	auipc	s4,0x2
ffffffffc0200318:	ebca0a13          	addi	s4,s4,-324 # ffffffffc02021d0 <etext+0x1dc>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020031c:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL) {
ffffffffc020031e:	854a                	mv	a0,s2
ffffffffc0200320:	315010ef          	jal	ra,ffffffffc0201e34 <readline>
ffffffffc0200324:	842a                	mv	s0,a0
ffffffffc0200326:	dd65                	beqz	a0,ffffffffc020031e <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200328:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc020032c:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc020032e:	e1bd                	bnez	a1,ffffffffc0200394 <kmonitor+0xe0>
    if (argc == 0) {
ffffffffc0200330:	fe0c87e3          	beqz	s9,ffffffffc020031e <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200334:	6582                	ld	a1,0(sp)
ffffffffc0200336:	00002d17          	auipc	s10,0x2
ffffffffc020033a:	fb2d0d13          	addi	s10,s10,-78 # ffffffffc02022e8 <commands>
        argv[argc ++] = buf;
ffffffffc020033e:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200340:	4401                	li	s0,0
ffffffffc0200342:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200344:	445010ef          	jal	ra,ffffffffc0201f88 <strcmp>
ffffffffc0200348:	c919                	beqz	a0,ffffffffc020035e <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc020034a:	2405                	addiw	s0,s0,1
ffffffffc020034c:	0b540063          	beq	s0,s5,ffffffffc02003ec <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200350:	000d3503          	ld	a0,0(s10)
ffffffffc0200354:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i ++) {
ffffffffc0200356:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0) {
ffffffffc0200358:	431010ef          	jal	ra,ffffffffc0201f88 <strcmp>
ffffffffc020035c:	f57d                	bnez	a0,ffffffffc020034a <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc020035e:	00141793          	slli	a5,s0,0x1
ffffffffc0200362:	97a2                	add	a5,a5,s0
ffffffffc0200364:	078e                	slli	a5,a5,0x3
ffffffffc0200366:	97e2                	add	a5,a5,s8
ffffffffc0200368:	6b9c                	ld	a5,16(a5)
ffffffffc020036a:	865e                	mv	a2,s7
ffffffffc020036c:	002c                	addi	a1,sp,8
ffffffffc020036e:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200372:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0) {
ffffffffc0200374:	fa0555e3          	bgez	a0,ffffffffc020031e <kmonitor+0x6a>
}
ffffffffc0200378:	60ee                	ld	ra,216(sp)
ffffffffc020037a:	644e                	ld	s0,208(sp)
ffffffffc020037c:	64ae                	ld	s1,200(sp)
ffffffffc020037e:	690e                	ld	s2,192(sp)
ffffffffc0200380:	79ea                	ld	s3,184(sp)
ffffffffc0200382:	7a4a                	ld	s4,176(sp)
ffffffffc0200384:	7aaa                	ld	s5,168(sp)
ffffffffc0200386:	7b0a                	ld	s6,160(sp)
ffffffffc0200388:	6bea                	ld	s7,152(sp)
ffffffffc020038a:	6c4a                	ld	s8,144(sp)
ffffffffc020038c:	6caa                	ld	s9,136(sp)
ffffffffc020038e:	6d0a                	ld	s10,128(sp)
ffffffffc0200390:	612d                	addi	sp,sp,224
ffffffffc0200392:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc0200394:	8526                	mv	a0,s1
ffffffffc0200396:	437010ef          	jal	ra,ffffffffc0201fcc <strchr>
ffffffffc020039a:	c901                	beqz	a0,ffffffffc02003aa <kmonitor+0xf6>
ffffffffc020039c:	00144583          	lbu	a1,1(s0)
            *buf ++ = '\0';
ffffffffc02003a0:	00040023          	sb	zero,0(s0)
ffffffffc02003a4:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003a6:	d5c9                	beqz	a1,ffffffffc0200330 <kmonitor+0x7c>
ffffffffc02003a8:	b7f5                	j	ffffffffc0200394 <kmonitor+0xe0>
        if (*buf == '\0') {
ffffffffc02003aa:	00044783          	lbu	a5,0(s0)
ffffffffc02003ae:	d3c9                	beqz	a5,ffffffffc0200330 <kmonitor+0x7c>
        if (argc == MAXARGS - 1) {
ffffffffc02003b0:	033c8963          	beq	s9,s3,ffffffffc02003e2 <kmonitor+0x12e>
        argv[argc ++] = buf;
ffffffffc02003b4:	003c9793          	slli	a5,s9,0x3
ffffffffc02003b8:	0118                	addi	a4,sp,128
ffffffffc02003ba:	97ba                	add	a5,a5,a4
ffffffffc02003bc:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003c0:	00044583          	lbu	a1,0(s0)
        argv[argc ++] = buf;
ffffffffc02003c4:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003c6:	e591                	bnez	a1,ffffffffc02003d2 <kmonitor+0x11e>
ffffffffc02003c8:	b7b5                	j	ffffffffc0200334 <kmonitor+0x80>
ffffffffc02003ca:	00144583          	lbu	a1,1(s0)
            buf ++;
ffffffffc02003ce:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
ffffffffc02003d0:	d1a5                	beqz	a1,ffffffffc0200330 <kmonitor+0x7c>
ffffffffc02003d2:	8526                	mv	a0,s1
ffffffffc02003d4:	3f9010ef          	jal	ra,ffffffffc0201fcc <strchr>
ffffffffc02003d8:	d96d                	beqz	a0,ffffffffc02003ca <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
ffffffffc02003da:	00044583          	lbu	a1,0(s0)
ffffffffc02003de:	d9a9                	beqz	a1,ffffffffc0200330 <kmonitor+0x7c>
ffffffffc02003e0:	bf55                	j	ffffffffc0200394 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc02003e2:	45c1                	li	a1,16
ffffffffc02003e4:	855a                	mv	a0,s6
ffffffffc02003e6:	d1dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
ffffffffc02003ea:	b7e9                	j	ffffffffc02003b4 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc02003ec:	6582                	ld	a1,0(sp)
ffffffffc02003ee:	00002517          	auipc	a0,0x2
ffffffffc02003f2:	ee250513          	addi	a0,a0,-286 # ffffffffc02022d0 <etext+0x2dc>
ffffffffc02003f6:	d0dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    return 0;
ffffffffc02003fa:	b715                	j	ffffffffc020031e <kmonitor+0x6a>

ffffffffc02003fc <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
    if (is_panic) {
ffffffffc02003fc:	00007317          	auipc	t1,0x7
ffffffffc0200400:	04430313          	addi	t1,t1,68 # ffffffffc0207440 <is_panic>
ffffffffc0200404:	00032e03          	lw	t3,0(t1)
__panic(const char *file, int line, const char *fmt, ...) {
ffffffffc0200408:	715d                	addi	sp,sp,-80
ffffffffc020040a:	ec06                	sd	ra,24(sp)
ffffffffc020040c:	e822                	sd	s0,16(sp)
ffffffffc020040e:	f436                	sd	a3,40(sp)
ffffffffc0200410:	f83a                	sd	a4,48(sp)
ffffffffc0200412:	fc3e                	sd	a5,56(sp)
ffffffffc0200414:	e0c2                	sd	a6,64(sp)
ffffffffc0200416:	e4c6                	sd	a7,72(sp)
    if (is_panic) {
ffffffffc0200418:	020e1a63          	bnez	t3,ffffffffc020044c <__panic+0x50>
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc020041c:	4785                	li	a5,1
ffffffffc020041e:	00f32023          	sw	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc0200422:	8432                	mv	s0,a2
ffffffffc0200424:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200426:	862e                	mv	a2,a1
ffffffffc0200428:	85aa                	mv	a1,a0
ffffffffc020042a:	00002517          	auipc	a0,0x2
ffffffffc020042e:	f0650513          	addi	a0,a0,-250 # ffffffffc0202330 <commands+0x48>
    va_start(ap, fmt);
ffffffffc0200432:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc0200434:	ccfff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    vcprintf(fmt, ap);
ffffffffc0200438:	65a2                	ld	a1,8(sp)
ffffffffc020043a:	8522                	mv	a0,s0
ffffffffc020043c:	ca7ff0ef          	jal	ra,ffffffffc02000e2 <vcprintf>
    cprintf("\n");
ffffffffc0200440:	00002517          	auipc	a0,0x2
ffffffffc0200444:	bf050513          	addi	a0,a0,-1040 # ffffffffc0202030 <etext+0x3c>
ffffffffc0200448:	cbbff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
ffffffffc020044c:	412000ef          	jal	ra,ffffffffc020085e <intr_disable>
    while (1) {
        kmonitor(NULL);
ffffffffc0200450:	4501                	li	a0,0
ffffffffc0200452:	e63ff0ef          	jal	ra,ffffffffc02002b4 <kmonitor>
    while (1) {
ffffffffc0200456:	bfed                	j	ffffffffc0200450 <__panic+0x54>

ffffffffc0200458 <clock_init>:

/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
ffffffffc0200458:	1141                	addi	sp,sp,-16
ffffffffc020045a:	e406                	sd	ra,8(sp)
    // enable timer interrupt in sie
    set_csr(sie, MIP_STIP);
ffffffffc020045c:	02000793          	li	a5,32
ffffffffc0200460:	1047a7f3          	csrrs	a5,sie,a5
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200464:	c0102573          	rdtime	a0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200468:	67e1                	lui	a5,0x18
ffffffffc020046a:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc020046e:	953e                	add	a0,a0,a5
ffffffffc0200470:	293010ef          	jal	ra,ffffffffc0201f02 <sbi_set_timer>
}
ffffffffc0200474:	60a2                	ld	ra,8(sp)
    ticks = 0;
ffffffffc0200476:	00007797          	auipc	a5,0x7
ffffffffc020047a:	fc07b923          	sd	zero,-46(a5) # ffffffffc0207448 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc020047e:	00002517          	auipc	a0,0x2
ffffffffc0200482:	ed250513          	addi	a0,a0,-302 # ffffffffc0202350 <commands+0x68>
}
ffffffffc0200486:	0141                	addi	sp,sp,16
    cprintf("++ setup timer interrupts\n");
ffffffffc0200488:	b9ad                	j	ffffffffc0200102 <cprintf>

ffffffffc020048a <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc020048a:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020048e:	67e1                	lui	a5,0x18
ffffffffc0200490:	6a078793          	addi	a5,a5,1696 # 186a0 <kern_entry-0xffffffffc01e7960>
ffffffffc0200494:	953e                	add	a0,a0,a5
ffffffffc0200496:	26d0106f          	j	ffffffffc0201f02 <sbi_set_timer>

ffffffffc020049a <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020049a:	8082                	ret

ffffffffc020049c <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) { sbi_console_putchar((unsigned char)c); }
ffffffffc020049c:	0ff57513          	zext.b	a0,a0
ffffffffc02004a0:	2490106f          	j	ffffffffc0201ee8 <sbi_console_putchar>

ffffffffc02004a4 <cons_getc>:
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int cons_getc(void) {
    int c = 0;
    c = sbi_console_getchar();
ffffffffc02004a4:	2790106f          	j	ffffffffc0201f1c <sbi_console_getchar>

ffffffffc02004a8 <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02004a8:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc02004aa:	00002517          	auipc	a0,0x2
ffffffffc02004ae:	ec650513          	addi	a0,a0,-314 # ffffffffc0202370 <commands+0x88>
void dtb_init(void) {
ffffffffc02004b2:	fc86                	sd	ra,120(sp)
ffffffffc02004b4:	f8a2                	sd	s0,112(sp)
ffffffffc02004b6:	e8d2                	sd	s4,80(sp)
ffffffffc02004b8:	f4a6                	sd	s1,104(sp)
ffffffffc02004ba:	f0ca                	sd	s2,96(sp)
ffffffffc02004bc:	ecce                	sd	s3,88(sp)
ffffffffc02004be:	e4d6                	sd	s5,72(sp)
ffffffffc02004c0:	e0da                	sd	s6,64(sp)
ffffffffc02004c2:	fc5e                	sd	s7,56(sp)
ffffffffc02004c4:	f862                	sd	s8,48(sp)
ffffffffc02004c6:	f466                	sd	s9,40(sp)
ffffffffc02004c8:	f06a                	sd	s10,32(sp)
ffffffffc02004ca:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc02004cc:	c37ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc02004d0:	00007597          	auipc	a1,0x7
ffffffffc02004d4:	b305b583          	ld	a1,-1232(a1) # ffffffffc0207000 <boot_hartid>
ffffffffc02004d8:	00002517          	auipc	a0,0x2
ffffffffc02004dc:	ea850513          	addi	a0,a0,-344 # ffffffffc0202380 <commands+0x98>
ffffffffc02004e0:	c23ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc02004e4:	00007417          	auipc	s0,0x7
ffffffffc02004e8:	b2440413          	addi	s0,s0,-1244 # ffffffffc0207008 <boot_dtb>
ffffffffc02004ec:	600c                	ld	a1,0(s0)
ffffffffc02004ee:	00002517          	auipc	a0,0x2
ffffffffc02004f2:	ea250513          	addi	a0,a0,-350 # ffffffffc0202390 <commands+0xa8>
ffffffffc02004f6:	c0dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc02004fa:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc02004fe:	00002517          	auipc	a0,0x2
ffffffffc0200502:	eaa50513          	addi	a0,a0,-342 # ffffffffc02023a8 <commands+0xc0>
    if (boot_dtb == 0) {
ffffffffc0200506:	120a0463          	beqz	s4,ffffffffc020062e <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc020050a:	57f5                	li	a5,-3
ffffffffc020050c:	07fa                	slli	a5,a5,0x1e
ffffffffc020050e:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200512:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200514:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200518:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020051a:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020051e:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200522:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200526:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020052a:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020052e:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200530:	8ec9                	or	a3,a3,a0
ffffffffc0200532:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200536:	1b7d                	addi	s6,s6,-1
ffffffffc0200538:	0167f7b3          	and	a5,a5,s6
ffffffffc020053c:	8dd5                	or	a1,a1,a3
ffffffffc020053e:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200540:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200544:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc0200546:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfed8a4d>
ffffffffc020054a:	10f59163          	bne	a1,a5,ffffffffc020064c <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc020054e:	471c                	lw	a5,8(a4)
ffffffffc0200550:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc0200552:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200554:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200558:	0086d51b          	srliw	a0,a3,0x8
ffffffffc020055c:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200560:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200564:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200568:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020056c:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200570:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200574:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200578:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020057c:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020057e:	01146433          	or	s0,s0,a7
ffffffffc0200582:	0086969b          	slliw	a3,a3,0x8
ffffffffc0200586:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020058a:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020058c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200590:	8c49                	or	s0,s0,a0
ffffffffc0200592:	0166f6b3          	and	a3,a3,s6
ffffffffc0200596:	00ca6a33          	or	s4,s4,a2
ffffffffc020059a:	0167f7b3          	and	a5,a5,s6
ffffffffc020059e:	8c55                	or	s0,s0,a3
ffffffffc02005a0:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005a4:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005a6:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005a8:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005aa:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02005ae:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02005b0:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005b2:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc02005b6:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02005b8:	00002917          	auipc	s2,0x2
ffffffffc02005bc:	e4090913          	addi	s2,s2,-448 # ffffffffc02023f8 <commands+0x110>
ffffffffc02005c0:	49bd                	li	s3,15
        switch (token) {
ffffffffc02005c2:	4d91                	li	s11,4
ffffffffc02005c4:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02005c6:	00002497          	auipc	s1,0x2
ffffffffc02005ca:	e2a48493          	addi	s1,s1,-470 # ffffffffc02023f0 <commands+0x108>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc02005ce:	000a2703          	lw	a4,0(s4)
ffffffffc02005d2:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005d6:	0087569b          	srliw	a3,a4,0x8
ffffffffc02005da:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005de:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005e2:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005e6:	0107571b          	srliw	a4,a4,0x10
ffffffffc02005ea:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02005ec:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02005f0:	0087171b          	slliw	a4,a4,0x8
ffffffffc02005f4:	8fd5                	or	a5,a5,a3
ffffffffc02005f6:	00eb7733          	and	a4,s6,a4
ffffffffc02005fa:	8fd9                	or	a5,a5,a4
ffffffffc02005fc:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc02005fe:	09778c63          	beq	a5,s7,ffffffffc0200696 <dtb_init+0x1ee>
ffffffffc0200602:	00fbea63          	bltu	s7,a5,ffffffffc0200616 <dtb_init+0x16e>
ffffffffc0200606:	07a78663          	beq	a5,s10,ffffffffc0200672 <dtb_init+0x1ca>
ffffffffc020060a:	4709                	li	a4,2
ffffffffc020060c:	00e79763          	bne	a5,a4,ffffffffc020061a <dtb_init+0x172>
ffffffffc0200610:	4c81                	li	s9,0
ffffffffc0200612:	8a56                	mv	s4,s5
ffffffffc0200614:	bf6d                	j	ffffffffc02005ce <dtb_init+0x126>
ffffffffc0200616:	ffb78ee3          	beq	a5,s11,ffffffffc0200612 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc020061a:	00002517          	auipc	a0,0x2
ffffffffc020061e:	e5650513          	addi	a0,a0,-426 # ffffffffc0202470 <commands+0x188>
ffffffffc0200622:	ae1ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc0200626:	00002517          	auipc	a0,0x2
ffffffffc020062a:	e8250513          	addi	a0,a0,-382 # ffffffffc02024a8 <commands+0x1c0>
}
ffffffffc020062e:	7446                	ld	s0,112(sp)
ffffffffc0200630:	70e6                	ld	ra,120(sp)
ffffffffc0200632:	74a6                	ld	s1,104(sp)
ffffffffc0200634:	7906                	ld	s2,96(sp)
ffffffffc0200636:	69e6                	ld	s3,88(sp)
ffffffffc0200638:	6a46                	ld	s4,80(sp)
ffffffffc020063a:	6aa6                	ld	s5,72(sp)
ffffffffc020063c:	6b06                	ld	s6,64(sp)
ffffffffc020063e:	7be2                	ld	s7,56(sp)
ffffffffc0200640:	7c42                	ld	s8,48(sp)
ffffffffc0200642:	7ca2                	ld	s9,40(sp)
ffffffffc0200644:	7d02                	ld	s10,32(sp)
ffffffffc0200646:	6de2                	ld	s11,24(sp)
ffffffffc0200648:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc020064a:	bc65                	j	ffffffffc0200102 <cprintf>
}
ffffffffc020064c:	7446                	ld	s0,112(sp)
ffffffffc020064e:	70e6                	ld	ra,120(sp)
ffffffffc0200650:	74a6                	ld	s1,104(sp)
ffffffffc0200652:	7906                	ld	s2,96(sp)
ffffffffc0200654:	69e6                	ld	s3,88(sp)
ffffffffc0200656:	6a46                	ld	s4,80(sp)
ffffffffc0200658:	6aa6                	ld	s5,72(sp)
ffffffffc020065a:	6b06                	ld	s6,64(sp)
ffffffffc020065c:	7be2                	ld	s7,56(sp)
ffffffffc020065e:	7c42                	ld	s8,48(sp)
ffffffffc0200660:	7ca2                	ld	s9,40(sp)
ffffffffc0200662:	7d02                	ld	s10,32(sp)
ffffffffc0200664:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200666:	00002517          	auipc	a0,0x2
ffffffffc020066a:	d6250513          	addi	a0,a0,-670 # ffffffffc02023c8 <commands+0xe0>
}
ffffffffc020066e:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc0200670:	bc49                	j	ffffffffc0200102 <cprintf>
                int name_len = strlen(name);
ffffffffc0200672:	8556                	mv	a0,s5
ffffffffc0200674:	0df010ef          	jal	ra,ffffffffc0201f52 <strlen>
ffffffffc0200678:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020067a:	4619                	li	a2,6
ffffffffc020067c:	85a6                	mv	a1,s1
ffffffffc020067e:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc0200680:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc0200682:	125010ef          	jal	ra,ffffffffc0201fa6 <strncmp>
ffffffffc0200686:	e111                	bnez	a0,ffffffffc020068a <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc0200688:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc020068a:	0a91                	addi	s5,s5,4
ffffffffc020068c:	9ad2                	add	s5,s5,s4
ffffffffc020068e:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200692:	8a56                	mv	s4,s5
ffffffffc0200694:	bf2d                	j	ffffffffc02005ce <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200696:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020069a:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020069e:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02006a2:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006a6:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ae:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02006b2:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006b6:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ba:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006be:	00eaeab3          	or	s5,s5,a4
ffffffffc02006c2:	00fb77b3          	and	a5,s6,a5
ffffffffc02006c6:	00faeab3          	or	s5,s5,a5
ffffffffc02006ca:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006cc:	000c9c63          	bnez	s9,ffffffffc02006e4 <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc02006d0:	1a82                	slli	s5,s5,0x20
ffffffffc02006d2:	00368793          	addi	a5,a3,3
ffffffffc02006d6:	020ada93          	srli	s5,s5,0x20
ffffffffc02006da:	9abe                	add	s5,s5,a5
ffffffffc02006dc:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02006e0:	8a56                	mv	s4,s5
ffffffffc02006e2:	b5f5                	j	ffffffffc02005ce <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02006e4:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc02006e8:	85ca                	mv	a1,s2
ffffffffc02006ea:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ec:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006f0:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006f4:	0187971b          	slliw	a4,a5,0x18
ffffffffc02006f8:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006fc:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200700:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200702:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200706:	0087979b          	slliw	a5,a5,0x8
ffffffffc020070a:	8d59                	or	a0,a0,a4
ffffffffc020070c:	00fb77b3          	and	a5,s6,a5
ffffffffc0200710:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200712:	1502                	slli	a0,a0,0x20
ffffffffc0200714:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200716:	9522                	add	a0,a0,s0
ffffffffc0200718:	071010ef          	jal	ra,ffffffffc0201f88 <strcmp>
ffffffffc020071c:	66a2                	ld	a3,8(sp)
ffffffffc020071e:	f94d                	bnez	a0,ffffffffc02006d0 <dtb_init+0x228>
ffffffffc0200720:	fb59f8e3          	bgeu	s3,s5,ffffffffc02006d0 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc0200724:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc0200728:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc020072c:	00002517          	auipc	a0,0x2
ffffffffc0200730:	cd450513          	addi	a0,a0,-812 # ffffffffc0202400 <commands+0x118>
           fdt32_to_cpu(x >> 32);
ffffffffc0200734:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200738:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc020073c:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200740:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200744:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200748:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020074c:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200750:	0187d693          	srli	a3,a5,0x18
ffffffffc0200754:	01861f1b          	slliw	t5,a2,0x18
ffffffffc0200758:	0087579b          	srliw	a5,a4,0x8
ffffffffc020075c:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200760:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200764:	010f6f33          	or	t5,t5,a6
ffffffffc0200768:	0187529b          	srliw	t0,a4,0x18
ffffffffc020076c:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200770:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200774:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200778:	0186f6b3          	and	a3,a3,s8
ffffffffc020077c:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200780:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200784:	0107581b          	srliw	a6,a4,0x10
ffffffffc0200788:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020078c:	8361                	srli	a4,a4,0x18
ffffffffc020078e:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200792:	0105d59b          	srliw	a1,a1,0x10
ffffffffc0200796:	01e6e6b3          	or	a3,a3,t5
ffffffffc020079a:	00cb7633          	and	a2,s6,a2
ffffffffc020079e:	0088181b          	slliw	a6,a6,0x8
ffffffffc02007a2:	0085959b          	slliw	a1,a1,0x8
ffffffffc02007a6:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007aa:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007ae:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007b2:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007b6:	0088989b          	slliw	a7,a7,0x8
ffffffffc02007ba:	011b78b3          	and	a7,s6,a7
ffffffffc02007be:	005eeeb3          	or	t4,t4,t0
ffffffffc02007c2:	00c6e733          	or	a4,a3,a2
ffffffffc02007c6:	006c6c33          	or	s8,s8,t1
ffffffffc02007ca:	010b76b3          	and	a3,s6,a6
ffffffffc02007ce:	00bb7b33          	and	s6,s6,a1
ffffffffc02007d2:	01d7e7b3          	or	a5,a5,t4
ffffffffc02007d6:	016c6b33          	or	s6,s8,s6
ffffffffc02007da:	01146433          	or	s0,s0,a7
ffffffffc02007de:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc02007e0:	1702                	slli	a4,a4,0x20
ffffffffc02007e2:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007e4:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007e6:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007e8:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc02007ea:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc02007ee:	0167eb33          	or	s6,a5,s6
ffffffffc02007f2:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc02007f4:	90fff0ef          	jal	ra,ffffffffc0200102 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc02007f8:	85a2                	mv	a1,s0
ffffffffc02007fa:	00002517          	auipc	a0,0x2
ffffffffc02007fe:	c2650513          	addi	a0,a0,-986 # ffffffffc0202420 <commands+0x138>
ffffffffc0200802:	901ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc0200806:	014b5613          	srli	a2,s6,0x14
ffffffffc020080a:	85da                	mv	a1,s6
ffffffffc020080c:	00002517          	auipc	a0,0x2
ffffffffc0200810:	c2c50513          	addi	a0,a0,-980 # ffffffffc0202438 <commands+0x150>
ffffffffc0200814:	8efff0ef          	jal	ra,ffffffffc0200102 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc0200818:	008b05b3          	add	a1,s6,s0
ffffffffc020081c:	15fd                	addi	a1,a1,-1
ffffffffc020081e:	00002517          	auipc	a0,0x2
ffffffffc0200822:	c3a50513          	addi	a0,a0,-966 # ffffffffc0202458 <commands+0x170>
ffffffffc0200826:	8ddff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc020082a:	00002517          	auipc	a0,0x2
ffffffffc020082e:	c7e50513          	addi	a0,a0,-898 # ffffffffc02024a8 <commands+0x1c0>
        memory_base = mem_base;
ffffffffc0200832:	00007797          	auipc	a5,0x7
ffffffffc0200836:	c087bf23          	sd	s0,-994(a5) # ffffffffc0207450 <memory_base>
        memory_size = mem_size;
ffffffffc020083a:	00007797          	auipc	a5,0x7
ffffffffc020083e:	c167bf23          	sd	s6,-994(a5) # ffffffffc0207458 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200842:	b3f5                	j	ffffffffc020062e <dtb_init+0x186>

ffffffffc0200844 <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc0200844:	00007517          	auipc	a0,0x7
ffffffffc0200848:	c0c53503          	ld	a0,-1012(a0) # ffffffffc0207450 <memory_base>
ffffffffc020084c:	8082                	ret

ffffffffc020084e <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc020084e:	00007517          	auipc	a0,0x7
ffffffffc0200852:	c0a53503          	ld	a0,-1014(a0) # ffffffffc0207458 <memory_size>
ffffffffc0200856:	8082                	ret

ffffffffc0200858 <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc0200858:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc020085c:	8082                	ret

ffffffffc020085e <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc020085e:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200862:	8082                	ret

ffffffffc0200864 <idt_init>:
     */

    extern void __alltraps(void);
    /* Set sup0 scratch register to 0, indicating to exception vector
       that we are presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc0200864:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc0200868:	00000797          	auipc	a5,0x0
ffffffffc020086c:	3b878793          	addi	a5,a5,952 # ffffffffc0200c20 <__alltraps>
ffffffffc0200870:	10579073          	csrw	stvec,a5
}
ffffffffc0200874:	8082                	ret

ffffffffc0200876 <print_regs>:
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr) {
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200876:	610c                	ld	a1,0(a0)
void print_regs(struct pushregs *gpr) {
ffffffffc0200878:	1141                	addi	sp,sp,-16
ffffffffc020087a:	e022                	sd	s0,0(sp)
ffffffffc020087c:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc020087e:	00002517          	auipc	a0,0x2
ffffffffc0200882:	c4250513          	addi	a0,a0,-958 # ffffffffc02024c0 <commands+0x1d8>
void print_regs(struct pushregs *gpr) {
ffffffffc0200886:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc0200888:	87bff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc020088c:	640c                	ld	a1,8(s0)
ffffffffc020088e:	00002517          	auipc	a0,0x2
ffffffffc0200892:	c4a50513          	addi	a0,a0,-950 # ffffffffc02024d8 <commands+0x1f0>
ffffffffc0200896:	86dff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc020089a:	680c                	ld	a1,16(s0)
ffffffffc020089c:	00002517          	auipc	a0,0x2
ffffffffc02008a0:	c5450513          	addi	a0,a0,-940 # ffffffffc02024f0 <commands+0x208>
ffffffffc02008a4:	85fff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc02008a8:	6c0c                	ld	a1,24(s0)
ffffffffc02008aa:	00002517          	auipc	a0,0x2
ffffffffc02008ae:	c5e50513          	addi	a0,a0,-930 # ffffffffc0202508 <commands+0x220>
ffffffffc02008b2:	851ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc02008b6:	700c                	ld	a1,32(s0)
ffffffffc02008b8:	00002517          	auipc	a0,0x2
ffffffffc02008bc:	c6850513          	addi	a0,a0,-920 # ffffffffc0202520 <commands+0x238>
ffffffffc02008c0:	843ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc02008c4:	740c                	ld	a1,40(s0)
ffffffffc02008c6:	00002517          	auipc	a0,0x2
ffffffffc02008ca:	c7250513          	addi	a0,a0,-910 # ffffffffc0202538 <commands+0x250>
ffffffffc02008ce:	835ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc02008d2:	780c                	ld	a1,48(s0)
ffffffffc02008d4:	00002517          	auipc	a0,0x2
ffffffffc02008d8:	c7c50513          	addi	a0,a0,-900 # ffffffffc0202550 <commands+0x268>
ffffffffc02008dc:	827ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc02008e0:	7c0c                	ld	a1,56(s0)
ffffffffc02008e2:	00002517          	auipc	a0,0x2
ffffffffc02008e6:	c8650513          	addi	a0,a0,-890 # ffffffffc0202568 <commands+0x280>
ffffffffc02008ea:	819ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc02008ee:	602c                	ld	a1,64(s0)
ffffffffc02008f0:	00002517          	auipc	a0,0x2
ffffffffc02008f4:	c9050513          	addi	a0,a0,-880 # ffffffffc0202580 <commands+0x298>
ffffffffc02008f8:	80bff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc02008fc:	642c                	ld	a1,72(s0)
ffffffffc02008fe:	00002517          	auipc	a0,0x2
ffffffffc0200902:	c9a50513          	addi	a0,a0,-870 # ffffffffc0202598 <commands+0x2b0>
ffffffffc0200906:	ffcff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc020090a:	682c                	ld	a1,80(s0)
ffffffffc020090c:	00002517          	auipc	a0,0x2
ffffffffc0200910:	ca450513          	addi	a0,a0,-860 # ffffffffc02025b0 <commands+0x2c8>
ffffffffc0200914:	feeff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200918:	6c2c                	ld	a1,88(s0)
ffffffffc020091a:	00002517          	auipc	a0,0x2
ffffffffc020091e:	cae50513          	addi	a0,a0,-850 # ffffffffc02025c8 <commands+0x2e0>
ffffffffc0200922:	fe0ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200926:	702c                	ld	a1,96(s0)
ffffffffc0200928:	00002517          	auipc	a0,0x2
ffffffffc020092c:	cb850513          	addi	a0,a0,-840 # ffffffffc02025e0 <commands+0x2f8>
ffffffffc0200930:	fd2ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200934:	742c                	ld	a1,104(s0)
ffffffffc0200936:	00002517          	auipc	a0,0x2
ffffffffc020093a:	cc250513          	addi	a0,a0,-830 # ffffffffc02025f8 <commands+0x310>
ffffffffc020093e:	fc4ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200942:	782c                	ld	a1,112(s0)
ffffffffc0200944:	00002517          	auipc	a0,0x2
ffffffffc0200948:	ccc50513          	addi	a0,a0,-820 # ffffffffc0202610 <commands+0x328>
ffffffffc020094c:	fb6ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200950:	7c2c                	ld	a1,120(s0)
ffffffffc0200952:	00002517          	auipc	a0,0x2
ffffffffc0200956:	cd650513          	addi	a0,a0,-810 # ffffffffc0202628 <commands+0x340>
ffffffffc020095a:	fa8ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc020095e:	604c                	ld	a1,128(s0)
ffffffffc0200960:	00002517          	auipc	a0,0x2
ffffffffc0200964:	ce050513          	addi	a0,a0,-800 # ffffffffc0202640 <commands+0x358>
ffffffffc0200968:	f9aff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc020096c:	644c                	ld	a1,136(s0)
ffffffffc020096e:	00002517          	auipc	a0,0x2
ffffffffc0200972:	cea50513          	addi	a0,a0,-790 # ffffffffc0202658 <commands+0x370>
ffffffffc0200976:	f8cff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc020097a:	684c                	ld	a1,144(s0)
ffffffffc020097c:	00002517          	auipc	a0,0x2
ffffffffc0200980:	cf450513          	addi	a0,a0,-780 # ffffffffc0202670 <commands+0x388>
ffffffffc0200984:	f7eff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200988:	6c4c                	ld	a1,152(s0)
ffffffffc020098a:	00002517          	auipc	a0,0x2
ffffffffc020098e:	cfe50513          	addi	a0,a0,-770 # ffffffffc0202688 <commands+0x3a0>
ffffffffc0200992:	f70ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200996:	704c                	ld	a1,160(s0)
ffffffffc0200998:	00002517          	auipc	a0,0x2
ffffffffc020099c:	d0850513          	addi	a0,a0,-760 # ffffffffc02026a0 <commands+0x3b8>
ffffffffc02009a0:	f62ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc02009a4:	744c                	ld	a1,168(s0)
ffffffffc02009a6:	00002517          	auipc	a0,0x2
ffffffffc02009aa:	d1250513          	addi	a0,a0,-750 # ffffffffc02026b8 <commands+0x3d0>
ffffffffc02009ae:	f54ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc02009b2:	784c                	ld	a1,176(s0)
ffffffffc02009b4:	00002517          	auipc	a0,0x2
ffffffffc02009b8:	d1c50513          	addi	a0,a0,-740 # ffffffffc02026d0 <commands+0x3e8>
ffffffffc02009bc:	f46ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc02009c0:	7c4c                	ld	a1,184(s0)
ffffffffc02009c2:	00002517          	auipc	a0,0x2
ffffffffc02009c6:	d2650513          	addi	a0,a0,-730 # ffffffffc02026e8 <commands+0x400>
ffffffffc02009ca:	f38ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc02009ce:	606c                	ld	a1,192(s0)
ffffffffc02009d0:	00002517          	auipc	a0,0x2
ffffffffc02009d4:	d3050513          	addi	a0,a0,-720 # ffffffffc0202700 <commands+0x418>
ffffffffc02009d8:	f2aff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc02009dc:	646c                	ld	a1,200(s0)
ffffffffc02009de:	00002517          	auipc	a0,0x2
ffffffffc02009e2:	d3a50513          	addi	a0,a0,-710 # ffffffffc0202718 <commands+0x430>
ffffffffc02009e6:	f1cff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc02009ea:	686c                	ld	a1,208(s0)
ffffffffc02009ec:	00002517          	auipc	a0,0x2
ffffffffc02009f0:	d4450513          	addi	a0,a0,-700 # ffffffffc0202730 <commands+0x448>
ffffffffc02009f4:	f0eff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc02009f8:	6c6c                	ld	a1,216(s0)
ffffffffc02009fa:	00002517          	auipc	a0,0x2
ffffffffc02009fe:	d4e50513          	addi	a0,a0,-690 # ffffffffc0202748 <commands+0x460>
ffffffffc0200a02:	f00ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200a06:	706c                	ld	a1,224(s0)
ffffffffc0200a08:	00002517          	auipc	a0,0x2
ffffffffc0200a0c:	d5850513          	addi	a0,a0,-680 # ffffffffc0202760 <commands+0x478>
ffffffffc0200a10:	ef2ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200a14:	746c                	ld	a1,232(s0)
ffffffffc0200a16:	00002517          	auipc	a0,0x2
ffffffffc0200a1a:	d6250513          	addi	a0,a0,-670 # ffffffffc0202778 <commands+0x490>
ffffffffc0200a1e:	ee4ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200a22:	786c                	ld	a1,240(s0)
ffffffffc0200a24:	00002517          	auipc	a0,0x2
ffffffffc0200a28:	d6c50513          	addi	a0,a0,-660 # ffffffffc0202790 <commands+0x4a8>
ffffffffc0200a2c:	ed6ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a30:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200a32:	6402                	ld	s0,0(sp)
ffffffffc0200a34:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a36:	00002517          	auipc	a0,0x2
ffffffffc0200a3a:	d7250513          	addi	a0,a0,-654 # ffffffffc02027a8 <commands+0x4c0>
}
ffffffffc0200a3e:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200a40:	ec2ff06f          	j	ffffffffc0200102 <cprintf>

ffffffffc0200a44 <print_trapframe>:
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a44:	1141                	addi	sp,sp,-16
ffffffffc0200a46:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a48:	85aa                	mv	a1,a0
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a4a:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a4c:	00002517          	auipc	a0,0x2
ffffffffc0200a50:	d7450513          	addi	a0,a0,-652 # ffffffffc02027c0 <commands+0x4d8>
void print_trapframe(struct trapframe *tf) {
ffffffffc0200a54:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200a56:	eacff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200a5a:	8522                	mv	a0,s0
ffffffffc0200a5c:	e1bff0ef          	jal	ra,ffffffffc0200876 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200a60:	10043583          	ld	a1,256(s0)
ffffffffc0200a64:	00002517          	auipc	a0,0x2
ffffffffc0200a68:	d7450513          	addi	a0,a0,-652 # ffffffffc02027d8 <commands+0x4f0>
ffffffffc0200a6c:	e96ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200a70:	10843583          	ld	a1,264(s0)
ffffffffc0200a74:	00002517          	auipc	a0,0x2
ffffffffc0200a78:	d7c50513          	addi	a0,a0,-644 # ffffffffc02027f0 <commands+0x508>
ffffffffc0200a7c:	e86ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  badvaddr 0x%08x\n", tf->badvaddr);
ffffffffc0200a80:	11043583          	ld	a1,272(s0)
ffffffffc0200a84:	00002517          	auipc	a0,0x2
ffffffffc0200a88:	d8450513          	addi	a0,a0,-636 # ffffffffc0202808 <commands+0x520>
ffffffffc0200a8c:	e76ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a90:	11843583          	ld	a1,280(s0)
}
ffffffffc0200a94:	6402                	ld	s0,0(sp)
ffffffffc0200a96:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200a98:	00002517          	auipc	a0,0x2
ffffffffc0200a9c:	d8850513          	addi	a0,a0,-632 # ffffffffc0202820 <commands+0x538>
}
ffffffffc0200aa0:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200aa2:	e60ff06f          	j	ffffffffc0200102 <cprintf>

ffffffffc0200aa6 <interrupt_handler>:

void interrupt_handler(struct trapframe *tf) {
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200aa6:	11853783          	ld	a5,280(a0)
ffffffffc0200aaa:	472d                	li	a4,11
ffffffffc0200aac:	0786                	slli	a5,a5,0x1
ffffffffc0200aae:	8385                	srli	a5,a5,0x1
ffffffffc0200ab0:	08f76363          	bltu	a4,a5,ffffffffc0200b36 <interrupt_handler+0x90>
ffffffffc0200ab4:	00002717          	auipc	a4,0x2
ffffffffc0200ab8:	e4c70713          	addi	a4,a4,-436 # ffffffffc0202900 <commands+0x618>
ffffffffc0200abc:	078a                	slli	a5,a5,0x2
ffffffffc0200abe:	97ba                	add	a5,a5,a4
ffffffffc0200ac0:	439c                	lw	a5,0(a5)
ffffffffc0200ac2:	97ba                	add	a5,a5,a4
ffffffffc0200ac4:	8782                	jr	a5
            break;
        case IRQ_H_SOFT:
            cprintf("Hypervisor software interrupt\n");
            break;
        case IRQ_M_SOFT:
            cprintf("Machine software interrupt\n");
ffffffffc0200ac6:	00002517          	auipc	a0,0x2
ffffffffc0200aca:	dd250513          	addi	a0,a0,-558 # ffffffffc0202898 <commands+0x5b0>
ffffffffc0200ace:	e34ff06f          	j	ffffffffc0200102 <cprintf>
            cprintf("Hypervisor software interrupt\n");
ffffffffc0200ad2:	00002517          	auipc	a0,0x2
ffffffffc0200ad6:	da650513          	addi	a0,a0,-602 # ffffffffc0202878 <commands+0x590>
ffffffffc0200ada:	e28ff06f          	j	ffffffffc0200102 <cprintf>
            cprintf("User software interrupt\n");
ffffffffc0200ade:	00002517          	auipc	a0,0x2
ffffffffc0200ae2:	d5a50513          	addi	a0,a0,-678 # ffffffffc0202838 <commands+0x550>
ffffffffc0200ae6:	e1cff06f          	j	ffffffffc0200102 <cprintf>
            break;
        case IRQ_U_TIMER:
            cprintf("User Timer interrupt\n");
ffffffffc0200aea:	00002517          	auipc	a0,0x2
ffffffffc0200aee:	dce50513          	addi	a0,a0,-562 # ffffffffc02028b8 <commands+0x5d0>
ffffffffc0200af2:	e10ff06f          	j	ffffffffc0200102 <cprintf>
void interrupt_handler(struct trapframe *tf) {
ffffffffc0200af6:	1141                	addi	sp,sp,-16
ffffffffc0200af8:	e406                	sd	ra,8(sp)
             *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
            * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
            */
        {
            static int print_count = 0;
            clock_set_next_event();
ffffffffc0200afa:	991ff0ef          	jal	ra,ffffffffc020048a <clock_set_next_event>
            ticks++;
ffffffffc0200afe:	00007797          	auipc	a5,0x7
ffffffffc0200b02:	94a78793          	addi	a5,a5,-1718 # ffffffffc0207448 <ticks>
ffffffffc0200b06:	6398                	ld	a4,0(a5)
ffffffffc0200b08:	0705                	addi	a4,a4,1
ffffffffc0200b0a:	e398                	sd	a4,0(a5)
            if (ticks % TICK_NUM == 0) {
ffffffffc0200b0c:	639c                	ld	a5,0(a5)
ffffffffc0200b0e:	06400713          	li	a4,100
ffffffffc0200b12:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200b16:	c38d                	beqz	a5,ffffffffc0200b38 <interrupt_handler+0x92>
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200b18:	60a2                	ld	ra,8(sp)
ffffffffc0200b1a:	0141                	addi	sp,sp,16
ffffffffc0200b1c:	8082                	ret
            cprintf("Supervisor external interrupt\n");
ffffffffc0200b1e:	00002517          	auipc	a0,0x2
ffffffffc0200b22:	dc250513          	addi	a0,a0,-574 # ffffffffc02028e0 <commands+0x5f8>
ffffffffc0200b26:	ddcff06f          	j	ffffffffc0200102 <cprintf>
            cprintf("Supervisor software interrupt\n");
ffffffffc0200b2a:	00002517          	auipc	a0,0x2
ffffffffc0200b2e:	d2e50513          	addi	a0,a0,-722 # ffffffffc0202858 <commands+0x570>
ffffffffc0200b32:	dd0ff06f          	j	ffffffffc0200102 <cprintf>
            print_trapframe(tf);
ffffffffc0200b36:	b739                	j	ffffffffc0200a44 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200b38:	06400593          	li	a1,100
ffffffffc0200b3c:	00002517          	auipc	a0,0x2
ffffffffc0200b40:	d9450513          	addi	a0,a0,-620 # ffffffffc02028d0 <commands+0x5e8>
ffffffffc0200b44:	dbeff0ef          	jal	ra,ffffffffc0200102 <cprintf>
                print_count++;
ffffffffc0200b48:	00007717          	auipc	a4,0x7
ffffffffc0200b4c:	91870713          	addi	a4,a4,-1768 # ffffffffc0207460 <print_count.0>
ffffffffc0200b50:	431c                	lw	a5,0(a4)
                if (print_count >= 10) {
ffffffffc0200b52:	46a5                	li	a3,9
                print_count++;
ffffffffc0200b54:	0017861b          	addiw	a2,a5,1
ffffffffc0200b58:	c310                	sw	a2,0(a4)
                if (print_count >= 10) {
ffffffffc0200b5a:	fac6dfe3          	bge	a3,a2,ffffffffc0200b18 <interrupt_handler+0x72>
}
ffffffffc0200b5e:	60a2                	ld	ra,8(sp)
ffffffffc0200b60:	0141                	addi	sp,sp,16
                    sbi_shutdown();
ffffffffc0200b62:	3d60106f          	j	ffffffffc0201f38 <sbi_shutdown>

ffffffffc0200b66 <exception_handler>:

void exception_handler(struct trapframe *tf) {
ffffffffc0200b66:	1101                	addi	sp,sp,-32
ffffffffc0200b68:	e822                	sd	s0,16(sp)
    switch (tf->cause) {
ffffffffc0200b6a:	11853403          	ld	s0,280(a0)
void exception_handler(struct trapframe *tf) {
ffffffffc0200b6e:	e426                	sd	s1,8(sp)
ffffffffc0200b70:	e04a                	sd	s2,0(sp)
ffffffffc0200b72:	ec06                	sd	ra,24(sp)
    switch (tf->cause) {
ffffffffc0200b74:	490d                	li	s2,3
void exception_handler(struct trapframe *tf) {
ffffffffc0200b76:	84aa                	mv	s1,a0
    switch (tf->cause) {
ffffffffc0200b78:	05240f63          	beq	s0,s2,ffffffffc0200bd6 <exception_handler+0x70>
ffffffffc0200b7c:	04896363          	bltu	s2,s0,ffffffffc0200bc2 <exception_handler+0x5c>
ffffffffc0200b80:	4789                	li	a5,2
ffffffffc0200b82:	02f41a63          	bne	s0,a5,ffffffffc0200bb6 <exception_handler+0x50>
             /* LAB3 CHALLENGE3   YOUR CODE :  */
            /*(1)输出指令异常类型（ Illegal instruction）
             *(2)输出异常指令地址
             *(3)更新 tf->epc寄存器
            */
            cprintf("Illegal instruction caught at 0x%08x\n", tf->epc);
ffffffffc0200b86:	10853583          	ld	a1,264(a0)
ffffffffc0200b8a:	00002517          	auipc	a0,0x2
ffffffffc0200b8e:	da650513          	addi	a0,a0,-602 # ffffffffc0202930 <commands+0x648>
ffffffffc0200b92:	d70ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
            cprintf("Exception type:Illegal instruction\n");
ffffffffc0200b96:	00002517          	auipc	a0,0x2
ffffffffc0200b9a:	dc250513          	addi	a0,a0,-574 # ffffffffc0202958 <commands+0x670>
ffffffffc0200b9e:	d64ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
            {
                // 读取指令的前2个字节
                uint16_t insn = *(uint16_t *)tf->epc;
ffffffffc0200ba2:	1084b783          	ld	a5,264(s1)
                // 检查最低两位
                if ((insn & 0x3) == 0x3) {
ffffffffc0200ba6:	0007d703          	lhu	a4,0(a5)
ffffffffc0200baa:	8b0d                	andi	a4,a4,3
ffffffffc0200bac:	05270a63          	beq	a4,s2,ffffffffc0200c00 <exception_handler+0x9a>
                uint16_t insn = *(uint16_t *)tf->epc;
                // 检查最低两位
                if ((insn & 0x3) == 0x3) {
                    tf->epc += 4; // 32位指令
                } else {
                    tf->epc += 2; // 16位指令
ffffffffc0200bb0:	0789                	addi	a5,a5,2
ffffffffc0200bb2:	10f4b423          	sd	a5,264(s1)
            break;
        default:
            print_trapframe(tf);
            break;
    }
}
ffffffffc0200bb6:	60e2                	ld	ra,24(sp)
ffffffffc0200bb8:	6442                	ld	s0,16(sp)
ffffffffc0200bba:	64a2                	ld	s1,8(sp)
ffffffffc0200bbc:	6902                	ld	s2,0(sp)
ffffffffc0200bbe:	6105                	addi	sp,sp,32
ffffffffc0200bc0:	8082                	ret
    switch (tf->cause) {
ffffffffc0200bc2:	1471                	addi	s0,s0,-4
ffffffffc0200bc4:	479d                	li	a5,7
ffffffffc0200bc6:	fe87f8e3          	bgeu	a5,s0,ffffffffc0200bb6 <exception_handler+0x50>
}
ffffffffc0200bca:	6442                	ld	s0,16(sp)
ffffffffc0200bcc:	60e2                	ld	ra,24(sp)
ffffffffc0200bce:	64a2                	ld	s1,8(sp)
ffffffffc0200bd0:	6902                	ld	s2,0(sp)
ffffffffc0200bd2:	6105                	addi	sp,sp,32
            print_trapframe(tf);
ffffffffc0200bd4:	bd85                	j	ffffffffc0200a44 <print_trapframe>
            cprintf("ebreak caught at 0x%08x\n", tf->epc);
ffffffffc0200bd6:	10853583          	ld	a1,264(a0)
ffffffffc0200bda:	00002517          	auipc	a0,0x2
ffffffffc0200bde:	da650513          	addi	a0,a0,-602 # ffffffffc0202980 <commands+0x698>
ffffffffc0200be2:	d20ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
            cprintf("Exception type: breakpoint\n");
ffffffffc0200be6:	00002517          	auipc	a0,0x2
ffffffffc0200bea:	dba50513          	addi	a0,a0,-582 # ffffffffc02029a0 <commands+0x6b8>
ffffffffc0200bee:	d14ff0ef          	jal	ra,ffffffffc0200102 <cprintf>
                uint16_t insn = *(uint16_t *)tf->epc;
ffffffffc0200bf2:	1084b783          	ld	a5,264(s1)
                if ((insn & 0x3) == 0x3) {
ffffffffc0200bf6:	0007d703          	lhu	a4,0(a5)
ffffffffc0200bfa:	8b0d                	andi	a4,a4,3
ffffffffc0200bfc:	fa871ae3          	bne	a4,s0,ffffffffc0200bb0 <exception_handler+0x4a>
}
ffffffffc0200c00:	60e2                	ld	ra,24(sp)
ffffffffc0200c02:	6442                	ld	s0,16(sp)
                    tf->epc += 4; // 32位指令
ffffffffc0200c04:	0791                	addi	a5,a5,4
ffffffffc0200c06:	10f4b423          	sd	a5,264(s1)
}
ffffffffc0200c0a:	6902                	ld	s2,0(sp)
ffffffffc0200c0c:	64a2                	ld	s1,8(sp)
ffffffffc0200c0e:	6105                	addi	sp,sp,32
ffffffffc0200c10:	8082                	ret

ffffffffc0200c12 <trap>:

static inline void trap_dispatch(struct trapframe *tf) {
    if ((intptr_t)tf->cause < 0) {
ffffffffc0200c12:	11853783          	ld	a5,280(a0)
ffffffffc0200c16:	0007c363          	bltz	a5,ffffffffc0200c1c <trap+0xa>
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
ffffffffc0200c1a:	b7b1                	j	ffffffffc0200b66 <exception_handler>
        interrupt_handler(tf);
ffffffffc0200c1c:	b569                	j	ffffffffc0200aa6 <interrupt_handler>
	...

ffffffffc0200c20 <__alltraps>:
    .endm

    .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
ffffffffc0200c20:	14011073          	csrw	sscratch,sp
ffffffffc0200c24:	712d                	addi	sp,sp,-288
ffffffffc0200c26:	e002                	sd	zero,0(sp)
ffffffffc0200c28:	e406                	sd	ra,8(sp)
ffffffffc0200c2a:	ec0e                	sd	gp,24(sp)
ffffffffc0200c2c:	f012                	sd	tp,32(sp)
ffffffffc0200c2e:	f416                	sd	t0,40(sp)
ffffffffc0200c30:	f81a                	sd	t1,48(sp)
ffffffffc0200c32:	fc1e                	sd	t2,56(sp)
ffffffffc0200c34:	e0a2                	sd	s0,64(sp)
ffffffffc0200c36:	e4a6                	sd	s1,72(sp)
ffffffffc0200c38:	e8aa                	sd	a0,80(sp)
ffffffffc0200c3a:	ecae                	sd	a1,88(sp)
ffffffffc0200c3c:	f0b2                	sd	a2,96(sp)
ffffffffc0200c3e:	f4b6                	sd	a3,104(sp)
ffffffffc0200c40:	f8ba                	sd	a4,112(sp)
ffffffffc0200c42:	fcbe                	sd	a5,120(sp)
ffffffffc0200c44:	e142                	sd	a6,128(sp)
ffffffffc0200c46:	e546                	sd	a7,136(sp)
ffffffffc0200c48:	e94a                	sd	s2,144(sp)
ffffffffc0200c4a:	ed4e                	sd	s3,152(sp)
ffffffffc0200c4c:	f152                	sd	s4,160(sp)
ffffffffc0200c4e:	f556                	sd	s5,168(sp)
ffffffffc0200c50:	f95a                	sd	s6,176(sp)
ffffffffc0200c52:	fd5e                	sd	s7,184(sp)
ffffffffc0200c54:	e1e2                	sd	s8,192(sp)
ffffffffc0200c56:	e5e6                	sd	s9,200(sp)
ffffffffc0200c58:	e9ea                	sd	s10,208(sp)
ffffffffc0200c5a:	edee                	sd	s11,216(sp)
ffffffffc0200c5c:	f1f2                	sd	t3,224(sp)
ffffffffc0200c5e:	f5f6                	sd	t4,232(sp)
ffffffffc0200c60:	f9fa                	sd	t5,240(sp)
ffffffffc0200c62:	fdfe                	sd	t6,248(sp)
ffffffffc0200c64:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200c68:	100024f3          	csrr	s1,sstatus
ffffffffc0200c6c:	14102973          	csrr	s2,sepc
ffffffffc0200c70:	143029f3          	csrr	s3,stval
ffffffffc0200c74:	14202a73          	csrr	s4,scause
ffffffffc0200c78:	e822                	sd	s0,16(sp)
ffffffffc0200c7a:	e226                	sd	s1,256(sp)
ffffffffc0200c7c:	e64a                	sd	s2,264(sp)
ffffffffc0200c7e:	ea4e                	sd	s3,272(sp)
ffffffffc0200c80:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200c82:	850a                	mv	a0,sp
    jal trap
ffffffffc0200c84:	f8fff0ef          	jal	ra,ffffffffc0200c12 <trap>

ffffffffc0200c88 <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200c88:	6492                	ld	s1,256(sp)
ffffffffc0200c8a:	6932                	ld	s2,264(sp)
ffffffffc0200c8c:	10049073          	csrw	sstatus,s1
ffffffffc0200c90:	14191073          	csrw	sepc,s2
ffffffffc0200c94:	60a2                	ld	ra,8(sp)
ffffffffc0200c96:	61e2                	ld	gp,24(sp)
ffffffffc0200c98:	7202                	ld	tp,32(sp)
ffffffffc0200c9a:	72a2                	ld	t0,40(sp)
ffffffffc0200c9c:	7342                	ld	t1,48(sp)
ffffffffc0200c9e:	73e2                	ld	t2,56(sp)
ffffffffc0200ca0:	6406                	ld	s0,64(sp)
ffffffffc0200ca2:	64a6                	ld	s1,72(sp)
ffffffffc0200ca4:	6546                	ld	a0,80(sp)
ffffffffc0200ca6:	65e6                	ld	a1,88(sp)
ffffffffc0200ca8:	7606                	ld	a2,96(sp)
ffffffffc0200caa:	76a6                	ld	a3,104(sp)
ffffffffc0200cac:	7746                	ld	a4,112(sp)
ffffffffc0200cae:	77e6                	ld	a5,120(sp)
ffffffffc0200cb0:	680a                	ld	a6,128(sp)
ffffffffc0200cb2:	68aa                	ld	a7,136(sp)
ffffffffc0200cb4:	694a                	ld	s2,144(sp)
ffffffffc0200cb6:	69ea                	ld	s3,152(sp)
ffffffffc0200cb8:	7a0a                	ld	s4,160(sp)
ffffffffc0200cba:	7aaa                	ld	s5,168(sp)
ffffffffc0200cbc:	7b4a                	ld	s6,176(sp)
ffffffffc0200cbe:	7bea                	ld	s7,184(sp)
ffffffffc0200cc0:	6c0e                	ld	s8,192(sp)
ffffffffc0200cc2:	6cae                	ld	s9,200(sp)
ffffffffc0200cc4:	6d4e                	ld	s10,208(sp)
ffffffffc0200cc6:	6dee                	ld	s11,216(sp)
ffffffffc0200cc8:	7e0e                	ld	t3,224(sp)
ffffffffc0200cca:	7eae                	ld	t4,232(sp)
ffffffffc0200ccc:	7f4e                	ld	t5,240(sp)
ffffffffc0200cce:	7fee                	ld	t6,248(sp)
ffffffffc0200cd0:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200cd2:	10200073          	sret

ffffffffc0200cd6 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200cd6:	00006797          	auipc	a5,0x6
ffffffffc0200cda:	35278793          	addi	a5,a5,850 # ffffffffc0207028 <free_area>
ffffffffc0200cde:	e79c                	sd	a5,8(a5)
ffffffffc0200ce0:	e39c                	sd	a5,0(a5)
#define nr_free (free_area.nr_free)

static void
default_init(void) {
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200ce2:	0007a823          	sw	zero,16(a5)
}
ffffffffc0200ce6:	8082                	ret

ffffffffc0200ce8 <default_nr_free_pages>:
}

static size_t
default_nr_free_pages(void) {
    return nr_free;
}
ffffffffc0200ce8:	00006517          	auipc	a0,0x6
ffffffffc0200cec:	35056503          	lwu	a0,848(a0) # ffffffffc0207038 <free_area+0x10>
ffffffffc0200cf0:	8082                	ret

ffffffffc0200cf2 <default_check>:
}

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
ffffffffc0200cf2:	715d                	addi	sp,sp,-80
ffffffffc0200cf4:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0200cf6:	00006417          	auipc	s0,0x6
ffffffffc0200cfa:	33240413          	addi	s0,s0,818 # ffffffffc0207028 <free_area>
ffffffffc0200cfe:	641c                	ld	a5,8(s0)
ffffffffc0200d00:	e486                	sd	ra,72(sp)
ffffffffc0200d02:	fc26                	sd	s1,56(sp)
ffffffffc0200d04:	f84a                	sd	s2,48(sp)
ffffffffc0200d06:	f44e                	sd	s3,40(sp)
ffffffffc0200d08:	f052                	sd	s4,32(sp)
ffffffffc0200d0a:	ec56                	sd	s5,24(sp)
ffffffffc0200d0c:	e85a                	sd	s6,16(sp)
ffffffffc0200d0e:	e45e                	sd	s7,8(sp)
ffffffffc0200d10:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200d12:	2c878763          	beq	a5,s0,ffffffffc0200fe0 <default_check+0x2ee>
    int count = 0, total = 0;
ffffffffc0200d16:	4481                	li	s1,0
ffffffffc0200d18:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0200d1a:	ff07b703          	ld	a4,-16(a5)
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc0200d1e:	8b09                	andi	a4,a4,2
ffffffffc0200d20:	2c070463          	beqz	a4,ffffffffc0200fe8 <default_check+0x2f6>
        count ++, total += p->property;
ffffffffc0200d24:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200d28:	679c                	ld	a5,8(a5)
ffffffffc0200d2a:	2905                	addiw	s2,s2,1
ffffffffc0200d2c:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200d2e:	fe8796e3          	bne	a5,s0,ffffffffc0200d1a <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc0200d32:	89a6                	mv	s3,s1
ffffffffc0200d34:	2f9000ef          	jal	ra,ffffffffc020182c <nr_free_pages>
ffffffffc0200d38:	71351863          	bne	a0,s3,ffffffffc0201448 <default_check+0x756>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200d3c:	4505                	li	a0,1
ffffffffc0200d3e:	271000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200d42:	8a2a                	mv	s4,a0
ffffffffc0200d44:	44050263          	beqz	a0,ffffffffc0201188 <default_check+0x496>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200d48:	4505                	li	a0,1
ffffffffc0200d4a:	265000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200d4e:	89aa                	mv	s3,a0
ffffffffc0200d50:	70050c63          	beqz	a0,ffffffffc0201468 <default_check+0x776>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200d54:	4505                	li	a0,1
ffffffffc0200d56:	259000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200d5a:	8aaa                	mv	s5,a0
ffffffffc0200d5c:	4a050663          	beqz	a0,ffffffffc0201208 <default_check+0x516>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0200d60:	2b3a0463          	beq	s4,s3,ffffffffc0201008 <default_check+0x316>
ffffffffc0200d64:	2aaa0263          	beq	s4,a0,ffffffffc0201008 <default_check+0x316>
ffffffffc0200d68:	2aa98063          	beq	s3,a0,ffffffffc0201008 <default_check+0x316>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0200d6c:	000a2783          	lw	a5,0(s4)
ffffffffc0200d70:	2a079c63          	bnez	a5,ffffffffc0201028 <default_check+0x336>
ffffffffc0200d74:	0009a783          	lw	a5,0(s3)
ffffffffc0200d78:	2a079863          	bnez	a5,ffffffffc0201028 <default_check+0x336>
ffffffffc0200d7c:	411c                	lw	a5,0(a0)
ffffffffc0200d7e:	2a079563          	bnez	a5,ffffffffc0201028 <default_check+0x336>
extern struct Page *pages;
extern size_t npage;
extern const size_t nbase;
extern uint64_t va_pa_offset;

static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200d82:	00006797          	auipc	a5,0x6
ffffffffc0200d86:	6ee7b783          	ld	a5,1774(a5) # ffffffffc0207470 <pages>
ffffffffc0200d8a:	40fa0733          	sub	a4,s4,a5
ffffffffc0200d8e:	870d                	srai	a4,a4,0x3
ffffffffc0200d90:	00002597          	auipc	a1,0x2
ffffffffc0200d94:	3b85b583          	ld	a1,952(a1) # ffffffffc0203148 <error_string+0x38>
ffffffffc0200d98:	02b70733          	mul	a4,a4,a1
ffffffffc0200d9c:	00002617          	auipc	a2,0x2
ffffffffc0200da0:	3b463603          	ld	a2,948(a2) # ffffffffc0203150 <nbase>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0200da4:	00006697          	auipc	a3,0x6
ffffffffc0200da8:	6c46b683          	ld	a3,1732(a3) # ffffffffc0207468 <npage>
ffffffffc0200dac:	06b2                	slli	a3,a3,0xc
ffffffffc0200dae:	9732                	add	a4,a4,a2

static inline uintptr_t page2pa(struct Page *page) {
    return page2ppn(page) << PGSHIFT;
ffffffffc0200db0:	0732                	slli	a4,a4,0xc
ffffffffc0200db2:	28d77b63          	bgeu	a4,a3,ffffffffc0201048 <default_check+0x356>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200db6:	40f98733          	sub	a4,s3,a5
ffffffffc0200dba:	870d                	srai	a4,a4,0x3
ffffffffc0200dbc:	02b70733          	mul	a4,a4,a1
ffffffffc0200dc0:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dc2:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0200dc4:	4cd77263          	bgeu	a4,a3,ffffffffc0201288 <default_check+0x596>
static inline ppn_t page2ppn(struct Page *page) { return page - pages + nbase; }
ffffffffc0200dc8:	40f507b3          	sub	a5,a0,a5
ffffffffc0200dcc:	878d                	srai	a5,a5,0x3
ffffffffc0200dce:	02b787b3          	mul	a5,a5,a1
ffffffffc0200dd2:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc0200dd4:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc0200dd6:	30d7f963          	bgeu	a5,a3,ffffffffc02010e8 <default_check+0x3f6>
    assert(alloc_page() == NULL);
ffffffffc0200dda:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200ddc:	00043c03          	ld	s8,0(s0)
ffffffffc0200de0:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc0200de4:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc0200de8:	e400                	sd	s0,8(s0)
ffffffffc0200dea:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc0200dec:	00006797          	auipc	a5,0x6
ffffffffc0200df0:	2407a623          	sw	zero,588(a5) # ffffffffc0207038 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc0200df4:	1bb000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200df8:	2c051863          	bnez	a0,ffffffffc02010c8 <default_check+0x3d6>
    free_page(p0);
ffffffffc0200dfc:	4585                	li	a1,1
ffffffffc0200dfe:	8552                	mv	a0,s4
ffffffffc0200e00:	1ed000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_page(p1);
ffffffffc0200e04:	4585                	li	a1,1
ffffffffc0200e06:	854e                	mv	a0,s3
ffffffffc0200e08:	1e5000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_page(p2);
ffffffffc0200e0c:	4585                	li	a1,1
ffffffffc0200e0e:	8556                	mv	a0,s5
ffffffffc0200e10:	1dd000ef          	jal	ra,ffffffffc02017ec <free_pages>
    assert(nr_free == 3);
ffffffffc0200e14:	4818                	lw	a4,16(s0)
ffffffffc0200e16:	478d                	li	a5,3
ffffffffc0200e18:	28f71863          	bne	a4,a5,ffffffffc02010a8 <default_check+0x3b6>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0200e1c:	4505                	li	a0,1
ffffffffc0200e1e:	191000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e22:	89aa                	mv	s3,a0
ffffffffc0200e24:	26050263          	beqz	a0,ffffffffc0201088 <default_check+0x396>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0200e28:	4505                	li	a0,1
ffffffffc0200e2a:	185000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e2e:	8aaa                	mv	s5,a0
ffffffffc0200e30:	3a050c63          	beqz	a0,ffffffffc02011e8 <default_check+0x4f6>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0200e34:	4505                	li	a0,1
ffffffffc0200e36:	179000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e3a:	8a2a                	mv	s4,a0
ffffffffc0200e3c:	38050663          	beqz	a0,ffffffffc02011c8 <default_check+0x4d6>
    assert(alloc_page() == NULL);
ffffffffc0200e40:	4505                	li	a0,1
ffffffffc0200e42:	16d000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e46:	36051163          	bnez	a0,ffffffffc02011a8 <default_check+0x4b6>
    free_page(p0);
ffffffffc0200e4a:	4585                	li	a1,1
ffffffffc0200e4c:	854e                	mv	a0,s3
ffffffffc0200e4e:	19f000ef          	jal	ra,ffffffffc02017ec <free_pages>
    assert(!list_empty(&free_list));
ffffffffc0200e52:	641c                	ld	a5,8(s0)
ffffffffc0200e54:	20878a63          	beq	a5,s0,ffffffffc0201068 <default_check+0x376>
    assert((p = alloc_page()) == p0);
ffffffffc0200e58:	4505                	li	a0,1
ffffffffc0200e5a:	155000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e5e:	30a99563          	bne	s3,a0,ffffffffc0201168 <default_check+0x476>
    assert(alloc_page() == NULL);
ffffffffc0200e62:	4505                	li	a0,1
ffffffffc0200e64:	14b000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e68:	2e051063          	bnez	a0,ffffffffc0201148 <default_check+0x456>
    assert(nr_free == 0);
ffffffffc0200e6c:	481c                	lw	a5,16(s0)
ffffffffc0200e6e:	2a079d63          	bnez	a5,ffffffffc0201128 <default_check+0x436>
    free_page(p);
ffffffffc0200e72:	854e                	mv	a0,s3
ffffffffc0200e74:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc0200e76:	01843023          	sd	s8,0(s0)
ffffffffc0200e7a:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0200e7e:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc0200e82:	16b000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_page(p1);
ffffffffc0200e86:	4585                	li	a1,1
ffffffffc0200e88:	8556                	mv	a0,s5
ffffffffc0200e8a:	163000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_page(p2);
ffffffffc0200e8e:	4585                	li	a1,1
ffffffffc0200e90:	8552                	mv	a0,s4
ffffffffc0200e92:	15b000ef          	jal	ra,ffffffffc02017ec <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc0200e96:	4515                	li	a0,5
ffffffffc0200e98:	117000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200e9c:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc0200e9e:	26050563          	beqz	a0,ffffffffc0201108 <default_check+0x416>
ffffffffc0200ea2:	651c                	ld	a5,8(a0)
ffffffffc0200ea4:	8385                	srli	a5,a5,0x1
    assert(!PageProperty(p0));
ffffffffc0200ea6:	8b85                	andi	a5,a5,1
ffffffffc0200ea8:	54079063          	bnez	a5,ffffffffc02013e8 <default_check+0x6f6>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc0200eac:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc0200eae:	00043b03          	ld	s6,0(s0)
ffffffffc0200eb2:	00843a83          	ld	s5,8(s0)
ffffffffc0200eb6:	e000                	sd	s0,0(s0)
ffffffffc0200eb8:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc0200eba:	0f5000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200ebe:	50051563          	bnez	a0,ffffffffc02013c8 <default_check+0x6d6>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc0200ec2:	05098a13          	addi	s4,s3,80
ffffffffc0200ec6:	8552                	mv	a0,s4
ffffffffc0200ec8:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc0200eca:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc0200ece:	00006797          	auipc	a5,0x6
ffffffffc0200ed2:	1607a523          	sw	zero,362(a5) # ffffffffc0207038 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc0200ed6:	117000ef          	jal	ra,ffffffffc02017ec <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc0200eda:	4511                	li	a0,4
ffffffffc0200edc:	0d3000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200ee0:	4c051463          	bnez	a0,ffffffffc02013a8 <default_check+0x6b6>
ffffffffc0200ee4:	0589b783          	ld	a5,88(s3)
ffffffffc0200ee8:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0200eea:	8b85                	andi	a5,a5,1
ffffffffc0200eec:	48078e63          	beqz	a5,ffffffffc0201388 <default_check+0x696>
ffffffffc0200ef0:	0609a703          	lw	a4,96(s3)
ffffffffc0200ef4:	478d                	li	a5,3
ffffffffc0200ef6:	48f71963          	bne	a4,a5,ffffffffc0201388 <default_check+0x696>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0200efa:	450d                	li	a0,3
ffffffffc0200efc:	0b3000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f00:	8c2a                	mv	s8,a0
ffffffffc0200f02:	46050363          	beqz	a0,ffffffffc0201368 <default_check+0x676>
    assert(alloc_page() == NULL);
ffffffffc0200f06:	4505                	li	a0,1
ffffffffc0200f08:	0a7000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f0c:	42051e63          	bnez	a0,ffffffffc0201348 <default_check+0x656>
    assert(p0 + 2 == p1);
ffffffffc0200f10:	418a1c63          	bne	s4,s8,ffffffffc0201328 <default_check+0x636>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc0200f14:	4585                	li	a1,1
ffffffffc0200f16:	854e                	mv	a0,s3
ffffffffc0200f18:	0d5000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_pages(p1, 3);
ffffffffc0200f1c:	458d                	li	a1,3
ffffffffc0200f1e:	8552                	mv	a0,s4
ffffffffc0200f20:	0cd000ef          	jal	ra,ffffffffc02017ec <free_pages>
ffffffffc0200f24:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0200f28:	02898c13          	addi	s8,s3,40
ffffffffc0200f2c:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0200f2e:	8b85                	andi	a5,a5,1
ffffffffc0200f30:	3c078c63          	beqz	a5,ffffffffc0201308 <default_check+0x616>
ffffffffc0200f34:	0109a703          	lw	a4,16(s3)
ffffffffc0200f38:	4785                	li	a5,1
ffffffffc0200f3a:	3cf71763          	bne	a4,a5,ffffffffc0201308 <default_check+0x616>
ffffffffc0200f3e:	008a3783          	ld	a5,8(s4)
ffffffffc0200f42:	8385                	srli	a5,a5,0x1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc0200f44:	8b85                	andi	a5,a5,1
ffffffffc0200f46:	3a078163          	beqz	a5,ffffffffc02012e8 <default_check+0x5f6>
ffffffffc0200f4a:	010a2703          	lw	a4,16(s4)
ffffffffc0200f4e:	478d                	li	a5,3
ffffffffc0200f50:	38f71c63          	bne	a4,a5,ffffffffc02012e8 <default_check+0x5f6>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc0200f54:	4505                	li	a0,1
ffffffffc0200f56:	059000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f5a:	36a99763          	bne	s3,a0,ffffffffc02012c8 <default_check+0x5d6>
    free_page(p0);
ffffffffc0200f5e:	4585                	li	a1,1
ffffffffc0200f60:	08d000ef          	jal	ra,ffffffffc02017ec <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc0200f64:	4509                	li	a0,2
ffffffffc0200f66:	049000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f6a:	32aa1f63          	bne	s4,a0,ffffffffc02012a8 <default_check+0x5b6>

    free_pages(p0, 2);
ffffffffc0200f6e:	4589                	li	a1,2
ffffffffc0200f70:	07d000ef          	jal	ra,ffffffffc02017ec <free_pages>
    free_page(p2);
ffffffffc0200f74:	4585                	li	a1,1
ffffffffc0200f76:	8562                	mv	a0,s8
ffffffffc0200f78:	075000ef          	jal	ra,ffffffffc02017ec <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0200f7c:	4515                	li	a0,5
ffffffffc0200f7e:	031000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f82:	89aa                	mv	s3,a0
ffffffffc0200f84:	48050263          	beqz	a0,ffffffffc0201408 <default_check+0x716>
    assert(alloc_page() == NULL);
ffffffffc0200f88:	4505                	li	a0,1
ffffffffc0200f8a:	025000ef          	jal	ra,ffffffffc02017ae <alloc_pages>
ffffffffc0200f8e:	2c051d63          	bnez	a0,ffffffffc0201268 <default_check+0x576>

    assert(nr_free == 0);
ffffffffc0200f92:	481c                	lw	a5,16(s0)
ffffffffc0200f94:	2a079a63          	bnez	a5,ffffffffc0201248 <default_check+0x556>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc0200f98:	4595                	li	a1,5
ffffffffc0200f9a:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc0200f9c:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc0200fa0:	01643023          	sd	s6,0(s0)
ffffffffc0200fa4:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc0200fa8:	045000ef          	jal	ra,ffffffffc02017ec <free_pages>
    return listelm->next;
ffffffffc0200fac:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fae:	00878963          	beq	a5,s0,ffffffffc0200fc0 <default_check+0x2ce>
        struct Page *p = le2page(le, page_link);
        count --, total -= p->property;
ffffffffc0200fb2:	ff87a703          	lw	a4,-8(a5)
ffffffffc0200fb6:	679c                	ld	a5,8(a5)
ffffffffc0200fb8:	397d                	addiw	s2,s2,-1
ffffffffc0200fba:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fbc:	fe879be3          	bne	a5,s0,ffffffffc0200fb2 <default_check+0x2c0>
    }
    assert(count == 0);
ffffffffc0200fc0:	26091463          	bnez	s2,ffffffffc0201228 <default_check+0x536>
    assert(total == 0);
ffffffffc0200fc4:	46049263          	bnez	s1,ffffffffc0201428 <default_check+0x736>
}
ffffffffc0200fc8:	60a6                	ld	ra,72(sp)
ffffffffc0200fca:	6406                	ld	s0,64(sp)
ffffffffc0200fcc:	74e2                	ld	s1,56(sp)
ffffffffc0200fce:	7942                	ld	s2,48(sp)
ffffffffc0200fd0:	79a2                	ld	s3,40(sp)
ffffffffc0200fd2:	7a02                	ld	s4,32(sp)
ffffffffc0200fd4:	6ae2                	ld	s5,24(sp)
ffffffffc0200fd6:	6b42                	ld	s6,16(sp)
ffffffffc0200fd8:	6ba2                	ld	s7,8(sp)
ffffffffc0200fda:	6c02                	ld	s8,0(sp)
ffffffffc0200fdc:	6161                	addi	sp,sp,80
ffffffffc0200fde:	8082                	ret
    while ((le = list_next(le)) != &free_list) {
ffffffffc0200fe0:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc0200fe2:	4481                	li	s1,0
ffffffffc0200fe4:	4901                	li	s2,0
ffffffffc0200fe6:	b3b9                	j	ffffffffc0200d34 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc0200fe8:	00002697          	auipc	a3,0x2
ffffffffc0200fec:	9d868693          	addi	a3,a3,-1576 # ffffffffc02029c0 <commands+0x6d8>
ffffffffc0200ff0:	00002617          	auipc	a2,0x2
ffffffffc0200ff4:	9e060613          	addi	a2,a2,-1568 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0200ff8:	0f000593          	li	a1,240
ffffffffc0200ffc:	00002517          	auipc	a0,0x2
ffffffffc0201000:	9ec50513          	addi	a0,a0,-1556 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201004:	bf8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201008:	00002697          	auipc	a3,0x2
ffffffffc020100c:	a7868693          	addi	a3,a3,-1416 # ffffffffc0202a80 <commands+0x798>
ffffffffc0201010:	00002617          	auipc	a2,0x2
ffffffffc0201014:	9c060613          	addi	a2,a2,-1600 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201018:	0bd00593          	li	a1,189
ffffffffc020101c:	00002517          	auipc	a0,0x2
ffffffffc0201020:	9cc50513          	addi	a0,a0,-1588 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201024:	bd8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201028:	00002697          	auipc	a3,0x2
ffffffffc020102c:	a8068693          	addi	a3,a3,-1408 # ffffffffc0202aa8 <commands+0x7c0>
ffffffffc0201030:	00002617          	auipc	a2,0x2
ffffffffc0201034:	9a060613          	addi	a2,a2,-1632 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201038:	0be00593          	li	a1,190
ffffffffc020103c:	00002517          	auipc	a0,0x2
ffffffffc0201040:	9ac50513          	addi	a0,a0,-1620 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201044:	bb8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201048:	00002697          	auipc	a3,0x2
ffffffffc020104c:	aa068693          	addi	a3,a3,-1376 # ffffffffc0202ae8 <commands+0x800>
ffffffffc0201050:	00002617          	auipc	a2,0x2
ffffffffc0201054:	98060613          	addi	a2,a2,-1664 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201058:	0c000593          	li	a1,192
ffffffffc020105c:	00002517          	auipc	a0,0x2
ffffffffc0201060:	98c50513          	addi	a0,a0,-1652 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201064:	b98ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201068:	00002697          	auipc	a3,0x2
ffffffffc020106c:	b0868693          	addi	a3,a3,-1272 # ffffffffc0202b70 <commands+0x888>
ffffffffc0201070:	00002617          	auipc	a2,0x2
ffffffffc0201074:	96060613          	addi	a2,a2,-1696 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201078:	0d900593          	li	a1,217
ffffffffc020107c:	00002517          	auipc	a0,0x2
ffffffffc0201080:	96c50513          	addi	a0,a0,-1684 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201084:	b78ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201088:	00002697          	auipc	a3,0x2
ffffffffc020108c:	99868693          	addi	a3,a3,-1640 # ffffffffc0202a20 <commands+0x738>
ffffffffc0201090:	00002617          	auipc	a2,0x2
ffffffffc0201094:	94060613          	addi	a2,a2,-1728 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201098:	0d200593          	li	a1,210
ffffffffc020109c:	00002517          	auipc	a0,0x2
ffffffffc02010a0:	94c50513          	addi	a0,a0,-1716 # ffffffffc02029e8 <commands+0x700>
ffffffffc02010a4:	b58ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(nr_free == 3);
ffffffffc02010a8:	00002697          	auipc	a3,0x2
ffffffffc02010ac:	ab868693          	addi	a3,a3,-1352 # ffffffffc0202b60 <commands+0x878>
ffffffffc02010b0:	00002617          	auipc	a2,0x2
ffffffffc02010b4:	92060613          	addi	a2,a2,-1760 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02010b8:	0d000593          	li	a1,208
ffffffffc02010bc:	00002517          	auipc	a0,0x2
ffffffffc02010c0:	92c50513          	addi	a0,a0,-1748 # ffffffffc02029e8 <commands+0x700>
ffffffffc02010c4:	b38ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc02010c8:	00002697          	auipc	a3,0x2
ffffffffc02010cc:	a8068693          	addi	a3,a3,-1408 # ffffffffc0202b48 <commands+0x860>
ffffffffc02010d0:	00002617          	auipc	a2,0x2
ffffffffc02010d4:	90060613          	addi	a2,a2,-1792 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02010d8:	0cb00593          	li	a1,203
ffffffffc02010dc:	00002517          	auipc	a0,0x2
ffffffffc02010e0:	90c50513          	addi	a0,a0,-1780 # ffffffffc02029e8 <commands+0x700>
ffffffffc02010e4:	b18ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010e8:	00002697          	auipc	a3,0x2
ffffffffc02010ec:	a4068693          	addi	a3,a3,-1472 # ffffffffc0202b28 <commands+0x840>
ffffffffc02010f0:	00002617          	auipc	a2,0x2
ffffffffc02010f4:	8e060613          	addi	a2,a2,-1824 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02010f8:	0c200593          	li	a1,194
ffffffffc02010fc:	00002517          	auipc	a0,0x2
ffffffffc0201100:	8ec50513          	addi	a0,a0,-1812 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201104:	af8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(p0 != NULL);
ffffffffc0201108:	00002697          	auipc	a3,0x2
ffffffffc020110c:	ab068693          	addi	a3,a3,-1360 # ffffffffc0202bb8 <commands+0x8d0>
ffffffffc0201110:	00002617          	auipc	a2,0x2
ffffffffc0201114:	8c060613          	addi	a2,a2,-1856 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201118:	0f800593          	li	a1,248
ffffffffc020111c:	00002517          	auipc	a0,0x2
ffffffffc0201120:	8cc50513          	addi	a0,a0,-1844 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201124:	ad8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(nr_free == 0);
ffffffffc0201128:	00002697          	auipc	a3,0x2
ffffffffc020112c:	a8068693          	addi	a3,a3,-1408 # ffffffffc0202ba8 <commands+0x8c0>
ffffffffc0201130:	00002617          	auipc	a2,0x2
ffffffffc0201134:	8a060613          	addi	a2,a2,-1888 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201138:	0df00593          	li	a1,223
ffffffffc020113c:	00002517          	auipc	a0,0x2
ffffffffc0201140:	8ac50513          	addi	a0,a0,-1876 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201144:	ab8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201148:	00002697          	auipc	a3,0x2
ffffffffc020114c:	a0068693          	addi	a3,a3,-1536 # ffffffffc0202b48 <commands+0x860>
ffffffffc0201150:	00002617          	auipc	a2,0x2
ffffffffc0201154:	88060613          	addi	a2,a2,-1920 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201158:	0dd00593          	li	a1,221
ffffffffc020115c:	00002517          	auipc	a0,0x2
ffffffffc0201160:	88c50513          	addi	a0,a0,-1908 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201164:	a98ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201168:	00002697          	auipc	a3,0x2
ffffffffc020116c:	a2068693          	addi	a3,a3,-1504 # ffffffffc0202b88 <commands+0x8a0>
ffffffffc0201170:	00002617          	auipc	a2,0x2
ffffffffc0201174:	86060613          	addi	a2,a2,-1952 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201178:	0dc00593          	li	a1,220
ffffffffc020117c:	00002517          	auipc	a0,0x2
ffffffffc0201180:	86c50513          	addi	a0,a0,-1940 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201184:	a78ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201188:	00002697          	auipc	a3,0x2
ffffffffc020118c:	89868693          	addi	a3,a3,-1896 # ffffffffc0202a20 <commands+0x738>
ffffffffc0201190:	00002617          	auipc	a2,0x2
ffffffffc0201194:	84060613          	addi	a2,a2,-1984 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201198:	0b900593          	li	a1,185
ffffffffc020119c:	00002517          	auipc	a0,0x2
ffffffffc02011a0:	84c50513          	addi	a0,a0,-1972 # ffffffffc02029e8 <commands+0x700>
ffffffffc02011a4:	a58ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc02011a8:	00002697          	auipc	a3,0x2
ffffffffc02011ac:	9a068693          	addi	a3,a3,-1632 # ffffffffc0202b48 <commands+0x860>
ffffffffc02011b0:	00002617          	auipc	a2,0x2
ffffffffc02011b4:	82060613          	addi	a2,a2,-2016 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02011b8:	0d600593          	li	a1,214
ffffffffc02011bc:	00002517          	auipc	a0,0x2
ffffffffc02011c0:	82c50513          	addi	a0,a0,-2004 # ffffffffc02029e8 <commands+0x700>
ffffffffc02011c4:	a38ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02011c8:	00002697          	auipc	a3,0x2
ffffffffc02011cc:	89868693          	addi	a3,a3,-1896 # ffffffffc0202a60 <commands+0x778>
ffffffffc02011d0:	00002617          	auipc	a2,0x2
ffffffffc02011d4:	80060613          	addi	a2,a2,-2048 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02011d8:	0d400593          	li	a1,212
ffffffffc02011dc:	00002517          	auipc	a0,0x2
ffffffffc02011e0:	80c50513          	addi	a0,a0,-2036 # ffffffffc02029e8 <commands+0x700>
ffffffffc02011e4:	a18ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02011e8:	00002697          	auipc	a3,0x2
ffffffffc02011ec:	85868693          	addi	a3,a3,-1960 # ffffffffc0202a40 <commands+0x758>
ffffffffc02011f0:	00001617          	auipc	a2,0x1
ffffffffc02011f4:	7e060613          	addi	a2,a2,2016 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02011f8:	0d300593          	li	a1,211
ffffffffc02011fc:	00001517          	auipc	a0,0x1
ffffffffc0201200:	7ec50513          	addi	a0,a0,2028 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201204:	9f8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201208:	00002697          	auipc	a3,0x2
ffffffffc020120c:	85868693          	addi	a3,a3,-1960 # ffffffffc0202a60 <commands+0x778>
ffffffffc0201210:	00001617          	auipc	a2,0x1
ffffffffc0201214:	7c060613          	addi	a2,a2,1984 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201218:	0bb00593          	li	a1,187
ffffffffc020121c:	00001517          	auipc	a0,0x1
ffffffffc0201220:	7cc50513          	addi	a0,a0,1996 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201224:	9d8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(count == 0);
ffffffffc0201228:	00002697          	auipc	a3,0x2
ffffffffc020122c:	ae068693          	addi	a3,a3,-1312 # ffffffffc0202d08 <commands+0xa20>
ffffffffc0201230:	00001617          	auipc	a2,0x1
ffffffffc0201234:	7a060613          	addi	a2,a2,1952 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201238:	12500593          	li	a1,293
ffffffffc020123c:	00001517          	auipc	a0,0x1
ffffffffc0201240:	7ac50513          	addi	a0,a0,1964 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201244:	9b8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(nr_free == 0);
ffffffffc0201248:	00002697          	auipc	a3,0x2
ffffffffc020124c:	96068693          	addi	a3,a3,-1696 # ffffffffc0202ba8 <commands+0x8c0>
ffffffffc0201250:	00001617          	auipc	a2,0x1
ffffffffc0201254:	78060613          	addi	a2,a2,1920 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201258:	11a00593          	li	a1,282
ffffffffc020125c:	00001517          	auipc	a0,0x1
ffffffffc0201260:	78c50513          	addi	a0,a0,1932 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201264:	998ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201268:	00002697          	auipc	a3,0x2
ffffffffc020126c:	8e068693          	addi	a3,a3,-1824 # ffffffffc0202b48 <commands+0x860>
ffffffffc0201270:	00001617          	auipc	a2,0x1
ffffffffc0201274:	76060613          	addi	a2,a2,1888 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201278:	11800593          	li	a1,280
ffffffffc020127c:	00001517          	auipc	a0,0x1
ffffffffc0201280:	76c50513          	addi	a0,a0,1900 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201284:	978ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201288:	00002697          	auipc	a3,0x2
ffffffffc020128c:	88068693          	addi	a3,a3,-1920 # ffffffffc0202b08 <commands+0x820>
ffffffffc0201290:	00001617          	auipc	a2,0x1
ffffffffc0201294:	74060613          	addi	a2,a2,1856 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201298:	0c100593          	li	a1,193
ffffffffc020129c:	00001517          	auipc	a0,0x1
ffffffffc02012a0:	74c50513          	addi	a0,a0,1868 # ffffffffc02029e8 <commands+0x700>
ffffffffc02012a4:	958ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02012a8:	00002697          	auipc	a3,0x2
ffffffffc02012ac:	a2068693          	addi	a3,a3,-1504 # ffffffffc0202cc8 <commands+0x9e0>
ffffffffc02012b0:	00001617          	auipc	a2,0x1
ffffffffc02012b4:	72060613          	addi	a2,a2,1824 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02012b8:	11200593          	li	a1,274
ffffffffc02012bc:	00001517          	auipc	a0,0x1
ffffffffc02012c0:	72c50513          	addi	a0,a0,1836 # ffffffffc02029e8 <commands+0x700>
ffffffffc02012c4:	938ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02012c8:	00002697          	auipc	a3,0x2
ffffffffc02012cc:	9e068693          	addi	a3,a3,-1568 # ffffffffc0202ca8 <commands+0x9c0>
ffffffffc02012d0:	00001617          	auipc	a2,0x1
ffffffffc02012d4:	70060613          	addi	a2,a2,1792 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02012d8:	11000593          	li	a1,272
ffffffffc02012dc:	00001517          	auipc	a0,0x1
ffffffffc02012e0:	70c50513          	addi	a0,a0,1804 # ffffffffc02029e8 <commands+0x700>
ffffffffc02012e4:	918ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02012e8:	00002697          	auipc	a3,0x2
ffffffffc02012ec:	99868693          	addi	a3,a3,-1640 # ffffffffc0202c80 <commands+0x998>
ffffffffc02012f0:	00001617          	auipc	a2,0x1
ffffffffc02012f4:	6e060613          	addi	a2,a2,1760 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02012f8:	10e00593          	li	a1,270
ffffffffc02012fc:	00001517          	auipc	a0,0x1
ffffffffc0201300:	6ec50513          	addi	a0,a0,1772 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201304:	8f8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201308:	00002697          	auipc	a3,0x2
ffffffffc020130c:	95068693          	addi	a3,a3,-1712 # ffffffffc0202c58 <commands+0x970>
ffffffffc0201310:	00001617          	auipc	a2,0x1
ffffffffc0201314:	6c060613          	addi	a2,a2,1728 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201318:	10d00593          	li	a1,269
ffffffffc020131c:	00001517          	auipc	a0,0x1
ffffffffc0201320:	6cc50513          	addi	a0,a0,1740 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201324:	8d8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201328:	00002697          	auipc	a3,0x2
ffffffffc020132c:	92068693          	addi	a3,a3,-1760 # ffffffffc0202c48 <commands+0x960>
ffffffffc0201330:	00001617          	auipc	a2,0x1
ffffffffc0201334:	6a060613          	addi	a2,a2,1696 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201338:	10800593          	li	a1,264
ffffffffc020133c:	00001517          	auipc	a0,0x1
ffffffffc0201340:	6ac50513          	addi	a0,a0,1708 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201344:	8b8ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201348:	00002697          	auipc	a3,0x2
ffffffffc020134c:	80068693          	addi	a3,a3,-2048 # ffffffffc0202b48 <commands+0x860>
ffffffffc0201350:	00001617          	auipc	a2,0x1
ffffffffc0201354:	68060613          	addi	a2,a2,1664 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201358:	10700593          	li	a1,263
ffffffffc020135c:	00001517          	auipc	a0,0x1
ffffffffc0201360:	68c50513          	addi	a0,a0,1676 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201364:	898ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201368:	00002697          	auipc	a3,0x2
ffffffffc020136c:	8c068693          	addi	a3,a3,-1856 # ffffffffc0202c28 <commands+0x940>
ffffffffc0201370:	00001617          	auipc	a2,0x1
ffffffffc0201374:	66060613          	addi	a2,a2,1632 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201378:	10600593          	li	a1,262
ffffffffc020137c:	00001517          	auipc	a0,0x1
ffffffffc0201380:	66c50513          	addi	a0,a0,1644 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201384:	878ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201388:	00002697          	auipc	a3,0x2
ffffffffc020138c:	87068693          	addi	a3,a3,-1936 # ffffffffc0202bf8 <commands+0x910>
ffffffffc0201390:	00001617          	auipc	a2,0x1
ffffffffc0201394:	64060613          	addi	a2,a2,1600 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201398:	10500593          	li	a1,261
ffffffffc020139c:	00001517          	auipc	a0,0x1
ffffffffc02013a0:	64c50513          	addi	a0,a0,1612 # ffffffffc02029e8 <commands+0x700>
ffffffffc02013a4:	858ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02013a8:	00002697          	auipc	a3,0x2
ffffffffc02013ac:	83868693          	addi	a3,a3,-1992 # ffffffffc0202be0 <commands+0x8f8>
ffffffffc02013b0:	00001617          	auipc	a2,0x1
ffffffffc02013b4:	62060613          	addi	a2,a2,1568 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02013b8:	10400593          	li	a1,260
ffffffffc02013bc:	00001517          	auipc	a0,0x1
ffffffffc02013c0:	62c50513          	addi	a0,a0,1580 # ffffffffc02029e8 <commands+0x700>
ffffffffc02013c4:	838ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013c8:	00001697          	auipc	a3,0x1
ffffffffc02013cc:	78068693          	addi	a3,a3,1920 # ffffffffc0202b48 <commands+0x860>
ffffffffc02013d0:	00001617          	auipc	a2,0x1
ffffffffc02013d4:	60060613          	addi	a2,a2,1536 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02013d8:	0fe00593          	li	a1,254
ffffffffc02013dc:	00001517          	auipc	a0,0x1
ffffffffc02013e0:	60c50513          	addi	a0,a0,1548 # ffffffffc02029e8 <commands+0x700>
ffffffffc02013e4:	818ff0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(!PageProperty(p0));
ffffffffc02013e8:	00001697          	auipc	a3,0x1
ffffffffc02013ec:	7e068693          	addi	a3,a3,2016 # ffffffffc0202bc8 <commands+0x8e0>
ffffffffc02013f0:	00001617          	auipc	a2,0x1
ffffffffc02013f4:	5e060613          	addi	a2,a2,1504 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02013f8:	0f900593          	li	a1,249
ffffffffc02013fc:	00001517          	auipc	a0,0x1
ffffffffc0201400:	5ec50513          	addi	a0,a0,1516 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201404:	ff9fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201408:	00002697          	auipc	a3,0x2
ffffffffc020140c:	8e068693          	addi	a3,a3,-1824 # ffffffffc0202ce8 <commands+0xa00>
ffffffffc0201410:	00001617          	auipc	a2,0x1
ffffffffc0201414:	5c060613          	addi	a2,a2,1472 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201418:	11700593          	li	a1,279
ffffffffc020141c:	00001517          	auipc	a0,0x1
ffffffffc0201420:	5cc50513          	addi	a0,a0,1484 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201424:	fd9fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(total == 0);
ffffffffc0201428:	00002697          	auipc	a3,0x2
ffffffffc020142c:	8f068693          	addi	a3,a3,-1808 # ffffffffc0202d18 <commands+0xa30>
ffffffffc0201430:	00001617          	auipc	a2,0x1
ffffffffc0201434:	5a060613          	addi	a2,a2,1440 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201438:	12600593          	li	a1,294
ffffffffc020143c:	00001517          	auipc	a0,0x1
ffffffffc0201440:	5ac50513          	addi	a0,a0,1452 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201444:	fb9fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(total == nr_free_pages());
ffffffffc0201448:	00001697          	auipc	a3,0x1
ffffffffc020144c:	5b868693          	addi	a3,a3,1464 # ffffffffc0202a00 <commands+0x718>
ffffffffc0201450:	00001617          	auipc	a2,0x1
ffffffffc0201454:	58060613          	addi	a2,a2,1408 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201458:	0f300593          	li	a1,243
ffffffffc020145c:	00001517          	auipc	a0,0x1
ffffffffc0201460:	58c50513          	addi	a0,a0,1420 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201464:	f99fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201468:	00001697          	auipc	a3,0x1
ffffffffc020146c:	5d868693          	addi	a3,a3,1496 # ffffffffc0202a40 <commands+0x758>
ffffffffc0201470:	00001617          	auipc	a2,0x1
ffffffffc0201474:	56060613          	addi	a2,a2,1376 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc0201478:	0ba00593          	li	a1,186
ffffffffc020147c:	00001517          	auipc	a0,0x1
ffffffffc0201480:	56c50513          	addi	a0,a0,1388 # ffffffffc02029e8 <commands+0x700>
ffffffffc0201484:	f79fe0ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc0201488 <default_free_pages>:
default_free_pages(struct Page *base, size_t n) {
ffffffffc0201488:	1141                	addi	sp,sp,-16
ffffffffc020148a:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc020148c:	14058a63          	beqz	a1,ffffffffc02015e0 <default_free_pages+0x158>
    for (; p != base + n; p ++) {
ffffffffc0201490:	00259693          	slli	a3,a1,0x2
ffffffffc0201494:	96ae                	add	a3,a3,a1
ffffffffc0201496:	068e                	slli	a3,a3,0x3
ffffffffc0201498:	96aa                	add	a3,a3,a0
ffffffffc020149a:	87aa                	mv	a5,a0
ffffffffc020149c:	02d50263          	beq	a0,a3,ffffffffc02014c0 <default_free_pages+0x38>
ffffffffc02014a0:	6798                	ld	a4,8(a5)
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02014a2:	8b05                	andi	a4,a4,1
ffffffffc02014a4:	10071e63          	bnez	a4,ffffffffc02015c0 <default_free_pages+0x138>
ffffffffc02014a8:	6798                	ld	a4,8(a5)
ffffffffc02014aa:	8b09                	andi	a4,a4,2
ffffffffc02014ac:	10071a63          	bnez	a4,ffffffffc02015c0 <default_free_pages+0x138>
        p->flags = 0;
ffffffffc02014b0:	0007b423          	sd	zero,8(a5)



static inline int page_ref(struct Page *page) { return page->ref; }

static inline void set_page_ref(struct Page *page, int val) { page->ref = val; }
ffffffffc02014b4:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02014b8:	02878793          	addi	a5,a5,40
ffffffffc02014bc:	fed792e3          	bne	a5,a3,ffffffffc02014a0 <default_free_pages+0x18>
    base->property = n;
ffffffffc02014c0:	2581                	sext.w	a1,a1
ffffffffc02014c2:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02014c4:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02014c8:	4789                	li	a5,2
ffffffffc02014ca:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02014ce:	00006697          	auipc	a3,0x6
ffffffffc02014d2:	b5a68693          	addi	a3,a3,-1190 # ffffffffc0207028 <free_area>
ffffffffc02014d6:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02014d8:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02014da:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02014de:	9db9                	addw	a1,a1,a4
ffffffffc02014e0:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc02014e2:	0ad78863          	beq	a5,a3,ffffffffc0201592 <default_free_pages+0x10a>
            struct Page* page = le2page(le, page_link);
ffffffffc02014e6:	fe878713          	addi	a4,a5,-24
ffffffffc02014ea:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc02014ee:	4581                	li	a1,0
            if (base < page) {
ffffffffc02014f0:	00e56a63          	bltu	a0,a4,ffffffffc0201504 <default_free_pages+0x7c>
    return listelm->next;
ffffffffc02014f4:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc02014f6:	06d70263          	beq	a4,a3,ffffffffc020155a <default_free_pages+0xd2>
    for (; p != base + n; p ++) {
ffffffffc02014fa:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc02014fc:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc0201500:	fee57ae3          	bgeu	a0,a4,ffffffffc02014f4 <default_free_pages+0x6c>
ffffffffc0201504:	c199                	beqz	a1,ffffffffc020150a <default_free_pages+0x82>
ffffffffc0201506:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020150a:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc020150c:	e390                	sd	a2,0(a5)
ffffffffc020150e:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201510:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201512:	ed18                	sd	a4,24(a0)
    if (le != &free_list) {
ffffffffc0201514:	02d70063          	beq	a4,a3,ffffffffc0201534 <default_free_pages+0xac>
        if (p + p->property == base) {
ffffffffc0201518:	ff872803          	lw	a6,-8(a4)
        p = le2page(le, page_link);
ffffffffc020151c:	fe870593          	addi	a1,a4,-24
        if (p + p->property == base) {
ffffffffc0201520:	02081613          	slli	a2,a6,0x20
ffffffffc0201524:	9201                	srli	a2,a2,0x20
ffffffffc0201526:	00261793          	slli	a5,a2,0x2
ffffffffc020152a:	97b2                	add	a5,a5,a2
ffffffffc020152c:	078e                	slli	a5,a5,0x3
ffffffffc020152e:	97ae                	add	a5,a5,a1
ffffffffc0201530:	02f50f63          	beq	a0,a5,ffffffffc020156e <default_free_pages+0xe6>
    return listelm->next;
ffffffffc0201534:	7118                	ld	a4,32(a0)
    if (le != &free_list) {
ffffffffc0201536:	00d70f63          	beq	a4,a3,ffffffffc0201554 <default_free_pages+0xcc>
        if (base + base->property == p) {
ffffffffc020153a:	490c                	lw	a1,16(a0)
        p = le2page(le, page_link);
ffffffffc020153c:	fe870693          	addi	a3,a4,-24
        if (base + base->property == p) {
ffffffffc0201540:	02059613          	slli	a2,a1,0x20
ffffffffc0201544:	9201                	srli	a2,a2,0x20
ffffffffc0201546:	00261793          	slli	a5,a2,0x2
ffffffffc020154a:	97b2                	add	a5,a5,a2
ffffffffc020154c:	078e                	slli	a5,a5,0x3
ffffffffc020154e:	97aa                	add	a5,a5,a0
ffffffffc0201550:	04f68863          	beq	a3,a5,ffffffffc02015a0 <default_free_pages+0x118>
}
ffffffffc0201554:	60a2                	ld	ra,8(sp)
ffffffffc0201556:	0141                	addi	sp,sp,16
ffffffffc0201558:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc020155a:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc020155c:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc020155e:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201560:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc0201562:	02d70563          	beq	a4,a3,ffffffffc020158c <default_free_pages+0x104>
    prev->next = next->prev = elm;
ffffffffc0201566:	8832                	mv	a6,a2
ffffffffc0201568:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc020156a:	87ba                	mv	a5,a4
ffffffffc020156c:	bf41                	j	ffffffffc02014fc <default_free_pages+0x74>
            p->property += base->property;
ffffffffc020156e:	491c                	lw	a5,16(a0)
ffffffffc0201570:	0107883b          	addw	a6,a5,a6
ffffffffc0201574:	ff072c23          	sw	a6,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201578:	57f5                	li	a5,-3
ffffffffc020157a:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc020157e:	6d10                	ld	a2,24(a0)
ffffffffc0201580:	711c                	ld	a5,32(a0)
            base = p;
ffffffffc0201582:	852e                	mv	a0,a1
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc0201584:	e61c                	sd	a5,8(a2)
    return listelm->next;
ffffffffc0201586:	6718                	ld	a4,8(a4)
    next->prev = prev;
ffffffffc0201588:	e390                	sd	a2,0(a5)
ffffffffc020158a:	b775                	j	ffffffffc0201536 <default_free_pages+0xae>
ffffffffc020158c:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020158e:	873e                	mv	a4,a5
ffffffffc0201590:	b761                	j	ffffffffc0201518 <default_free_pages+0x90>
}
ffffffffc0201592:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201594:	e390                	sd	a2,0(a5)
ffffffffc0201596:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201598:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020159a:	ed1c                	sd	a5,24(a0)
ffffffffc020159c:	0141                	addi	sp,sp,16
ffffffffc020159e:	8082                	ret
            base->property += p->property;
ffffffffc02015a0:	ff872783          	lw	a5,-8(a4)
ffffffffc02015a4:	ff070693          	addi	a3,a4,-16
ffffffffc02015a8:	9dbd                	addw	a1,a1,a5
ffffffffc02015aa:	c90c                	sw	a1,16(a0)
ffffffffc02015ac:	57f5                	li	a5,-3
ffffffffc02015ae:	60f6b02f          	amoand.d	zero,a5,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02015b2:	6314                	ld	a3,0(a4)
ffffffffc02015b4:	671c                	ld	a5,8(a4)
}
ffffffffc02015b6:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02015b8:	e69c                	sd	a5,8(a3)
    next->prev = prev;
ffffffffc02015ba:	e394                	sd	a3,0(a5)
ffffffffc02015bc:	0141                	addi	sp,sp,16
ffffffffc02015be:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02015c0:	00001697          	auipc	a3,0x1
ffffffffc02015c4:	77068693          	addi	a3,a3,1904 # ffffffffc0202d30 <commands+0xa48>
ffffffffc02015c8:	00001617          	auipc	a2,0x1
ffffffffc02015cc:	40860613          	addi	a2,a2,1032 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02015d0:	08300593          	li	a1,131
ffffffffc02015d4:	00001517          	auipc	a0,0x1
ffffffffc02015d8:	41450513          	addi	a0,a0,1044 # ffffffffc02029e8 <commands+0x700>
ffffffffc02015dc:	e21fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(n > 0);
ffffffffc02015e0:	00001697          	auipc	a3,0x1
ffffffffc02015e4:	74868693          	addi	a3,a3,1864 # ffffffffc0202d28 <commands+0xa40>
ffffffffc02015e8:	00001617          	auipc	a2,0x1
ffffffffc02015ec:	3e860613          	addi	a2,a2,1000 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02015f0:	08000593          	li	a1,128
ffffffffc02015f4:	00001517          	auipc	a0,0x1
ffffffffc02015f8:	3f450513          	addi	a0,a0,1012 # ffffffffc02029e8 <commands+0x700>
ffffffffc02015fc:	e01fe0ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc0201600 <default_alloc_pages>:
    assert(n > 0);
ffffffffc0201600:	c959                	beqz	a0,ffffffffc0201696 <default_alloc_pages+0x96>
    if (n > nr_free) {
ffffffffc0201602:	00006597          	auipc	a1,0x6
ffffffffc0201606:	a2658593          	addi	a1,a1,-1498 # ffffffffc0207028 <free_area>
ffffffffc020160a:	0105a803          	lw	a6,16(a1)
ffffffffc020160e:	862a                	mv	a2,a0
ffffffffc0201610:	02081793          	slli	a5,a6,0x20
ffffffffc0201614:	9381                	srli	a5,a5,0x20
ffffffffc0201616:	00a7ee63          	bltu	a5,a0,ffffffffc0201632 <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc020161a:	87ae                	mv	a5,a1
ffffffffc020161c:	a801                	j	ffffffffc020162c <default_alloc_pages+0x2c>
        if (p->property >= n) {
ffffffffc020161e:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201622:	02071693          	slli	a3,a4,0x20
ffffffffc0201626:	9281                	srli	a3,a3,0x20
ffffffffc0201628:	00c6f763          	bgeu	a3,a2,ffffffffc0201636 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc020162c:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list) {
ffffffffc020162e:	feb798e3          	bne	a5,a1,ffffffffc020161e <default_alloc_pages+0x1e>
        return NULL;
ffffffffc0201632:	4501                	li	a0,0
}
ffffffffc0201634:	8082                	ret
    return listelm->prev;
ffffffffc0201636:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc020163a:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020163e:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc0201642:	00060e1b          	sext.w	t3,a2
    prev->next = next;
ffffffffc0201646:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc020164a:	01133023          	sd	a7,0(t1)
        if (page->property > n) {
ffffffffc020164e:	02d67b63          	bgeu	a2,a3,ffffffffc0201684 <default_alloc_pages+0x84>
            struct Page *p = page + n;
ffffffffc0201652:	00261693          	slli	a3,a2,0x2
ffffffffc0201656:	96b2                	add	a3,a3,a2
ffffffffc0201658:	068e                	slli	a3,a3,0x3
ffffffffc020165a:	96aa                	add	a3,a3,a0
            p->property = page->property - n;
ffffffffc020165c:	41c7073b          	subw	a4,a4,t3
ffffffffc0201660:	ca98                	sw	a4,16(a3)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201662:	00868613          	addi	a2,a3,8
ffffffffc0201666:	4709                	li	a4,2
ffffffffc0201668:	40e6302f          	amoor.d	zero,a4,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc020166c:	0088b703          	ld	a4,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201670:	01868613          	addi	a2,a3,24
        nr_free -= n;
ffffffffc0201674:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc0201678:	e310                	sd	a2,0(a4)
ffffffffc020167a:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc020167e:	f298                	sd	a4,32(a3)
    elm->prev = prev;
ffffffffc0201680:	0116bc23          	sd	a7,24(a3)
ffffffffc0201684:	41c8083b          	subw	a6,a6,t3
ffffffffc0201688:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020168c:	5775                	li	a4,-3
ffffffffc020168e:	17c1                	addi	a5,a5,-16
ffffffffc0201690:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc0201694:	8082                	ret
default_alloc_pages(size_t n) {
ffffffffc0201696:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc0201698:	00001697          	auipc	a3,0x1
ffffffffc020169c:	69068693          	addi	a3,a3,1680 # ffffffffc0202d28 <commands+0xa40>
ffffffffc02016a0:	00001617          	auipc	a2,0x1
ffffffffc02016a4:	33060613          	addi	a2,a2,816 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc02016a8:	06200593          	li	a1,98
ffffffffc02016ac:	00001517          	auipc	a0,0x1
ffffffffc02016b0:	33c50513          	addi	a0,a0,828 # ffffffffc02029e8 <commands+0x700>
default_alloc_pages(size_t n) {
ffffffffc02016b4:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016b6:	d47fe0ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc02016ba <default_init_memmap>:
default_init_memmap(struct Page *base, size_t n) {
ffffffffc02016ba:	1141                	addi	sp,sp,-16
ffffffffc02016bc:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02016be:	c9e1                	beqz	a1,ffffffffc020178e <default_init_memmap+0xd4>
    for (; p != base + n; p ++) {
ffffffffc02016c0:	00259693          	slli	a3,a1,0x2
ffffffffc02016c4:	96ae                	add	a3,a3,a1
ffffffffc02016c6:	068e                	slli	a3,a3,0x3
ffffffffc02016c8:	96aa                	add	a3,a3,a0
ffffffffc02016ca:	87aa                	mv	a5,a0
ffffffffc02016cc:	00d50f63          	beq	a0,a3,ffffffffc02016ea <default_init_memmap+0x30>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02016d0:	6798                	ld	a4,8(a5)
        assert(PageReserved(p));
ffffffffc02016d2:	8b05                	andi	a4,a4,1
ffffffffc02016d4:	cf49                	beqz	a4,ffffffffc020176e <default_init_memmap+0xb4>
        p->flags = p->property = 0;
ffffffffc02016d6:	0007a823          	sw	zero,16(a5)
ffffffffc02016da:	0007b423          	sd	zero,8(a5)
ffffffffc02016de:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p ++) {
ffffffffc02016e2:	02878793          	addi	a5,a5,40
ffffffffc02016e6:	fed795e3          	bne	a5,a3,ffffffffc02016d0 <default_init_memmap+0x16>
    base->property = n;
ffffffffc02016ea:	2581                	sext.w	a1,a1
ffffffffc02016ec:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02016ee:	4789                	li	a5,2
ffffffffc02016f0:	00850713          	addi	a4,a0,8
ffffffffc02016f4:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02016f8:	00006697          	auipc	a3,0x6
ffffffffc02016fc:	93068693          	addi	a3,a3,-1744 # ffffffffc0207028 <free_area>
ffffffffc0201700:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc0201702:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc0201704:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc0201708:	9db9                	addw	a1,a1,a4
ffffffffc020170a:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list)) {
ffffffffc020170c:	04d78a63          	beq	a5,a3,ffffffffc0201760 <default_init_memmap+0xa6>
            struct Page* page = le2page(le, page_link);
ffffffffc0201710:	fe878713          	addi	a4,a5,-24
ffffffffc0201714:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list)) {
ffffffffc0201718:	4581                	li	a1,0
            if (base < page) {
ffffffffc020171a:	00e56a63          	bltu	a0,a4,ffffffffc020172e <default_init_memmap+0x74>
    return listelm->next;
ffffffffc020171e:	6798                	ld	a4,8(a5)
            } else if (list_next(le) == &free_list) {
ffffffffc0201720:	02d70263          	beq	a4,a3,ffffffffc0201744 <default_init_memmap+0x8a>
    for (; p != base + n; p ++) {
ffffffffc0201724:	87ba                	mv	a5,a4
            struct Page* page = le2page(le, page_link);
ffffffffc0201726:	fe878713          	addi	a4,a5,-24
            if (base < page) {
ffffffffc020172a:	fee57ae3          	bgeu	a0,a4,ffffffffc020171e <default_init_memmap+0x64>
ffffffffc020172e:	c199                	beqz	a1,ffffffffc0201734 <default_init_memmap+0x7a>
ffffffffc0201730:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201734:	6398                	ld	a4,0(a5)
}
ffffffffc0201736:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201738:	e390                	sd	a2,0(a5)
ffffffffc020173a:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc020173c:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc020173e:	ed18                	sd	a4,24(a0)
ffffffffc0201740:	0141                	addi	sp,sp,16
ffffffffc0201742:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201744:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201746:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201748:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc020174a:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list) {
ffffffffc020174c:	00d70663          	beq	a4,a3,ffffffffc0201758 <default_init_memmap+0x9e>
    prev->next = next->prev = elm;
ffffffffc0201750:	8832                	mv	a6,a2
ffffffffc0201752:	4585                	li	a1,1
    for (; p != base + n; p ++) {
ffffffffc0201754:	87ba                	mv	a5,a4
ffffffffc0201756:	bfc1                	j	ffffffffc0201726 <default_init_memmap+0x6c>
}
ffffffffc0201758:	60a2                	ld	ra,8(sp)
ffffffffc020175a:	e290                	sd	a2,0(a3)
ffffffffc020175c:	0141                	addi	sp,sp,16
ffffffffc020175e:	8082                	ret
ffffffffc0201760:	60a2                	ld	ra,8(sp)
ffffffffc0201762:	e390                	sd	a2,0(a5)
ffffffffc0201764:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201766:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201768:	ed1c                	sd	a5,24(a0)
ffffffffc020176a:	0141                	addi	sp,sp,16
ffffffffc020176c:	8082                	ret
        assert(PageReserved(p));
ffffffffc020176e:	00001697          	auipc	a3,0x1
ffffffffc0201772:	5ea68693          	addi	a3,a3,1514 # ffffffffc0202d58 <commands+0xa70>
ffffffffc0201776:	00001617          	auipc	a2,0x1
ffffffffc020177a:	25a60613          	addi	a2,a2,602 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc020177e:	04900593          	li	a1,73
ffffffffc0201782:	00001517          	auipc	a0,0x1
ffffffffc0201786:	26650513          	addi	a0,a0,614 # ffffffffc02029e8 <commands+0x700>
ffffffffc020178a:	c73fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    assert(n > 0);
ffffffffc020178e:	00001697          	auipc	a3,0x1
ffffffffc0201792:	59a68693          	addi	a3,a3,1434 # ffffffffc0202d28 <commands+0xa40>
ffffffffc0201796:	00001617          	auipc	a2,0x1
ffffffffc020179a:	23a60613          	addi	a2,a2,570 # ffffffffc02029d0 <commands+0x6e8>
ffffffffc020179e:	04600593          	li	a1,70
ffffffffc02017a2:	00001517          	auipc	a0,0x1
ffffffffc02017a6:	24650513          	addi	a0,a0,582 # ffffffffc02029e8 <commands+0x700>
ffffffffc02017aa:	c53fe0ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc02017ae <alloc_pages>:
#include <defs.h>
#include <intr.h>
#include <riscv.h>

static inline bool __intr_save(void) {
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017ae:	100027f3          	csrr	a5,sstatus
ffffffffc02017b2:	8b89                	andi	a5,a5,2
ffffffffc02017b4:	e799                	bnez	a5,ffffffffc02017c2 <alloc_pages+0x14>
struct Page *alloc_pages(size_t n) {
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc02017b6:	00006797          	auipc	a5,0x6
ffffffffc02017ba:	cc27b783          	ld	a5,-830(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017be:	6f9c                	ld	a5,24(a5)
ffffffffc02017c0:	8782                	jr	a5
struct Page *alloc_pages(size_t n) {
ffffffffc02017c2:	1141                	addi	sp,sp,-16
ffffffffc02017c4:	e406                	sd	ra,8(sp)
ffffffffc02017c6:	e022                	sd	s0,0(sp)
ffffffffc02017c8:	842a                	mv	s0,a0
        intr_disable();
ffffffffc02017ca:	894ff0ef          	jal	ra,ffffffffc020085e <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02017ce:	00006797          	auipc	a5,0x6
ffffffffc02017d2:	caa7b783          	ld	a5,-854(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017d6:	6f9c                	ld	a5,24(a5)
ffffffffc02017d8:	8522                	mv	a0,s0
ffffffffc02017da:	9782                	jalr	a5
ffffffffc02017dc:	842a                	mv	s0,a0
    return 0;
}

static inline void __intr_restore(bool flag) {
    if (flag) {
        intr_enable();
ffffffffc02017de:	87aff0ef          	jal	ra,ffffffffc0200858 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc02017e2:	60a2                	ld	ra,8(sp)
ffffffffc02017e4:	8522                	mv	a0,s0
ffffffffc02017e6:	6402                	ld	s0,0(sp)
ffffffffc02017e8:	0141                	addi	sp,sp,16
ffffffffc02017ea:	8082                	ret

ffffffffc02017ec <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc02017ec:	100027f3          	csrr	a5,sstatus
ffffffffc02017f0:	8b89                	andi	a5,a5,2
ffffffffc02017f2:	e799                	bnez	a5,ffffffffc0201800 <free_pages+0x14>
// free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory
void free_pages(struct Page *base, size_t n) {
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc02017f4:	00006797          	auipc	a5,0x6
ffffffffc02017f8:	c847b783          	ld	a5,-892(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc02017fc:	739c                	ld	a5,32(a5)
ffffffffc02017fe:	8782                	jr	a5
void free_pages(struct Page *base, size_t n) {
ffffffffc0201800:	1101                	addi	sp,sp,-32
ffffffffc0201802:	ec06                	sd	ra,24(sp)
ffffffffc0201804:	e822                	sd	s0,16(sp)
ffffffffc0201806:	e426                	sd	s1,8(sp)
ffffffffc0201808:	842a                	mv	s0,a0
ffffffffc020180a:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc020180c:	852ff0ef          	jal	ra,ffffffffc020085e <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201810:	00006797          	auipc	a5,0x6
ffffffffc0201814:	c687b783          	ld	a5,-920(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201818:	739c                	ld	a5,32(a5)
ffffffffc020181a:	85a6                	mv	a1,s1
ffffffffc020181c:	8522                	mv	a0,s0
ffffffffc020181e:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201820:	6442                	ld	s0,16(sp)
ffffffffc0201822:	60e2                	ld	ra,24(sp)
ffffffffc0201824:	64a2                	ld	s1,8(sp)
ffffffffc0201826:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201828:	830ff06f          	j	ffffffffc0200858 <intr_enable>

ffffffffc020182c <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE) {
ffffffffc020182c:	100027f3          	csrr	a5,sstatus
ffffffffc0201830:	8b89                	andi	a5,a5,2
ffffffffc0201832:	e799                	bnez	a5,ffffffffc0201840 <nr_free_pages+0x14>
size_t nr_free_pages(void) {
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201834:	00006797          	auipc	a5,0x6
ffffffffc0201838:	c447b783          	ld	a5,-956(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc020183c:	779c                	ld	a5,40(a5)
ffffffffc020183e:	8782                	jr	a5
size_t nr_free_pages(void) {
ffffffffc0201840:	1141                	addi	sp,sp,-16
ffffffffc0201842:	e406                	sd	ra,8(sp)
ffffffffc0201844:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201846:	818ff0ef          	jal	ra,ffffffffc020085e <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc020184a:	00006797          	auipc	a5,0x6
ffffffffc020184e:	c2e7b783          	ld	a5,-978(a5) # ffffffffc0207478 <pmm_manager>
ffffffffc0201852:	779c                	ld	a5,40(a5)
ffffffffc0201854:	9782                	jalr	a5
ffffffffc0201856:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201858:	800ff0ef          	jal	ra,ffffffffc0200858 <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc020185c:	60a2                	ld	ra,8(sp)
ffffffffc020185e:	8522                	mv	a0,s0
ffffffffc0201860:	6402                	ld	s0,0(sp)
ffffffffc0201862:	0141                	addi	sp,sp,16
ffffffffc0201864:	8082                	ret

ffffffffc0201866 <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc0201866:	00001797          	auipc	a5,0x1
ffffffffc020186a:	51a78793          	addi	a5,a5,1306 # ffffffffc0202d80 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020186e:	638c                	ld	a1,0(a5)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
    }
}

/* pmm_init - initialize the physical memory management */
void pmm_init(void) {
ffffffffc0201870:	7179                	addi	sp,sp,-48
ffffffffc0201872:	f022                	sd	s0,32(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201874:	00001517          	auipc	a0,0x1
ffffffffc0201878:	54450513          	addi	a0,a0,1348 # ffffffffc0202db8 <default_pmm_manager+0x38>
    pmm_manager = &default_pmm_manager;
ffffffffc020187c:	00006417          	auipc	s0,0x6
ffffffffc0201880:	bfc40413          	addi	s0,s0,-1028 # ffffffffc0207478 <pmm_manager>
void pmm_init(void) {
ffffffffc0201884:	f406                	sd	ra,40(sp)
ffffffffc0201886:	ec26                	sd	s1,24(sp)
ffffffffc0201888:	e44e                	sd	s3,8(sp)
ffffffffc020188a:	e84a                	sd	s2,16(sp)
ffffffffc020188c:	e052                	sd	s4,0(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc020188e:	e01c                	sd	a5,0(s0)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0201890:	873fe0ef          	jal	ra,ffffffffc0200102 <cprintf>
    pmm_manager->init();
ffffffffc0201894:	601c                	ld	a5,0(s0)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0201896:	00006497          	auipc	s1,0x6
ffffffffc020189a:	bfa48493          	addi	s1,s1,-1030 # ffffffffc0207490 <va_pa_offset>
    pmm_manager->init();
ffffffffc020189e:	679c                	ld	a5,8(a5)
ffffffffc02018a0:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc02018a2:	57f5                	li	a5,-3
ffffffffc02018a4:	07fa                	slli	a5,a5,0x1e
ffffffffc02018a6:	e09c                	sd	a5,0(s1)
    uint64_t mem_begin = get_memory_base();
ffffffffc02018a8:	f9dfe0ef          	jal	ra,ffffffffc0200844 <get_memory_base>
ffffffffc02018ac:	89aa                	mv	s3,a0
    uint64_t mem_size  = get_memory_size();
ffffffffc02018ae:	fa1fe0ef          	jal	ra,ffffffffc020084e <get_memory_size>
    if (mem_size == 0) {
ffffffffc02018b2:	16050163          	beqz	a0,ffffffffc0201a14 <pmm_init+0x1ae>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018b6:	892a                	mv	s2,a0
    cprintf("physcial memory map:\n");
ffffffffc02018b8:	00001517          	auipc	a0,0x1
ffffffffc02018bc:	54850513          	addi	a0,a0,1352 # ffffffffc0202e00 <default_pmm_manager+0x80>
ffffffffc02018c0:	843fe0ef          	jal	ra,ffffffffc0200102 <cprintf>
    uint64_t mem_end   = mem_begin + mem_size;
ffffffffc02018c4:	01298a33          	add	s4,s3,s2
    cprintf("  memory: 0x%016lx, [0x%016lx, 0x%016lx].\n", mem_size, mem_begin,
ffffffffc02018c8:	864e                	mv	a2,s3
ffffffffc02018ca:	fffa0693          	addi	a3,s4,-1
ffffffffc02018ce:	85ca                	mv	a1,s2
ffffffffc02018d0:	00001517          	auipc	a0,0x1
ffffffffc02018d4:	54850513          	addi	a0,a0,1352 # ffffffffc0202e18 <default_pmm_manager+0x98>
ffffffffc02018d8:	82bfe0ef          	jal	ra,ffffffffc0200102 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02018dc:	c80007b7          	lui	a5,0xc8000
ffffffffc02018e0:	8652                	mv	a2,s4
ffffffffc02018e2:	0d47e863          	bltu	a5,s4,ffffffffc02019b2 <pmm_init+0x14c>
ffffffffc02018e6:	00007797          	auipc	a5,0x7
ffffffffc02018ea:	bb978793          	addi	a5,a5,-1095 # ffffffffc020849f <end+0xfff>
ffffffffc02018ee:	757d                	lui	a0,0xfffff
ffffffffc02018f0:	8d7d                	and	a0,a0,a5
ffffffffc02018f2:	8231                	srli	a2,a2,0xc
ffffffffc02018f4:	00006597          	auipc	a1,0x6
ffffffffc02018f8:	b7458593          	addi	a1,a1,-1164 # ffffffffc0207468 <npage>
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02018fc:	00006817          	auipc	a6,0x6
ffffffffc0201900:	b7480813          	addi	a6,a6,-1164 # ffffffffc0207470 <pages>
    npage = maxpa / PGSIZE;
ffffffffc0201904:	e190                	sd	a2,0(a1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0201906:	00a83023          	sd	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020190a:	000807b7          	lui	a5,0x80
ffffffffc020190e:	02f60663          	beq	a2,a5,ffffffffc020193a <pmm_init+0xd4>
ffffffffc0201912:	4701                	li	a4,0
ffffffffc0201914:	4781                	li	a5,0
ffffffffc0201916:	4305                	li	t1,1
ffffffffc0201918:	fff808b7          	lui	a7,0xfff80
        SetPageReserved(pages + i);
ffffffffc020191c:	953a                	add	a0,a0,a4
ffffffffc020191e:	00850693          	addi	a3,a0,8 # fffffffffffff008 <end+0x3fdf7b68>
ffffffffc0201922:	4066b02f          	amoor.d	zero,t1,(a3)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc0201926:	6190                	ld	a2,0(a1)
ffffffffc0201928:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc020192a:	00083503          	ld	a0,0(a6)
    for (size_t i = 0; i < npage - nbase; i++) {
ffffffffc020192e:	011606b3          	add	a3,a2,a7
ffffffffc0201932:	02870713          	addi	a4,a4,40
ffffffffc0201936:	fed7e3e3          	bltu	a5,a3,ffffffffc020191c <pmm_init+0xb6>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020193a:	00261693          	slli	a3,a2,0x2
ffffffffc020193e:	96b2                	add	a3,a3,a2
ffffffffc0201940:	fec007b7          	lui	a5,0xfec00
ffffffffc0201944:	97aa                	add	a5,a5,a0
ffffffffc0201946:	068e                	slli	a3,a3,0x3
ffffffffc0201948:	96be                	add	a3,a3,a5
ffffffffc020194a:	c02007b7          	lui	a5,0xc0200
ffffffffc020194e:	0af6e763          	bltu	a3,a5,ffffffffc02019fc <pmm_init+0x196>
ffffffffc0201952:	6098                	ld	a4,0(s1)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0201954:	77fd                	lui	a5,0xfffff
ffffffffc0201956:	00fa75b3          	and	a1,s4,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020195a:	8e99                	sub	a3,a3,a4
    if (freemem < mem_end) {
ffffffffc020195c:	04b6ee63          	bltu	a3,a1,ffffffffc02019b8 <pmm_init+0x152>
    satp_physical = PADDR(satp_virtual);
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
}

static void check_alloc_page(void) {
    pmm_manager->check();
ffffffffc0201960:	601c                	ld	a5,0(s0)
ffffffffc0201962:	7b9c                	ld	a5,48(a5)
ffffffffc0201964:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc0201966:	00001517          	auipc	a0,0x1
ffffffffc020196a:	53a50513          	addi	a0,a0,1338 # ffffffffc0202ea0 <default_pmm_manager+0x120>
ffffffffc020196e:	f94fe0ef          	jal	ra,ffffffffc0200102 <cprintf>
    satp_virtual = (pte_t*)boot_page_table_sv39;
ffffffffc0201972:	00004597          	auipc	a1,0x4
ffffffffc0201976:	68e58593          	addi	a1,a1,1678 # ffffffffc0206000 <boot_page_table_sv39>
ffffffffc020197a:	00006797          	auipc	a5,0x6
ffffffffc020197e:	b0b7b723          	sd	a1,-1266(a5) # ffffffffc0207488 <satp_virtual>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201982:	c02007b7          	lui	a5,0xc0200
ffffffffc0201986:	0af5e363          	bltu	a1,a5,ffffffffc0201a2c <pmm_init+0x1c6>
ffffffffc020198a:	6090                	ld	a2,0(s1)
}
ffffffffc020198c:	7402                	ld	s0,32(sp)
ffffffffc020198e:	70a2                	ld	ra,40(sp)
ffffffffc0201990:	64e2                	ld	s1,24(sp)
ffffffffc0201992:	6942                	ld	s2,16(sp)
ffffffffc0201994:	69a2                	ld	s3,8(sp)
ffffffffc0201996:	6a02                	ld	s4,0(sp)
    satp_physical = PADDR(satp_virtual);
ffffffffc0201998:	40c58633          	sub	a2,a1,a2
ffffffffc020199c:	00006797          	auipc	a5,0x6
ffffffffc02019a0:	aec7b223          	sd	a2,-1308(a5) # ffffffffc0207480 <satp_physical>
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02019a4:	00001517          	auipc	a0,0x1
ffffffffc02019a8:	51c50513          	addi	a0,a0,1308 # ffffffffc0202ec0 <default_pmm_manager+0x140>
}
ffffffffc02019ac:	6145                	addi	sp,sp,48
    cprintf("satp virtual address: 0x%016lx\nsatp physical address: 0x%016lx\n", satp_virtual, satp_physical);
ffffffffc02019ae:	f54fe06f          	j	ffffffffc0200102 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02019b2:	c8000637          	lui	a2,0xc8000
ffffffffc02019b6:	bf05                	j	ffffffffc02018e6 <pmm_init+0x80>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc02019b8:	6705                	lui	a4,0x1
ffffffffc02019ba:	177d                	addi	a4,a4,-1
ffffffffc02019bc:	96ba                	add	a3,a3,a4
ffffffffc02019be:	8efd                	and	a3,a3,a5
static inline int page_ref_dec(struct Page *page) {
    page->ref -= 1;
    return page->ref;
}
static inline struct Page *pa2page(uintptr_t pa) {
    if (PPN(pa) >= npage) {
ffffffffc02019c0:	00c6d793          	srli	a5,a3,0xc
ffffffffc02019c4:	02c7f063          	bgeu	a5,a2,ffffffffc02019e4 <pmm_init+0x17e>
    pmm_manager->init_memmap(base, n);
ffffffffc02019c8:	6010                	ld	a2,0(s0)
        panic("pa2page called with invalid pa");
    }
    return &pages[PPN(pa) - nbase];
ffffffffc02019ca:	fff80737          	lui	a4,0xfff80
ffffffffc02019ce:	973e                	add	a4,a4,a5
ffffffffc02019d0:	00271793          	slli	a5,a4,0x2
ffffffffc02019d4:	97ba                	add	a5,a5,a4
ffffffffc02019d6:	6a18                	ld	a4,16(a2)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc02019d8:	8d95                	sub	a1,a1,a3
ffffffffc02019da:	078e                	slli	a5,a5,0x3
    pmm_manager->init_memmap(base, n);
ffffffffc02019dc:	81b1                	srli	a1,a1,0xc
ffffffffc02019de:	953e                	add	a0,a0,a5
ffffffffc02019e0:	9702                	jalr	a4
}
ffffffffc02019e2:	bfbd                	j	ffffffffc0201960 <pmm_init+0xfa>
        panic("pa2page called with invalid pa");
ffffffffc02019e4:	00001617          	auipc	a2,0x1
ffffffffc02019e8:	48c60613          	addi	a2,a2,1164 # ffffffffc0202e70 <default_pmm_manager+0xf0>
ffffffffc02019ec:	06b00593          	li	a1,107
ffffffffc02019f0:	00001517          	auipc	a0,0x1
ffffffffc02019f4:	4a050513          	addi	a0,a0,1184 # ffffffffc0202e90 <default_pmm_manager+0x110>
ffffffffc02019f8:	a05fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc02019fc:	00001617          	auipc	a2,0x1
ffffffffc0201a00:	44c60613          	addi	a2,a2,1100 # ffffffffc0202e48 <default_pmm_manager+0xc8>
ffffffffc0201a04:	07100593          	li	a1,113
ffffffffc0201a08:	00001517          	auipc	a0,0x1
ffffffffc0201a0c:	3e850513          	addi	a0,a0,1000 # ffffffffc0202df0 <default_pmm_manager+0x70>
ffffffffc0201a10:	9edfe0ef          	jal	ra,ffffffffc02003fc <__panic>
        panic("DTB memory info not available");
ffffffffc0201a14:	00001617          	auipc	a2,0x1
ffffffffc0201a18:	3bc60613          	addi	a2,a2,956 # ffffffffc0202dd0 <default_pmm_manager+0x50>
ffffffffc0201a1c:	05a00593          	li	a1,90
ffffffffc0201a20:	00001517          	auipc	a0,0x1
ffffffffc0201a24:	3d050513          	addi	a0,a0,976 # ffffffffc0202df0 <default_pmm_manager+0x70>
ffffffffc0201a28:	9d5fe0ef          	jal	ra,ffffffffc02003fc <__panic>
    satp_physical = PADDR(satp_virtual);
ffffffffc0201a2c:	86ae                	mv	a3,a1
ffffffffc0201a2e:	00001617          	auipc	a2,0x1
ffffffffc0201a32:	41a60613          	addi	a2,a2,1050 # ffffffffc0202e48 <default_pmm_manager+0xc8>
ffffffffc0201a36:	08c00593          	li	a1,140
ffffffffc0201a3a:	00001517          	auipc	a0,0x1
ffffffffc0201a3e:	3b650513          	addi	a0,a0,950 # ffffffffc0202df0 <default_pmm_manager+0x70>
ffffffffc0201a42:	9bbfe0ef          	jal	ra,ffffffffc02003fc <__panic>

ffffffffc0201a46 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0201a46:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a4a:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc0201a4c:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a50:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0201a52:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0201a56:	f022                	sd	s0,32(sp)
ffffffffc0201a58:	ec26                	sd	s1,24(sp)
ffffffffc0201a5a:	e84a                	sd	s2,16(sp)
ffffffffc0201a5c:	f406                	sd	ra,40(sp)
ffffffffc0201a5e:	e44e                	sd	s3,8(sp)
ffffffffc0201a60:	84aa                	mv	s1,a0
ffffffffc0201a62:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0201a64:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0201a68:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0201a6a:	03067e63          	bgeu	a2,a6,ffffffffc0201aa6 <printnum+0x60>
ffffffffc0201a6e:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc0201a70:	00805763          	blez	s0,ffffffffc0201a7e <printnum+0x38>
ffffffffc0201a74:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0201a76:	85ca                	mv	a1,s2
ffffffffc0201a78:	854e                	mv	a0,s3
ffffffffc0201a7a:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc0201a7c:	fc65                	bnez	s0,ffffffffc0201a74 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a7e:	1a02                	slli	s4,s4,0x20
ffffffffc0201a80:	00001797          	auipc	a5,0x1
ffffffffc0201a84:	48078793          	addi	a5,a5,1152 # ffffffffc0202f00 <default_pmm_manager+0x180>
ffffffffc0201a88:	020a5a13          	srli	s4,s4,0x20
ffffffffc0201a8c:	9a3e                	add	s4,s4,a5
}
ffffffffc0201a8e:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a90:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0201a94:	70a2                	ld	ra,40(sp)
ffffffffc0201a96:	69a2                	ld	s3,8(sp)
ffffffffc0201a98:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201a9a:	85ca                	mv	a1,s2
ffffffffc0201a9c:	87a6                	mv	a5,s1
}
ffffffffc0201a9e:	6942                	ld	s2,16(sp)
ffffffffc0201aa0:	64e2                	ld	s1,24(sp)
ffffffffc0201aa2:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0201aa4:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0201aa6:	03065633          	divu	a2,a2,a6
ffffffffc0201aaa:	8722                	mv	a4,s0
ffffffffc0201aac:	f9bff0ef          	jal	ra,ffffffffc0201a46 <printnum>
ffffffffc0201ab0:	b7f9                	j	ffffffffc0201a7e <printnum+0x38>

ffffffffc0201ab2 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0201ab2:	7119                	addi	sp,sp,-128
ffffffffc0201ab4:	f4a6                	sd	s1,104(sp)
ffffffffc0201ab6:	f0ca                	sd	s2,96(sp)
ffffffffc0201ab8:	ecce                	sd	s3,88(sp)
ffffffffc0201aba:	e8d2                	sd	s4,80(sp)
ffffffffc0201abc:	e4d6                	sd	s5,72(sp)
ffffffffc0201abe:	e0da                	sd	s6,64(sp)
ffffffffc0201ac0:	fc5e                	sd	s7,56(sp)
ffffffffc0201ac2:	f06a                	sd	s10,32(sp)
ffffffffc0201ac4:	fc86                	sd	ra,120(sp)
ffffffffc0201ac6:	f8a2                	sd	s0,112(sp)
ffffffffc0201ac8:	f862                	sd	s8,48(sp)
ffffffffc0201aca:	f466                	sd	s9,40(sp)
ffffffffc0201acc:	ec6e                	sd	s11,24(sp)
ffffffffc0201ace:	892a                	mv	s2,a0
ffffffffc0201ad0:	84ae                	mv	s1,a1
ffffffffc0201ad2:	8d32                	mv	s10,a2
ffffffffc0201ad4:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201ad6:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc0201ada:	5b7d                	li	s6,-1
ffffffffc0201adc:	00001a97          	auipc	s5,0x1
ffffffffc0201ae0:	458a8a93          	addi	s5,s5,1112 # ffffffffc0202f34 <default_pmm_manager+0x1b4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201ae4:	00001b97          	auipc	s7,0x1
ffffffffc0201ae8:	62cb8b93          	addi	s7,s7,1580 # ffffffffc0203110 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201aec:	000d4503          	lbu	a0,0(s10)
ffffffffc0201af0:	001d0413          	addi	s0,s10,1
ffffffffc0201af4:	01350a63          	beq	a0,s3,ffffffffc0201b08 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc0201af8:	c121                	beqz	a0,ffffffffc0201b38 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc0201afa:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201afc:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc0201afe:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc0201b00:	fff44503          	lbu	a0,-1(s0)
ffffffffc0201b04:	ff351ae3          	bne	a0,s3,ffffffffc0201af8 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b08:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc0201b0c:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc0201b10:	4c81                	li	s9,0
ffffffffc0201b12:	4881                	li	a7,0
        width = precision = -1;
ffffffffc0201b14:	5c7d                	li	s8,-1
ffffffffc0201b16:	5dfd                	li	s11,-1
ffffffffc0201b18:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc0201b1c:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b1e:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b22:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b26:	00140d13          	addi	s10,s0,1
ffffffffc0201b2a:	04b56263          	bltu	a0,a1,ffffffffc0201b6e <vprintfmt+0xbc>
ffffffffc0201b2e:	058a                	slli	a1,a1,0x2
ffffffffc0201b30:	95d6                	add	a1,a1,s5
ffffffffc0201b32:	4194                	lw	a3,0(a1)
ffffffffc0201b34:	96d6                	add	a3,a3,s5
ffffffffc0201b36:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0201b38:	70e6                	ld	ra,120(sp)
ffffffffc0201b3a:	7446                	ld	s0,112(sp)
ffffffffc0201b3c:	74a6                	ld	s1,104(sp)
ffffffffc0201b3e:	7906                	ld	s2,96(sp)
ffffffffc0201b40:	69e6                	ld	s3,88(sp)
ffffffffc0201b42:	6a46                	ld	s4,80(sp)
ffffffffc0201b44:	6aa6                	ld	s5,72(sp)
ffffffffc0201b46:	6b06                	ld	s6,64(sp)
ffffffffc0201b48:	7be2                	ld	s7,56(sp)
ffffffffc0201b4a:	7c42                	ld	s8,48(sp)
ffffffffc0201b4c:	7ca2                	ld	s9,40(sp)
ffffffffc0201b4e:	7d02                	ld	s10,32(sp)
ffffffffc0201b50:	6de2                	ld	s11,24(sp)
ffffffffc0201b52:	6109                	addi	sp,sp,128
ffffffffc0201b54:	8082                	ret
            padc = '0';
ffffffffc0201b56:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0201b58:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b5c:	846a                	mv	s0,s10
ffffffffc0201b5e:	00140d13          	addi	s10,s0,1
ffffffffc0201b62:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0201b66:	0ff5f593          	zext.b	a1,a1
ffffffffc0201b6a:	fcb572e3          	bgeu	a0,a1,ffffffffc0201b2e <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc0201b6e:	85a6                	mv	a1,s1
ffffffffc0201b70:	02500513          	li	a0,37
ffffffffc0201b74:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0201b76:	fff44783          	lbu	a5,-1(s0)
ffffffffc0201b7a:	8d22                	mv	s10,s0
ffffffffc0201b7c:	f73788e3          	beq	a5,s3,ffffffffc0201aec <vprintfmt+0x3a>
ffffffffc0201b80:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0201b84:	1d7d                	addi	s10,s10,-1
ffffffffc0201b86:	ff379de3          	bne	a5,s3,ffffffffc0201b80 <vprintfmt+0xce>
ffffffffc0201b8a:	b78d                	j	ffffffffc0201aec <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc0201b8c:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc0201b90:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201b94:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0201b96:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0201b9a:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201b9e:	02d86463          	bltu	a6,a3,ffffffffc0201bc6 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0201ba2:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0201ba6:	002c169b          	slliw	a3,s8,0x2
ffffffffc0201baa:	0186873b          	addw	a4,a3,s8
ffffffffc0201bae:	0017171b          	slliw	a4,a4,0x1
ffffffffc0201bb2:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0201bb4:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0201bb8:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0201bba:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc0201bbe:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0201bc2:	fed870e3          	bgeu	a6,a3,ffffffffc0201ba2 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0201bc6:	f40ddce3          	bgez	s11,ffffffffc0201b1e <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0201bca:	8de2                	mv	s11,s8
ffffffffc0201bcc:	5c7d                	li	s8,-1
ffffffffc0201bce:	bf81                	j	ffffffffc0201b1e <vprintfmt+0x6c>
            if (width < 0)
ffffffffc0201bd0:	fffdc693          	not	a3,s11
ffffffffc0201bd4:	96fd                	srai	a3,a3,0x3f
ffffffffc0201bd6:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bda:	00144603          	lbu	a2,1(s0)
ffffffffc0201bde:	2d81                	sext.w	s11,s11
ffffffffc0201be0:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201be2:	bf35                	j	ffffffffc0201b1e <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc0201be4:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201be8:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc0201bec:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201bee:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc0201bf0:	bfd9                	j	ffffffffc0201bc6 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc0201bf2:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201bf4:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201bf8:	01174463          	blt	a4,a7,ffffffffc0201c00 <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc0201bfc:	1a088e63          	beqz	a7,ffffffffc0201db8 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc0201c00:	000a3603          	ld	a2,0(s4)
ffffffffc0201c04:	46c1                	li	a3,16
ffffffffc0201c06:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc0201c08:	2781                	sext.w	a5,a5
ffffffffc0201c0a:	876e                	mv	a4,s11
ffffffffc0201c0c:	85a6                	mv	a1,s1
ffffffffc0201c0e:	854a                	mv	a0,s2
ffffffffc0201c10:	e37ff0ef          	jal	ra,ffffffffc0201a46 <printnum>
            break;
ffffffffc0201c14:	bde1                	j	ffffffffc0201aec <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc0201c16:	000a2503          	lw	a0,0(s4)
ffffffffc0201c1a:	85a6                	mv	a1,s1
ffffffffc0201c1c:	0a21                	addi	s4,s4,8
ffffffffc0201c1e:	9902                	jalr	s2
            break;
ffffffffc0201c20:	b5f1                	j	ffffffffc0201aec <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201c22:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c24:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c28:	01174463          	blt	a4,a7,ffffffffc0201c30 <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc0201c2c:	18088163          	beqz	a7,ffffffffc0201dae <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc0201c30:	000a3603          	ld	a2,0(s4)
ffffffffc0201c34:	46a9                	li	a3,10
ffffffffc0201c36:	8a2e                	mv	s4,a1
ffffffffc0201c38:	bfc1                	j	ffffffffc0201c08 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c3a:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc0201c3e:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c40:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c42:	bdf1                	j	ffffffffc0201b1e <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0201c44:	85a6                	mv	a1,s1
ffffffffc0201c46:	02500513          	li	a0,37
ffffffffc0201c4a:	9902                	jalr	s2
            break;
ffffffffc0201c4c:	b545                	j	ffffffffc0201aec <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c4e:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0201c52:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0201c54:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0201c56:	b5e1                	j	ffffffffc0201b1e <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0201c58:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201c5a:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc0201c5e:	01174463          	blt	a4,a7,ffffffffc0201c66 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0201c62:	14088163          	beqz	a7,ffffffffc0201da4 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0201c66:	000a3603          	ld	a2,0(s4)
ffffffffc0201c6a:	46a1                	li	a3,8
ffffffffc0201c6c:	8a2e                	mv	s4,a1
ffffffffc0201c6e:	bf69                	j	ffffffffc0201c08 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc0201c70:	03000513          	li	a0,48
ffffffffc0201c74:	85a6                	mv	a1,s1
ffffffffc0201c76:	e03e                	sd	a5,0(sp)
ffffffffc0201c78:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0201c7a:	85a6                	mv	a1,s1
ffffffffc0201c7c:	07800513          	li	a0,120
ffffffffc0201c80:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c82:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0201c84:	6782                	ld	a5,0(sp)
ffffffffc0201c86:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0201c88:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc0201c8c:	bfb5                	j	ffffffffc0201c08 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201c8e:	000a3403          	ld	s0,0(s4)
ffffffffc0201c92:	008a0713          	addi	a4,s4,8
ffffffffc0201c96:	e03a                	sd	a4,0(sp)
ffffffffc0201c98:	14040263          	beqz	s0,ffffffffc0201ddc <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc0201c9c:	0fb05763          	blez	s11,ffffffffc0201d8a <vprintfmt+0x2d8>
ffffffffc0201ca0:	02d00693          	li	a3,45
ffffffffc0201ca4:	0cd79163          	bne	a5,a3,ffffffffc0201d66 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201ca8:	00044783          	lbu	a5,0(s0)
ffffffffc0201cac:	0007851b          	sext.w	a0,a5
ffffffffc0201cb0:	cf85                	beqz	a5,ffffffffc0201ce8 <vprintfmt+0x236>
ffffffffc0201cb2:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201cb6:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201cba:	000c4563          	bltz	s8,ffffffffc0201cc4 <vprintfmt+0x212>
ffffffffc0201cbe:	3c7d                	addiw	s8,s8,-1
ffffffffc0201cc0:	036c0263          	beq	s8,s6,ffffffffc0201ce4 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0201cc4:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201cc6:	0e0c8e63          	beqz	s9,ffffffffc0201dc2 <vprintfmt+0x310>
ffffffffc0201cca:	3781                	addiw	a5,a5,-32
ffffffffc0201ccc:	0ef47b63          	bgeu	s0,a5,ffffffffc0201dc2 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc0201cd0:	03f00513          	li	a0,63
ffffffffc0201cd4:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201cd6:	000a4783          	lbu	a5,0(s4)
ffffffffc0201cda:	3dfd                	addiw	s11,s11,-1
ffffffffc0201cdc:	0a05                	addi	s4,s4,1
ffffffffc0201cde:	0007851b          	sext.w	a0,a5
ffffffffc0201ce2:	ffe1                	bnez	a5,ffffffffc0201cba <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc0201ce4:	01b05963          	blez	s11,ffffffffc0201cf6 <vprintfmt+0x244>
ffffffffc0201ce8:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc0201cea:	85a6                	mv	a1,s1
ffffffffc0201cec:	02000513          	li	a0,32
ffffffffc0201cf0:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc0201cf2:	fe0d9be3          	bnez	s11,ffffffffc0201ce8 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc0201cf6:	6a02                	ld	s4,0(sp)
ffffffffc0201cf8:	bbd5                	j	ffffffffc0201aec <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc0201cfa:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0201cfc:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc0201d00:	01174463          	blt	a4,a7,ffffffffc0201d08 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc0201d04:	08088d63          	beqz	a7,ffffffffc0201d9e <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc0201d08:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc0201d0c:	0a044d63          	bltz	s0,ffffffffc0201dc6 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc0201d10:	8622                	mv	a2,s0
ffffffffc0201d12:	8a66                	mv	s4,s9
ffffffffc0201d14:	46a9                	li	a3,10
ffffffffc0201d16:	bdcd                	j	ffffffffc0201c08 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc0201d18:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d1c:	4719                	li	a4,6
            err = va_arg(ap, int);
ffffffffc0201d1e:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc0201d20:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc0201d24:	8fb5                	xor	a5,a5,a3
ffffffffc0201d26:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc0201d2a:	02d74163          	blt	a4,a3,ffffffffc0201d4c <vprintfmt+0x29a>
ffffffffc0201d2e:	00369793          	slli	a5,a3,0x3
ffffffffc0201d32:	97de                	add	a5,a5,s7
ffffffffc0201d34:	639c                	ld	a5,0(a5)
ffffffffc0201d36:	cb99                	beqz	a5,ffffffffc0201d4c <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0201d38:	86be                	mv	a3,a5
ffffffffc0201d3a:	00001617          	auipc	a2,0x1
ffffffffc0201d3e:	1f660613          	addi	a2,a2,502 # ffffffffc0202f30 <default_pmm_manager+0x1b0>
ffffffffc0201d42:	85a6                	mv	a1,s1
ffffffffc0201d44:	854a                	mv	a0,s2
ffffffffc0201d46:	0ce000ef          	jal	ra,ffffffffc0201e14 <printfmt>
ffffffffc0201d4a:	b34d                	j	ffffffffc0201aec <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc0201d4c:	00001617          	auipc	a2,0x1
ffffffffc0201d50:	1d460613          	addi	a2,a2,468 # ffffffffc0202f20 <default_pmm_manager+0x1a0>
ffffffffc0201d54:	85a6                	mv	a1,s1
ffffffffc0201d56:	854a                	mv	a0,s2
ffffffffc0201d58:	0bc000ef          	jal	ra,ffffffffc0201e14 <printfmt>
ffffffffc0201d5c:	bb41                	j	ffffffffc0201aec <vprintfmt+0x3a>
                p = "(null)";
ffffffffc0201d5e:	00001417          	auipc	s0,0x1
ffffffffc0201d62:	1ba40413          	addi	s0,s0,442 # ffffffffc0202f18 <default_pmm_manager+0x198>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d66:	85e2                	mv	a1,s8
ffffffffc0201d68:	8522                	mv	a0,s0
ffffffffc0201d6a:	e43e                	sd	a5,8(sp)
ffffffffc0201d6c:	200000ef          	jal	ra,ffffffffc0201f6c <strnlen>
ffffffffc0201d70:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0201d74:	01b05b63          	blez	s11,ffffffffc0201d8a <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0201d78:	67a2                	ld	a5,8(sp)
ffffffffc0201d7a:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d7e:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc0201d80:	85a6                	mv	a1,s1
ffffffffc0201d82:	8552                	mv	a0,s4
ffffffffc0201d84:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0201d86:	fe0d9ce3          	bnez	s11,ffffffffc0201d7e <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201d8a:	00044783          	lbu	a5,0(s0)
ffffffffc0201d8e:	00140a13          	addi	s4,s0,1
ffffffffc0201d92:	0007851b          	sext.w	a0,a5
ffffffffc0201d96:	d3a5                	beqz	a5,ffffffffc0201cf6 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201d98:	05e00413          	li	s0,94
ffffffffc0201d9c:	bf39                	j	ffffffffc0201cba <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc0201d9e:	000a2403          	lw	s0,0(s4)
ffffffffc0201da2:	b7ad                	j	ffffffffc0201d0c <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0201da4:	000a6603          	lwu	a2,0(s4)
ffffffffc0201da8:	46a1                	li	a3,8
ffffffffc0201daa:	8a2e                	mv	s4,a1
ffffffffc0201dac:	bdb1                	j	ffffffffc0201c08 <vprintfmt+0x156>
ffffffffc0201dae:	000a6603          	lwu	a2,0(s4)
ffffffffc0201db2:	46a9                	li	a3,10
ffffffffc0201db4:	8a2e                	mv	s4,a1
ffffffffc0201db6:	bd89                	j	ffffffffc0201c08 <vprintfmt+0x156>
ffffffffc0201db8:	000a6603          	lwu	a2,0(s4)
ffffffffc0201dbc:	46c1                	li	a3,16
ffffffffc0201dbe:	8a2e                	mv	s4,a1
ffffffffc0201dc0:	b5a1                	j	ffffffffc0201c08 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0201dc2:	9902                	jalr	s2
ffffffffc0201dc4:	bf09                	j	ffffffffc0201cd6 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0201dc6:	85a6                	mv	a1,s1
ffffffffc0201dc8:	02d00513          	li	a0,45
ffffffffc0201dcc:	e03e                	sd	a5,0(sp)
ffffffffc0201dce:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc0201dd0:	6782                	ld	a5,0(sp)
ffffffffc0201dd2:	8a66                	mv	s4,s9
ffffffffc0201dd4:	40800633          	neg	a2,s0
ffffffffc0201dd8:	46a9                	li	a3,10
ffffffffc0201dda:	b53d                	j	ffffffffc0201c08 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc0201ddc:	03b05163          	blez	s11,ffffffffc0201dfe <vprintfmt+0x34c>
ffffffffc0201de0:	02d00693          	li	a3,45
ffffffffc0201de4:	f6d79de3          	bne	a5,a3,ffffffffc0201d5e <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc0201de8:	00001417          	auipc	s0,0x1
ffffffffc0201dec:	13040413          	addi	s0,s0,304 # ffffffffc0202f18 <default_pmm_manager+0x198>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0201df0:	02800793          	li	a5,40
ffffffffc0201df4:	02800513          	li	a0,40
ffffffffc0201df8:	00140a13          	addi	s4,s0,1
ffffffffc0201dfc:	bd6d                	j	ffffffffc0201cb6 <vprintfmt+0x204>
ffffffffc0201dfe:	00001a17          	auipc	s4,0x1
ffffffffc0201e02:	11ba0a13          	addi	s4,s4,283 # ffffffffc0202f19 <default_pmm_manager+0x199>
ffffffffc0201e06:	02800513          	li	a0,40
ffffffffc0201e0a:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0201e0e:	05e00413          	li	s0,94
ffffffffc0201e12:	b565                	j	ffffffffc0201cba <vprintfmt+0x208>

ffffffffc0201e14 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e14:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc0201e16:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e1a:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e1c:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc0201e1e:	ec06                	sd	ra,24(sp)
ffffffffc0201e20:	f83a                	sd	a4,48(sp)
ffffffffc0201e22:	fc3e                	sd	a5,56(sp)
ffffffffc0201e24:	e0c2                	sd	a6,64(sp)
ffffffffc0201e26:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0201e28:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc0201e2a:	c89ff0ef          	jal	ra,ffffffffc0201ab2 <vprintfmt>
}
ffffffffc0201e2e:	60e2                	ld	ra,24(sp)
ffffffffc0201e30:	6161                	addi	sp,sp,80
ffffffffc0201e32:	8082                	ret

ffffffffc0201e34 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc0201e34:	715d                	addi	sp,sp,-80
ffffffffc0201e36:	e486                	sd	ra,72(sp)
ffffffffc0201e38:	e0a6                	sd	s1,64(sp)
ffffffffc0201e3a:	fc4a                	sd	s2,56(sp)
ffffffffc0201e3c:	f84e                	sd	s3,48(sp)
ffffffffc0201e3e:	f452                	sd	s4,40(sp)
ffffffffc0201e40:	f056                	sd	s5,32(sp)
ffffffffc0201e42:	ec5a                	sd	s6,24(sp)
ffffffffc0201e44:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc0201e46:	c901                	beqz	a0,ffffffffc0201e56 <readline+0x22>
ffffffffc0201e48:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc0201e4a:	00001517          	auipc	a0,0x1
ffffffffc0201e4e:	0e650513          	addi	a0,a0,230 # ffffffffc0202f30 <default_pmm_manager+0x1b0>
ffffffffc0201e52:	ab0fe0ef          	jal	ra,ffffffffc0200102 <cprintf>
readline(const char *prompt) {
ffffffffc0201e56:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e58:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc0201e5a:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc0201e5c:	4aa9                	li	s5,10
ffffffffc0201e5e:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc0201e60:	00005b97          	auipc	s7,0x5
ffffffffc0201e64:	1e0b8b93          	addi	s7,s7,480 # ffffffffc0207040 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e68:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc0201e6c:	b0efe0ef          	jal	ra,ffffffffc020017a <getchar>
        if (c < 0) {
ffffffffc0201e70:	00054a63          	bltz	a0,ffffffffc0201e84 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e74:	00a95a63          	bge	s2,a0,ffffffffc0201e88 <readline+0x54>
ffffffffc0201e78:	029a5263          	bge	s4,s1,ffffffffc0201e9c <readline+0x68>
        c = getchar();
ffffffffc0201e7c:	afefe0ef          	jal	ra,ffffffffc020017a <getchar>
        if (c < 0) {
ffffffffc0201e80:	fe055ae3          	bgez	a0,ffffffffc0201e74 <readline+0x40>
            return NULL;
ffffffffc0201e84:	4501                	li	a0,0
ffffffffc0201e86:	a091                	j	ffffffffc0201eca <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc0201e88:	03351463          	bne	a0,s3,ffffffffc0201eb0 <readline+0x7c>
ffffffffc0201e8c:	e8a9                	bnez	s1,ffffffffc0201ede <readline+0xaa>
        c = getchar();
ffffffffc0201e8e:	aecfe0ef          	jal	ra,ffffffffc020017a <getchar>
        if (c < 0) {
ffffffffc0201e92:	fe0549e3          	bltz	a0,ffffffffc0201e84 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0201e96:	fea959e3          	bge	s2,a0,ffffffffc0201e88 <readline+0x54>
ffffffffc0201e9a:	4481                	li	s1,0
            cputchar(c);
ffffffffc0201e9c:	e42a                	sd	a0,8(sp)
ffffffffc0201e9e:	a9afe0ef          	jal	ra,ffffffffc0200138 <cputchar>
            buf[i ++] = c;
ffffffffc0201ea2:	6522                	ld	a0,8(sp)
ffffffffc0201ea4:	009b87b3          	add	a5,s7,s1
ffffffffc0201ea8:	2485                	addiw	s1,s1,1
ffffffffc0201eaa:	00a78023          	sb	a0,0(a5)
ffffffffc0201eae:	bf7d                	j	ffffffffc0201e6c <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0201eb0:	01550463          	beq	a0,s5,ffffffffc0201eb8 <readline+0x84>
ffffffffc0201eb4:	fb651ce3          	bne	a0,s6,ffffffffc0201e6c <readline+0x38>
            cputchar(c);
ffffffffc0201eb8:	a80fe0ef          	jal	ra,ffffffffc0200138 <cputchar>
            buf[i] = '\0';
ffffffffc0201ebc:	00005517          	auipc	a0,0x5
ffffffffc0201ec0:	18450513          	addi	a0,a0,388 # ffffffffc0207040 <buf>
ffffffffc0201ec4:	94aa                	add	s1,s1,a0
ffffffffc0201ec6:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc0201eca:	60a6                	ld	ra,72(sp)
ffffffffc0201ecc:	6486                	ld	s1,64(sp)
ffffffffc0201ece:	7962                	ld	s2,56(sp)
ffffffffc0201ed0:	79c2                	ld	s3,48(sp)
ffffffffc0201ed2:	7a22                	ld	s4,40(sp)
ffffffffc0201ed4:	7a82                	ld	s5,32(sp)
ffffffffc0201ed6:	6b62                	ld	s6,24(sp)
ffffffffc0201ed8:	6bc2                	ld	s7,16(sp)
ffffffffc0201eda:	6161                	addi	sp,sp,80
ffffffffc0201edc:	8082                	ret
            cputchar(c);
ffffffffc0201ede:	4521                	li	a0,8
ffffffffc0201ee0:	a58fe0ef          	jal	ra,ffffffffc0200138 <cputchar>
            i --;
ffffffffc0201ee4:	34fd                	addiw	s1,s1,-1
ffffffffc0201ee6:	b759                	j	ffffffffc0201e6c <readline+0x38>

ffffffffc0201ee8 <sbi_console_putchar>:
uint64_t SBI_REMOTE_SFENCE_VMA_ASID = 7;
uint64_t SBI_SHUTDOWN = 8;

uint64_t sbi_call(uint64_t sbi_type, uint64_t arg0, uint64_t arg1, uint64_t arg2) {
    uint64_t ret_val;
    __asm__ volatile (
ffffffffc0201ee8:	4781                	li	a5,0
ffffffffc0201eea:	00005717          	auipc	a4,0x5
ffffffffc0201eee:	12e73703          	ld	a4,302(a4) # ffffffffc0207018 <SBI_CONSOLE_PUTCHAR>
ffffffffc0201ef2:	88ba                	mv	a7,a4
ffffffffc0201ef4:	852a                	mv	a0,a0
ffffffffc0201ef6:	85be                	mv	a1,a5
ffffffffc0201ef8:	863e                	mv	a2,a5
ffffffffc0201efa:	00000073          	ecall
ffffffffc0201efe:	87aa                	mv	a5,a0
    return ret_val;
}

void sbi_console_putchar(unsigned char ch) {
    sbi_call(SBI_CONSOLE_PUTCHAR, ch, 0, 0);
}
ffffffffc0201f00:	8082                	ret

ffffffffc0201f02 <sbi_set_timer>:
    __asm__ volatile (
ffffffffc0201f02:	4781                	li	a5,0
ffffffffc0201f04:	00005717          	auipc	a4,0x5
ffffffffc0201f08:	59473703          	ld	a4,1428(a4) # ffffffffc0207498 <SBI_SET_TIMER>
ffffffffc0201f0c:	88ba                	mv	a7,a4
ffffffffc0201f0e:	852a                	mv	a0,a0
ffffffffc0201f10:	85be                	mv	a1,a5
ffffffffc0201f12:	863e                	mv	a2,a5
ffffffffc0201f14:	00000073          	ecall
ffffffffc0201f18:	87aa                	mv	a5,a0

void sbi_set_timer(unsigned long long stime_value) {
    sbi_call(SBI_SET_TIMER, stime_value, 0, 0);
}
ffffffffc0201f1a:	8082                	ret

ffffffffc0201f1c <sbi_console_getchar>:
    __asm__ volatile (
ffffffffc0201f1c:	4501                	li	a0,0
ffffffffc0201f1e:	00005797          	auipc	a5,0x5
ffffffffc0201f22:	0f27b783          	ld	a5,242(a5) # ffffffffc0207010 <SBI_CONSOLE_GETCHAR>
ffffffffc0201f26:	88be                	mv	a7,a5
ffffffffc0201f28:	852a                	mv	a0,a0
ffffffffc0201f2a:	85aa                	mv	a1,a0
ffffffffc0201f2c:	862a                	mv	a2,a0
ffffffffc0201f2e:	00000073          	ecall
ffffffffc0201f32:	852a                	mv	a0,a0

int sbi_console_getchar(void) {
    return sbi_call(SBI_CONSOLE_GETCHAR, 0, 0, 0);
}
ffffffffc0201f34:	2501                	sext.w	a0,a0
ffffffffc0201f36:	8082                	ret

ffffffffc0201f38 <sbi_shutdown>:
    __asm__ volatile (
ffffffffc0201f38:	4781                	li	a5,0
ffffffffc0201f3a:	00005717          	auipc	a4,0x5
ffffffffc0201f3e:	0e673703          	ld	a4,230(a4) # ffffffffc0207020 <SBI_SHUTDOWN>
ffffffffc0201f42:	88ba                	mv	a7,a4
ffffffffc0201f44:	853e                	mv	a0,a5
ffffffffc0201f46:	85be                	mv	a1,a5
ffffffffc0201f48:	863e                	mv	a2,a5
ffffffffc0201f4a:	00000073          	ecall
ffffffffc0201f4e:	87aa                	mv	a5,a0

void sbi_shutdown(void)
{
	sbi_call(SBI_SHUTDOWN, 0, 0, 0);
ffffffffc0201f50:	8082                	ret

ffffffffc0201f52 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0201f52:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0201f56:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0201f58:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc0201f5a:	cb81                	beqz	a5,ffffffffc0201f6a <strlen+0x18>
        cnt ++;
ffffffffc0201f5c:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc0201f5e:	00a707b3          	add	a5,a4,a0
ffffffffc0201f62:	0007c783          	lbu	a5,0(a5)
ffffffffc0201f66:	fbfd                	bnez	a5,ffffffffc0201f5c <strlen+0xa>
ffffffffc0201f68:	8082                	ret
    }
    return cnt;
}
ffffffffc0201f6a:	8082                	ret

ffffffffc0201f6c <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc0201f6c:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f6e:	e589                	bnez	a1,ffffffffc0201f78 <strnlen+0xc>
ffffffffc0201f70:	a811                	j	ffffffffc0201f84 <strnlen+0x18>
        cnt ++;
ffffffffc0201f72:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0201f74:	00f58863          	beq	a1,a5,ffffffffc0201f84 <strnlen+0x18>
ffffffffc0201f78:	00f50733          	add	a4,a0,a5
ffffffffc0201f7c:	00074703          	lbu	a4,0(a4)
ffffffffc0201f80:	fb6d                	bnez	a4,ffffffffc0201f72 <strnlen+0x6>
ffffffffc0201f82:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0201f84:	852e                	mv	a0,a1
ffffffffc0201f86:	8082                	ret

ffffffffc0201f88 <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f88:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f8c:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f90:	cb89                	beqz	a5,ffffffffc0201fa2 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0201f92:	0505                	addi	a0,a0,1
ffffffffc0201f94:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0201f96:	fee789e3          	beq	a5,a4,ffffffffc0201f88 <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201f9a:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0201f9e:	9d19                	subw	a0,a0,a4
ffffffffc0201fa0:	8082                	ret
ffffffffc0201fa2:	4501                	li	a0,0
ffffffffc0201fa4:	bfed                	j	ffffffffc0201f9e <strcmp+0x16>

ffffffffc0201fa6 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fa6:	c20d                	beqz	a2,ffffffffc0201fc8 <strncmp+0x22>
ffffffffc0201fa8:	962e                	add	a2,a2,a1
ffffffffc0201faa:	a031                	j	ffffffffc0201fb6 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc0201fac:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fae:	00e79a63          	bne	a5,a4,ffffffffc0201fc2 <strncmp+0x1c>
ffffffffc0201fb2:	00b60b63          	beq	a2,a1,ffffffffc0201fc8 <strncmp+0x22>
ffffffffc0201fb6:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc0201fba:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0201fbc:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0201fc0:	f7f5                	bnez	a5,ffffffffc0201fac <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fc2:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0201fc6:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0201fc8:	4501                	li	a0,0
ffffffffc0201fca:	8082                	ret

ffffffffc0201fcc <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc0201fcc:	00054783          	lbu	a5,0(a0)
ffffffffc0201fd0:	c799                	beqz	a5,ffffffffc0201fde <strchr+0x12>
        if (*s == c) {
ffffffffc0201fd2:	00f58763          	beq	a1,a5,ffffffffc0201fe0 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0201fd6:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc0201fda:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc0201fdc:	fbfd                	bnez	a5,ffffffffc0201fd2 <strchr+0x6>
    }
    return NULL;
ffffffffc0201fde:	4501                	li	a0,0
}
ffffffffc0201fe0:	8082                	ret

ffffffffc0201fe2 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc0201fe2:	ca01                	beqz	a2,ffffffffc0201ff2 <memset+0x10>
ffffffffc0201fe4:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc0201fe6:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc0201fe8:	0785                	addi	a5,a5,1
ffffffffc0201fea:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc0201fee:	fec79de3          	bne	a5,a2,ffffffffc0201fe8 <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc0201ff2:	8082                	ret
