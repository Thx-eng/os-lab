
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00013297          	auipc	t0,0x13
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0213000 <boot_hartid>
ffffffffc020000c:	00013297          	auipc	t0,0x13
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0213008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02122b7          	lui	t0,0xc0212
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0212137          	lui	sp,0xc0212
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00090517          	auipc	a0,0x90
ffffffffc020004e:	00e50513          	addi	a0,a0,14 # ffffffffc0290058 <buf>
ffffffffc0200052:	00096617          	auipc	a2,0x96
ffffffffc0200056:	8b660613          	addi	a2,a2,-1866 # ffffffffc0295908 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	3060a0ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000a597          	auipc	a1,0xa
ffffffffc020006e:	36e58593          	addi	a1,a1,878 # ffffffffc020a3d8 <etext+0x6>
ffffffffc0200072:	0000a517          	auipc	a0,0xa
ffffffffc0200076:	38650513          	addi	a0,a0,902 # ffffffffc020a3f8 <etext+0x26>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24b020ef          	jal	ra,ffffffffc0202ad0 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	22d030ef          	jal	ra,ffffffffc0203abe <vmm_init>
ffffffffc0200096:	29e060ef          	jal	ra,ffffffffc0206334 <sched_init>
ffffffffc020009a:	689050ef          	jal	ra,ffffffffc0205f22 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	45f040ef          	jal	ra,ffffffffc0204d00 <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	0c6060ef          	jal	ra,ffffffffc0206174 <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000a517          	auipc	a0,0xa
ffffffffc02000cc:	33850513          	addi	a0,a0,824 # ffffffffc020a400 <etext+0x2e>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00090b97          	auipc	s7,0x90
ffffffffc02000e2:	f7ab8b93          	addi	s7,s7,-134 # ffffffffc0290058 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00090517          	auipc	a0,0x90
ffffffffc020013e:	f1e50513          	addi	a0,a0,-226 # ffffffffc0290058 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611d1>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	541090ef          	jal	ra,ffffffffc0209eda <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0212028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611d1>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	505090ef          	jal	ra,ffffffffc0209eda <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	0c60a0ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	1a40a0ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000a517          	auipc	a0,0xa
ffffffffc0200232:	1da50513          	addi	a0,a0,474 # ffffffffc020a408 <etext+0x36>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000a517          	auipc	a0,0xa
ffffffffc0200248:	1e450513          	addi	a0,a0,484 # ffffffffc020a428 <etext+0x56>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000a597          	auipc	a1,0xa
ffffffffc0200254:	18258593          	addi	a1,a1,386 # ffffffffc020a3d2 <etext>
ffffffffc0200258:	0000a517          	auipc	a0,0xa
ffffffffc020025c:	1f050513          	addi	a0,a0,496 # ffffffffc020a448 <etext+0x76>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00090597          	auipc	a1,0x90
ffffffffc0200268:	df458593          	addi	a1,a1,-524 # ffffffffc0290058 <buf>
ffffffffc020026c:	0000a517          	auipc	a0,0xa
ffffffffc0200270:	1fc50513          	addi	a0,a0,508 # ffffffffc020a468 <etext+0x96>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00095597          	auipc	a1,0x95
ffffffffc020027c:	69058593          	addi	a1,a1,1680 # ffffffffc0295908 <end>
ffffffffc0200280:	0000a517          	auipc	a0,0xa
ffffffffc0200284:	20850513          	addi	a0,a0,520 # ffffffffc020a488 <etext+0xb6>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00096597          	auipc	a1,0x96
ffffffffc0200290:	a7b58593          	addi	a1,a1,-1413 # ffffffffc0295d07 <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000a517          	auipc	a0,0xa
ffffffffc02002b2:	1fa50513          	addi	a0,a0,506 # ffffffffc020a4a8 <etext+0xd6>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000a617          	auipc	a2,0xa
ffffffffc02002c0:	21c60613          	addi	a2,a2,540 # ffffffffc020a4d8 <etext+0x106>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000a517          	auipc	a0,0xa
ffffffffc02002cc:	22850513          	addi	a0,a0,552 # ffffffffc020a4f0 <etext+0x11e>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000a617          	auipc	a2,0xa
ffffffffc02002dc:	23060613          	addi	a2,a2,560 # ffffffffc020a508 <etext+0x136>
ffffffffc02002e0:	0000a597          	auipc	a1,0xa
ffffffffc02002e4:	24858593          	addi	a1,a1,584 # ffffffffc020a528 <etext+0x156>
ffffffffc02002e8:	0000a517          	auipc	a0,0xa
ffffffffc02002ec:	24850513          	addi	a0,a0,584 # ffffffffc020a530 <etext+0x15e>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000a617          	auipc	a2,0xa
ffffffffc02002fa:	24a60613          	addi	a2,a2,586 # ffffffffc020a540 <etext+0x16e>
ffffffffc02002fe:	0000a597          	auipc	a1,0xa
ffffffffc0200302:	26a58593          	addi	a1,a1,618 # ffffffffc020a568 <etext+0x196>
ffffffffc0200306:	0000a517          	auipc	a0,0xa
ffffffffc020030a:	22a50513          	addi	a0,a0,554 # ffffffffc020a530 <etext+0x15e>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000a617          	auipc	a2,0xa
ffffffffc0200316:	26660613          	addi	a2,a2,614 # ffffffffc020a578 <etext+0x1a6>
ffffffffc020031a:	0000a597          	auipc	a1,0xa
ffffffffc020031e:	27e58593          	addi	a1,a1,638 # ffffffffc020a598 <etext+0x1c6>
ffffffffc0200322:	0000a517          	auipc	a0,0xa
ffffffffc0200326:	20e50513          	addi	a0,a0,526 # ffffffffc020a530 <etext+0x15e>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000a517          	auipc	a0,0xa
ffffffffc0200360:	24c50513          	addi	a0,a0,588 # ffffffffc020a5a8 <etext+0x1d6>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000a517          	auipc	a0,0xa
ffffffffc0200382:	25250513          	addi	a0,a0,594 # ffffffffc020a5d0 <etext+0x1fe>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000ac17          	auipc	s8,0xa
ffffffffc0200398:	2acc0c13          	addi	s8,s8,684 # ffffffffc020a640 <commands>
ffffffffc020039c:	0000a917          	auipc	s2,0xa
ffffffffc02003a0:	25c90913          	addi	s2,s2,604 # ffffffffc020a5f8 <etext+0x226>
ffffffffc02003a4:	0000a497          	auipc	s1,0xa
ffffffffc02003a8:	25c48493          	addi	s1,s1,604 # ffffffffc020a600 <etext+0x22e>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000ab17          	auipc	s6,0xa
ffffffffc02003b2:	25ab0b13          	addi	s6,s6,602 # ffffffffc020a608 <etext+0x236>
ffffffffc02003b6:	0000aa17          	auipc	s4,0xa
ffffffffc02003ba:	172a0a13          	addi	s4,s4,370 # ffffffffc020a528 <etext+0x156>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000ad17          	auipc	s10,0xa
ffffffffc02003dc:	268d0d13          	addi	s10,s10,616 # ffffffffc020a640 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	729090ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	715090ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	71b090ef          	jal	ra,ffffffffc020a352 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	6dd090ef          	jal	ra,ffffffffc020a352 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000a517          	auipc	a0,0xa
ffffffffc0200494:	19850513          	addi	a0,a0,408 # ffffffffc020a628 <etext+0x256>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00095317          	auipc	t1,0x95
ffffffffc02004a2:	3c230313          	addi	t1,t1,962 # ffffffffc0295860 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000a517          	auipc	a0,0xa
ffffffffc02004d0:	1bc50513          	addi	a0,a0,444 # ffffffffc020a688 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000b517          	auipc	a0,0xb
ffffffffc02004e6:	46650513          	addi	a0,a0,1126 # ffffffffc020b948 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000a517          	auipc	a0,0xa
ffffffffc020051a:	19250513          	addi	a0,a0,402 # ffffffffc020a6a8 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000b517          	auipc	a0,0xb
ffffffffc020053a:	41250513          	addi	a0,a0,1042 # ffffffffc020b948 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000a517          	auipc	a0,0xa
ffffffffc020056c:	16050513          	addi	a0,a0,352 # ffffffffc020a6c8 <commands+0x88>
ffffffffc0200570:	00095797          	auipc	a5,0x95
ffffffffc0200574:	2e07bc23          	sd	zero,760(a5) # ffffffffc0295868 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00090697          	auipc	a3,0x90
ffffffffc0200606:	e5668693          	addi	a3,a3,-426 # ffffffffc0290458 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00090797          	auipc	a5,0x90
ffffffffc0200652:	0007a723          	sw	zero,14(a5) # ffffffffc029065c <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00090797          	auipc	a5,0x90
ffffffffc020068e:	fc07a723          	sw	zero,-50(a5) # ffffffffc0290658 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000a517          	auipc	a0,0xa
ffffffffc02006b2:	03a50513          	addi	a0,a0,58 # ffffffffc020a6e8 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00013597          	auipc	a1,0x13
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0213000 <boot_hartid>
ffffffffc02006dc:	0000a517          	auipc	a0,0xa
ffffffffc02006e0:	01c50513          	addi	a0,a0,28 # ffffffffc020a6f8 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00013417          	auipc	s0,0x13
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0213008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000a517          	auipc	a0,0xa
ffffffffc02006f6:	01650513          	addi	a0,a0,22 # ffffffffc020a708 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000a517          	auipc	a0,0xa
ffffffffc0200706:	01e50513          	addi	a0,a0,30 # ffffffffc020a720 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe4a5e5>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000a917          	auipc	s2,0xa
ffffffffc02007c0:	fb490913          	addi	s2,s2,-76 # ffffffffc020a770 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000a497          	auipc	s1,0xa
ffffffffc02007ce:	f9e48493          	addi	s1,s1,-98 # ffffffffc020a768 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000a517          	auipc	a0,0xa
ffffffffc0200822:	fca50513          	addi	a0,a0,-54 # ffffffffc020a7e8 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000a517          	auipc	a0,0xa
ffffffffc020082e:	ff650513          	addi	a0,a0,-10 # ffffffffc020a820 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000a517          	auipc	a0,0xa
ffffffffc020086e:	ed650513          	addi	a0,a0,-298 # ffffffffc020a740 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	24f090ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	2a7090ef          	jal	ra,ffffffffc020a32c <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	1f3090ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000a517          	auipc	a0,0xa
ffffffffc0200934:	e4850513          	addi	a0,a0,-440 # ffffffffc020a778 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000a517          	auipc	a0,0xa
ffffffffc0200a02:	d9a50513          	addi	a0,a0,-614 # ffffffffc020a798 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000a517          	auipc	a0,0xa
ffffffffc0200a14:	da050513          	addi	a0,a0,-608 # ffffffffc020a7b0 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000a517          	auipc	a0,0xa
ffffffffc0200a26:	dae50513          	addi	a0,a0,-594 # ffffffffc020a7d0 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000a517          	auipc	a0,0xa
ffffffffc0200a32:	df250513          	addi	a0,a0,-526 # ffffffffc020a820 <commands+0x1e0>
ffffffffc0200a36:	00095797          	auipc	a5,0x95
ffffffffc0200a3a:	e287bd23          	sd	s0,-454(a5) # ffffffffc0295870 <memory_base>
ffffffffc0200a3e:	00095797          	auipc	a5,0x95
ffffffffc0200a42:	e367bd23          	sd	s6,-454(a5) # ffffffffc0295878 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00095517          	auipc	a0,0x95
ffffffffc0200a4c:	e2853503          	ld	a0,-472(a0) # ffffffffc0295870 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00095517          	auipc	a0,0x95
ffffffffc0200a56:	e2653503          	ld	a0,-474(a0) # ffffffffc0295878 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00090597          	auipc	a1,0x90
ffffffffc0200a62:	c5258593          	addi	a1,a1,-942 # ffffffffc02906b0 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00090797          	auipc	a5,0x90
ffffffffc0200a6e:	be07ab23          	sw	zero,-1034(a5) # ffffffffc0290660 <ide_devices>
ffffffffc0200a72:	00090797          	auipc	a5,0x90
ffffffffc0200a76:	c207af23          	sw	zero,-962(a5) # ffffffffc02906b0 <ide_devices+0x50>
ffffffffc0200a7a:	00090797          	auipc	a5,0x90
ffffffffc0200a7e:	c807a323          	sw	zero,-890(a5) # ffffffffc0290700 <ide_devices+0xa0>
ffffffffc0200a82:	00090797          	auipc	a5,0x90
ffffffffc0200a86:	cc07a723          	sw	zero,-818(a5) # ffffffffc0290750 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00090417          	auipc	s0,0x90
ffffffffc0200a90:	bd440413          	addi	s0,s0,-1068 # ffffffffc0290660 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00090597          	auipc	a1,0x90
ffffffffc0200aa0:	c6458593          	addi	a1,a1,-924 # ffffffffc0290700 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000a697          	auipc	a3,0xa
ffffffffc0200abc:	d8068693          	addi	a3,a3,-640 # ffffffffc020a838 <commands+0x1f8>
ffffffffc0200ac0:	0000a617          	auipc	a2,0xa
ffffffffc0200ac4:	d9060613          	addi	a2,a2,-624 # ffffffffc020a850 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000a517          	auipc	a0,0xa
ffffffffc0200ace:	d9e50513          	addi	a0,a0,-610 # ffffffffc020a868 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000a697          	auipc	a3,0xa
ffffffffc0200ada:	daa68693          	addi	a3,a3,-598 # ffffffffc020a880 <commands+0x240>
ffffffffc0200ade:	0000a617          	auipc	a2,0xa
ffffffffc0200ae2:	d7260613          	addi	a2,a2,-654 # ffffffffc020a850 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000a517          	auipc	a0,0xa
ffffffffc0200aec:	d8050513          	addi	a0,a0,-640 # ffffffffc020a868 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00090797          	auipc	a5,0x90
ffffffffc0200b06:	b5e78793          	addi	a5,a5,-1186 # ffffffffc0290660 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00090797          	auipc	a5,0x90
ffffffffc0200b2a:	b3a78793          	addi	a5,a5,-1222 # ffffffffc0290660 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00090817          	auipc	a6,0x90
ffffffffc0200b62:	b0280813          	addi	a6,a6,-1278 # ffffffffc0290660 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000a697          	auipc	a3,0xa
ffffffffc0200b9a:	d0268693          	addi	a3,a3,-766 # ffffffffc020a898 <commands+0x258>
ffffffffc0200b9e:	0000a617          	auipc	a2,0xa
ffffffffc0200ba2:	cb260613          	addi	a2,a2,-846 # ffffffffc020a850 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000a517          	auipc	a0,0xa
ffffffffc0200bae:	cbe50513          	addi	a0,a0,-834 # ffffffffc020a868 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000a697          	auipc	a3,0xa
ffffffffc0200bba:	d0a68693          	addi	a3,a3,-758 # ffffffffc020a8c0 <commands+0x280>
ffffffffc0200bbe:	0000a617          	auipc	a2,0xa
ffffffffc0200bc2:	c9260613          	addi	a2,a2,-878 # ffffffffc020a850 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000a517          	auipc	a0,0xa
ffffffffc0200bce:	c9e50513          	addi	a0,a0,-866 # ffffffffc020a868 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00090817          	auipc	a6,0x90
ffffffffc0200bf8:	a6c80813          	addi	a6,a6,-1428 # ffffffffc0290660 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000a697          	auipc	a3,0xa
ffffffffc0200c30:	c6c68693          	addi	a3,a3,-916 # ffffffffc020a898 <commands+0x258>
ffffffffc0200c34:	0000a617          	auipc	a2,0xa
ffffffffc0200c38:	c1c60613          	addi	a2,a2,-996 # ffffffffc020a850 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000a517          	auipc	a0,0xa
ffffffffc0200c44:	c2850513          	addi	a0,a0,-984 # ffffffffc020a868 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000a697          	auipc	a3,0xa
ffffffffc0200c50:	c7468693          	addi	a3,a3,-908 # ffffffffc020a8c0 <commands+0x280>
ffffffffc0200c54:	0000a617          	auipc	a2,0xa
ffffffffc0200c58:	bfc60613          	addi	a2,a2,-1028 # ffffffffc020a850 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000a517          	auipc	a0,0xa
ffffffffc0200c64:	c0850513          	addi	a0,a0,-1016 # ffffffffc020a868 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	722090ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	6f8090ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	684090ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	0008f617          	auipc	a2,0x8f
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0290010 <arena>
ffffffffc0200cf8:	0001a917          	auipc	s2,0x1a
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021ad10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000a517          	auipc	a0,0xa
ffffffffc0200d16:	c0650513          	addi	a0,a0,-1018 # ffffffffc020a918 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000a597          	auipc	a1,0xa
ffffffffc0200d38:	c3c58593          	addi	a1,a1,-964 # ffffffffc020a970 <commands+0x330>
ffffffffc0200d3c:	5c0090ef          	jal	ra,ffffffffc020a2fc <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001a617          	auipc	a2,0x1a
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021ad10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00012917          	auipc	s2,0x12
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0213010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000a517          	auipc	a0,0xa
ffffffffc0200d80:	b8450513          	addi	a0,a0,-1148 # ffffffffc020a900 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000a617          	auipc	a2,0xa
ffffffffc0200d8e:	bb660613          	addi	a2,a2,-1098 # ffffffffc020a940 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000a517          	auipc	a0,0xa
ffffffffc0200d9a:	bc250513          	addi	a0,a0,-1086 # ffffffffc020a958 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000a517          	auipc	a0,0xa
ffffffffc0200dc8:	bbc50513          	addi	a0,a0,-1092 # ffffffffc020a980 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000a517          	auipc	a0,0xa
ffffffffc0200dd8:	bc450513          	addi	a0,a0,-1084 # ffffffffc020a998 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000a517          	auipc	a0,0xa
ffffffffc0200de6:	bce50513          	addi	a0,a0,-1074 # ffffffffc020a9b0 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000a517          	auipc	a0,0xa
ffffffffc0200df4:	bd850513          	addi	a0,a0,-1064 # ffffffffc020a9c8 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000a517          	auipc	a0,0xa
ffffffffc0200e02:	be250513          	addi	a0,a0,-1054 # ffffffffc020a9e0 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000a517          	auipc	a0,0xa
ffffffffc0200e10:	bec50513          	addi	a0,a0,-1044 # ffffffffc020a9f8 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000a517          	auipc	a0,0xa
ffffffffc0200e1e:	bf650513          	addi	a0,a0,-1034 # ffffffffc020aa10 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000a517          	auipc	a0,0xa
ffffffffc0200e2c:	c0050513          	addi	a0,a0,-1024 # ffffffffc020aa28 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000a517          	auipc	a0,0xa
ffffffffc0200e3a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc020aa40 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000a517          	auipc	a0,0xa
ffffffffc0200e48:	c1450513          	addi	a0,a0,-1004 # ffffffffc020aa58 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000a517          	auipc	a0,0xa
ffffffffc0200e56:	c1e50513          	addi	a0,a0,-994 # ffffffffc020aa70 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000a517          	auipc	a0,0xa
ffffffffc0200e64:	c2850513          	addi	a0,a0,-984 # ffffffffc020aa88 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000a517          	auipc	a0,0xa
ffffffffc0200e72:	c3250513          	addi	a0,a0,-974 # ffffffffc020aaa0 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000a517          	auipc	a0,0xa
ffffffffc0200e80:	c3c50513          	addi	a0,a0,-964 # ffffffffc020aab8 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000a517          	auipc	a0,0xa
ffffffffc0200e8e:	c4650513          	addi	a0,a0,-954 # ffffffffc020aad0 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000a517          	auipc	a0,0xa
ffffffffc0200e9c:	c5050513          	addi	a0,a0,-944 # ffffffffc020aae8 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000a517          	auipc	a0,0xa
ffffffffc0200eaa:	c5a50513          	addi	a0,a0,-934 # ffffffffc020ab00 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000a517          	auipc	a0,0xa
ffffffffc0200eb8:	c6450513          	addi	a0,a0,-924 # ffffffffc020ab18 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000a517          	auipc	a0,0xa
ffffffffc0200ec6:	c6e50513          	addi	a0,a0,-914 # ffffffffc020ab30 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000a517          	auipc	a0,0xa
ffffffffc0200ed4:	c7850513          	addi	a0,a0,-904 # ffffffffc020ab48 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000a517          	auipc	a0,0xa
ffffffffc0200ee2:	c8250513          	addi	a0,a0,-894 # ffffffffc020ab60 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000a517          	auipc	a0,0xa
ffffffffc0200ef0:	c8c50513          	addi	a0,a0,-884 # ffffffffc020ab78 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000a517          	auipc	a0,0xa
ffffffffc0200efe:	c9650513          	addi	a0,a0,-874 # ffffffffc020ab90 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000a517          	auipc	a0,0xa
ffffffffc0200f0c:	ca050513          	addi	a0,a0,-864 # ffffffffc020aba8 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000a517          	auipc	a0,0xa
ffffffffc0200f1a:	caa50513          	addi	a0,a0,-854 # ffffffffc020abc0 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000a517          	auipc	a0,0xa
ffffffffc0200f28:	cb450513          	addi	a0,a0,-844 # ffffffffc020abd8 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000a517          	auipc	a0,0xa
ffffffffc0200f36:	cbe50513          	addi	a0,a0,-834 # ffffffffc020abf0 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000a517          	auipc	a0,0xa
ffffffffc0200f44:	cc850513          	addi	a0,a0,-824 # ffffffffc020ac08 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000a517          	auipc	a0,0xa
ffffffffc0200f52:	cd250513          	addi	a0,a0,-814 # ffffffffc020ac20 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000a517          	auipc	a0,0xa
ffffffffc0200f60:	cdc50513          	addi	a0,a0,-804 # ffffffffc020ac38 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000a517          	auipc	a0,0xa
ffffffffc0200f6e:	ce650513          	addi	a0,a0,-794 # ffffffffc020ac50 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000a517          	auipc	a0,0xa
ffffffffc0200f80:	cec50513          	addi	a0,a0,-788 # ffffffffc020ac68 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000a517          	auipc	a0,0xa
ffffffffc0200f96:	cee50513          	addi	a0,a0,-786 # ffffffffc020ac80 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000a517          	auipc	a0,0xa
ffffffffc0200fae:	cee50513          	addi	a0,a0,-786 # ffffffffc020ac98 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000a517          	auipc	a0,0xa
ffffffffc0200fbe:	cf650513          	addi	a0,a0,-778 # ffffffffc020acb0 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000a517          	auipc	a0,0xa
ffffffffc0200fce:	cfe50513          	addi	a0,a0,-770 # ffffffffc020acc8 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000a517          	auipc	a0,0xa
ffffffffc0200fe2:	cfa50513          	addi	a0,a0,-774 # ffffffffc020acd8 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000a717          	auipc	a4,0xa
ffffffffc0200ffe:	d9670713          	addi	a4,a4,-618 # ffffffffc020ad90 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000a517          	auipc	a0,0xa
ffffffffc0201010:	d4450513          	addi	a0,a0,-700 # ffffffffc020ad50 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000a517          	auipc	a0,0xa
ffffffffc020101c:	d1850513          	addi	a0,a0,-744 # ffffffffc020ad30 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000a517          	auipc	a0,0xa
ffffffffc0201028:	ccc50513          	addi	a0,a0,-820 # ffffffffc020acf0 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000a517          	auipc	a0,0xa
ffffffffc0201034:	ce050513          	addi	a0,a0,-800 # ffffffffc020ad10 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00095717          	auipc	a4,0x95
ffffffffc0201048:	82470713          	addi	a4,a4,-2012 # ffffffffc0295868 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	5f2050ef          	jal	ra,ffffffffc0206644 <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	4b70606f          	j	ffffffffc0207d14 <dev_stdin_write>
ffffffffc0201062:	0000a517          	auipc	a0,0xa
ffffffffc0201066:	d0e50513          	addi	a0,a0,-754 # ffffffffc020ad70 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000a717          	auipc	a4,0xa
ffffffffc0201086:	ece70713          	addi	a4,a4,-306 # ffffffffc020af50 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000a517          	auipc	a0,0xa
ffffffffc0201098:	e1450513          	addi	a0,a0,-492 # ffffffffc020aea8 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	7aa0506f          	j	ffffffffc020685a <syscall>
ffffffffc02010b4:	0000a517          	auipc	a0,0xa
ffffffffc02010b8:	e1450513          	addi	a0,a0,-492 # ffffffffc020aec8 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000a517          	auipc	a0,0xa
ffffffffc02010ca:	e2250513          	addi	a0,a0,-478 # ffffffffc020aee8 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000a517          	auipc	a0,0xa
ffffffffc02010d4:	e3850513          	addi	a0,a0,-456 # ffffffffc020af08 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000a517          	auipc	a0,0xa
ffffffffc02010de:	e4650513          	addi	a0,a0,-442 # ffffffffc020af20 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000a517          	auipc	a0,0xa
ffffffffc02010e8:	e5450513          	addi	a0,a0,-428 # ffffffffc020af38 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000a517          	auipc	a0,0xa
ffffffffc02010f2:	cd250513          	addi	a0,a0,-814 # ffffffffc020adc0 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000a517          	auipc	a0,0xa
ffffffffc02010fc:	ce850513          	addi	a0,a0,-792 # ffffffffc020ade0 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000a517          	auipc	a0,0xa
ffffffffc0201106:	cfe50513          	addi	a0,a0,-770 # ffffffffc020ae00 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000a517          	auipc	a0,0xa
ffffffffc0201110:	d0c50513          	addi	a0,a0,-756 # ffffffffc020ae18 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000a517          	auipc	a0,0xa
ffffffffc020111a:	d1250513          	addi	a0,a0,-750 # ffffffffc020ae28 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000a517          	auipc	a0,0xa
ffffffffc0201124:	d2850513          	addi	a0,a0,-728 # ffffffffc020ae48 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000a517          	auipc	a0,0xa
ffffffffc020112e:	d6650513          	addi	a0,a0,-666 # ffffffffc020ae90 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000a617          	auipc	a2,0xa
ffffffffc0201142:	d2260613          	addi	a2,a2,-734 # ffffffffc020ae60 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000a517          	auipc	a0,0xa
ffffffffc020114e:	d2e50513          	addi	a0,a0,-722 # ffffffffc020ae78 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00094417          	auipc	s0,0x94
ffffffffc020115e:	75e40413          	addi	s0,s0,1886 # ffffffffc02958b8 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	2660506f          	j	ffffffffc0206438 <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	512040ef          	jal	ra,ffffffffc02056ea <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	0008f797          	auipc	a5,0x8f
ffffffffc02012b2:	4f278793          	addi	a5,a5,1266 # ffffffffc02907a0 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	0008f517          	auipc	a0,0x8f
ffffffffc02012c4:	4f056503          	lwu	a0,1264(a0) # ffffffffc02907b0 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	0008f417          	auipc	s0,0x8f
ffffffffc02012d2:	4d240413          	addi	s0,s0,1234 # ffffffffc02907a0 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00094797          	auipc	a5,0x94
ffffffffc020135e:	5467b783          	ld	a5,1350(a5) # ffffffffc02958a0 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000d617          	auipc	a2,0xd
ffffffffc020136a:	16a63603          	ld	a2,362(a2) # ffffffffc020e4d0 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00094697          	auipc	a3,0x94
ffffffffc0201376:	5266b683          	ld	a3,1318(a3) # ffffffffc0295898 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	0008f797          	auipc	a5,0x8f
ffffffffc02013b4:	4007a023          	sw	zero,1024(a5) # ffffffffc02907b0 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	0008f797          	auipc	a5,0x8f
ffffffffc0201496:	3007af23          	sw	zero,798(a5) # ffffffffc02907b0 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000a697          	auipc	a3,0xa
ffffffffc02015b0:	9e468693          	addi	a3,a3,-1564 # ffffffffc020af90 <commands+0x950>
ffffffffc02015b4:	00009617          	auipc	a2,0x9
ffffffffc02015b8:	29c60613          	addi	a2,a2,668 # ffffffffc020a850 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000a517          	auipc	a0,0xa
ffffffffc02015c4:	9e050513          	addi	a0,a0,-1568 # ffffffffc020afa0 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000a697          	auipc	a3,0xa
ffffffffc02015d0:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020b038 <commands+0x9f8>
ffffffffc02015d4:	00009617          	auipc	a2,0x9
ffffffffc02015d8:	27c60613          	addi	a2,a2,636 # ffffffffc020a850 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000a517          	auipc	a0,0xa
ffffffffc02015e4:	9c050513          	addi	a0,a0,-1600 # ffffffffc020afa0 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000a697          	auipc	a3,0xa
ffffffffc02015f0:	a7468693          	addi	a3,a3,-1420 # ffffffffc020b060 <commands+0xa20>
ffffffffc02015f4:	00009617          	auipc	a2,0x9
ffffffffc02015f8:	25c60613          	addi	a2,a2,604 # ffffffffc020a850 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000a517          	auipc	a0,0xa
ffffffffc0201604:	9a050513          	addi	a0,a0,-1632 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000a697          	auipc	a3,0xa
ffffffffc0201610:	a9468693          	addi	a3,a3,-1388 # ffffffffc020b0a0 <commands+0xa60>
ffffffffc0201614:	00009617          	auipc	a2,0x9
ffffffffc0201618:	23c60613          	addi	a2,a2,572 # ffffffffc020a850 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000a517          	auipc	a0,0xa
ffffffffc0201624:	98050513          	addi	a0,a0,-1664 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000a697          	auipc	a3,0xa
ffffffffc0201630:	afc68693          	addi	a3,a3,-1284 # ffffffffc020b128 <commands+0xae8>
ffffffffc0201634:	00009617          	auipc	a2,0x9
ffffffffc0201638:	21c60613          	addi	a2,a2,540 # ffffffffc020a850 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000a517          	auipc	a0,0xa
ffffffffc0201644:	96050513          	addi	a0,a0,-1696 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000a697          	auipc	a3,0xa
ffffffffc0201650:	98c68693          	addi	a3,a3,-1652 # ffffffffc020afd8 <commands+0x998>
ffffffffc0201654:	00009617          	auipc	a2,0x9
ffffffffc0201658:	1fc60613          	addi	a2,a2,508 # ffffffffc020a850 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000a517          	auipc	a0,0xa
ffffffffc0201664:	94050513          	addi	a0,a0,-1728 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000a697          	auipc	a3,0xa
ffffffffc0201670:	aac68693          	addi	a3,a3,-1364 # ffffffffc020b118 <commands+0xad8>
ffffffffc0201674:	00009617          	auipc	a2,0x9
ffffffffc0201678:	1dc60613          	addi	a2,a2,476 # ffffffffc020a850 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000a517          	auipc	a0,0xa
ffffffffc0201684:	92050513          	addi	a0,a0,-1760 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000a697          	auipc	a3,0xa
ffffffffc0201690:	a7468693          	addi	a3,a3,-1420 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201694:	00009617          	auipc	a2,0x9
ffffffffc0201698:	1bc60613          	addi	a2,a2,444 # ffffffffc020a850 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000a517          	auipc	a0,0xa
ffffffffc02016a4:	90050513          	addi	a0,a0,-1792 # ffffffffc020afa0 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000a697          	auipc	a3,0xa
ffffffffc02016b0:	a3468693          	addi	a3,a3,-1484 # ffffffffc020b0e0 <commands+0xaa0>
ffffffffc02016b4:	00009617          	auipc	a2,0x9
ffffffffc02016b8:	19c60613          	addi	a2,a2,412 # ffffffffc020a850 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000a517          	auipc	a0,0xa
ffffffffc02016c4:	8e050513          	addi	a0,a0,-1824 # ffffffffc020afa0 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000a697          	auipc	a3,0xa
ffffffffc02016d0:	aa468693          	addi	a3,a3,-1372 # ffffffffc020b170 <commands+0xb30>
ffffffffc02016d4:	00009617          	auipc	a2,0x9
ffffffffc02016d8:	17c60613          	addi	a2,a2,380 # ffffffffc020a850 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000a517          	auipc	a0,0xa
ffffffffc02016e4:	8c050513          	addi	a0,a0,-1856 # ffffffffc020afa0 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000a697          	auipc	a3,0xa
ffffffffc02016f0:	a7468693          	addi	a3,a3,-1420 # ffffffffc020b160 <commands+0xb20>
ffffffffc02016f4:	00009617          	auipc	a2,0x9
ffffffffc02016f8:	15c60613          	addi	a2,a2,348 # ffffffffc020a850 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000a517          	auipc	a0,0xa
ffffffffc0201704:	8a050513          	addi	a0,a0,-1888 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000a697          	auipc	a3,0xa
ffffffffc0201710:	9f468693          	addi	a3,a3,-1548 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201714:	00009617          	auipc	a2,0x9
ffffffffc0201718:	13c60613          	addi	a2,a2,316 # ffffffffc020a850 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000a517          	auipc	a0,0xa
ffffffffc0201724:	88050513          	addi	a0,a0,-1920 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000a697          	auipc	a3,0xa
ffffffffc0201730:	a1468693          	addi	a3,a3,-1516 # ffffffffc020b140 <commands+0xb00>
ffffffffc0201734:	00009617          	auipc	a2,0x9
ffffffffc0201738:	11c60613          	addi	a2,a2,284 # ffffffffc020a850 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000a517          	auipc	a0,0xa
ffffffffc0201744:	86050513          	addi	a0,a0,-1952 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000a697          	auipc	a3,0xa
ffffffffc0201750:	88c68693          	addi	a3,a3,-1908 # ffffffffc020afd8 <commands+0x998>
ffffffffc0201754:	00009617          	auipc	a2,0x9
ffffffffc0201758:	0fc60613          	addi	a2,a2,252 # ffffffffc020a850 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000a517          	auipc	a0,0xa
ffffffffc0201764:	84050513          	addi	a0,a0,-1984 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000a697          	auipc	a3,0xa
ffffffffc0201770:	99468693          	addi	a3,a3,-1644 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201774:	00009617          	auipc	a2,0x9
ffffffffc0201778:	0dc60613          	addi	a2,a2,220 # ffffffffc020a850 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000a517          	auipc	a0,0xa
ffffffffc0201784:	82050513          	addi	a0,a0,-2016 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000a697          	auipc	a3,0xa
ffffffffc0201790:	88c68693          	addi	a3,a3,-1908 # ffffffffc020b018 <commands+0x9d8>
ffffffffc0201794:	00009617          	auipc	a2,0x9
ffffffffc0201798:	0bc60613          	addi	a2,a2,188 # ffffffffc020a850 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000a517          	auipc	a0,0xa
ffffffffc02017a4:	80050513          	addi	a0,a0,-2048 # ffffffffc020afa0 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000a697          	auipc	a3,0xa
ffffffffc02017b0:	84c68693          	addi	a3,a3,-1972 # ffffffffc020aff8 <commands+0x9b8>
ffffffffc02017b4:	00009617          	auipc	a2,0x9
ffffffffc02017b8:	09c60613          	addi	a2,a2,156 # ffffffffc020a850 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	00009517          	auipc	a0,0x9
ffffffffc02017c4:	7e050513          	addi	a0,a0,2016 # ffffffffc020afa0 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000a697          	auipc	a3,0xa
ffffffffc02017d0:	84c68693          	addi	a3,a3,-1972 # ffffffffc020b018 <commands+0x9d8>
ffffffffc02017d4:	00009617          	auipc	a2,0x9
ffffffffc02017d8:	07c60613          	addi	a2,a2,124 # ffffffffc020a850 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	00009517          	auipc	a0,0x9
ffffffffc02017e4:	7c050513          	addi	a0,a0,1984 # ffffffffc020afa0 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000a697          	auipc	a3,0xa
ffffffffc02017f0:	ad468693          	addi	a3,a3,-1324 # ffffffffc020b2c0 <commands+0xc80>
ffffffffc02017f4:	00009617          	auipc	a2,0x9
ffffffffc02017f8:	05c60613          	addi	a2,a2,92 # ffffffffc020a850 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	00009517          	auipc	a0,0x9
ffffffffc0201804:	7a050513          	addi	a0,a0,1952 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000a697          	auipc	a3,0xa
ffffffffc0201810:	95468693          	addi	a3,a3,-1708 # ffffffffc020b160 <commands+0xb20>
ffffffffc0201814:	00009617          	auipc	a2,0x9
ffffffffc0201818:	03c60613          	addi	a2,a2,60 # ffffffffc020a850 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	00009517          	auipc	a0,0x9
ffffffffc0201824:	78050513          	addi	a0,a0,1920 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000a697          	auipc	a3,0xa
ffffffffc0201830:	8d468693          	addi	a3,a3,-1836 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201834:	00009617          	auipc	a2,0x9
ffffffffc0201838:	01c60613          	addi	a2,a2,28 # ffffffffc020a850 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	00009517          	auipc	a0,0x9
ffffffffc0201844:	76050513          	addi	a0,a0,1888 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000a697          	auipc	a3,0xa
ffffffffc0201850:	87468693          	addi	a3,a3,-1932 # ffffffffc020b0c0 <commands+0xa80>
ffffffffc0201854:	00009617          	auipc	a2,0x9
ffffffffc0201858:	ffc60613          	addi	a2,a2,-4 # ffffffffc020a850 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	00009517          	auipc	a0,0x9
ffffffffc0201864:	74050513          	addi	a0,a0,1856 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000a697          	auipc	a3,0xa
ffffffffc0201870:	a1468693          	addi	a3,a3,-1516 # ffffffffc020b280 <commands+0xc40>
ffffffffc0201874:	00009617          	auipc	a2,0x9
ffffffffc0201878:	fdc60613          	addi	a2,a2,-36 # ffffffffc020a850 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	00009517          	auipc	a0,0x9
ffffffffc0201884:	72050513          	addi	a0,a0,1824 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000a697          	auipc	a3,0xa
ffffffffc0201890:	9d468693          	addi	a3,a3,-1580 # ffffffffc020b260 <commands+0xc20>
ffffffffc0201894:	00009617          	auipc	a2,0x9
ffffffffc0201898:	fbc60613          	addi	a2,a2,-68 # ffffffffc020a850 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	00009517          	auipc	a0,0x9
ffffffffc02018a4:	70050513          	addi	a0,a0,1792 # ffffffffc020afa0 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000a697          	auipc	a3,0xa
ffffffffc02018b0:	98c68693          	addi	a3,a3,-1652 # ffffffffc020b238 <commands+0xbf8>
ffffffffc02018b4:	00009617          	auipc	a2,0x9
ffffffffc02018b8:	f9c60613          	addi	a2,a2,-100 # ffffffffc020a850 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	00009517          	auipc	a0,0x9
ffffffffc02018c4:	6e050513          	addi	a0,a0,1760 # ffffffffc020afa0 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000a697          	auipc	a3,0xa
ffffffffc02018d0:	94468693          	addi	a3,a3,-1724 # ffffffffc020b210 <commands+0xbd0>
ffffffffc02018d4:	00009617          	auipc	a2,0x9
ffffffffc02018d8:	f7c60613          	addi	a2,a2,-132 # ffffffffc020a850 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	00009517          	auipc	a0,0x9
ffffffffc02018e4:	6c050513          	addi	a0,a0,1728 # ffffffffc020afa0 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000a697          	auipc	a3,0xa
ffffffffc02018f0:	91468693          	addi	a3,a3,-1772 # ffffffffc020b200 <commands+0xbc0>
ffffffffc02018f4:	00009617          	auipc	a2,0x9
ffffffffc02018f8:	f5c60613          	addi	a2,a2,-164 # ffffffffc020a850 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	00009517          	auipc	a0,0x9
ffffffffc0201904:	6a050513          	addi	a0,a0,1696 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	00009697          	auipc	a3,0x9
ffffffffc0201910:	7f468693          	addi	a3,a3,2036 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201914:	00009617          	auipc	a2,0x9
ffffffffc0201918:	f3c60613          	addi	a2,a2,-196 # ffffffffc020a850 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	00009517          	auipc	a0,0x9
ffffffffc0201924:	68050513          	addi	a0,a0,1664 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000a697          	auipc	a3,0xa
ffffffffc0201930:	8b468693          	addi	a3,a3,-1868 # ffffffffc020b1e0 <commands+0xba0>
ffffffffc0201934:	00009617          	auipc	a2,0x9
ffffffffc0201938:	f1c60613          	addi	a2,a2,-228 # ffffffffc020a850 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	00009517          	auipc	a0,0x9
ffffffffc0201944:	66050513          	addi	a0,a0,1632 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000a697          	auipc	a3,0xa
ffffffffc0201950:	86468693          	addi	a3,a3,-1948 # ffffffffc020b1b0 <commands+0xb70>
ffffffffc0201954:	00009617          	auipc	a2,0x9
ffffffffc0201958:	efc60613          	addi	a2,a2,-260 # ffffffffc020a850 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	00009517          	auipc	a0,0x9
ffffffffc0201964:	64050513          	addi	a0,a0,1600 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000a697          	auipc	a3,0xa
ffffffffc0201970:	82c68693          	addi	a3,a3,-2004 # ffffffffc020b198 <commands+0xb58>
ffffffffc0201974:	00009617          	auipc	a2,0x9
ffffffffc0201978:	edc60613          	addi	a2,a2,-292 # ffffffffc020a850 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	00009517          	auipc	a0,0x9
ffffffffc0201984:	62050513          	addi	a0,a0,1568 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	00009697          	auipc	a3,0x9
ffffffffc0201990:	77468693          	addi	a3,a3,1908 # ffffffffc020b100 <commands+0xac0>
ffffffffc0201994:	00009617          	auipc	a2,0x9
ffffffffc0201998:	ebc60613          	addi	a2,a2,-324 # ffffffffc020a850 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	00009517          	auipc	a0,0x9
ffffffffc02019a4:	60050513          	addi	a0,a0,1536 # ffffffffc020afa0 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	00009697          	auipc	a3,0x9
ffffffffc02019b0:	7d468693          	addi	a3,a3,2004 # ffffffffc020b180 <commands+0xb40>
ffffffffc02019b4:	00009617          	auipc	a2,0x9
ffffffffc02019b8:	e9c60613          	addi	a2,a2,-356 # ffffffffc020a850 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	00009517          	auipc	a0,0x9
ffffffffc02019c4:	5e050513          	addi	a0,a0,1504 # ffffffffc020afa0 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000a697          	auipc	a3,0xa
ffffffffc02019d0:	8d468693          	addi	a3,a3,-1836 # ffffffffc020b2a0 <commands+0xc60>
ffffffffc02019d4:	00009617          	auipc	a2,0x9
ffffffffc02019d8:	e7c60613          	addi	a2,a2,-388 # ffffffffc020a850 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	00009517          	auipc	a0,0x9
ffffffffc02019e4:	5c050513          	addi	a0,a0,1472 # ffffffffc020afa0 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000a697          	auipc	a3,0xa
ffffffffc02019f0:	8e468693          	addi	a3,a3,-1820 # ffffffffc020b2d0 <commands+0xc90>
ffffffffc02019f4:	00009617          	auipc	a2,0x9
ffffffffc02019f8:	e5c60613          	addi	a2,a2,-420 # ffffffffc020a850 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	00009517          	auipc	a0,0x9
ffffffffc0201a04:	5a050513          	addi	a0,a0,1440 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	00009697          	auipc	a3,0x9
ffffffffc0201a10:	5ac68693          	addi	a3,a3,1452 # ffffffffc020afb8 <commands+0x978>
ffffffffc0201a14:	00009617          	auipc	a2,0x9
ffffffffc0201a18:	e3c60613          	addi	a2,a2,-452 # ffffffffc020a850 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	00009517          	auipc	a0,0x9
ffffffffc0201a24:	58050513          	addi	a0,a0,1408 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	00009697          	auipc	a3,0x9
ffffffffc0201a30:	5cc68693          	addi	a3,a3,1484 # ffffffffc020aff8 <commands+0x9b8>
ffffffffc0201a34:	00009617          	auipc	a2,0x9
ffffffffc0201a38:	e1c60613          	addi	a2,a2,-484 # ffffffffc020a850 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	00009517          	auipc	a0,0x9
ffffffffc0201a44:	56050513          	addi	a0,a0,1376 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	0008f697          	auipc	a3,0x8f
ffffffffc0201a92:	d1268693          	addi	a3,a3,-750 # ffffffffc02907a0 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	00009697          	auipc	a3,0x9
ffffffffc0201b7c:	77068693          	addi	a3,a3,1904 # ffffffffc020b2e8 <commands+0xca8>
ffffffffc0201b80:	00009617          	auipc	a2,0x9
ffffffffc0201b84:	cd060613          	addi	a2,a2,-816 # ffffffffc020a850 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	00009517          	auipc	a0,0x9
ffffffffc0201b90:	41450513          	addi	a0,a0,1044 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	00009697          	auipc	a3,0x9
ffffffffc0201b9c:	74868693          	addi	a3,a3,1864 # ffffffffc020b2e0 <commands+0xca0>
ffffffffc0201ba0:	00009617          	auipc	a2,0x9
ffffffffc0201ba4:	cb060613          	addi	a2,a2,-848 # ffffffffc020a850 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	00009517          	auipc	a0,0x9
ffffffffc0201bb0:	3f450513          	addi	a0,a0,1012 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	0008f597          	auipc	a1,0x8f
ffffffffc0201bbe:	be658593          	addi	a1,a1,-1050 # ffffffffc02907a0 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	00009697          	auipc	a3,0x9
ffffffffc0201c4e:	69668693          	addi	a3,a3,1686 # ffffffffc020b2e0 <commands+0xca0>
ffffffffc0201c52:	00009617          	auipc	a2,0x9
ffffffffc0201c56:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020a850 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	00009517          	auipc	a0,0x9
ffffffffc0201c62:	34250513          	addi	a0,a0,834 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	0008f697          	auipc	a3,0x8f
ffffffffc0201caa:	afa68693          	addi	a3,a3,-1286 # ffffffffc02907a0 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	00009697          	auipc	a3,0x9
ffffffffc0201d20:	5f468693          	addi	a3,a3,1524 # ffffffffc020b310 <commands+0xcd0>
ffffffffc0201d24:	00009617          	auipc	a2,0x9
ffffffffc0201d28:	b2c60613          	addi	a2,a2,-1236 # ffffffffc020a850 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	00009517          	auipc	a0,0x9
ffffffffc0201d34:	27050513          	addi	a0,a0,624 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	00009697          	auipc	a3,0x9
ffffffffc0201d40:	5a468693          	addi	a3,a3,1444 # ffffffffc020b2e0 <commands+0xca0>
ffffffffc0201d44:	00009617          	auipc	a2,0x9
ffffffffc0201d48:	b0c60613          	addi	a2,a2,-1268 # ffffffffc020a850 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	00009517          	auipc	a0,0x9
ffffffffc0201d54:	25050513          	addi	a0,a0,592 # ffffffffc020afa0 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008e617          	auipc	a2,0x8e
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0290050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00094697          	auipc	a3,0x94
ffffffffc0201e24:	a806b683          	ld	a3,-1408(a3) # ffffffffc02958a0 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000c697          	auipc	a3,0xc
ffffffffc0201e30:	6a46b683          	ld	a3,1700(a3) # ffffffffc020e4d0 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00094717          	auipc	a4,0x94
ffffffffc0201e40:	a5c73703          	ld	a4,-1444(a4) # ffffffffc0295898 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00094697          	auipc	a3,0x94
ffffffffc0201e4e:	a666b683          	ld	a3,-1434(a3) # ffffffffc02958b0 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	00009617          	auipc	a2,0x9
ffffffffc0201e60:	51460613          	addi	a2,a2,1300 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	00009517          	auipc	a0,0x9
ffffffffc0201e6c:	53050513          	addi	a0,a0,1328 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008e917          	auipc	s2,0x8e
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0290050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	00009697          	auipc	a3,0x9
ffffffffc0201f4e:	45e68693          	addi	a3,a3,1118 # ffffffffc020b3a8 <default_pmm_manager+0x70>
ffffffffc0201f52:	00009617          	auipc	a2,0x9
ffffffffc0201f56:	8fe60613          	addi	a2,a2,-1794 # ffffffffc020a850 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	00009517          	auipc	a0,0x9
ffffffffc0201f62:	46a50513          	addi	a0,a0,1130 # ffffffffc020b3c8 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	00009517          	auipc	a0,0x9
ffffffffc0201f70:	47450513          	addi	a0,a0,1140 # ffffffffc020b3e0 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	00009517          	auipc	a0,0x9
ffffffffc0201f80:	47c50513          	addi	a0,a0,1148 # ffffffffc020b3f8 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00094797          	auipc	a5,0x94
ffffffffc0201fda:	8aa78793          	addi	a5,a5,-1878 # ffffffffc0295880 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00094797          	auipc	a5,0x94
ffffffffc0202016:	86e78793          	addi	a5,a5,-1938 # ffffffffc0295880 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00094797          	auipc	a5,0x94
ffffffffc020205c:	8287b783          	ld	a5,-2008(a5) # ffffffffc0295880 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00094697          	auipc	a3,0x94
ffffffffc0202068:	81c68693          	addi	a3,a3,-2020 # ffffffffc0295880 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00094697          	auipc	a3,0x94
ffffffffc0202090:	8246b683          	ld	a3,-2012(a3) # ffffffffc02958b0 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00094797          	auipc	a5,0x94
ffffffffc020209c:	8007b783          	ld	a5,-2048(a5) # ffffffffc0295898 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000c517          	auipc	a0,0xc
ffffffffc02020a8:	42c53503          	ld	a0,1068(a0) # ffffffffc020e4d0 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00093517          	auipc	a0,0x93
ffffffffc02020b4:	7f053503          	ld	a0,2032(a0) # ffffffffc02958a0 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00093797          	auipc	a5,0x93
ffffffffc02020ec:	7987b783          	ld	a5,1944(a5) # ffffffffc0295880 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	00009617          	auipc	a2,0x9
ffffffffc0202106:	33e60613          	addi	a2,a2,830 # ffffffffc020b440 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	00009517          	auipc	a0,0x9
ffffffffc0202112:	28a50513          	addi	a0,a0,650 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	00009617          	auipc	a2,0x9
ffffffffc0202120:	2fc60613          	addi	a2,a2,764 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	00009517          	auipc	a0,0x9
ffffffffc020212c:	27050513          	addi	a0,a0,624 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	00009617          	auipc	a2,0x9
ffffffffc020213a:	30a60613          	addi	a2,a2,778 # ffffffffc020b440 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	00009517          	auipc	a0,0x9
ffffffffc0202146:	25650513          	addi	a0,a0,598 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	00009617          	auipc	a2,0x9
ffffffffc0202156:	30e60613          	addi	a2,a2,782 # ffffffffc020b460 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	00009517          	auipc	a0,0x9
ffffffffc0202162:	23a50513          	addi	a0,a0,570 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00093797          	auipc	a5,0x93
ffffffffc0202178:	7347b783          	ld	a5,1844(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00093797          	auipc	a5,0x93
ffffffffc0202190:	71c7b783          	ld	a5,1820(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00093797          	auipc	a5,0x93
ffffffffc02021b6:	6f67b783          	ld	a5,1782(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00093797          	auipc	a5,0x93
ffffffffc02021d2:	6da7b783          	ld	a5,1754(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00093797          	auipc	a5,0x93
ffffffffc02021f6:	6b67b783          	ld	a5,1718(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00093797          	auipc	a5,0x93
ffffffffc020220c:	6a07b783          	ld	a5,1696(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00093997          	auipc	s3,0x93
ffffffffc0202252:	64a98993          	addi	s3,s3,1610 # ffffffffc0295898 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00093797          	auipc	a5,0x93
ffffffffc020226a:	6427b783          	ld	a5,1602(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00093b17          	auipc	s6,0x93
ffffffffc020227e:	626b0b13          	addi	s6,s6,1574 # ffffffffc02958a0 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00093997          	auipc	s3,0x93
ffffffffc020228e:	60e98993          	addi	s3,s3,1550 # ffffffffc0295898 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00093797          	auipc	a5,0x93
ffffffffc02022b2:	6027b783          	ld	a5,1538(a5) # ffffffffc02958b0 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	0ac080ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00093a97          	auipc	s5,0x93
ffffffffc02022ea:	5caa8a93          	addi	s5,s5,1482 # ffffffffc02958b0 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00093797          	auipc	a5,0x93
ffffffffc020231a:	5927b783          	ld	a5,1426(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00093b17          	auipc	s6,0x93
ffffffffc020232c:	578b0b13          	addi	s6,s6,1400 # ffffffffc02958a0 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	00a080ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00093797          	auipc	a5,0x93
ffffffffc02023bc:	4f07b783          	ld	a5,1264(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00093797          	auipc	a5,0x93
ffffffffc02023d6:	4d67b783          	ld	a5,1238(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	00009617          	auipc	a2,0x9
ffffffffc02023ec:	f8860613          	addi	a2,a2,-120 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	00009517          	auipc	a0,0x9
ffffffffc02023f8:	09450513          	addi	a0,a0,148 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	00009617          	auipc	a2,0x9
ffffffffc0202404:	f7060613          	addi	a2,a2,-144 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	00009517          	auipc	a0,0x9
ffffffffc0202410:	07c50513          	addi	a0,a0,124 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	00009617          	auipc	a2,0x9
ffffffffc020241e:	f5660613          	addi	a2,a2,-170 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	00009517          	auipc	a0,0x9
ffffffffc020242a:	06250513          	addi	a0,a0,98 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	00009617          	auipc	a2,0x9
ffffffffc0202438:	f3c60613          	addi	a2,a2,-196 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	00009517          	auipc	a0,0x9
ffffffffc0202444:	04850513          	addi	a0,a0,72 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	00009697          	auipc	a3,0x9
ffffffffc02024d6:	fde68693          	addi	a3,a3,-34 # ffffffffc020b4b0 <default_pmm_manager+0x178>
ffffffffc02024da:	00008617          	auipc	a2,0x8
ffffffffc02024de:	37660613          	addi	a2,a2,886 # ffffffffc020a850 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	00009517          	auipc	a0,0x9
ffffffffc02024ea:	fa250513          	addi	a0,a0,-94 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	00009697          	auipc	a3,0x9
ffffffffc02024f6:	fa668693          	addi	a3,a3,-90 # ffffffffc020b498 <default_pmm_manager+0x160>
ffffffffc02024fa:	00008617          	auipc	a2,0x8
ffffffffc02024fe:	35660613          	addi	a2,a2,854 # ffffffffc020a850 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	00009517          	auipc	a0,0x9
ffffffffc020250a:	f8250513          	addi	a0,a0,-126 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00093717          	auipc	a4,0x93
ffffffffc0202540:	35c73703          	ld	a4,860(a4) # ffffffffc0295898 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00093517          	auipc	a0,0x93
ffffffffc0202558:	34c53503          	ld	a0,844(a0) # ffffffffc02958a0 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00093c97          	auipc	s9,0x93
ffffffffc02025a8:	2f4c8c93          	addi	s9,s9,756 # ffffffffc0295898 <npage>
ffffffffc02025ac:	00093c17          	auipc	s8,0x93
ffffffffc02025b0:	2f4c0c13          	addi	s8,s8,756 # ffffffffc02958a0 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00093d17          	auipc	s10,0x93
ffffffffc02025bc:	2f0d0d13          	addi	s10,s10,752 # ffffffffc02958a8 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	00009697          	auipc	a3,0x9
ffffffffc020266c:	e5868693          	addi	a3,a3,-424 # ffffffffc020b4c0 <default_pmm_manager+0x188>
ffffffffc0202670:	00008617          	auipc	a2,0x8
ffffffffc0202674:	1e060613          	addi	a2,a2,480 # ffffffffc020a850 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	00009517          	auipc	a0,0x9
ffffffffc0202680:	e0c50513          	addi	a0,a0,-500 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	00009697          	auipc	a3,0x9
ffffffffc020268c:	e6868693          	addi	a3,a3,-408 # ffffffffc020b4f0 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00008617          	auipc	a2,0x8
ffffffffc0202694:	1c060613          	addi	a2,a2,448 # ffffffffc020a850 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	00009517          	auipc	a0,0x9
ffffffffc02026a0:	dec50513          	addi	a0,a0,-532 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00093d17          	auipc	s10,0x93
ffffffffc0202706:	196d0d13          	addi	s10,s10,406 # ffffffffc0295898 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00093717          	auipc	a4,0x93
ffffffffc0202712:	19270713          	addi	a4,a4,402 # ffffffffc02958a0 <pages>
ffffffffc0202716:	00093d97          	auipc	s11,0x93
ffffffffc020271a:	192d8d93          	addi	s11,s11,402 # ffffffffc02958a8 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00093817          	auipc	a6,0x93
ffffffffc0202776:	13e80813          	addi	a6,a6,318 # ffffffffc02958b0 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00093817          	auipc	a6,0x93
ffffffffc020280a:	0aa80813          	addi	a6,a6,170 # ffffffffc02958b0 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00093717          	auipc	a4,0x93
ffffffffc020281c:	08870713          	addi	a4,a4,136 # ffffffffc02958a0 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00093717          	auipc	a4,0x93
ffffffffc0202854:	05070713          	addi	a4,a4,80 # ffffffffc02958a0 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00093717          	auipc	a4,0x93
ffffffffc02028a2:	00270713          	addi	a4,a4,2 # ffffffffc02958a0 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00093817          	auipc	a6,0x93
ffffffffc02028b4:	00080813          	mv	a6,a6
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00093717          	auipc	a4,0x93
ffffffffc02028d8:	fcc70713          	addi	a4,a4,-52 # ffffffffc02958a0 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	00009697          	auipc	a3,0x9
ffffffffc02028e6:	bde68693          	addi	a3,a3,-1058 # ffffffffc020b4c0 <default_pmm_manager+0x188>
ffffffffc02028ea:	00008617          	auipc	a2,0x8
ffffffffc02028ee:	f6660613          	addi	a2,a2,-154 # ffffffffc020a850 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	00009517          	auipc	a0,0x9
ffffffffc02028fa:	b9250513          	addi	a0,a0,-1134 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	00009617          	auipc	a2,0x9
ffffffffc0202906:	a6e60613          	addi	a2,a2,-1426 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	00009517          	auipc	a0,0x9
ffffffffc0202912:	a8a50513          	addi	a0,a0,-1398 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	00009697          	auipc	a3,0x9
ffffffffc0202922:	bd268693          	addi	a3,a3,-1070 # ffffffffc020b4f0 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00008617          	auipc	a2,0x8
ffffffffc020292a:	f2a60613          	addi	a2,a2,-214 # ffffffffc020a850 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	00009517          	auipc	a0,0x9
ffffffffc0202936:	b5650513          	addi	a0,a0,-1194 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <page_remove>:
ffffffffc020293e:	7179                	addi	sp,sp,-48
ffffffffc0202940:	4601                	li	a2,0
ffffffffc0202942:	ec26                	sd	s1,24(sp)
ffffffffc0202944:	f406                	sd	ra,40(sp)
ffffffffc0202946:	f022                	sd	s0,32(sp)
ffffffffc0202948:	84ae                	mv	s1,a1
ffffffffc020294a:	8dbff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020294e:	c511                	beqz	a0,ffffffffc020295a <page_remove+0x1c>
ffffffffc0202950:	611c                	ld	a5,0(a0)
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	0017f713          	andi	a4,a5,1
ffffffffc0202958:	e711                	bnez	a4,ffffffffc0202964 <page_remove+0x26>
ffffffffc020295a:	70a2                	ld	ra,40(sp)
ffffffffc020295c:	7402                	ld	s0,32(sp)
ffffffffc020295e:	64e2                	ld	s1,24(sp)
ffffffffc0202960:	6145                	addi	sp,sp,48
ffffffffc0202962:	8082                	ret
ffffffffc0202964:	078a                	slli	a5,a5,0x2
ffffffffc0202966:	83b1                	srli	a5,a5,0xc
ffffffffc0202968:	00093717          	auipc	a4,0x93
ffffffffc020296c:	f3073703          	ld	a4,-208(a4) # ffffffffc0295898 <npage>
ffffffffc0202970:	06e7f363          	bgeu	a5,a4,ffffffffc02029d6 <page_remove+0x98>
ffffffffc0202974:	fff80537          	lui	a0,0xfff80
ffffffffc0202978:	97aa                	add	a5,a5,a0
ffffffffc020297a:	079a                	slli	a5,a5,0x6
ffffffffc020297c:	00093517          	auipc	a0,0x93
ffffffffc0202980:	f2453503          	ld	a0,-220(a0) # ffffffffc02958a0 <pages>
ffffffffc0202984:	953e                	add	a0,a0,a5
ffffffffc0202986:	411c                	lw	a5,0(a0)
ffffffffc0202988:	fff7871b          	addiw	a4,a5,-1
ffffffffc020298c:	c118                	sw	a4,0(a0)
ffffffffc020298e:	cb11                	beqz	a4,ffffffffc02029a2 <page_remove+0x64>
ffffffffc0202990:	00043023          	sd	zero,0(s0)
ffffffffc0202994:	12048073          	sfence.vma	s1
ffffffffc0202998:	70a2                	ld	ra,40(sp)
ffffffffc020299a:	7402                	ld	s0,32(sp)
ffffffffc020299c:	64e2                	ld	s1,24(sp)
ffffffffc020299e:	6145                	addi	sp,sp,48
ffffffffc02029a0:	8082                	ret
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	eb89                	bnez	a5,ffffffffc02029ba <page_remove+0x7c>
ffffffffc02029aa:	00093797          	auipc	a5,0x93
ffffffffc02029ae:	efe7b783          	ld	a5,-258(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02029b2:	739c                	ld	a5,32(a5)
ffffffffc02029b4:	4585                	li	a1,1
ffffffffc02029b6:	9782                	jalr	a5
ffffffffc02029b8:	bfe1                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029ba:	e42a                	sd	a0,8(sp)
ffffffffc02029bc:	ab6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c0:	00093797          	auipc	a5,0x93
ffffffffc02029c4:	ee87b783          	ld	a5,-280(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc02029c8:	739c                	ld	a5,32(a5)
ffffffffc02029ca:	6522                	ld	a0,8(sp)
ffffffffc02029cc:	4585                	li	a1,1
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	a9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d4:	bf75                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029d6:	f5eff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02029da <page_insert>:
ffffffffc02029da:	7139                	addi	sp,sp,-64
ffffffffc02029dc:	e852                	sd	s4,16(sp)
ffffffffc02029de:	8a32                	mv	s4,a2
ffffffffc02029e0:	f822                	sd	s0,48(sp)
ffffffffc02029e2:	4605                	li	a2,1
ffffffffc02029e4:	842e                	mv	s0,a1
ffffffffc02029e6:	85d2                	mv	a1,s4
ffffffffc02029e8:	f426                	sd	s1,40(sp)
ffffffffc02029ea:	fc06                	sd	ra,56(sp)
ffffffffc02029ec:	f04a                	sd	s2,32(sp)
ffffffffc02029ee:	ec4e                	sd	s3,24(sp)
ffffffffc02029f0:	e456                	sd	s5,8(sp)
ffffffffc02029f2:	84b6                	mv	s1,a3
ffffffffc02029f4:	831ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029f8:	c961                	beqz	a0,ffffffffc0202ac8 <page_insert+0xee>
ffffffffc02029fa:	4014                	lw	a3,0(s0)
ffffffffc02029fc:	611c                	ld	a5,0(a0)
ffffffffc02029fe:	89aa                	mv	s3,a0
ffffffffc0202a00:	0016871b          	addiw	a4,a3,1
ffffffffc0202a04:	c018                	sw	a4,0(s0)
ffffffffc0202a06:	0017f713          	andi	a4,a5,1
ffffffffc0202a0a:	ef05                	bnez	a4,ffffffffc0202a42 <page_insert+0x68>
ffffffffc0202a0c:	00093717          	auipc	a4,0x93
ffffffffc0202a10:	e9473703          	ld	a4,-364(a4) # ffffffffc02958a0 <pages>
ffffffffc0202a14:	8c19                	sub	s0,s0,a4
ffffffffc0202a16:	000807b7          	lui	a5,0x80
ffffffffc0202a1a:	8419                	srai	s0,s0,0x6
ffffffffc0202a1c:	943e                	add	s0,s0,a5
ffffffffc0202a1e:	042a                	slli	s0,s0,0xa
ffffffffc0202a20:	8cc1                	or	s1,s1,s0
ffffffffc0202a22:	0014e493          	ori	s1,s1,1
ffffffffc0202a26:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2a:	120a0073          	sfence.vma	s4
ffffffffc0202a2e:	4501                	li	a0,0
ffffffffc0202a30:	70e2                	ld	ra,56(sp)
ffffffffc0202a32:	7442                	ld	s0,48(sp)
ffffffffc0202a34:	74a2                	ld	s1,40(sp)
ffffffffc0202a36:	7902                	ld	s2,32(sp)
ffffffffc0202a38:	69e2                	ld	s3,24(sp)
ffffffffc0202a3a:	6a42                	ld	s4,16(sp)
ffffffffc0202a3c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a3e:	6121                	addi	sp,sp,64
ffffffffc0202a40:	8082                	ret
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	83b1                	srli	a5,a5,0xc
ffffffffc0202a46:	00093717          	auipc	a4,0x93
ffffffffc0202a4a:	e5273703          	ld	a4,-430(a4) # ffffffffc0295898 <npage>
ffffffffc0202a4e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202acc <page_insert+0xf2>
ffffffffc0202a52:	00093a97          	auipc	s5,0x93
ffffffffc0202a56:	e4ea8a93          	addi	s5,s5,-434 # ffffffffc02958a0 <pages>
ffffffffc0202a5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202a5e:	fff80937          	lui	s2,0xfff80
ffffffffc0202a62:	993e                	add	s2,s2,a5
ffffffffc0202a64:	091a                	slli	s2,s2,0x6
ffffffffc0202a66:	993a                	add	s2,s2,a4
ffffffffc0202a68:	01240c63          	beq	s0,s2,ffffffffc0202a80 <page_insert+0xa6>
ffffffffc0202a6c:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcea6f8>
ffffffffc0202a70:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a74:	00d92023          	sw	a3,0(s2)
ffffffffc0202a78:	c691                	beqz	a3,ffffffffc0202a84 <page_insert+0xaa>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	bf59                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a80:	c014                	sw	a3,0(s0)
ffffffffc0202a82:	bf49                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a84:	100027f3          	csrr	a5,sstatus
ffffffffc0202a88:	8b89                	andi	a5,a5,2
ffffffffc0202a8a:	ef91                	bnez	a5,ffffffffc0202aa6 <page_insert+0xcc>
ffffffffc0202a8c:	00093797          	auipc	a5,0x93
ffffffffc0202a90:	e1c7b783          	ld	a5,-484(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc0202a94:	739c                	ld	a5,32(a5)
ffffffffc0202a96:	4585                	li	a1,1
ffffffffc0202a98:	854a                	mv	a0,s2
ffffffffc0202a9a:	9782                	jalr	a5
ffffffffc0202a9c:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa0:	120a0073          	sfence.vma	s4
ffffffffc0202aa4:	bf85                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202aa6:	9ccfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aaa:	00093797          	auipc	a5,0x93
ffffffffc0202aae:	dfe7b783          	ld	a5,-514(a5) # ffffffffc02958a8 <pmm_manager>
ffffffffc0202ab2:	739c                	ld	a5,32(a5)
ffffffffc0202ab4:	4585                	li	a1,1
ffffffffc0202ab6:	854a                	mv	a0,s2
ffffffffc0202ab8:	9782                	jalr	a5
ffffffffc0202aba:	9b2fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202abe:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac2:	120a0073          	sfence.vma	s4
ffffffffc0202ac6:	b7b9                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202ac8:	5571                	li	a0,-4
ffffffffc0202aca:	b79d                	j	ffffffffc0202a30 <page_insert+0x56>
ffffffffc0202acc:	e68ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202ad0 <pmm_init>:
ffffffffc0202ad0:	00009797          	auipc	a5,0x9
ffffffffc0202ad4:	86878793          	addi	a5,a5,-1944 # ffffffffc020b338 <default_pmm_manager>
ffffffffc0202ad8:	638c                	ld	a1,0(a5)
ffffffffc0202ada:	7159                	addi	sp,sp,-112
ffffffffc0202adc:	f85a                	sd	s6,48(sp)
ffffffffc0202ade:	00009517          	auipc	a0,0x9
ffffffffc0202ae2:	a2a50513          	addi	a0,a0,-1494 # ffffffffc020b508 <default_pmm_manager+0x1d0>
ffffffffc0202ae6:	00093b17          	auipc	s6,0x93
ffffffffc0202aea:	dc2b0b13          	addi	s6,s6,-574 # ffffffffc02958a8 <pmm_manager>
ffffffffc0202aee:	f486                	sd	ra,104(sp)
ffffffffc0202af0:	e8ca                	sd	s2,80(sp)
ffffffffc0202af2:	e4ce                	sd	s3,72(sp)
ffffffffc0202af4:	f0a2                	sd	s0,96(sp)
ffffffffc0202af6:	eca6                	sd	s1,88(sp)
ffffffffc0202af8:	e0d2                	sd	s4,64(sp)
ffffffffc0202afa:	fc56                	sd	s5,56(sp)
ffffffffc0202afc:	f45e                	sd	s7,40(sp)
ffffffffc0202afe:	f062                	sd	s8,32(sp)
ffffffffc0202b00:	ec66                	sd	s9,24(sp)
ffffffffc0202b02:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b06:	ea0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b0e:	00093997          	auipc	s3,0x93
ffffffffc0202b12:	da298993          	addi	s3,s3,-606 # ffffffffc02958b0 <va_pa_offset>
ffffffffc0202b16:	679c                	ld	a5,8(a5)
ffffffffc0202b18:	9782                	jalr	a5
ffffffffc0202b1a:	57f5                	li	a5,-3
ffffffffc0202b1c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b1e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b22:	f27fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b26:	892a                	mv	s2,a0
ffffffffc0202b28:	f2bfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b2c:	280502e3          	beqz	a0,ffffffffc02035b0 <pmm_init+0xae0>
ffffffffc0202b30:	84aa                	mv	s1,a0
ffffffffc0202b32:	00009517          	auipc	a0,0x9
ffffffffc0202b36:	a0e50513          	addi	a0,a0,-1522 # ffffffffc020b540 <default_pmm_manager+0x208>
ffffffffc0202b3a:	e6cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b3e:	00990433          	add	s0,s2,s1
ffffffffc0202b42:	fff40693          	addi	a3,s0,-1
ffffffffc0202b46:	864a                	mv	a2,s2
ffffffffc0202b48:	85a6                	mv	a1,s1
ffffffffc0202b4a:	00009517          	auipc	a0,0x9
ffffffffc0202b4e:	a0e50513          	addi	a0,a0,-1522 # ffffffffc020b558 <default_pmm_manager+0x220>
ffffffffc0202b52:	e54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b56:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5a:	87a2                	mv	a5,s0
ffffffffc0202b5c:	5e876e63          	bltu	a4,s0,ffffffffc0203158 <pmm_init+0x688>
ffffffffc0202b60:	757d                	lui	a0,0xfffff
ffffffffc0202b62:	00094617          	auipc	a2,0x94
ffffffffc0202b66:	da560613          	addi	a2,a2,-603 # ffffffffc0296907 <end+0xfff>
ffffffffc0202b6a:	8e69                	and	a2,a2,a0
ffffffffc0202b6c:	00093497          	auipc	s1,0x93
ffffffffc0202b70:	d2c48493          	addi	s1,s1,-724 # ffffffffc0295898 <npage>
ffffffffc0202b74:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b78:	00093b97          	auipc	s7,0x93
ffffffffc0202b7c:	d28b8b93          	addi	s7,s7,-728 # ffffffffc02958a0 <pages>
ffffffffc0202b80:	e088                	sd	a0,0(s1)
ffffffffc0202b82:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b86:	000807b7          	lui	a5,0x80
ffffffffc0202b8a:	86b2                	mv	a3,a2
ffffffffc0202b8c:	02f50863          	beq	a0,a5,ffffffffc0202bbc <pmm_init+0xec>
ffffffffc0202b90:	4781                	li	a5,0
ffffffffc0202b92:	4585                	li	a1,1
ffffffffc0202b94:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b98:	00679513          	slli	a0,a5,0x6
ffffffffc0202b9c:	9532                	add	a0,a0,a2
ffffffffc0202b9e:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd69700>
ffffffffc0202ba2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202ba6:	6088                	ld	a0,0(s1)
ffffffffc0202ba8:	0785                	addi	a5,a5,1
ffffffffc0202baa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bae:	00d50733          	add	a4,a0,a3
ffffffffc0202bb2:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b98 <pmm_init+0xc8>
ffffffffc0202bb6:	071a                	slli	a4,a4,0x6
ffffffffc0202bb8:	00e606b3          	add	a3,a2,a4
ffffffffc0202bbc:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc0:	3af6eae3          	bltu	a3,a5,ffffffffc0203774 <pmm_init+0xca4>
ffffffffc0202bc4:	0009b583          	ld	a1,0(s3)
ffffffffc0202bc8:	77fd                	lui	a5,0xfffff
ffffffffc0202bca:	8c7d                	and	s0,s0,a5
ffffffffc0202bcc:	8e8d                	sub	a3,a3,a1
ffffffffc0202bce:	5e86e363          	bltu	a3,s0,ffffffffc02031b4 <pmm_init+0x6e4>
ffffffffc0202bd2:	00009517          	auipc	a0,0x9
ffffffffc0202bd6:	9ae50513          	addi	a0,a0,-1618 # ffffffffc020b580 <default_pmm_manager+0x248>
ffffffffc0202bda:	dccfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	7b9c                	ld	a5,48(a5)
ffffffffc0202be4:	9782                	jalr	a5
ffffffffc0202be6:	00009517          	auipc	a0,0x9
ffffffffc0202bea:	9b250513          	addi	a0,a0,-1614 # ffffffffc020b598 <default_pmm_manager+0x260>
ffffffffc0202bee:	db8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf2:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf6:	8b89                	andi	a5,a5,2
ffffffffc0202bf8:	5a079363          	bnez	a5,ffffffffc020319e <pmm_init+0x6ce>
ffffffffc0202bfc:	000b3783          	ld	a5,0(s6)
ffffffffc0202c00:	4505                	li	a0,1
ffffffffc0202c02:	6f9c                	ld	a5,24(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
ffffffffc0202c08:	180408e3          	beqz	s0,ffffffffc0203598 <pmm_init+0xac8>
ffffffffc0202c0c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c10:	5a7d                	li	s4,-1
ffffffffc0202c12:	6098                	ld	a4,0(s1)
ffffffffc0202c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c18:	8699                	srai	a3,a3,0x6
ffffffffc0202c1a:	00080437          	lui	s0,0x80
ffffffffc0202c1e:	96a2                	add	a3,a3,s0
ffffffffc0202c20:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c24:	8ff5                	and	a5,a5,a3
ffffffffc0202c26:	06b2                	slli	a3,a3,0xc
ffffffffc0202c28:	30e7fde3          	bgeu	a5,a4,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202c2c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c30:	6605                	lui	a2,0x1
ffffffffc0202c32:	4581                	li	a1,0
ffffffffc0202c34:	9436                	add	s0,s0,a3
ffffffffc0202c36:	8522                	mv	a0,s0
ffffffffc0202c38:	730070ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0202c3c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c40:	77fd                	lui	a5,0xfffff
ffffffffc0202c42:	00008917          	auipc	s2,0x8
ffffffffc0202c46:	78f90913          	addi	s2,s2,1935 # ffffffffc020b3d1 <default_pmm_manager+0x99>
ffffffffc0202c4a:	00f97933          	and	s2,s2,a5
ffffffffc0202c4e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c52:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c56:	964a                	add	a2,a2,s2
ffffffffc0202c58:	4729                	li	a4,10
ffffffffc0202c5a:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c5e:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c62:	8522                	mv	a0,s0
ffffffffc0202c64:	fe8ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c68:	c8000637          	lui	a2,0xc8000
ffffffffc0202c6c:	41260633          	sub	a2,a2,s2
ffffffffc0202c70:	3f596ce3          	bltu	s2,s5,ffffffffc0203868 <pmm_init+0xd98>
ffffffffc0202c74:	0009b683          	ld	a3,0(s3)
ffffffffc0202c78:	85ca                	mv	a1,s2
ffffffffc0202c7a:	4719                	li	a4,6
ffffffffc0202c7c:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c80:	8522                	mv	a0,s0
ffffffffc0202c82:	00093917          	auipc	s2,0x93
ffffffffc0202c86:	c0e90913          	addi	s2,s2,-1010 # ffffffffc0295890 <boot_pgdir_va>
ffffffffc0202c8a:	fc2ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c8e:	00893023          	sd	s0,0(s2)
ffffffffc0202c92:	2d5464e3          	bltu	s0,s5,ffffffffc020375a <pmm_init+0xc8a>
ffffffffc0202c96:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9a:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202c9c:	8c1d                	sub	s0,s0,a5
ffffffffc0202c9e:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca2:	00093717          	auipc	a4,0x93
ffffffffc0202ca6:	be873323          	sd	s0,-1050(a4) # ffffffffc0295888 <boot_pgdir_pa>
ffffffffc0202caa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cae:	180a1073          	csrw	satp,s4
ffffffffc0202cb2:	12000073          	sfence.vma
ffffffffc0202cb6:	00009517          	auipc	a0,0x9
ffffffffc0202cba:	92250513          	addi	a0,a0,-1758 # ffffffffc020b5d8 <default_pmm_manager+0x2a0>
ffffffffc0202cbe:	ce8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc2:	0000d717          	auipc	a4,0xd
ffffffffc0202cc6:	33e70713          	addi	a4,a4,830 # ffffffffc0210000 <bootstack>
ffffffffc0202cca:	0000d797          	auipc	a5,0xd
ffffffffc0202cce:	33678793          	addi	a5,a5,822 # ffffffffc0210000 <bootstack>
ffffffffc0202cd2:	5cf70d63          	beq	a4,a5,ffffffffc02032ac <pmm_init+0x7dc>
ffffffffc0202cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0202cda:	8b89                	andi	a5,a5,2
ffffffffc0202cdc:	4a079763          	bnez	a5,ffffffffc020318a <pmm_init+0x6ba>
ffffffffc0202ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce4:	779c                	ld	a5,40(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	842a                	mv	s0,a0
ffffffffc0202cea:	6098                	ld	a4,0(s1)
ffffffffc0202cec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf0:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf2:	08e7e3e3          	bltu	a5,a4,ffffffffc0203578 <pmm_init+0xaa8>
ffffffffc0202cf6:	00093503          	ld	a0,0(s2)
ffffffffc0202cfa:	04050fe3          	beqz	a0,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202cfe:	03451793          	slli	a5,a0,0x34
ffffffffc0202d02:	04079be3          	bnez	a5,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202d06:	4601                	li	a2,0
ffffffffc0202d08:	4581                	li	a1,0
ffffffffc0202d0a:	809ff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202d0e:	2e0511e3          	bnez	a0,ffffffffc02037f0 <pmm_init+0xd20>
ffffffffc0202d12:	100027f3          	csrr	a5,sstatus
ffffffffc0202d16:	8b89                	andi	a5,a5,2
ffffffffc0202d18:	44079e63          	bnez	a5,ffffffffc0203174 <pmm_init+0x6a4>
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	4505                	li	a0,1
ffffffffc0202d22:	6f9c                	ld	a5,24(a5)
ffffffffc0202d24:	9782                	jalr	a5
ffffffffc0202d26:	8a2a                	mv	s4,a0
ffffffffc0202d28:	00093503          	ld	a0,0(s2)
ffffffffc0202d2c:	4681                	li	a3,0
ffffffffc0202d2e:	4601                	li	a2,0
ffffffffc0202d30:	85d2                	mv	a1,s4
ffffffffc0202d32:	ca9ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202d36:	26051be3          	bnez	a0,ffffffffc02037ac <pmm_init+0xcdc>
ffffffffc0202d3a:	00093503          	ld	a0,0(s2)
ffffffffc0202d3e:	4601                	li	a2,0
ffffffffc0202d40:	4581                	li	a1,0
ffffffffc0202d42:	ce2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202d46:	280505e3          	beqz	a0,ffffffffc02037d0 <pmm_init+0xd00>
ffffffffc0202d4a:	611c                	ld	a5,0(a0)
ffffffffc0202d4c:	0017f713          	andi	a4,a5,1
ffffffffc0202d50:	26070ee3          	beqz	a4,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202d54:	6098                	ld	a4,0(s1)
ffffffffc0202d56:	078a                	slli	a5,a5,0x2
ffffffffc0202d58:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5a:	62e7f363          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202d5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202d62:	fff80637          	lui	a2,0xfff80
ffffffffc0202d66:	97b2                	add	a5,a5,a2
ffffffffc0202d68:	079a                	slli	a5,a5,0x6
ffffffffc0202d6a:	97b6                	add	a5,a5,a3
ffffffffc0202d6c:	2afa12e3          	bne	s4,a5,ffffffffc0203810 <pmm_init+0xd40>
ffffffffc0202d70:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d74:	4785                	li	a5,1
ffffffffc0202d76:	2cf699e3          	bne	a3,a5,ffffffffc0203848 <pmm_init+0xd78>
ffffffffc0202d7a:	00093503          	ld	a0,0(s2)
ffffffffc0202d7e:	77fd                	lui	a5,0xfffff
ffffffffc0202d80:	6114                	ld	a3,0(a0)
ffffffffc0202d82:	068a                	slli	a3,a3,0x2
ffffffffc0202d84:	8efd                	and	a3,a3,a5
ffffffffc0202d86:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8a:	2ae673e3          	bgeu	a2,a4,ffffffffc0203830 <pmm_init+0xd60>
ffffffffc0202d8e:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d92:	96e2                	add	a3,a3,s8
ffffffffc0202d94:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fcea6f8>
ffffffffc0202d98:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9a:	00fafab3          	and	s5,s5,a5
ffffffffc0202d9e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203608 <pmm_init+0xb38>
ffffffffc0202da6:	4601                	li	a2,0
ffffffffc0202da8:	6585                	lui	a1,0x1
ffffffffc0202daa:	9ae2                	add	s5,s5,s8
ffffffffc0202dac:	c78ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202db0:	0aa1                	addi	s5,s5,8
ffffffffc0202db2:	03551be3          	bne	a0,s5,ffffffffc02035e8 <pmm_init+0xb18>
ffffffffc0202db6:	100027f3          	csrr	a5,sstatus
ffffffffc0202dba:	8b89                	andi	a5,a5,2
ffffffffc0202dbc:	3a079163          	bnez	a5,ffffffffc020315e <pmm_init+0x68e>
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	4505                	li	a0,1
ffffffffc0202dc6:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc8:	9782                	jalr	a5
ffffffffc0202dca:	8c2a                	mv	s8,a0
ffffffffc0202dcc:	00093503          	ld	a0,0(s2)
ffffffffc0202dd0:	46d1                	li	a3,20
ffffffffc0202dd2:	6605                	lui	a2,0x1
ffffffffc0202dd4:	85e2                	mv	a1,s8
ffffffffc0202dd6:	c05ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202dda:	1a0519e3          	bnez	a0,ffffffffc020378c <pmm_init+0xcbc>
ffffffffc0202dde:	00093503          	ld	a0,0(s2)
ffffffffc0202de2:	4601                	li	a2,0
ffffffffc0202de4:	6585                	lui	a1,0x1
ffffffffc0202de6:	c3eff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202dea:	10050ce3          	beqz	a0,ffffffffc0203702 <pmm_init+0xc32>
ffffffffc0202dee:	611c                	ld	a5,0(a0)
ffffffffc0202df0:	0107f713          	andi	a4,a5,16
ffffffffc0202df4:	0e0707e3          	beqz	a4,ffffffffc02036e2 <pmm_init+0xc12>
ffffffffc0202df8:	8b91                	andi	a5,a5,4
ffffffffc0202dfa:	0c0784e3          	beqz	a5,ffffffffc02036c2 <pmm_init+0xbf2>
ffffffffc0202dfe:	00093503          	ld	a0,0(s2)
ffffffffc0202e02:	611c                	ld	a5,0(a0)
ffffffffc0202e04:	8bc1                	andi	a5,a5,16
ffffffffc0202e06:	08078ee3          	beqz	a5,ffffffffc02036a2 <pmm_init+0xbd2>
ffffffffc0202e0a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e0e:	4785                	li	a5,1
ffffffffc0202e10:	06f719e3          	bne	a4,a5,ffffffffc0203682 <pmm_init+0xbb2>
ffffffffc0202e14:	4681                	li	a3,0
ffffffffc0202e16:	6605                	lui	a2,0x1
ffffffffc0202e18:	85d2                	mv	a1,s4
ffffffffc0202e1a:	bc1ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202e1e:	040512e3          	bnez	a0,ffffffffc0203662 <pmm_init+0xb92>
ffffffffc0202e22:	000a2703          	lw	a4,0(s4)
ffffffffc0202e26:	4789                	li	a5,2
ffffffffc0202e28:	00f71de3          	bne	a4,a5,ffffffffc0203642 <pmm_init+0xb72>
ffffffffc0202e2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e30:	7e079963          	bnez	a5,ffffffffc0203622 <pmm_init+0xb52>
ffffffffc0202e34:	00093503          	ld	a0,0(s2)
ffffffffc0202e38:	4601                	li	a2,0
ffffffffc0202e3a:	6585                	lui	a1,0x1
ffffffffc0202e3c:	be8ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202e40:	54050263          	beqz	a0,ffffffffc0203384 <pmm_init+0x8b4>
ffffffffc0202e44:	6118                	ld	a4,0(a0)
ffffffffc0202e46:	00177793          	andi	a5,a4,1
ffffffffc0202e4a:	180781e3          	beqz	a5,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202e4e:	6094                	ld	a3,0(s1)
ffffffffc0202e50:	00271793          	slli	a5,a4,0x2
ffffffffc0202e54:	83b1                	srli	a5,a5,0xc
ffffffffc0202e56:	52d7f563          	bgeu	a5,a3,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202e5a:	000bb683          	ld	a3,0(s7)
ffffffffc0202e5e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e62:	97d6                	add	a5,a5,s5
ffffffffc0202e64:	079a                	slli	a5,a5,0x6
ffffffffc0202e66:	97b6                	add	a5,a5,a3
ffffffffc0202e68:	58fa1e63          	bne	s4,a5,ffffffffc0203404 <pmm_init+0x934>
ffffffffc0202e6c:	8b41                	andi	a4,a4,16
ffffffffc0202e6e:	56071b63          	bnez	a4,ffffffffc02033e4 <pmm_init+0x914>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4581                	li	a1,0
ffffffffc0202e78:	ac7ff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e7c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e80:	4785                	li	a5,1
ffffffffc0202e82:	5cfc9163          	bne	s9,a5,ffffffffc0203444 <pmm_init+0x974>
ffffffffc0202e86:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8a:	58079d63          	bnez	a5,ffffffffc0203424 <pmm_init+0x954>
ffffffffc0202e8e:	00093503          	ld	a0,0(s2)
ffffffffc0202e92:	6585                	lui	a1,0x1
ffffffffc0202e94:	aabff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e98:	000a2783          	lw	a5,0(s4)
ffffffffc0202e9c:	200793e3          	bnez	a5,ffffffffc02038a2 <pmm_init+0xdd2>
ffffffffc0202ea0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea4:	1c079fe3          	bnez	a5,ffffffffc0203882 <pmm_init+0xdb2>
ffffffffc0202ea8:	00093a03          	ld	s4,0(s2)
ffffffffc0202eac:	608c                	ld	a1,0(s1)
ffffffffc0202eae:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb2:	068a                	slli	a3,a3,0x2
ffffffffc0202eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0202eb6:	4cb6f563          	bgeu	a3,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202eba:	000bb503          	ld	a0,0(s7)
ffffffffc0202ebe:	96d6                	add	a3,a3,s5
ffffffffc0202ec0:	069a                	slli	a3,a3,0x6
ffffffffc0202ec2:	00d507b3          	add	a5,a0,a3
ffffffffc0202ec6:	439c                	lw	a5,0(a5)
ffffffffc0202ec8:	4f979e63          	bne	a5,s9,ffffffffc02033c4 <pmm_init+0x8f4>
ffffffffc0202ecc:	8699                	srai	a3,a3,0x6
ffffffffc0202ece:	00080637          	lui	a2,0x80
ffffffffc0202ed2:	96b2                	add	a3,a3,a2
ffffffffc0202ed4:	00c69713          	slli	a4,a3,0xc
ffffffffc0202ed8:	8331                	srli	a4,a4,0xc
ffffffffc0202eda:	06b2                	slli	a3,a3,0xc
ffffffffc0202edc:	06b773e3          	bgeu	a4,a1,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202ee0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee4:	96ba                	add	a3,a3,a4
ffffffffc0202ee6:	629c                	ld	a5,0(a3)
ffffffffc0202ee8:	078a                	slli	a5,a5,0x2
ffffffffc0202eea:	83b1                	srli	a5,a5,0xc
ffffffffc0202eec:	48b7fa63          	bgeu	a5,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202ef0:	8f91                	sub	a5,a5,a2
ffffffffc0202ef2:	079a                	slli	a5,a5,0x6
ffffffffc0202ef4:	953e                	add	a0,a0,a5
ffffffffc0202ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0202efa:	8b89                	andi	a5,a5,2
ffffffffc0202efc:	32079463          	bnez	a5,ffffffffc0203224 <pmm_init+0x754>
ffffffffc0202f00:	000b3783          	ld	a5,0(s6)
ffffffffc0202f04:	4585                	li	a1,1
ffffffffc0202f06:	739c                	ld	a5,32(a5)
ffffffffc0202f08:	9782                	jalr	a5
ffffffffc0202f0a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f0e:	6098                	ld	a4,0(s1)
ffffffffc0202f10:	078a                	slli	a5,a5,0x2
ffffffffc0202f12:	83b1                	srli	a5,a5,0xc
ffffffffc0202f14:	46e7f663          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202f18:	000bb503          	ld	a0,0(s7)
ffffffffc0202f1c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f20:	97ba                	add	a5,a5,a4
ffffffffc0202f22:	079a                	slli	a5,a5,0x6
ffffffffc0202f24:	953e                	add	a0,a0,a5
ffffffffc0202f26:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2a:	8b89                	andi	a5,a5,2
ffffffffc0202f2c:	2e079063          	bnez	a5,ffffffffc020320c <pmm_init+0x73c>
ffffffffc0202f30:	000b3783          	ld	a5,0(s6)
ffffffffc0202f34:	4585                	li	a1,1
ffffffffc0202f36:	739c                	ld	a5,32(a5)
ffffffffc0202f38:	9782                	jalr	a5
ffffffffc0202f3a:	00093783          	ld	a5,0(s2)
ffffffffc0202f3e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd696f8>
ffffffffc0202f42:	12000073          	sfence.vma
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	2a079663          	bnez	a5,ffffffffc02031f8 <pmm_init+0x728>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	779c                	ld	a5,40(a5)
ffffffffc0202f56:	9782                	jalr	a5
ffffffffc0202f58:	8a2a                	mv	s4,a0
ffffffffc0202f5a:	7d441463          	bne	s0,s4,ffffffffc0203722 <pmm_init+0xc52>
ffffffffc0202f5e:	00009517          	auipc	a0,0x9
ffffffffc0202f62:	9d250513          	addi	a0,a0,-1582 # ffffffffc020b930 <default_pmm_manager+0x5f8>
ffffffffc0202f66:	a40fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f6e:	8b89                	andi	a5,a5,2
ffffffffc0202f70:	26079a63          	bnez	a5,ffffffffc02031e4 <pmm_init+0x714>
ffffffffc0202f74:	000b3783          	ld	a5,0(s6)
ffffffffc0202f78:	779c                	ld	a5,40(a5)
ffffffffc0202f7a:	9782                	jalr	a5
ffffffffc0202f7c:	8c2a                	mv	s8,a0
ffffffffc0202f7e:	6098                	ld	a4,0(s1)
ffffffffc0202f80:	c0200437          	lui	s0,0xc0200
ffffffffc0202f84:	7afd                	lui	s5,0xfffff
ffffffffc0202f86:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8a:	6a05                	lui	s4,0x1
ffffffffc0202f8c:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc4 <pmm_init+0x4f4>
ffffffffc0202f90:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f94:	00093503          	ld	a0,0(s2)
ffffffffc0202f98:	3ae7f763          	bgeu	a5,a4,ffffffffc0203346 <pmm_init+0x876>
ffffffffc0202f9c:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	95a2                	add	a1,a1,s0
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	36050f63          	beqz	a0,ffffffffc0203326 <pmm_init+0x856>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	078a                	slli	a5,a5,0x2
ffffffffc0202fb0:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb4:	3a879663          	bne	a5,s0,ffffffffc0203360 <pmm_init+0x890>
ffffffffc0202fb8:	6098                	ld	a4,0(s1)
ffffffffc0202fba:	9452                	add	s0,s0,s4
ffffffffc0202fbc:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc0:	fcf468e3          	bltu	s0,a5,ffffffffc0202f90 <pmm_init+0x4c0>
ffffffffc0202fc4:	00093783          	ld	a5,0(s2)
ffffffffc0202fc8:	639c                	ld	a5,0(a5)
ffffffffc0202fca:	48079d63          	bnez	a5,ffffffffc0203464 <pmm_init+0x994>
ffffffffc0202fce:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd2:	8b89                	andi	a5,a5,2
ffffffffc0202fd4:	26079463          	bnez	a5,ffffffffc020323c <pmm_init+0x76c>
ffffffffc0202fd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202fdc:	4505                	li	a0,1
ffffffffc0202fde:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe0:	9782                	jalr	a5
ffffffffc0202fe2:	8a2a                	mv	s4,a0
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	4699                	li	a3,6
ffffffffc0202fea:	10000613          	li	a2,256
ffffffffc0202fee:	85d2                	mv	a1,s4
ffffffffc0202ff0:	9ebff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202ff4:	4a051863          	bnez	a0,ffffffffc02034a4 <pmm_init+0x9d4>
ffffffffc0202ff8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202ffc:	4785                	li	a5,1
ffffffffc0202ffe:	48f71363          	bne	a4,a5,ffffffffc0203484 <pmm_init+0x9b4>
ffffffffc0203002:	00093503          	ld	a0,0(s2)
ffffffffc0203006:	6405                	lui	s0,0x1
ffffffffc0203008:	4699                	li	a3,6
ffffffffc020300a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020300e:	85d2                	mv	a1,s4
ffffffffc0203010:	9cbff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203014:	38051863          	bnez	a0,ffffffffc02033a4 <pmm_init+0x8d4>
ffffffffc0203018:	000a2703          	lw	a4,0(s4)
ffffffffc020301c:	4789                	li	a5,2
ffffffffc020301e:	4ef71363          	bne	a4,a5,ffffffffc0203504 <pmm_init+0xa34>
ffffffffc0203022:	00009597          	auipc	a1,0x9
ffffffffc0203026:	a5658593          	addi	a1,a1,-1450 # ffffffffc020ba78 <default_pmm_manager+0x740>
ffffffffc020302a:	10000513          	li	a0,256
ffffffffc020302e:	2ce070ef          	jal	ra,ffffffffc020a2fc <strcpy>
ffffffffc0203032:	10040593          	addi	a1,s0,256
ffffffffc0203036:	10000513          	li	a0,256
ffffffffc020303a:	2d4070ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc020303e:	4a051363          	bnez	a0,ffffffffc02034e4 <pmm_init+0xa14>
ffffffffc0203042:	000bb683          	ld	a3,0(s7)
ffffffffc0203046:	00080737          	lui	a4,0x80
ffffffffc020304a:	547d                	li	s0,-1
ffffffffc020304c:	40da06b3          	sub	a3,s4,a3
ffffffffc0203050:	8699                	srai	a3,a3,0x6
ffffffffc0203052:	609c                	ld	a5,0(s1)
ffffffffc0203054:	96ba                	add	a3,a3,a4
ffffffffc0203056:	8031                	srli	s0,s0,0xc
ffffffffc0203058:	0086f733          	and	a4,a3,s0
ffffffffc020305c:	06b2                	slli	a3,a3,0xc
ffffffffc020305e:	6ef77263          	bgeu	a4,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203062:	0009b783          	ld	a5,0(s3)
ffffffffc0203066:	10000513          	li	a0,256
ffffffffc020306a:	96be                	add	a3,a3,a5
ffffffffc020306c:	10068023          	sb	zero,256(a3)
ffffffffc0203070:	256070ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc0203074:	44051863          	bnez	a0,ffffffffc02034c4 <pmm_init+0x9f4>
ffffffffc0203078:	00093a83          	ld	s5,0(s2)
ffffffffc020307c:	609c                	ld	a5,0(s1)
ffffffffc020307e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd696f8>
ffffffffc0203082:	068a                	slli	a3,a3,0x2
ffffffffc0203084:	82b1                	srli	a3,a3,0xc
ffffffffc0203086:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc020308a:	8c75                	and	s0,s0,a3
ffffffffc020308c:	06b2                	slli	a3,a3,0xc
ffffffffc020308e:	6af47a63          	bgeu	s0,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203092:	0009b403          	ld	s0,0(s3)
ffffffffc0203096:	9436                	add	s0,s0,a3
ffffffffc0203098:	100027f3          	csrr	a5,sstatus
ffffffffc020309c:	8b89                	andi	a5,a5,2
ffffffffc020309e:	1e079c63          	bnez	a5,ffffffffc0203296 <pmm_init+0x7c6>
ffffffffc02030a2:	000b3783          	ld	a5,0(s6)
ffffffffc02030a6:	4585                	li	a1,1
ffffffffc02030a8:	8552                	mv	a0,s4
ffffffffc02030aa:	739c                	ld	a5,32(a5)
ffffffffc02030ac:	9782                	jalr	a5
ffffffffc02030ae:	601c                	ld	a5,0(s0)
ffffffffc02030b0:	6098                	ld	a4,0(s1)
ffffffffc02030b2:	078a                	slli	a5,a5,0x2
ffffffffc02030b4:	83b1                	srli	a5,a5,0xc
ffffffffc02030b6:	2ce7f563          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ba:	000bb503          	ld	a0,0(s7)
ffffffffc02030be:	fff80737          	lui	a4,0xfff80
ffffffffc02030c2:	97ba                	add	a5,a5,a4
ffffffffc02030c4:	079a                	slli	a5,a5,0x6
ffffffffc02030c6:	953e                	add	a0,a0,a5
ffffffffc02030c8:	100027f3          	csrr	a5,sstatus
ffffffffc02030cc:	8b89                	andi	a5,a5,2
ffffffffc02030ce:	1a079863          	bnez	a5,ffffffffc020327e <pmm_init+0x7ae>
ffffffffc02030d2:	000b3783          	ld	a5,0(s6)
ffffffffc02030d6:	4585                	li	a1,1
ffffffffc02030d8:	739c                	ld	a5,32(a5)
ffffffffc02030da:	9782                	jalr	a5
ffffffffc02030dc:	000ab783          	ld	a5,0(s5)
ffffffffc02030e0:	6098                	ld	a4,0(s1)
ffffffffc02030e2:	078a                	slli	a5,a5,0x2
ffffffffc02030e4:	83b1                	srli	a5,a5,0xc
ffffffffc02030e6:	28e7fd63          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ea:	000bb503          	ld	a0,0(s7)
ffffffffc02030ee:	fff80737          	lui	a4,0xfff80
ffffffffc02030f2:	97ba                	add	a5,a5,a4
ffffffffc02030f4:	079a                	slli	a5,a5,0x6
ffffffffc02030f6:	953e                	add	a0,a0,a5
ffffffffc02030f8:	100027f3          	csrr	a5,sstatus
ffffffffc02030fc:	8b89                	andi	a5,a5,2
ffffffffc02030fe:	16079463          	bnez	a5,ffffffffc0203266 <pmm_init+0x796>
ffffffffc0203102:	000b3783          	ld	a5,0(s6)
ffffffffc0203106:	4585                	li	a1,1
ffffffffc0203108:	739c                	ld	a5,32(a5)
ffffffffc020310a:	9782                	jalr	a5
ffffffffc020310c:	00093783          	ld	a5,0(s2)
ffffffffc0203110:	0007b023          	sd	zero,0(a5)
ffffffffc0203114:	12000073          	sfence.vma
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	12079a63          	bnez	a5,ffffffffc0203252 <pmm_init+0x782>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	779c                	ld	a5,40(a5)
ffffffffc0203128:	9782                	jalr	a5
ffffffffc020312a:	842a                	mv	s0,a0
ffffffffc020312c:	488c1e63          	bne	s8,s0,ffffffffc02035c8 <pmm_init+0xaf8>
ffffffffc0203130:	00009517          	auipc	a0,0x9
ffffffffc0203134:	9c050513          	addi	a0,a0,-1600 # ffffffffc020baf0 <default_pmm_manager+0x7b8>
ffffffffc0203138:	86efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020313c:	7406                	ld	s0,96(sp)
ffffffffc020313e:	70a6                	ld	ra,104(sp)
ffffffffc0203140:	64e6                	ld	s1,88(sp)
ffffffffc0203142:	6946                	ld	s2,80(sp)
ffffffffc0203144:	69a6                	ld	s3,72(sp)
ffffffffc0203146:	6a06                	ld	s4,64(sp)
ffffffffc0203148:	7ae2                	ld	s5,56(sp)
ffffffffc020314a:	7b42                	ld	s6,48(sp)
ffffffffc020314c:	7ba2                	ld	s7,40(sp)
ffffffffc020314e:	7c02                	ld	s8,32(sp)
ffffffffc0203150:	6ce2                	ld	s9,24(sp)
ffffffffc0203152:	6165                	addi	sp,sp,112
ffffffffc0203154:	e17fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203158:	c80007b7          	lui	a5,0xc8000
ffffffffc020315c:	b411                	j	ffffffffc0202b60 <pmm_init+0x90>
ffffffffc020315e:	b15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203162:	000b3783          	ld	a5,0(s6)
ffffffffc0203166:	4505                	li	a0,1
ffffffffc0203168:	6f9c                	ld	a5,24(a5)
ffffffffc020316a:	9782                	jalr	a5
ffffffffc020316c:	8c2a                	mv	s8,a0
ffffffffc020316e:	afffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203172:	b9a9                	j	ffffffffc0202dcc <pmm_init+0x2fc>
ffffffffc0203174:	afffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203178:	000b3783          	ld	a5,0(s6)
ffffffffc020317c:	4505                	li	a0,1
ffffffffc020317e:	6f9c                	ld	a5,24(a5)
ffffffffc0203180:	9782                	jalr	a5
ffffffffc0203182:	8a2a                	mv	s4,a0
ffffffffc0203184:	ae9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203188:	b645                	j	ffffffffc0202d28 <pmm_init+0x258>
ffffffffc020318a:	ae9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020318e:	000b3783          	ld	a5,0(s6)
ffffffffc0203192:	779c                	ld	a5,40(a5)
ffffffffc0203194:	9782                	jalr	a5
ffffffffc0203196:	842a                	mv	s0,a0
ffffffffc0203198:	ad5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020319c:	b6b9                	j	ffffffffc0202cea <pmm_init+0x21a>
ffffffffc020319e:	ad5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a2:	000b3783          	ld	a5,0(s6)
ffffffffc02031a6:	4505                	li	a0,1
ffffffffc02031a8:	6f9c                	ld	a5,24(a5)
ffffffffc02031aa:	9782                	jalr	a5
ffffffffc02031ac:	842a                	mv	s0,a0
ffffffffc02031ae:	abffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b2:	bc99                	j	ffffffffc0202c08 <pmm_init+0x138>
ffffffffc02031b4:	6705                	lui	a4,0x1
ffffffffc02031b6:	177d                	addi	a4,a4,-1
ffffffffc02031b8:	96ba                	add	a3,a3,a4
ffffffffc02031ba:	8ff5                	and	a5,a5,a3
ffffffffc02031bc:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c0:	1ca77063          	bgeu	a4,a0,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02031c4:	000b3683          	ld	a3,0(s6)
ffffffffc02031c8:	fff80537          	lui	a0,0xfff80
ffffffffc02031cc:	972a                	add	a4,a4,a0
ffffffffc02031ce:	6a94                	ld	a3,16(a3)
ffffffffc02031d0:	8c1d                	sub	s0,s0,a5
ffffffffc02031d2:	00671513          	slli	a0,a4,0x6
ffffffffc02031d6:	00c45593          	srli	a1,s0,0xc
ffffffffc02031da:	9532                	add	a0,a0,a2
ffffffffc02031dc:	9682                	jalr	a3
ffffffffc02031de:	0009b583          	ld	a1,0(s3)
ffffffffc02031e2:	bac5                	j	ffffffffc0202bd2 <pmm_init+0x102>
ffffffffc02031e4:	a8ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031e8:	000b3783          	ld	a5,0(s6)
ffffffffc02031ec:	779c                	ld	a5,40(a5)
ffffffffc02031ee:	9782                	jalr	a5
ffffffffc02031f0:	8c2a                	mv	s8,a0
ffffffffc02031f2:	a7bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031f6:	b361                	j	ffffffffc0202f7e <pmm_init+0x4ae>
ffffffffc02031f8:	a7bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031fc:	000b3783          	ld	a5,0(s6)
ffffffffc0203200:	779c                	ld	a5,40(a5)
ffffffffc0203202:	9782                	jalr	a5
ffffffffc0203204:	8a2a                	mv	s4,a0
ffffffffc0203206:	a67fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320a:	bb81                	j	ffffffffc0202f5a <pmm_init+0x48a>
ffffffffc020320c:	e42a                	sd	a0,8(sp)
ffffffffc020320e:	a65fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203212:	000b3783          	ld	a5,0(s6)
ffffffffc0203216:	6522                	ld	a0,8(sp)
ffffffffc0203218:	4585                	li	a1,1
ffffffffc020321a:	739c                	ld	a5,32(a5)
ffffffffc020321c:	9782                	jalr	a5
ffffffffc020321e:	a4ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203222:	bb21                	j	ffffffffc0202f3a <pmm_init+0x46a>
ffffffffc0203224:	e42a                	sd	a0,8(sp)
ffffffffc0203226:	a4dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322a:	000b3783          	ld	a5,0(s6)
ffffffffc020322e:	6522                	ld	a0,8(sp)
ffffffffc0203230:	4585                	li	a1,1
ffffffffc0203232:	739c                	ld	a5,32(a5)
ffffffffc0203234:	9782                	jalr	a5
ffffffffc0203236:	a37fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323a:	b9c1                	j	ffffffffc0202f0a <pmm_init+0x43a>
ffffffffc020323c:	a37fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203240:	000b3783          	ld	a5,0(s6)
ffffffffc0203244:	4505                	li	a0,1
ffffffffc0203246:	6f9c                	ld	a5,24(a5)
ffffffffc0203248:	9782                	jalr	a5
ffffffffc020324a:	8a2a                	mv	s4,a0
ffffffffc020324c:	a21fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203250:	bb51                	j	ffffffffc0202fe4 <pmm_init+0x514>
ffffffffc0203252:	a21fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203256:	000b3783          	ld	a5,0(s6)
ffffffffc020325a:	779c                	ld	a5,40(a5)
ffffffffc020325c:	9782                	jalr	a5
ffffffffc020325e:	842a                	mv	s0,a0
ffffffffc0203260:	a0dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203264:	b5e1                	j	ffffffffc020312c <pmm_init+0x65c>
ffffffffc0203266:	e42a                	sd	a0,8(sp)
ffffffffc0203268:	a0bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020326c:	000b3783          	ld	a5,0(s6)
ffffffffc0203270:	6522                	ld	a0,8(sp)
ffffffffc0203272:	4585                	li	a1,1
ffffffffc0203274:	739c                	ld	a5,32(a5)
ffffffffc0203276:	9782                	jalr	a5
ffffffffc0203278:	9f5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020327c:	bd41                	j	ffffffffc020310c <pmm_init+0x63c>
ffffffffc020327e:	e42a                	sd	a0,8(sp)
ffffffffc0203280:	9f3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203284:	000b3783          	ld	a5,0(s6)
ffffffffc0203288:	6522                	ld	a0,8(sp)
ffffffffc020328a:	4585                	li	a1,1
ffffffffc020328c:	739c                	ld	a5,32(a5)
ffffffffc020328e:	9782                	jalr	a5
ffffffffc0203290:	9ddfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203294:	b5a1                	j	ffffffffc02030dc <pmm_init+0x60c>
ffffffffc0203296:	9ddfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329a:	000b3783          	ld	a5,0(s6)
ffffffffc020329e:	4585                	li	a1,1
ffffffffc02032a0:	8552                	mv	a0,s4
ffffffffc02032a2:	739c                	ld	a5,32(a5)
ffffffffc02032a4:	9782                	jalr	a5
ffffffffc02032a6:	9c7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032aa:	b511                	j	ffffffffc02030ae <pmm_init+0x5de>
ffffffffc02032ac:	0000f417          	auipc	s0,0xf
ffffffffc02032b0:	d5440413          	addi	s0,s0,-684 # ffffffffc0212000 <boot_page_table_sv39>
ffffffffc02032b4:	0000f797          	auipc	a5,0xf
ffffffffc02032b8:	d4c78793          	addi	a5,a5,-692 # ffffffffc0212000 <boot_page_table_sv39>
ffffffffc02032bc:	a0f41de3          	bne	s0,a5,ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	6605                	lui	a2,0x1
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	0a2070ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc02032ca:	0000c597          	auipc	a1,0xc
ffffffffc02032ce:	d3658593          	addi	a1,a1,-714 # ffffffffc020f000 <bootstackguard>
ffffffffc02032d2:	0000d797          	auipc	a5,0xd
ffffffffc02032d6:	d20786a3          	sb	zero,-723(a5) # ffffffffc020ffff <bootstackguard+0xfff>
ffffffffc02032da:	0000c797          	auipc	a5,0xc
ffffffffc02032de:	d2078323          	sb	zero,-730(a5) # ffffffffc020f000 <bootstackguard>
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	2555ec63          	bltu	a1,s5,ffffffffc020353e <pmm_init+0xa6e>
ffffffffc02032ea:	0009b683          	ld	a3,0(s3)
ffffffffc02032ee:	4701                	li	a4,0
ffffffffc02032f0:	6605                	lui	a2,0x1
ffffffffc02032f2:	40d586b3          	sub	a3,a1,a3
ffffffffc02032f6:	956ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02032fa:	00093503          	ld	a0,0(s2)
ffffffffc02032fe:	23546363          	bltu	s0,s5,ffffffffc0203524 <pmm_init+0xa54>
ffffffffc0203302:	0009b683          	ld	a3,0(s3)
ffffffffc0203306:	4701                	li	a4,0
ffffffffc0203308:	6605                	lui	a2,0x1
ffffffffc020330a:	40d406b3          	sub	a3,s0,a3
ffffffffc020330e:	85a2                	mv	a1,s0
ffffffffc0203310:	93cff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0203314:	12000073          	sfence.vma
ffffffffc0203318:	00008517          	auipc	a0,0x8
ffffffffc020331c:	2e850513          	addi	a0,a0,744 # ffffffffc020b600 <default_pmm_manager+0x2c8>
ffffffffc0203320:	e87fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203324:	ba4d                	j	ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc0203326:	00008697          	auipc	a3,0x8
ffffffffc020332a:	62a68693          	addi	a3,a3,1578 # ffffffffc020b950 <default_pmm_manager+0x618>
ffffffffc020332e:	00007617          	auipc	a2,0x7
ffffffffc0203332:	52260613          	addi	a2,a2,1314 # ffffffffc020a850 <commands+0x210>
ffffffffc0203336:	28500593          	li	a1,645
ffffffffc020333a:	00008517          	auipc	a0,0x8
ffffffffc020333e:	14e50513          	addi	a0,a0,334 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203342:	95cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203346:	86a2                	mv	a3,s0
ffffffffc0203348:	00008617          	auipc	a2,0x8
ffffffffc020334c:	02860613          	addi	a2,a2,40 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0203350:	28500593          	li	a1,645
ffffffffc0203354:	00008517          	auipc	a0,0x8
ffffffffc0203358:	13450513          	addi	a0,a0,308 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020335c:	942fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203360:	00008697          	auipc	a3,0x8
ffffffffc0203364:	63068693          	addi	a3,a3,1584 # ffffffffc020b990 <default_pmm_manager+0x658>
ffffffffc0203368:	00007617          	auipc	a2,0x7
ffffffffc020336c:	4e860613          	addi	a2,a2,1256 # ffffffffc020a850 <commands+0x210>
ffffffffc0203370:	28600593          	li	a1,646
ffffffffc0203374:	00008517          	auipc	a0,0x8
ffffffffc0203378:	11450513          	addi	a0,a0,276 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020337c:	922fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203380:	db5fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203384:	00008697          	auipc	a3,0x8
ffffffffc0203388:	43468693          	addi	a3,a3,1076 # ffffffffc020b7b8 <default_pmm_manager+0x480>
ffffffffc020338c:	00007617          	auipc	a2,0x7
ffffffffc0203390:	4c460613          	addi	a2,a2,1220 # ffffffffc020a850 <commands+0x210>
ffffffffc0203394:	26200593          	li	a1,610
ffffffffc0203398:	00008517          	auipc	a0,0x8
ffffffffc020339c:	0f050513          	addi	a0,a0,240 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02033a0:	8fefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a4:	00008697          	auipc	a3,0x8
ffffffffc02033a8:	67468693          	addi	a3,a3,1652 # ffffffffc020ba18 <default_pmm_manager+0x6e0>
ffffffffc02033ac:	00007617          	auipc	a2,0x7
ffffffffc02033b0:	4a460613          	addi	a2,a2,1188 # ffffffffc020a850 <commands+0x210>
ffffffffc02033b4:	28f00593          	li	a1,655
ffffffffc02033b8:	00008517          	auipc	a0,0x8
ffffffffc02033bc:	0d050513          	addi	a0,a0,208 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02033c0:	8defd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c4:	00008697          	auipc	a3,0x8
ffffffffc02033c8:	51468693          	addi	a3,a3,1300 # ffffffffc020b8d8 <default_pmm_manager+0x5a0>
ffffffffc02033cc:	00007617          	auipc	a2,0x7
ffffffffc02033d0:	48460613          	addi	a2,a2,1156 # ffffffffc020a850 <commands+0x210>
ffffffffc02033d4:	26e00593          	li	a1,622
ffffffffc02033d8:	00008517          	auipc	a0,0x8
ffffffffc02033dc:	0b050513          	addi	a0,a0,176 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02033e0:	8befd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e4:	00008697          	auipc	a3,0x8
ffffffffc02033e8:	4c468693          	addi	a3,a3,1220 # ffffffffc020b8a8 <default_pmm_manager+0x570>
ffffffffc02033ec:	00007617          	auipc	a2,0x7
ffffffffc02033f0:	46460613          	addi	a2,a2,1124 # ffffffffc020a850 <commands+0x210>
ffffffffc02033f4:	26400593          	li	a1,612
ffffffffc02033f8:	00008517          	auipc	a0,0x8
ffffffffc02033fc:	09050513          	addi	a0,a0,144 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203400:	89efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203404:	00008697          	auipc	a3,0x8
ffffffffc0203408:	31468693          	addi	a3,a3,788 # ffffffffc020b718 <default_pmm_manager+0x3e0>
ffffffffc020340c:	00007617          	auipc	a2,0x7
ffffffffc0203410:	44460613          	addi	a2,a2,1092 # ffffffffc020a850 <commands+0x210>
ffffffffc0203414:	26300593          	li	a1,611
ffffffffc0203418:	00008517          	auipc	a0,0x8
ffffffffc020341c:	07050513          	addi	a0,a0,112 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203420:	87efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203424:	00008697          	auipc	a3,0x8
ffffffffc0203428:	46c68693          	addi	a3,a3,1132 # ffffffffc020b890 <default_pmm_manager+0x558>
ffffffffc020342c:	00007617          	auipc	a2,0x7
ffffffffc0203430:	42460613          	addi	a2,a2,1060 # ffffffffc020a850 <commands+0x210>
ffffffffc0203434:	26800593          	li	a1,616
ffffffffc0203438:	00008517          	auipc	a0,0x8
ffffffffc020343c:	05050513          	addi	a0,a0,80 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203440:	85efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203444:	00008697          	auipc	a3,0x8
ffffffffc0203448:	2ec68693          	addi	a3,a3,748 # ffffffffc020b730 <default_pmm_manager+0x3f8>
ffffffffc020344c:	00007617          	auipc	a2,0x7
ffffffffc0203450:	40460613          	addi	a2,a2,1028 # ffffffffc020a850 <commands+0x210>
ffffffffc0203454:	26700593          	li	a1,615
ffffffffc0203458:	00008517          	auipc	a0,0x8
ffffffffc020345c:	03050513          	addi	a0,a0,48 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203460:	83efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203464:	00008697          	auipc	a3,0x8
ffffffffc0203468:	54468693          	addi	a3,a3,1348 # ffffffffc020b9a8 <default_pmm_manager+0x670>
ffffffffc020346c:	00007617          	auipc	a2,0x7
ffffffffc0203470:	3e460613          	addi	a2,a2,996 # ffffffffc020a850 <commands+0x210>
ffffffffc0203474:	28900593          	li	a1,649
ffffffffc0203478:	00008517          	auipc	a0,0x8
ffffffffc020347c:	01050513          	addi	a0,a0,16 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203480:	81efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203484:	00008697          	auipc	a3,0x8
ffffffffc0203488:	57c68693          	addi	a3,a3,1404 # ffffffffc020ba00 <default_pmm_manager+0x6c8>
ffffffffc020348c:	00007617          	auipc	a2,0x7
ffffffffc0203490:	3c460613          	addi	a2,a2,964 # ffffffffc020a850 <commands+0x210>
ffffffffc0203494:	28e00593          	li	a1,654
ffffffffc0203498:	00008517          	auipc	a0,0x8
ffffffffc020349c:	ff050513          	addi	a0,a0,-16 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02034a0:	ffffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a4:	00008697          	auipc	a3,0x8
ffffffffc02034a8:	51c68693          	addi	a3,a3,1308 # ffffffffc020b9c0 <default_pmm_manager+0x688>
ffffffffc02034ac:	00007617          	auipc	a2,0x7
ffffffffc02034b0:	3a460613          	addi	a2,a2,932 # ffffffffc020a850 <commands+0x210>
ffffffffc02034b4:	28d00593          	li	a1,653
ffffffffc02034b8:	00008517          	auipc	a0,0x8
ffffffffc02034bc:	fd050513          	addi	a0,a0,-48 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02034c0:	fdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c4:	00008697          	auipc	a3,0x8
ffffffffc02034c8:	60468693          	addi	a3,a3,1540 # ffffffffc020bac8 <default_pmm_manager+0x790>
ffffffffc02034cc:	00007617          	auipc	a2,0x7
ffffffffc02034d0:	38460613          	addi	a2,a2,900 # ffffffffc020a850 <commands+0x210>
ffffffffc02034d4:	29700593          	li	a1,663
ffffffffc02034d8:	00008517          	auipc	a0,0x8
ffffffffc02034dc:	fb050513          	addi	a0,a0,-80 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02034e0:	fbffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e4:	00008697          	auipc	a3,0x8
ffffffffc02034e8:	5ac68693          	addi	a3,a3,1452 # ffffffffc020ba90 <default_pmm_manager+0x758>
ffffffffc02034ec:	00007617          	auipc	a2,0x7
ffffffffc02034f0:	36460613          	addi	a2,a2,868 # ffffffffc020a850 <commands+0x210>
ffffffffc02034f4:	29400593          	li	a1,660
ffffffffc02034f8:	00008517          	auipc	a0,0x8
ffffffffc02034fc:	f9050513          	addi	a0,a0,-112 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	00008697          	auipc	a3,0x8
ffffffffc0203508:	55c68693          	addi	a3,a3,1372 # ffffffffc020ba60 <default_pmm_manager+0x728>
ffffffffc020350c:	00007617          	auipc	a2,0x7
ffffffffc0203510:	34460613          	addi	a2,a2,836 # ffffffffc020a850 <commands+0x210>
ffffffffc0203514:	29000593          	li	a1,656
ffffffffc0203518:	00008517          	auipc	a0,0x8
ffffffffc020351c:	f7050513          	addi	a0,a0,-144 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203520:	f7ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203524:	86a2                	mv	a3,s0
ffffffffc0203526:	00008617          	auipc	a2,0x8
ffffffffc020352a:	ef260613          	addi	a2,a2,-270 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc020352e:	0dc00593          	li	a1,220
ffffffffc0203532:	00008517          	auipc	a0,0x8
ffffffffc0203536:	f5650513          	addi	a0,a0,-170 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	86ae                	mv	a3,a1
ffffffffc0203540:	00008617          	auipc	a2,0x8
ffffffffc0203544:	ed860613          	addi	a2,a2,-296 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc0203548:	0db00593          	li	a1,219
ffffffffc020354c:	00008517          	auipc	a0,0x8
ffffffffc0203550:	f3c50513          	addi	a0,a0,-196 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	00008697          	auipc	a3,0x8
ffffffffc020355c:	0f068693          	addi	a3,a3,240 # ffffffffc020b648 <default_pmm_manager+0x310>
ffffffffc0203560:	00007617          	auipc	a2,0x7
ffffffffc0203564:	2f060613          	addi	a2,a2,752 # ffffffffc020a850 <commands+0x210>
ffffffffc0203568:	24700593          	li	a1,583
ffffffffc020356c:	00008517          	auipc	a0,0x8
ffffffffc0203570:	f1c50513          	addi	a0,a0,-228 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	00008697          	auipc	a3,0x8
ffffffffc020357c:	0b068693          	addi	a3,a3,176 # ffffffffc020b628 <default_pmm_manager+0x2f0>
ffffffffc0203580:	00007617          	auipc	a2,0x7
ffffffffc0203584:	2d060613          	addi	a2,a2,720 # ffffffffc020a850 <commands+0x210>
ffffffffc0203588:	24600593          	li	a1,582
ffffffffc020358c:	00008517          	auipc	a0,0x8
ffffffffc0203590:	efc50513          	addi	a0,a0,-260 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	00008617          	auipc	a2,0x8
ffffffffc020359c:	02060613          	addi	a2,a2,32 # ffffffffc020b5b8 <default_pmm_manager+0x280>
ffffffffc02035a0:	0aa00593          	li	a1,170
ffffffffc02035a4:	00008517          	auipc	a0,0x8
ffffffffc02035a8:	ee450513          	addi	a0,a0,-284 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02035ac:	ef3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b0:	00008617          	auipc	a2,0x8
ffffffffc02035b4:	f7060613          	addi	a2,a2,-144 # ffffffffc020b520 <default_pmm_manager+0x1e8>
ffffffffc02035b8:	06500593          	li	a1,101
ffffffffc02035bc:	00008517          	auipc	a0,0x8
ffffffffc02035c0:	ecc50513          	addi	a0,a0,-308 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00008697          	auipc	a3,0x8
ffffffffc02035cc:	34068693          	addi	a3,a3,832 # ffffffffc020b908 <default_pmm_manager+0x5d0>
ffffffffc02035d0:	00007617          	auipc	a2,0x7
ffffffffc02035d4:	28060613          	addi	a2,a2,640 # ffffffffc020a850 <commands+0x210>
ffffffffc02035d8:	2a000593          	li	a1,672
ffffffffc02035dc:	00008517          	auipc	a0,0x8
ffffffffc02035e0:	eac50513          	addi	a0,a0,-340 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00008697          	auipc	a3,0x8
ffffffffc02035ec:	16068693          	addi	a3,a3,352 # ffffffffc020b748 <default_pmm_manager+0x410>
ffffffffc02035f0:	00007617          	auipc	a2,0x7
ffffffffc02035f4:	26060613          	addi	a2,a2,608 # ffffffffc020a850 <commands+0x210>
ffffffffc02035f8:	25500593          	li	a1,597
ffffffffc02035fc:	00008517          	auipc	a0,0x8
ffffffffc0203600:	e8c50513          	addi	a0,a0,-372 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203604:	e9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203608:	86d6                	mv	a3,s5
ffffffffc020360a:	00008617          	auipc	a2,0x8
ffffffffc020360e:	d6660613          	addi	a2,a2,-666 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0203612:	25400593          	li	a1,596
ffffffffc0203616:	00008517          	auipc	a0,0x8
ffffffffc020361a:	e7250513          	addi	a0,a0,-398 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00008697          	auipc	a3,0x8
ffffffffc0203626:	26e68693          	addi	a3,a3,622 # ffffffffc020b890 <default_pmm_manager+0x558>
ffffffffc020362a:	00007617          	auipc	a2,0x7
ffffffffc020362e:	22660613          	addi	a2,a2,550 # ffffffffc020a850 <commands+0x210>
ffffffffc0203632:	26100593          	li	a1,609
ffffffffc0203636:	00008517          	auipc	a0,0x8
ffffffffc020363a:	e5250513          	addi	a0,a0,-430 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00008697          	auipc	a3,0x8
ffffffffc0203646:	23668693          	addi	a3,a3,566 # ffffffffc020b878 <default_pmm_manager+0x540>
ffffffffc020364a:	00007617          	auipc	a2,0x7
ffffffffc020364e:	20660613          	addi	a2,a2,518 # ffffffffc020a850 <commands+0x210>
ffffffffc0203652:	26000593          	li	a1,608
ffffffffc0203656:	00008517          	auipc	a0,0x8
ffffffffc020365a:	e3250513          	addi	a0,a0,-462 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00008697          	auipc	a3,0x8
ffffffffc0203666:	1e668693          	addi	a3,a3,486 # ffffffffc020b848 <default_pmm_manager+0x510>
ffffffffc020366a:	00007617          	auipc	a2,0x7
ffffffffc020366e:	1e660613          	addi	a2,a2,486 # ffffffffc020a850 <commands+0x210>
ffffffffc0203672:	25f00593          	li	a1,607
ffffffffc0203676:	00008517          	auipc	a0,0x8
ffffffffc020367a:	e1250513          	addi	a0,a0,-494 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00008697          	auipc	a3,0x8
ffffffffc0203686:	1ae68693          	addi	a3,a3,430 # ffffffffc020b830 <default_pmm_manager+0x4f8>
ffffffffc020368a:	00007617          	auipc	a2,0x7
ffffffffc020368e:	1c660613          	addi	a2,a2,454 # ffffffffc020a850 <commands+0x210>
ffffffffc0203692:	25d00593          	li	a1,605
ffffffffc0203696:	00008517          	auipc	a0,0x8
ffffffffc020369a:	df250513          	addi	a0,a0,-526 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00008697          	auipc	a3,0x8
ffffffffc02036a6:	16e68693          	addi	a3,a3,366 # ffffffffc020b810 <default_pmm_manager+0x4d8>
ffffffffc02036aa:	00007617          	auipc	a2,0x7
ffffffffc02036ae:	1a660613          	addi	a2,a2,422 # ffffffffc020a850 <commands+0x210>
ffffffffc02036b2:	25c00593          	li	a1,604
ffffffffc02036b6:	00008517          	auipc	a0,0x8
ffffffffc02036ba:	dd250513          	addi	a0,a0,-558 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00008697          	auipc	a3,0x8
ffffffffc02036c6:	13e68693          	addi	a3,a3,318 # ffffffffc020b800 <default_pmm_manager+0x4c8>
ffffffffc02036ca:	00007617          	auipc	a2,0x7
ffffffffc02036ce:	18660613          	addi	a2,a2,390 # ffffffffc020a850 <commands+0x210>
ffffffffc02036d2:	25b00593          	li	a1,603
ffffffffc02036d6:	00008517          	auipc	a0,0x8
ffffffffc02036da:	db250513          	addi	a0,a0,-590 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	00008697          	auipc	a3,0x8
ffffffffc02036e6:	10e68693          	addi	a3,a3,270 # ffffffffc020b7f0 <default_pmm_manager+0x4b8>
ffffffffc02036ea:	00007617          	auipc	a2,0x7
ffffffffc02036ee:	16660613          	addi	a2,a2,358 # ffffffffc020a850 <commands+0x210>
ffffffffc02036f2:	25a00593          	li	a1,602
ffffffffc02036f6:	00008517          	auipc	a0,0x8
ffffffffc02036fa:	d9250513          	addi	a0,a0,-622 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02036fe:	da1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203702:	00008697          	auipc	a3,0x8
ffffffffc0203706:	0b668693          	addi	a3,a3,182 # ffffffffc020b7b8 <default_pmm_manager+0x480>
ffffffffc020370a:	00007617          	auipc	a2,0x7
ffffffffc020370e:	14660613          	addi	a2,a2,326 # ffffffffc020a850 <commands+0x210>
ffffffffc0203712:	25900593          	li	a1,601
ffffffffc0203716:	00008517          	auipc	a0,0x8
ffffffffc020371a:	d7250513          	addi	a0,a0,-654 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020371e:	d81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203722:	00008697          	auipc	a3,0x8
ffffffffc0203726:	1e668693          	addi	a3,a3,486 # ffffffffc020b908 <default_pmm_manager+0x5d0>
ffffffffc020372a:	00007617          	auipc	a2,0x7
ffffffffc020372e:	12660613          	addi	a2,a2,294 # ffffffffc020a850 <commands+0x210>
ffffffffc0203732:	27600593          	li	a1,630
ffffffffc0203736:	00008517          	auipc	a0,0x8
ffffffffc020373a:	d5250513          	addi	a0,a0,-686 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020373e:	d61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203742:	00008617          	auipc	a2,0x8
ffffffffc0203746:	c2e60613          	addi	a2,a2,-978 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc020374a:	07100593          	li	a1,113
ffffffffc020374e:	00008517          	auipc	a0,0x8
ffffffffc0203752:	c4a50513          	addi	a0,a0,-950 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0203756:	d49fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375a:	86a2                	mv	a3,s0
ffffffffc020375c:	00008617          	auipc	a2,0x8
ffffffffc0203760:	cbc60613          	addi	a2,a2,-836 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc0203764:	0ca00593          	li	a1,202
ffffffffc0203768:	00008517          	auipc	a0,0x8
ffffffffc020376c:	d2050513          	addi	a0,a0,-736 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203770:	d2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203774:	00008617          	auipc	a2,0x8
ffffffffc0203778:	ca460613          	addi	a2,a2,-860 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc020377c:	08100593          	li	a1,129
ffffffffc0203780:	00008517          	auipc	a0,0x8
ffffffffc0203784:	d0850513          	addi	a0,a0,-760 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203788:	d17fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020378c:	00008697          	auipc	a3,0x8
ffffffffc0203790:	fec68693          	addi	a3,a3,-20 # ffffffffc020b778 <default_pmm_manager+0x440>
ffffffffc0203794:	00007617          	auipc	a2,0x7
ffffffffc0203798:	0bc60613          	addi	a2,a2,188 # ffffffffc020a850 <commands+0x210>
ffffffffc020379c:	25800593          	li	a1,600
ffffffffc02037a0:	00008517          	auipc	a0,0x8
ffffffffc02037a4:	ce850513          	addi	a0,a0,-792 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02037a8:	cf7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ac:	00008697          	auipc	a3,0x8
ffffffffc02037b0:	f0c68693          	addi	a3,a3,-244 # ffffffffc020b6b8 <default_pmm_manager+0x380>
ffffffffc02037b4:	00007617          	auipc	a2,0x7
ffffffffc02037b8:	09c60613          	addi	a2,a2,156 # ffffffffc020a850 <commands+0x210>
ffffffffc02037bc:	24c00593          	li	a1,588
ffffffffc02037c0:	00008517          	auipc	a0,0x8
ffffffffc02037c4:	cc850513          	addi	a0,a0,-824 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02037c8:	cd7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037cc:	985fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc02037d0:	00008697          	auipc	a3,0x8
ffffffffc02037d4:	f1868693          	addi	a3,a3,-232 # ffffffffc020b6e8 <default_pmm_manager+0x3b0>
ffffffffc02037d8:	00007617          	auipc	a2,0x7
ffffffffc02037dc:	07860613          	addi	a2,a2,120 # ffffffffc020a850 <commands+0x210>
ffffffffc02037e0:	24f00593          	li	a1,591
ffffffffc02037e4:	00008517          	auipc	a0,0x8
ffffffffc02037e8:	ca450513          	addi	a0,a0,-860 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02037ec:	cb3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f0:	00008697          	auipc	a3,0x8
ffffffffc02037f4:	e9868693          	addi	a3,a3,-360 # ffffffffc020b688 <default_pmm_manager+0x350>
ffffffffc02037f8:	00007617          	auipc	a2,0x7
ffffffffc02037fc:	05860613          	addi	a2,a2,88 # ffffffffc020a850 <commands+0x210>
ffffffffc0203800:	24800593          	li	a1,584
ffffffffc0203804:	00008517          	auipc	a0,0x8
ffffffffc0203808:	c8450513          	addi	a0,a0,-892 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020380c:	c93fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203810:	00008697          	auipc	a3,0x8
ffffffffc0203814:	f0868693          	addi	a3,a3,-248 # ffffffffc020b718 <default_pmm_manager+0x3e0>
ffffffffc0203818:	00007617          	auipc	a2,0x7
ffffffffc020381c:	03860613          	addi	a2,a2,56 # ffffffffc020a850 <commands+0x210>
ffffffffc0203820:	25000593          	li	a1,592
ffffffffc0203824:	00008517          	auipc	a0,0x8
ffffffffc0203828:	c6450513          	addi	a0,a0,-924 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020382c:	c73fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203830:	00008617          	auipc	a2,0x8
ffffffffc0203834:	b4060613          	addi	a2,a2,-1216 # ffffffffc020b370 <default_pmm_manager+0x38>
ffffffffc0203838:	25300593          	li	a1,595
ffffffffc020383c:	00008517          	auipc	a0,0x8
ffffffffc0203840:	c4c50513          	addi	a0,a0,-948 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203844:	c5bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203848:	00008697          	auipc	a3,0x8
ffffffffc020384c:	ee868693          	addi	a3,a3,-280 # ffffffffc020b730 <default_pmm_manager+0x3f8>
ffffffffc0203850:	00007617          	auipc	a2,0x7
ffffffffc0203854:	00060613          	mv	a2,a2
ffffffffc0203858:	25100593          	li	a1,593
ffffffffc020385c:	00008517          	auipc	a0,0x8
ffffffffc0203860:	c2c50513          	addi	a0,a0,-980 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc0203864:	c3bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203868:	86ca                	mv	a3,s2
ffffffffc020386a:	00008617          	auipc	a2,0x8
ffffffffc020386e:	bae60613          	addi	a2,a2,-1106 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc0203872:	0c600593          	li	a1,198
ffffffffc0203876:	00008517          	auipc	a0,0x8
ffffffffc020387a:	c1250513          	addi	a0,a0,-1006 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020387e:	c21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203882:	00008697          	auipc	a3,0x8
ffffffffc0203886:	00e68693          	addi	a3,a3,14 # ffffffffc020b890 <default_pmm_manager+0x558>
ffffffffc020388a:	00007617          	auipc	a2,0x7
ffffffffc020388e:	fc660613          	addi	a2,a2,-58 # ffffffffc020a850 <commands+0x210>
ffffffffc0203892:	26c00593          	li	a1,620
ffffffffc0203896:	00008517          	auipc	a0,0x8
ffffffffc020389a:	bf250513          	addi	a0,a0,-1038 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc020389e:	c01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a2:	00008697          	auipc	a3,0x8
ffffffffc02038a6:	01e68693          	addi	a3,a3,30 # ffffffffc020b8c0 <default_pmm_manager+0x588>
ffffffffc02038aa:	00007617          	auipc	a2,0x7
ffffffffc02038ae:	fa660613          	addi	a2,a2,-90 # ffffffffc020a850 <commands+0x210>
ffffffffc02038b2:	26b00593          	li	a1,619
ffffffffc02038b6:	00008517          	auipc	a0,0x8
ffffffffc02038ba:	bd250513          	addi	a0,a0,-1070 # ffffffffc020b488 <default_pmm_manager+0x150>
ffffffffc02038be:	be1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c2 <check_vma_overlap.part.0>:
ffffffffc02038c2:	1141                	addi	sp,sp,-16
ffffffffc02038c4:	00008697          	auipc	a3,0x8
ffffffffc02038c8:	24c68693          	addi	a3,a3,588 # ffffffffc020bb10 <default_pmm_manager+0x7d8>
ffffffffc02038cc:	00007617          	auipc	a2,0x7
ffffffffc02038d0:	f8460613          	addi	a2,a2,-124 # ffffffffc020a850 <commands+0x210>
ffffffffc02038d4:	07400593          	li	a1,116
ffffffffc02038d8:	00008517          	auipc	a0,0x8
ffffffffc02038dc:	25850513          	addi	a0,a0,600 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc02038e0:	e406                	sd	ra,8(sp)
ffffffffc02038e2:	bbdfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038e6 <find_vma>:
ffffffffc02038e6:	86aa                	mv	a3,a0
ffffffffc02038e8:	c505                	beqz	a0,ffffffffc0203910 <find_vma+0x2a>
ffffffffc02038ea:	6908                	ld	a0,16(a0)
ffffffffc02038ec:	c501                	beqz	a0,ffffffffc02038f4 <find_vma+0xe>
ffffffffc02038ee:	651c                	ld	a5,8(a0)
ffffffffc02038f0:	02f5f263          	bgeu	a1,a5,ffffffffc0203914 <find_vma+0x2e>
ffffffffc02038f4:	669c                	ld	a5,8(a3)
ffffffffc02038f6:	00f68d63          	beq	a3,a5,ffffffffc0203910 <find_vma+0x2a>
ffffffffc02038fa:	fe87b703          	ld	a4,-24(a5)
ffffffffc02038fe:	00e5e663          	bltu	a1,a4,ffffffffc020390a <find_vma+0x24>
ffffffffc0203902:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203906:	00e5ec63          	bltu	a1,a4,ffffffffc020391e <find_vma+0x38>
ffffffffc020390a:	679c                	ld	a5,8(a5)
ffffffffc020390c:	fef697e3          	bne	a3,a5,ffffffffc02038fa <find_vma+0x14>
ffffffffc0203910:	4501                	li	a0,0
ffffffffc0203912:	8082                	ret
ffffffffc0203914:	691c                	ld	a5,16(a0)
ffffffffc0203916:	fcf5ffe3          	bgeu	a1,a5,ffffffffc02038f4 <find_vma+0xe>
ffffffffc020391a:	ea88                	sd	a0,16(a3)
ffffffffc020391c:	8082                	ret
ffffffffc020391e:	fe078513          	addi	a0,a5,-32
ffffffffc0203922:	ea88                	sd	a0,16(a3)
ffffffffc0203924:	8082                	ret

ffffffffc0203926 <insert_vma_struct>:
ffffffffc0203926:	6590                	ld	a2,8(a1)
ffffffffc0203928:	0105b803          	ld	a6,16(a1)
ffffffffc020392c:	1141                	addi	sp,sp,-16
ffffffffc020392e:	e406                	sd	ra,8(sp)
ffffffffc0203930:	87aa                	mv	a5,a0
ffffffffc0203932:	01066763          	bltu	a2,a6,ffffffffc0203940 <insert_vma_struct+0x1a>
ffffffffc0203936:	a085                	j	ffffffffc0203996 <insert_vma_struct+0x70>
ffffffffc0203938:	fe87b703          	ld	a4,-24(a5)
ffffffffc020393c:	04e66863          	bltu	a2,a4,ffffffffc020398c <insert_vma_struct+0x66>
ffffffffc0203940:	86be                	mv	a3,a5
ffffffffc0203942:	679c                	ld	a5,8(a5)
ffffffffc0203944:	fef51ae3          	bne	a0,a5,ffffffffc0203938 <insert_vma_struct+0x12>
ffffffffc0203948:	02a68463          	beq	a3,a0,ffffffffc0203970 <insert_vma_struct+0x4a>
ffffffffc020394c:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203950:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203954:	08e8f163          	bgeu	a7,a4,ffffffffc02039d6 <insert_vma_struct+0xb0>
ffffffffc0203958:	04e66f63          	bltu	a2,a4,ffffffffc02039b6 <insert_vma_struct+0x90>
ffffffffc020395c:	00f50a63          	beq	a0,a5,ffffffffc0203970 <insert_vma_struct+0x4a>
ffffffffc0203960:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203964:	05076963          	bltu	a4,a6,ffffffffc02039b6 <insert_vma_struct+0x90>
ffffffffc0203968:	ff07b603          	ld	a2,-16(a5)
ffffffffc020396c:	02c77363          	bgeu	a4,a2,ffffffffc0203992 <insert_vma_struct+0x6c>
ffffffffc0203970:	5118                	lw	a4,32(a0)
ffffffffc0203972:	e188                	sd	a0,0(a1)
ffffffffc0203974:	02058613          	addi	a2,a1,32
ffffffffc0203978:	e390                	sd	a2,0(a5)
ffffffffc020397a:	e690                	sd	a2,8(a3)
ffffffffc020397c:	60a2                	ld	ra,8(sp)
ffffffffc020397e:	f59c                	sd	a5,40(a1)
ffffffffc0203980:	f194                	sd	a3,32(a1)
ffffffffc0203982:	0017079b          	addiw	a5,a4,1
ffffffffc0203986:	d11c                	sw	a5,32(a0)
ffffffffc0203988:	0141                	addi	sp,sp,16
ffffffffc020398a:	8082                	ret
ffffffffc020398c:	fca690e3          	bne	a3,a0,ffffffffc020394c <insert_vma_struct+0x26>
ffffffffc0203990:	bfd1                	j	ffffffffc0203964 <insert_vma_struct+0x3e>
ffffffffc0203992:	f31ff0ef          	jal	ra,ffffffffc02038c2 <check_vma_overlap.part.0>
ffffffffc0203996:	00008697          	auipc	a3,0x8
ffffffffc020399a:	1aa68693          	addi	a3,a3,426 # ffffffffc020bb40 <default_pmm_manager+0x808>
ffffffffc020399e:	00007617          	auipc	a2,0x7
ffffffffc02039a2:	eb260613          	addi	a2,a2,-334 # ffffffffc020a850 <commands+0x210>
ffffffffc02039a6:	07a00593          	li	a1,122
ffffffffc02039aa:	00008517          	auipc	a0,0x8
ffffffffc02039ae:	18650513          	addi	a0,a0,390 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc02039b2:	aedfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039b6:	00008697          	auipc	a3,0x8
ffffffffc02039ba:	1ca68693          	addi	a3,a3,458 # ffffffffc020bb80 <default_pmm_manager+0x848>
ffffffffc02039be:	00007617          	auipc	a2,0x7
ffffffffc02039c2:	e9260613          	addi	a2,a2,-366 # ffffffffc020a850 <commands+0x210>
ffffffffc02039c6:	07300593          	li	a1,115
ffffffffc02039ca:	00008517          	auipc	a0,0x8
ffffffffc02039ce:	16650513          	addi	a0,a0,358 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc02039d2:	acdfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02039d6:	00008697          	auipc	a3,0x8
ffffffffc02039da:	18a68693          	addi	a3,a3,394 # ffffffffc020bb60 <default_pmm_manager+0x828>
ffffffffc02039de:	00007617          	auipc	a2,0x7
ffffffffc02039e2:	e7260613          	addi	a2,a2,-398 # ffffffffc020a850 <commands+0x210>
ffffffffc02039e6:	07200593          	li	a1,114
ffffffffc02039ea:	00008517          	auipc	a0,0x8
ffffffffc02039ee:	14650513          	addi	a0,a0,326 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc02039f2:	aadfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02039f6 <mm_destroy>:
ffffffffc02039f6:	591c                	lw	a5,48(a0)
ffffffffc02039f8:	1141                	addi	sp,sp,-16
ffffffffc02039fa:	e406                	sd	ra,8(sp)
ffffffffc02039fc:	e022                	sd	s0,0(sp)
ffffffffc02039fe:	e78d                	bnez	a5,ffffffffc0203a28 <mm_destroy+0x32>
ffffffffc0203a00:	842a                	mv	s0,a0
ffffffffc0203a02:	6508                	ld	a0,8(a0)
ffffffffc0203a04:	00a40c63          	beq	s0,a0,ffffffffc0203a1c <mm_destroy+0x26>
ffffffffc0203a08:	6118                	ld	a4,0(a0)
ffffffffc0203a0a:	651c                	ld	a5,8(a0)
ffffffffc0203a0c:	1501                	addi	a0,a0,-32
ffffffffc0203a0e:	e71c                	sd	a5,8(a4)
ffffffffc0203a10:	e398                	sd	a4,0(a5)
ffffffffc0203a12:	e2cfe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203a16:	6408                	ld	a0,8(s0)
ffffffffc0203a18:	fea418e3          	bne	s0,a0,ffffffffc0203a08 <mm_destroy+0x12>
ffffffffc0203a1c:	8522                	mv	a0,s0
ffffffffc0203a1e:	6402                	ld	s0,0(sp)
ffffffffc0203a20:	60a2                	ld	ra,8(sp)
ffffffffc0203a22:	0141                	addi	sp,sp,16
ffffffffc0203a24:	e1afe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203a28:	00008697          	auipc	a3,0x8
ffffffffc0203a2c:	17868693          	addi	a3,a3,376 # ffffffffc020bba0 <default_pmm_manager+0x868>
ffffffffc0203a30:	00007617          	auipc	a2,0x7
ffffffffc0203a34:	e2060613          	addi	a2,a2,-480 # ffffffffc020a850 <commands+0x210>
ffffffffc0203a38:	09e00593          	li	a1,158
ffffffffc0203a3c:	00008517          	auipc	a0,0x8
ffffffffc0203a40:	0f450513          	addi	a0,a0,244 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203a44:	a5bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203a48 <exit_mmap>:
ffffffffc0203a48:	1101                	addi	sp,sp,-32
ffffffffc0203a4a:	ec06                	sd	ra,24(sp)
ffffffffc0203a4c:	e822                	sd	s0,16(sp)
ffffffffc0203a4e:	e426                	sd	s1,8(sp)
ffffffffc0203a50:	e04a                	sd	s2,0(sp)
ffffffffc0203a52:	c531                	beqz	a0,ffffffffc0203a9e <exit_mmap+0x56>
ffffffffc0203a54:	591c                	lw	a5,48(a0)
ffffffffc0203a56:	84aa                	mv	s1,a0
ffffffffc0203a58:	e3b9                	bnez	a5,ffffffffc0203a9e <exit_mmap+0x56>
ffffffffc0203a5a:	6500                	ld	s0,8(a0)
ffffffffc0203a5c:	01853903          	ld	s2,24(a0)
ffffffffc0203a60:	02850663          	beq	a0,s0,ffffffffc0203a8c <exit_mmap+0x44>
ffffffffc0203a64:	ff043603          	ld	a2,-16(s0)
ffffffffc0203a68:	fe843583          	ld	a1,-24(s0)
ffffffffc0203a6c:	854a                	mv	a0,s2
ffffffffc0203a6e:	af9fe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203a72:	6400                	ld	s0,8(s0)
ffffffffc0203a74:	fe8498e3          	bne	s1,s0,ffffffffc0203a64 <exit_mmap+0x1c>
ffffffffc0203a78:	6400                	ld	s0,8(s0)
ffffffffc0203a7a:	00848c63          	beq	s1,s0,ffffffffc0203a92 <exit_mmap+0x4a>
ffffffffc0203a7e:	ff043603          	ld	a2,-16(s0)
ffffffffc0203a82:	fe843583          	ld	a1,-24(s0)
ffffffffc0203a86:	854a                	mv	a0,s2
ffffffffc0203a88:	c25fe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203a8c:	6400                	ld	s0,8(s0)
ffffffffc0203a8e:	fe8498e3          	bne	s1,s0,ffffffffc0203a7e <exit_mmap+0x36>
ffffffffc0203a92:	60e2                	ld	ra,24(sp)
ffffffffc0203a94:	6442                	ld	s0,16(sp)
ffffffffc0203a96:	64a2                	ld	s1,8(sp)
ffffffffc0203a98:	6902                	ld	s2,0(sp)
ffffffffc0203a9a:	6105                	addi	sp,sp,32
ffffffffc0203a9c:	8082                	ret
ffffffffc0203a9e:	00008697          	auipc	a3,0x8
ffffffffc0203aa2:	12a68693          	addi	a3,a3,298 # ffffffffc020bbc8 <default_pmm_manager+0x890>
ffffffffc0203aa6:	00007617          	auipc	a2,0x7
ffffffffc0203aaa:	daa60613          	addi	a2,a2,-598 # ffffffffc020a850 <commands+0x210>
ffffffffc0203aae:	0e800593          	li	a1,232
ffffffffc0203ab2:	00008517          	auipc	a0,0x8
ffffffffc0203ab6:	07e50513          	addi	a0,a0,126 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203aba:	9e5fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203abe <vmm_init>:
ffffffffc0203abe:	7139                	addi	sp,sp,-64
ffffffffc0203ac0:	05800513          	li	a0,88
ffffffffc0203ac4:	fc06                	sd	ra,56(sp)
ffffffffc0203ac6:	f822                	sd	s0,48(sp)
ffffffffc0203ac8:	f426                	sd	s1,40(sp)
ffffffffc0203aca:	f04a                	sd	s2,32(sp)
ffffffffc0203acc:	ec4e                	sd	s3,24(sp)
ffffffffc0203ace:	e852                	sd	s4,16(sp)
ffffffffc0203ad0:	e456                	sd	s5,8(sp)
ffffffffc0203ad2:	cbcfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203ad6:	2e050963          	beqz	a0,ffffffffc0203dc8 <vmm_init+0x30a>
ffffffffc0203ada:	e508                	sd	a0,8(a0)
ffffffffc0203adc:	e108                	sd	a0,0(a0)
ffffffffc0203ade:	00053823          	sd	zero,16(a0)
ffffffffc0203ae2:	00053c23          	sd	zero,24(a0)
ffffffffc0203ae6:	02052023          	sw	zero,32(a0)
ffffffffc0203aea:	02053423          	sd	zero,40(a0)
ffffffffc0203aee:	02052823          	sw	zero,48(a0)
ffffffffc0203af2:	84aa                	mv	s1,a0
ffffffffc0203af4:	4585                	li	a1,1
ffffffffc0203af6:	03850513          	addi	a0,a0,56
ffffffffc0203afa:	5b6000ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0203afe:	03200413          	li	s0,50
ffffffffc0203b02:	a811                	j	ffffffffc0203b16 <vmm_init+0x58>
ffffffffc0203b04:	e500                	sd	s0,8(a0)
ffffffffc0203b06:	e91c                	sd	a5,16(a0)
ffffffffc0203b08:	00052c23          	sw	zero,24(a0)
ffffffffc0203b0c:	146d                	addi	s0,s0,-5
ffffffffc0203b0e:	8526                	mv	a0,s1
ffffffffc0203b10:	e17ff0ef          	jal	ra,ffffffffc0203926 <insert_vma_struct>
ffffffffc0203b14:	c80d                	beqz	s0,ffffffffc0203b46 <vmm_init+0x88>
ffffffffc0203b16:	03000513          	li	a0,48
ffffffffc0203b1a:	c74fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203b1e:	85aa                	mv	a1,a0
ffffffffc0203b20:	00240793          	addi	a5,s0,2
ffffffffc0203b24:	f165                	bnez	a0,ffffffffc0203b04 <vmm_init+0x46>
ffffffffc0203b26:	00008697          	auipc	a3,0x8
ffffffffc0203b2a:	23a68693          	addi	a3,a3,570 # ffffffffc020bd60 <default_pmm_manager+0xa28>
ffffffffc0203b2e:	00007617          	auipc	a2,0x7
ffffffffc0203b32:	d2260613          	addi	a2,a2,-734 # ffffffffc020a850 <commands+0x210>
ffffffffc0203b36:	12c00593          	li	a1,300
ffffffffc0203b3a:	00008517          	auipc	a0,0x8
ffffffffc0203b3e:	ff650513          	addi	a0,a0,-10 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203b42:	95dfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b46:	03700413          	li	s0,55
ffffffffc0203b4a:	1f900913          	li	s2,505
ffffffffc0203b4e:	a819                	j	ffffffffc0203b64 <vmm_init+0xa6>
ffffffffc0203b50:	e500                	sd	s0,8(a0)
ffffffffc0203b52:	e91c                	sd	a5,16(a0)
ffffffffc0203b54:	00052c23          	sw	zero,24(a0)
ffffffffc0203b58:	0415                	addi	s0,s0,5
ffffffffc0203b5a:	8526                	mv	a0,s1
ffffffffc0203b5c:	dcbff0ef          	jal	ra,ffffffffc0203926 <insert_vma_struct>
ffffffffc0203b60:	03240a63          	beq	s0,s2,ffffffffc0203b94 <vmm_init+0xd6>
ffffffffc0203b64:	03000513          	li	a0,48
ffffffffc0203b68:	c26fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203b6c:	85aa                	mv	a1,a0
ffffffffc0203b6e:	00240793          	addi	a5,s0,2
ffffffffc0203b72:	fd79                	bnez	a0,ffffffffc0203b50 <vmm_init+0x92>
ffffffffc0203b74:	00008697          	auipc	a3,0x8
ffffffffc0203b78:	1ec68693          	addi	a3,a3,492 # ffffffffc020bd60 <default_pmm_manager+0xa28>
ffffffffc0203b7c:	00007617          	auipc	a2,0x7
ffffffffc0203b80:	cd460613          	addi	a2,a2,-812 # ffffffffc020a850 <commands+0x210>
ffffffffc0203b84:	13300593          	li	a1,307
ffffffffc0203b88:	00008517          	auipc	a0,0x8
ffffffffc0203b8c:	fa850513          	addi	a0,a0,-88 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203b90:	90ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b94:	649c                	ld	a5,8(s1)
ffffffffc0203b96:	471d                	li	a4,7
ffffffffc0203b98:	1fb00593          	li	a1,507
ffffffffc0203b9c:	16f48663          	beq	s1,a5,ffffffffc0203d08 <vmm_init+0x24a>
ffffffffc0203ba0:	fe87b603          	ld	a2,-24(a5)
ffffffffc0203ba4:	ffe70693          	addi	a3,a4,-2 # ffe <_binary_bin_swap_img_size-0x6d02>
ffffffffc0203ba8:	10d61063          	bne	a2,a3,ffffffffc0203ca8 <vmm_init+0x1ea>
ffffffffc0203bac:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203bb0:	0ed71c63          	bne	a4,a3,ffffffffc0203ca8 <vmm_init+0x1ea>
ffffffffc0203bb4:	0715                	addi	a4,a4,5
ffffffffc0203bb6:	679c                	ld	a5,8(a5)
ffffffffc0203bb8:	feb712e3          	bne	a4,a1,ffffffffc0203b9c <vmm_init+0xde>
ffffffffc0203bbc:	4a1d                	li	s4,7
ffffffffc0203bbe:	4415                	li	s0,5
ffffffffc0203bc0:	1f900a93          	li	s5,505
ffffffffc0203bc4:	85a2                	mv	a1,s0
ffffffffc0203bc6:	8526                	mv	a0,s1
ffffffffc0203bc8:	d1fff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203bcc:	892a                	mv	s2,a0
ffffffffc0203bce:	16050d63          	beqz	a0,ffffffffc0203d48 <vmm_init+0x28a>
ffffffffc0203bd2:	00140593          	addi	a1,s0,1
ffffffffc0203bd6:	8526                	mv	a0,s1
ffffffffc0203bd8:	d0fff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203bdc:	89aa                	mv	s3,a0
ffffffffc0203bde:	14050563          	beqz	a0,ffffffffc0203d28 <vmm_init+0x26a>
ffffffffc0203be2:	85d2                	mv	a1,s4
ffffffffc0203be4:	8526                	mv	a0,s1
ffffffffc0203be6:	d01ff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203bea:	16051f63          	bnez	a0,ffffffffc0203d68 <vmm_init+0x2aa>
ffffffffc0203bee:	00340593          	addi	a1,s0,3
ffffffffc0203bf2:	8526                	mv	a0,s1
ffffffffc0203bf4:	cf3ff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203bf8:	1a051863          	bnez	a0,ffffffffc0203da8 <vmm_init+0x2ea>
ffffffffc0203bfc:	00440593          	addi	a1,s0,4
ffffffffc0203c00:	8526                	mv	a0,s1
ffffffffc0203c02:	ce5ff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203c06:	18051163          	bnez	a0,ffffffffc0203d88 <vmm_init+0x2ca>
ffffffffc0203c0a:	00893783          	ld	a5,8(s2)
ffffffffc0203c0e:	0a879d63          	bne	a5,s0,ffffffffc0203cc8 <vmm_init+0x20a>
ffffffffc0203c12:	01093783          	ld	a5,16(s2)
ffffffffc0203c16:	0b479963          	bne	a5,s4,ffffffffc0203cc8 <vmm_init+0x20a>
ffffffffc0203c1a:	0089b783          	ld	a5,8(s3)
ffffffffc0203c1e:	0c879563          	bne	a5,s0,ffffffffc0203ce8 <vmm_init+0x22a>
ffffffffc0203c22:	0109b783          	ld	a5,16(s3)
ffffffffc0203c26:	0d479163          	bne	a5,s4,ffffffffc0203ce8 <vmm_init+0x22a>
ffffffffc0203c2a:	0415                	addi	s0,s0,5
ffffffffc0203c2c:	0a15                	addi	s4,s4,5
ffffffffc0203c2e:	f9541be3          	bne	s0,s5,ffffffffc0203bc4 <vmm_init+0x106>
ffffffffc0203c32:	4411                	li	s0,4
ffffffffc0203c34:	597d                	li	s2,-1
ffffffffc0203c36:	85a2                	mv	a1,s0
ffffffffc0203c38:	8526                	mv	a0,s1
ffffffffc0203c3a:	cadff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203c3e:	0004059b          	sext.w	a1,s0
ffffffffc0203c42:	c90d                	beqz	a0,ffffffffc0203c74 <vmm_init+0x1b6>
ffffffffc0203c44:	6914                	ld	a3,16(a0)
ffffffffc0203c46:	6510                	ld	a2,8(a0)
ffffffffc0203c48:	00008517          	auipc	a0,0x8
ffffffffc0203c4c:	0a050513          	addi	a0,a0,160 # ffffffffc020bce8 <default_pmm_manager+0x9b0>
ffffffffc0203c50:	d56fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203c54:	00008697          	auipc	a3,0x8
ffffffffc0203c58:	0bc68693          	addi	a3,a3,188 # ffffffffc020bd10 <default_pmm_manager+0x9d8>
ffffffffc0203c5c:	00007617          	auipc	a2,0x7
ffffffffc0203c60:	bf460613          	addi	a2,a2,-1036 # ffffffffc020a850 <commands+0x210>
ffffffffc0203c64:	15900593          	li	a1,345
ffffffffc0203c68:	00008517          	auipc	a0,0x8
ffffffffc0203c6c:	ec850513          	addi	a0,a0,-312 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203c70:	82ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203c74:	147d                	addi	s0,s0,-1
ffffffffc0203c76:	fd2410e3          	bne	s0,s2,ffffffffc0203c36 <vmm_init+0x178>
ffffffffc0203c7a:	8526                	mv	a0,s1
ffffffffc0203c7c:	d7bff0ef          	jal	ra,ffffffffc02039f6 <mm_destroy>
ffffffffc0203c80:	00008517          	auipc	a0,0x8
ffffffffc0203c84:	0a850513          	addi	a0,a0,168 # ffffffffc020bd28 <default_pmm_manager+0x9f0>
ffffffffc0203c88:	d1efc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203c8c:	7442                	ld	s0,48(sp)
ffffffffc0203c8e:	70e2                	ld	ra,56(sp)
ffffffffc0203c90:	74a2                	ld	s1,40(sp)
ffffffffc0203c92:	7902                	ld	s2,32(sp)
ffffffffc0203c94:	69e2                	ld	s3,24(sp)
ffffffffc0203c96:	6a42                	ld	s4,16(sp)
ffffffffc0203c98:	6aa2                	ld	s5,8(sp)
ffffffffc0203c9a:	00008517          	auipc	a0,0x8
ffffffffc0203c9e:	0ae50513          	addi	a0,a0,174 # ffffffffc020bd48 <default_pmm_manager+0xa10>
ffffffffc0203ca2:	6121                	addi	sp,sp,64
ffffffffc0203ca4:	d02fc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0203ca8:	00008697          	auipc	a3,0x8
ffffffffc0203cac:	f5868693          	addi	a3,a3,-168 # ffffffffc020bc00 <default_pmm_manager+0x8c8>
ffffffffc0203cb0:	00007617          	auipc	a2,0x7
ffffffffc0203cb4:	ba060613          	addi	a2,a2,-1120 # ffffffffc020a850 <commands+0x210>
ffffffffc0203cb8:	13d00593          	li	a1,317
ffffffffc0203cbc:	00008517          	auipc	a0,0x8
ffffffffc0203cc0:	e7450513          	addi	a0,a0,-396 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203cc4:	fdafc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203cc8:	00008697          	auipc	a3,0x8
ffffffffc0203ccc:	fc068693          	addi	a3,a3,-64 # ffffffffc020bc88 <default_pmm_manager+0x950>
ffffffffc0203cd0:	00007617          	auipc	a2,0x7
ffffffffc0203cd4:	b8060613          	addi	a2,a2,-1152 # ffffffffc020a850 <commands+0x210>
ffffffffc0203cd8:	14e00593          	li	a1,334
ffffffffc0203cdc:	00008517          	auipc	a0,0x8
ffffffffc0203ce0:	e5450513          	addi	a0,a0,-428 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203ce4:	fbafc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ce8:	00008697          	auipc	a3,0x8
ffffffffc0203cec:	fd068693          	addi	a3,a3,-48 # ffffffffc020bcb8 <default_pmm_manager+0x980>
ffffffffc0203cf0:	00007617          	auipc	a2,0x7
ffffffffc0203cf4:	b6060613          	addi	a2,a2,-1184 # ffffffffc020a850 <commands+0x210>
ffffffffc0203cf8:	14f00593          	li	a1,335
ffffffffc0203cfc:	00008517          	auipc	a0,0x8
ffffffffc0203d00:	e3450513          	addi	a0,a0,-460 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203d04:	f9afc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d08:	00008697          	auipc	a3,0x8
ffffffffc0203d0c:	ee068693          	addi	a3,a3,-288 # ffffffffc020bbe8 <default_pmm_manager+0x8b0>
ffffffffc0203d10:	00007617          	auipc	a2,0x7
ffffffffc0203d14:	b4060613          	addi	a2,a2,-1216 # ffffffffc020a850 <commands+0x210>
ffffffffc0203d18:	13b00593          	li	a1,315
ffffffffc0203d1c:	00008517          	auipc	a0,0x8
ffffffffc0203d20:	e1450513          	addi	a0,a0,-492 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203d24:	f7afc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d28:	00008697          	auipc	a3,0x8
ffffffffc0203d2c:	f2068693          	addi	a3,a3,-224 # ffffffffc020bc48 <default_pmm_manager+0x910>
ffffffffc0203d30:	00007617          	auipc	a2,0x7
ffffffffc0203d34:	b2060613          	addi	a2,a2,-1248 # ffffffffc020a850 <commands+0x210>
ffffffffc0203d38:	14600593          	li	a1,326
ffffffffc0203d3c:	00008517          	auipc	a0,0x8
ffffffffc0203d40:	df450513          	addi	a0,a0,-524 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203d44:	f5afc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d48:	00008697          	auipc	a3,0x8
ffffffffc0203d4c:	ef068693          	addi	a3,a3,-272 # ffffffffc020bc38 <default_pmm_manager+0x900>
ffffffffc0203d50:	00007617          	auipc	a2,0x7
ffffffffc0203d54:	b0060613          	addi	a2,a2,-1280 # ffffffffc020a850 <commands+0x210>
ffffffffc0203d58:	14400593          	li	a1,324
ffffffffc0203d5c:	00008517          	auipc	a0,0x8
ffffffffc0203d60:	dd450513          	addi	a0,a0,-556 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203d64:	f3afc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d68:	00008697          	auipc	a3,0x8
ffffffffc0203d6c:	ef068693          	addi	a3,a3,-272 # ffffffffc020bc58 <default_pmm_manager+0x920>
ffffffffc0203d70:	00007617          	auipc	a2,0x7
ffffffffc0203d74:	ae060613          	addi	a2,a2,-1312 # ffffffffc020a850 <commands+0x210>
ffffffffc0203d78:	14800593          	li	a1,328
ffffffffc0203d7c:	00008517          	auipc	a0,0x8
ffffffffc0203d80:	db450513          	addi	a0,a0,-588 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203d84:	f1afc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d88:	00008697          	auipc	a3,0x8
ffffffffc0203d8c:	ef068693          	addi	a3,a3,-272 # ffffffffc020bc78 <default_pmm_manager+0x940>
ffffffffc0203d90:	00007617          	auipc	a2,0x7
ffffffffc0203d94:	ac060613          	addi	a2,a2,-1344 # ffffffffc020a850 <commands+0x210>
ffffffffc0203d98:	14c00593          	li	a1,332
ffffffffc0203d9c:	00008517          	auipc	a0,0x8
ffffffffc0203da0:	d9450513          	addi	a0,a0,-620 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203da4:	efafc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203da8:	00008697          	auipc	a3,0x8
ffffffffc0203dac:	ec068693          	addi	a3,a3,-320 # ffffffffc020bc68 <default_pmm_manager+0x930>
ffffffffc0203db0:	00007617          	auipc	a2,0x7
ffffffffc0203db4:	aa060613          	addi	a2,a2,-1376 # ffffffffc020a850 <commands+0x210>
ffffffffc0203db8:	14a00593          	li	a1,330
ffffffffc0203dbc:	00008517          	auipc	a0,0x8
ffffffffc0203dc0:	d7450513          	addi	a0,a0,-652 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203dc4:	edafc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203dc8:	00008697          	auipc	a3,0x8
ffffffffc0203dcc:	df068693          	addi	a3,a3,-528 # ffffffffc020bbb8 <default_pmm_manager+0x880>
ffffffffc0203dd0:	00007617          	auipc	a2,0x7
ffffffffc0203dd4:	a8060613          	addi	a2,a2,-1408 # ffffffffc020a850 <commands+0x210>
ffffffffc0203dd8:	12400593          	li	a1,292
ffffffffc0203ddc:	00008517          	auipc	a0,0x8
ffffffffc0203de0:	d5450513          	addi	a0,a0,-684 # ffffffffc020bb30 <default_pmm_manager+0x7f8>
ffffffffc0203de4:	ebafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203de8 <user_mem_check>:
ffffffffc0203de8:	7179                	addi	sp,sp,-48
ffffffffc0203dea:	f022                	sd	s0,32(sp)
ffffffffc0203dec:	f406                	sd	ra,40(sp)
ffffffffc0203dee:	ec26                	sd	s1,24(sp)
ffffffffc0203df0:	e84a                	sd	s2,16(sp)
ffffffffc0203df2:	e44e                	sd	s3,8(sp)
ffffffffc0203df4:	e052                	sd	s4,0(sp)
ffffffffc0203df6:	842e                	mv	s0,a1
ffffffffc0203df8:	c135                	beqz	a0,ffffffffc0203e5c <user_mem_check+0x74>
ffffffffc0203dfa:	002007b7          	lui	a5,0x200
ffffffffc0203dfe:	04f5e663          	bltu	a1,a5,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e02:	00c584b3          	add	s1,a1,a2
ffffffffc0203e06:	0495f263          	bgeu	a1,s1,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e0a:	4785                	li	a5,1
ffffffffc0203e0c:	07fe                	slli	a5,a5,0x1f
ffffffffc0203e0e:	0297ee63          	bltu	a5,s1,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e12:	892a                	mv	s2,a0
ffffffffc0203e14:	89b6                	mv	s3,a3
ffffffffc0203e16:	6a05                	lui	s4,0x1
ffffffffc0203e18:	a821                	j	ffffffffc0203e30 <user_mem_check+0x48>
ffffffffc0203e1a:	0027f693          	andi	a3,a5,2
ffffffffc0203e1e:	9752                	add	a4,a4,s4
ffffffffc0203e20:	8ba1                	andi	a5,a5,8
ffffffffc0203e22:	c685                	beqz	a3,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e24:	c399                	beqz	a5,ffffffffc0203e2a <user_mem_check+0x42>
ffffffffc0203e26:	02e46263          	bltu	s0,a4,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e2a:	6900                	ld	s0,16(a0)
ffffffffc0203e2c:	04947663          	bgeu	s0,s1,ffffffffc0203e78 <user_mem_check+0x90>
ffffffffc0203e30:	85a2                	mv	a1,s0
ffffffffc0203e32:	854a                	mv	a0,s2
ffffffffc0203e34:	ab3ff0ef          	jal	ra,ffffffffc02038e6 <find_vma>
ffffffffc0203e38:	c909                	beqz	a0,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e3a:	6518                	ld	a4,8(a0)
ffffffffc0203e3c:	00e46763          	bltu	s0,a4,ffffffffc0203e4a <user_mem_check+0x62>
ffffffffc0203e40:	4d1c                	lw	a5,24(a0)
ffffffffc0203e42:	fc099ce3          	bnez	s3,ffffffffc0203e1a <user_mem_check+0x32>
ffffffffc0203e46:	8b85                	andi	a5,a5,1
ffffffffc0203e48:	f3ed                	bnez	a5,ffffffffc0203e2a <user_mem_check+0x42>
ffffffffc0203e4a:	4501                	li	a0,0
ffffffffc0203e4c:	70a2                	ld	ra,40(sp)
ffffffffc0203e4e:	7402                	ld	s0,32(sp)
ffffffffc0203e50:	64e2                	ld	s1,24(sp)
ffffffffc0203e52:	6942                	ld	s2,16(sp)
ffffffffc0203e54:	69a2                	ld	s3,8(sp)
ffffffffc0203e56:	6a02                	ld	s4,0(sp)
ffffffffc0203e58:	6145                	addi	sp,sp,48
ffffffffc0203e5a:	8082                	ret
ffffffffc0203e5c:	c02007b7          	lui	a5,0xc0200
ffffffffc0203e60:	4501                	li	a0,0
ffffffffc0203e62:	fef5e5e3          	bltu	a1,a5,ffffffffc0203e4c <user_mem_check+0x64>
ffffffffc0203e66:	962e                	add	a2,a2,a1
ffffffffc0203e68:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203e4c <user_mem_check+0x64>
ffffffffc0203e6c:	c8000537          	lui	a0,0xc8000
ffffffffc0203e70:	0505                	addi	a0,a0,1
ffffffffc0203e72:	00a63533          	sltu	a0,a2,a0
ffffffffc0203e76:	bfd9                	j	ffffffffc0203e4c <user_mem_check+0x64>
ffffffffc0203e78:	4505                	li	a0,1
ffffffffc0203e7a:	bfc9                	j	ffffffffc0203e4c <user_mem_check+0x64>

ffffffffc0203e7c <copy_from_user>:
ffffffffc0203e7c:	1101                	addi	sp,sp,-32
ffffffffc0203e7e:	e822                	sd	s0,16(sp)
ffffffffc0203e80:	e426                	sd	s1,8(sp)
ffffffffc0203e82:	8432                	mv	s0,a2
ffffffffc0203e84:	84b6                	mv	s1,a3
ffffffffc0203e86:	e04a                	sd	s2,0(sp)
ffffffffc0203e88:	86ba                	mv	a3,a4
ffffffffc0203e8a:	892e                	mv	s2,a1
ffffffffc0203e8c:	8626                	mv	a2,s1
ffffffffc0203e8e:	85a2                	mv	a1,s0
ffffffffc0203e90:	ec06                	sd	ra,24(sp)
ffffffffc0203e92:	f57ff0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0203e96:	c519                	beqz	a0,ffffffffc0203ea4 <copy_from_user+0x28>
ffffffffc0203e98:	8626                	mv	a2,s1
ffffffffc0203e9a:	85a2                	mv	a1,s0
ffffffffc0203e9c:	854a                	mv	a0,s2
ffffffffc0203e9e:	51c060ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0203ea2:	4505                	li	a0,1
ffffffffc0203ea4:	60e2                	ld	ra,24(sp)
ffffffffc0203ea6:	6442                	ld	s0,16(sp)
ffffffffc0203ea8:	64a2                	ld	s1,8(sp)
ffffffffc0203eaa:	6902                	ld	s2,0(sp)
ffffffffc0203eac:	6105                	addi	sp,sp,32
ffffffffc0203eae:	8082                	ret

ffffffffc0203eb0 <copy_to_user>:
ffffffffc0203eb0:	1101                	addi	sp,sp,-32
ffffffffc0203eb2:	e822                	sd	s0,16(sp)
ffffffffc0203eb4:	8436                	mv	s0,a3
ffffffffc0203eb6:	e04a                	sd	s2,0(sp)
ffffffffc0203eb8:	4685                	li	a3,1
ffffffffc0203eba:	8932                	mv	s2,a2
ffffffffc0203ebc:	8622                	mv	a2,s0
ffffffffc0203ebe:	e426                	sd	s1,8(sp)
ffffffffc0203ec0:	ec06                	sd	ra,24(sp)
ffffffffc0203ec2:	84ae                	mv	s1,a1
ffffffffc0203ec4:	f25ff0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0203ec8:	c519                	beqz	a0,ffffffffc0203ed6 <copy_to_user+0x26>
ffffffffc0203eca:	8622                	mv	a2,s0
ffffffffc0203ecc:	85ca                	mv	a1,s2
ffffffffc0203ece:	8526                	mv	a0,s1
ffffffffc0203ed0:	4ea060ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0203ed4:	4505                	li	a0,1
ffffffffc0203ed6:	60e2                	ld	ra,24(sp)
ffffffffc0203ed8:	6442                	ld	s0,16(sp)
ffffffffc0203eda:	64a2                	ld	s1,8(sp)
ffffffffc0203edc:	6902                	ld	s2,0(sp)
ffffffffc0203ede:	6105                	addi	sp,sp,32
ffffffffc0203ee0:	8082                	ret

ffffffffc0203ee2 <copy_string>:
ffffffffc0203ee2:	7139                	addi	sp,sp,-64
ffffffffc0203ee4:	ec4e                	sd	s3,24(sp)
ffffffffc0203ee6:	6985                	lui	s3,0x1
ffffffffc0203ee8:	99b2                	add	s3,s3,a2
ffffffffc0203eea:	77fd                	lui	a5,0xfffff
ffffffffc0203eec:	00f9f9b3          	and	s3,s3,a5
ffffffffc0203ef0:	f426                	sd	s1,40(sp)
ffffffffc0203ef2:	f04a                	sd	s2,32(sp)
ffffffffc0203ef4:	e852                	sd	s4,16(sp)
ffffffffc0203ef6:	e456                	sd	s5,8(sp)
ffffffffc0203ef8:	fc06                	sd	ra,56(sp)
ffffffffc0203efa:	f822                	sd	s0,48(sp)
ffffffffc0203efc:	84b2                	mv	s1,a2
ffffffffc0203efe:	8aaa                	mv	s5,a0
ffffffffc0203f00:	8a2e                	mv	s4,a1
ffffffffc0203f02:	8936                	mv	s2,a3
ffffffffc0203f04:	40c989b3          	sub	s3,s3,a2
ffffffffc0203f08:	a015                	j	ffffffffc0203f2c <copy_string+0x4a>
ffffffffc0203f0a:	3d6060ef          	jal	ra,ffffffffc020a2e0 <strnlen>
ffffffffc0203f0e:	87aa                	mv	a5,a0
ffffffffc0203f10:	85a6                	mv	a1,s1
ffffffffc0203f12:	8552                	mv	a0,s4
ffffffffc0203f14:	8622                	mv	a2,s0
ffffffffc0203f16:	0487e363          	bltu	a5,s0,ffffffffc0203f5c <copy_string+0x7a>
ffffffffc0203f1a:	0329f763          	bgeu	s3,s2,ffffffffc0203f48 <copy_string+0x66>
ffffffffc0203f1e:	49c060ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0203f22:	9a22                	add	s4,s4,s0
ffffffffc0203f24:	94a2                	add	s1,s1,s0
ffffffffc0203f26:	40890933          	sub	s2,s2,s0
ffffffffc0203f2a:	6985                	lui	s3,0x1
ffffffffc0203f2c:	4681                	li	a3,0
ffffffffc0203f2e:	85a6                	mv	a1,s1
ffffffffc0203f30:	8556                	mv	a0,s5
ffffffffc0203f32:	844a                	mv	s0,s2
ffffffffc0203f34:	0129f363          	bgeu	s3,s2,ffffffffc0203f3a <copy_string+0x58>
ffffffffc0203f38:	844e                	mv	s0,s3
ffffffffc0203f3a:	8622                	mv	a2,s0
ffffffffc0203f3c:	eadff0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0203f40:	87aa                	mv	a5,a0
ffffffffc0203f42:	85a2                	mv	a1,s0
ffffffffc0203f44:	8526                	mv	a0,s1
ffffffffc0203f46:	f3f1                	bnez	a5,ffffffffc0203f0a <copy_string+0x28>
ffffffffc0203f48:	4501                	li	a0,0
ffffffffc0203f4a:	70e2                	ld	ra,56(sp)
ffffffffc0203f4c:	7442                	ld	s0,48(sp)
ffffffffc0203f4e:	74a2                	ld	s1,40(sp)
ffffffffc0203f50:	7902                	ld	s2,32(sp)
ffffffffc0203f52:	69e2                	ld	s3,24(sp)
ffffffffc0203f54:	6a42                	ld	s4,16(sp)
ffffffffc0203f56:	6aa2                	ld	s5,8(sp)
ffffffffc0203f58:	6121                	addi	sp,sp,64
ffffffffc0203f5a:	8082                	ret
ffffffffc0203f5c:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd696f9>
ffffffffc0203f60:	45a060ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0203f64:	4505                	li	a0,1
ffffffffc0203f66:	b7d5                	j	ffffffffc0203f4a <copy_string+0x68>

ffffffffc0203f68 <__down.constprop.0>:
ffffffffc0203f68:	715d                	addi	sp,sp,-80
ffffffffc0203f6a:	e0a2                	sd	s0,64(sp)
ffffffffc0203f6c:	e486                	sd	ra,72(sp)
ffffffffc0203f6e:	fc26                	sd	s1,56(sp)
ffffffffc0203f70:	842a                	mv	s0,a0
ffffffffc0203f72:	100027f3          	csrr	a5,sstatus
ffffffffc0203f76:	8b89                	andi	a5,a5,2
ffffffffc0203f78:	ebb1                	bnez	a5,ffffffffc0203fcc <__down.constprop.0+0x64>
ffffffffc0203f7a:	411c                	lw	a5,0(a0)
ffffffffc0203f7c:	00f05a63          	blez	a5,ffffffffc0203f90 <__down.constprop.0+0x28>
ffffffffc0203f80:	37fd                	addiw	a5,a5,-1
ffffffffc0203f82:	c11c                	sw	a5,0(a0)
ffffffffc0203f84:	4501                	li	a0,0
ffffffffc0203f86:	60a6                	ld	ra,72(sp)
ffffffffc0203f88:	6406                	ld	s0,64(sp)
ffffffffc0203f8a:	74e2                	ld	s1,56(sp)
ffffffffc0203f8c:	6161                	addi	sp,sp,80
ffffffffc0203f8e:	8082                	ret
ffffffffc0203f90:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d6a700>
ffffffffc0203f94:	0024                	addi	s1,sp,8
ffffffffc0203f96:	10000613          	li	a2,256
ffffffffc0203f9a:	85a6                	mv	a1,s1
ffffffffc0203f9c:	8522                	mv	a0,s0
ffffffffc0203f9e:	2d8000ef          	jal	ra,ffffffffc0204276 <wait_current_set>
ffffffffc0203fa2:	496020ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc0203fa6:	100027f3          	csrr	a5,sstatus
ffffffffc0203faa:	8b89                	andi	a5,a5,2
ffffffffc0203fac:	efb9                	bnez	a5,ffffffffc020400a <__down.constprop.0+0xa2>
ffffffffc0203fae:	8526                	mv	a0,s1
ffffffffc0203fb0:	19c000ef          	jal	ra,ffffffffc020414c <wait_in_queue>
ffffffffc0203fb4:	e531                	bnez	a0,ffffffffc0204000 <__down.constprop.0+0x98>
ffffffffc0203fb6:	4542                	lw	a0,16(sp)
ffffffffc0203fb8:	10000793          	li	a5,256
ffffffffc0203fbc:	fcf515e3          	bne	a0,a5,ffffffffc0203f86 <__down.constprop.0+0x1e>
ffffffffc0203fc0:	60a6                	ld	ra,72(sp)
ffffffffc0203fc2:	6406                	ld	s0,64(sp)
ffffffffc0203fc4:	74e2                	ld	s1,56(sp)
ffffffffc0203fc6:	4501                	li	a0,0
ffffffffc0203fc8:	6161                	addi	sp,sp,80
ffffffffc0203fca:	8082                	ret
ffffffffc0203fcc:	ca7fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203fd0:	401c                	lw	a5,0(s0)
ffffffffc0203fd2:	00f05c63          	blez	a5,ffffffffc0203fea <__down.constprop.0+0x82>
ffffffffc0203fd6:	37fd                	addiw	a5,a5,-1
ffffffffc0203fd8:	c01c                	sw	a5,0(s0)
ffffffffc0203fda:	c93fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203fde:	60a6                	ld	ra,72(sp)
ffffffffc0203fe0:	6406                	ld	s0,64(sp)
ffffffffc0203fe2:	74e2                	ld	s1,56(sp)
ffffffffc0203fe4:	4501                	li	a0,0
ffffffffc0203fe6:	6161                	addi	sp,sp,80
ffffffffc0203fe8:	8082                	ret
ffffffffc0203fea:	0421                	addi	s0,s0,8
ffffffffc0203fec:	0024                	addi	s1,sp,8
ffffffffc0203fee:	10000613          	li	a2,256
ffffffffc0203ff2:	85a6                	mv	a1,s1
ffffffffc0203ff4:	8522                	mv	a0,s0
ffffffffc0203ff6:	280000ef          	jal	ra,ffffffffc0204276 <wait_current_set>
ffffffffc0203ffa:	c73fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203ffe:	b755                	j	ffffffffc0203fa2 <__down.constprop.0+0x3a>
ffffffffc0204000:	85a6                	mv	a1,s1
ffffffffc0204002:	8522                	mv	a0,s0
ffffffffc0204004:	0ee000ef          	jal	ra,ffffffffc02040f2 <wait_queue_del>
ffffffffc0204008:	b77d                	j	ffffffffc0203fb6 <__down.constprop.0+0x4e>
ffffffffc020400a:	c69fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020400e:	8526                	mv	a0,s1
ffffffffc0204010:	13c000ef          	jal	ra,ffffffffc020414c <wait_in_queue>
ffffffffc0204014:	e501                	bnez	a0,ffffffffc020401c <__down.constprop.0+0xb4>
ffffffffc0204016:	c57fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020401a:	bf71                	j	ffffffffc0203fb6 <__down.constprop.0+0x4e>
ffffffffc020401c:	85a6                	mv	a1,s1
ffffffffc020401e:	8522                	mv	a0,s0
ffffffffc0204020:	0d2000ef          	jal	ra,ffffffffc02040f2 <wait_queue_del>
ffffffffc0204024:	bfcd                	j	ffffffffc0204016 <__down.constprop.0+0xae>

ffffffffc0204026 <__up.constprop.0>:
ffffffffc0204026:	1101                	addi	sp,sp,-32
ffffffffc0204028:	e822                	sd	s0,16(sp)
ffffffffc020402a:	ec06                	sd	ra,24(sp)
ffffffffc020402c:	e426                	sd	s1,8(sp)
ffffffffc020402e:	e04a                	sd	s2,0(sp)
ffffffffc0204030:	842a                	mv	s0,a0
ffffffffc0204032:	100027f3          	csrr	a5,sstatus
ffffffffc0204036:	8b89                	andi	a5,a5,2
ffffffffc0204038:	4901                	li	s2,0
ffffffffc020403a:	eba1                	bnez	a5,ffffffffc020408a <__up.constprop.0+0x64>
ffffffffc020403c:	00840493          	addi	s1,s0,8
ffffffffc0204040:	8526                	mv	a0,s1
ffffffffc0204042:	0ee000ef          	jal	ra,ffffffffc0204130 <wait_queue_first>
ffffffffc0204046:	85aa                	mv	a1,a0
ffffffffc0204048:	cd0d                	beqz	a0,ffffffffc0204082 <__up.constprop.0+0x5c>
ffffffffc020404a:	6118                	ld	a4,0(a0)
ffffffffc020404c:	10000793          	li	a5,256
ffffffffc0204050:	0ec72703          	lw	a4,236(a4)
ffffffffc0204054:	02f71f63          	bne	a4,a5,ffffffffc0204092 <__up.constprop.0+0x6c>
ffffffffc0204058:	4685                	li	a3,1
ffffffffc020405a:	10000613          	li	a2,256
ffffffffc020405e:	8526                	mv	a0,s1
ffffffffc0204060:	0fa000ef          	jal	ra,ffffffffc020415a <wakeup_wait>
ffffffffc0204064:	00091863          	bnez	s2,ffffffffc0204074 <__up.constprop.0+0x4e>
ffffffffc0204068:	60e2                	ld	ra,24(sp)
ffffffffc020406a:	6442                	ld	s0,16(sp)
ffffffffc020406c:	64a2                	ld	s1,8(sp)
ffffffffc020406e:	6902                	ld	s2,0(sp)
ffffffffc0204070:	6105                	addi	sp,sp,32
ffffffffc0204072:	8082                	ret
ffffffffc0204074:	6442                	ld	s0,16(sp)
ffffffffc0204076:	60e2                	ld	ra,24(sp)
ffffffffc0204078:	64a2                	ld	s1,8(sp)
ffffffffc020407a:	6902                	ld	s2,0(sp)
ffffffffc020407c:	6105                	addi	sp,sp,32
ffffffffc020407e:	beffc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0204082:	401c                	lw	a5,0(s0)
ffffffffc0204084:	2785                	addiw	a5,a5,1
ffffffffc0204086:	c01c                	sw	a5,0(s0)
ffffffffc0204088:	bff1                	j	ffffffffc0204064 <__up.constprop.0+0x3e>
ffffffffc020408a:	be9fc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020408e:	4905                	li	s2,1
ffffffffc0204090:	b775                	j	ffffffffc020403c <__up.constprop.0+0x16>
ffffffffc0204092:	00008697          	auipc	a3,0x8
ffffffffc0204096:	cde68693          	addi	a3,a3,-802 # ffffffffc020bd70 <default_pmm_manager+0xa38>
ffffffffc020409a:	00006617          	auipc	a2,0x6
ffffffffc020409e:	7b660613          	addi	a2,a2,1974 # ffffffffc020a850 <commands+0x210>
ffffffffc02040a2:	45e5                	li	a1,25
ffffffffc02040a4:	00008517          	auipc	a0,0x8
ffffffffc02040a8:	cf450513          	addi	a0,a0,-780 # ffffffffc020bd98 <default_pmm_manager+0xa60>
ffffffffc02040ac:	bf2fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02040b0 <sem_init>:
ffffffffc02040b0:	c10c                	sw	a1,0(a0)
ffffffffc02040b2:	0521                	addi	a0,a0,8
ffffffffc02040b4:	a825                	j	ffffffffc02040ec <wait_queue_init>

ffffffffc02040b6 <up>:
ffffffffc02040b6:	f71ff06f          	j	ffffffffc0204026 <__up.constprop.0>

ffffffffc02040ba <down>:
ffffffffc02040ba:	1141                	addi	sp,sp,-16
ffffffffc02040bc:	e406                	sd	ra,8(sp)
ffffffffc02040be:	eabff0ef          	jal	ra,ffffffffc0203f68 <__down.constprop.0>
ffffffffc02040c2:	2501                	sext.w	a0,a0
ffffffffc02040c4:	e501                	bnez	a0,ffffffffc02040cc <down+0x12>
ffffffffc02040c6:	60a2                	ld	ra,8(sp)
ffffffffc02040c8:	0141                	addi	sp,sp,16
ffffffffc02040ca:	8082                	ret
ffffffffc02040cc:	00008697          	auipc	a3,0x8
ffffffffc02040d0:	cdc68693          	addi	a3,a3,-804 # ffffffffc020bda8 <default_pmm_manager+0xa70>
ffffffffc02040d4:	00006617          	auipc	a2,0x6
ffffffffc02040d8:	77c60613          	addi	a2,a2,1916 # ffffffffc020a850 <commands+0x210>
ffffffffc02040dc:	04000593          	li	a1,64
ffffffffc02040e0:	00008517          	auipc	a0,0x8
ffffffffc02040e4:	cb850513          	addi	a0,a0,-840 # ffffffffc020bd98 <default_pmm_manager+0xa60>
ffffffffc02040e8:	bb6fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02040ec <wait_queue_init>:
ffffffffc02040ec:	e508                	sd	a0,8(a0)
ffffffffc02040ee:	e108                	sd	a0,0(a0)
ffffffffc02040f0:	8082                	ret

ffffffffc02040f2 <wait_queue_del>:
ffffffffc02040f2:	7198                	ld	a4,32(a1)
ffffffffc02040f4:	01858793          	addi	a5,a1,24
ffffffffc02040f8:	00e78b63          	beq	a5,a4,ffffffffc020410e <wait_queue_del+0x1c>
ffffffffc02040fc:	6994                	ld	a3,16(a1)
ffffffffc02040fe:	00a69863          	bne	a3,a0,ffffffffc020410e <wait_queue_del+0x1c>
ffffffffc0204102:	6d94                	ld	a3,24(a1)
ffffffffc0204104:	e698                	sd	a4,8(a3)
ffffffffc0204106:	e314                	sd	a3,0(a4)
ffffffffc0204108:	f19c                	sd	a5,32(a1)
ffffffffc020410a:	ed9c                	sd	a5,24(a1)
ffffffffc020410c:	8082                	ret
ffffffffc020410e:	1141                	addi	sp,sp,-16
ffffffffc0204110:	00008697          	auipc	a3,0x8
ffffffffc0204114:	cf868693          	addi	a3,a3,-776 # ffffffffc020be08 <default_pmm_manager+0xad0>
ffffffffc0204118:	00006617          	auipc	a2,0x6
ffffffffc020411c:	73860613          	addi	a2,a2,1848 # ffffffffc020a850 <commands+0x210>
ffffffffc0204120:	45f1                	li	a1,28
ffffffffc0204122:	00008517          	auipc	a0,0x8
ffffffffc0204126:	cce50513          	addi	a0,a0,-818 # ffffffffc020bdf0 <default_pmm_manager+0xab8>
ffffffffc020412a:	e406                	sd	ra,8(sp)
ffffffffc020412c:	b72fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204130 <wait_queue_first>:
ffffffffc0204130:	651c                	ld	a5,8(a0)
ffffffffc0204132:	00f50563          	beq	a0,a5,ffffffffc020413c <wait_queue_first+0xc>
ffffffffc0204136:	fe878513          	addi	a0,a5,-24
ffffffffc020413a:	8082                	ret
ffffffffc020413c:	4501                	li	a0,0
ffffffffc020413e:	8082                	ret

ffffffffc0204140 <wait_queue_empty>:
ffffffffc0204140:	651c                	ld	a5,8(a0)
ffffffffc0204142:	40a78533          	sub	a0,a5,a0
ffffffffc0204146:	00153513          	seqz	a0,a0
ffffffffc020414a:	8082                	ret

ffffffffc020414c <wait_in_queue>:
ffffffffc020414c:	711c                	ld	a5,32(a0)
ffffffffc020414e:	0561                	addi	a0,a0,24
ffffffffc0204150:	40a78533          	sub	a0,a5,a0
ffffffffc0204154:	00a03533          	snez	a0,a0
ffffffffc0204158:	8082                	ret

ffffffffc020415a <wakeup_wait>:
ffffffffc020415a:	e689                	bnez	a3,ffffffffc0204164 <wakeup_wait+0xa>
ffffffffc020415c:	6188                	ld	a0,0(a1)
ffffffffc020415e:	c590                	sw	a2,8(a1)
ffffffffc0204160:	2260206f          	j	ffffffffc0206386 <wakeup_proc>
ffffffffc0204164:	7198                	ld	a4,32(a1)
ffffffffc0204166:	01858793          	addi	a5,a1,24
ffffffffc020416a:	00e78e63          	beq	a5,a4,ffffffffc0204186 <wakeup_wait+0x2c>
ffffffffc020416e:	6994                	ld	a3,16(a1)
ffffffffc0204170:	00d51b63          	bne	a0,a3,ffffffffc0204186 <wakeup_wait+0x2c>
ffffffffc0204174:	6d94                	ld	a3,24(a1)
ffffffffc0204176:	6188                	ld	a0,0(a1)
ffffffffc0204178:	e698                	sd	a4,8(a3)
ffffffffc020417a:	e314                	sd	a3,0(a4)
ffffffffc020417c:	f19c                	sd	a5,32(a1)
ffffffffc020417e:	ed9c                	sd	a5,24(a1)
ffffffffc0204180:	c590                	sw	a2,8(a1)
ffffffffc0204182:	2040206f          	j	ffffffffc0206386 <wakeup_proc>
ffffffffc0204186:	1141                	addi	sp,sp,-16
ffffffffc0204188:	00008697          	auipc	a3,0x8
ffffffffc020418c:	c8068693          	addi	a3,a3,-896 # ffffffffc020be08 <default_pmm_manager+0xad0>
ffffffffc0204190:	00006617          	auipc	a2,0x6
ffffffffc0204194:	6c060613          	addi	a2,a2,1728 # ffffffffc020a850 <commands+0x210>
ffffffffc0204198:	45f1                	li	a1,28
ffffffffc020419a:	00008517          	auipc	a0,0x8
ffffffffc020419e:	c5650513          	addi	a0,a0,-938 # ffffffffc020bdf0 <default_pmm_manager+0xab8>
ffffffffc02041a2:	e406                	sd	ra,8(sp)
ffffffffc02041a4:	afafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02041a8 <wakeup_queue>:
ffffffffc02041a8:	651c                	ld	a5,8(a0)
ffffffffc02041aa:	0ca78563          	beq	a5,a0,ffffffffc0204274 <wakeup_queue+0xcc>
ffffffffc02041ae:	1101                	addi	sp,sp,-32
ffffffffc02041b0:	e822                	sd	s0,16(sp)
ffffffffc02041b2:	e426                	sd	s1,8(sp)
ffffffffc02041b4:	e04a                	sd	s2,0(sp)
ffffffffc02041b6:	ec06                	sd	ra,24(sp)
ffffffffc02041b8:	84aa                	mv	s1,a0
ffffffffc02041ba:	892e                	mv	s2,a1
ffffffffc02041bc:	fe878413          	addi	s0,a5,-24
ffffffffc02041c0:	e23d                	bnez	a2,ffffffffc0204226 <wakeup_queue+0x7e>
ffffffffc02041c2:	6008                	ld	a0,0(s0)
ffffffffc02041c4:	01242423          	sw	s2,8(s0)
ffffffffc02041c8:	1be020ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc02041cc:	701c                	ld	a5,32(s0)
ffffffffc02041ce:	01840713          	addi	a4,s0,24
ffffffffc02041d2:	02e78463          	beq	a5,a4,ffffffffc02041fa <wakeup_queue+0x52>
ffffffffc02041d6:	6818                	ld	a4,16(s0)
ffffffffc02041d8:	02e49163          	bne	s1,a4,ffffffffc02041fa <wakeup_queue+0x52>
ffffffffc02041dc:	02f48f63          	beq	s1,a5,ffffffffc020421a <wakeup_queue+0x72>
ffffffffc02041e0:	fe87b503          	ld	a0,-24(a5)
ffffffffc02041e4:	ff27a823          	sw	s2,-16(a5)
ffffffffc02041e8:	fe878413          	addi	s0,a5,-24
ffffffffc02041ec:	19a020ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc02041f0:	701c                	ld	a5,32(s0)
ffffffffc02041f2:	01840713          	addi	a4,s0,24
ffffffffc02041f6:	fee790e3          	bne	a5,a4,ffffffffc02041d6 <wakeup_queue+0x2e>
ffffffffc02041fa:	00008697          	auipc	a3,0x8
ffffffffc02041fe:	c0e68693          	addi	a3,a3,-1010 # ffffffffc020be08 <default_pmm_manager+0xad0>
ffffffffc0204202:	00006617          	auipc	a2,0x6
ffffffffc0204206:	64e60613          	addi	a2,a2,1614 # ffffffffc020a850 <commands+0x210>
ffffffffc020420a:	02200593          	li	a1,34
ffffffffc020420e:	00008517          	auipc	a0,0x8
ffffffffc0204212:	be250513          	addi	a0,a0,-1054 # ffffffffc020bdf0 <default_pmm_manager+0xab8>
ffffffffc0204216:	a88fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020421a:	60e2                	ld	ra,24(sp)
ffffffffc020421c:	6442                	ld	s0,16(sp)
ffffffffc020421e:	64a2                	ld	s1,8(sp)
ffffffffc0204220:	6902                	ld	s2,0(sp)
ffffffffc0204222:	6105                	addi	sp,sp,32
ffffffffc0204224:	8082                	ret
ffffffffc0204226:	6798                	ld	a4,8(a5)
ffffffffc0204228:	02f70763          	beq	a4,a5,ffffffffc0204256 <wakeup_queue+0xae>
ffffffffc020422c:	6814                	ld	a3,16(s0)
ffffffffc020422e:	02d49463          	bne	s1,a3,ffffffffc0204256 <wakeup_queue+0xae>
ffffffffc0204232:	6c14                	ld	a3,24(s0)
ffffffffc0204234:	6008                	ld	a0,0(s0)
ffffffffc0204236:	e698                	sd	a4,8(a3)
ffffffffc0204238:	e314                	sd	a3,0(a4)
ffffffffc020423a:	f01c                	sd	a5,32(s0)
ffffffffc020423c:	ec1c                	sd	a5,24(s0)
ffffffffc020423e:	01242423          	sw	s2,8(s0)
ffffffffc0204242:	144020ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc0204246:	6480                	ld	s0,8(s1)
ffffffffc0204248:	fc8489e3          	beq	s1,s0,ffffffffc020421a <wakeup_queue+0x72>
ffffffffc020424c:	6418                	ld	a4,8(s0)
ffffffffc020424e:	87a2                	mv	a5,s0
ffffffffc0204250:	1421                	addi	s0,s0,-24
ffffffffc0204252:	fce79de3          	bne	a5,a4,ffffffffc020422c <wakeup_queue+0x84>
ffffffffc0204256:	00008697          	auipc	a3,0x8
ffffffffc020425a:	bb268693          	addi	a3,a3,-1102 # ffffffffc020be08 <default_pmm_manager+0xad0>
ffffffffc020425e:	00006617          	auipc	a2,0x6
ffffffffc0204262:	5f260613          	addi	a2,a2,1522 # ffffffffc020a850 <commands+0x210>
ffffffffc0204266:	45f1                	li	a1,28
ffffffffc0204268:	00008517          	auipc	a0,0x8
ffffffffc020426c:	b8850513          	addi	a0,a0,-1144 # ffffffffc020bdf0 <default_pmm_manager+0xab8>
ffffffffc0204270:	a2efc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204274:	8082                	ret

ffffffffc0204276 <wait_current_set>:
ffffffffc0204276:	00091797          	auipc	a5,0x91
ffffffffc020427a:	6427b783          	ld	a5,1602(a5) # ffffffffc02958b8 <current>
ffffffffc020427e:	c39d                	beqz	a5,ffffffffc02042a4 <wait_current_set+0x2e>
ffffffffc0204280:	01858713          	addi	a4,a1,24
ffffffffc0204284:	800006b7          	lui	a3,0x80000
ffffffffc0204288:	ed98                	sd	a4,24(a1)
ffffffffc020428a:	e19c                	sd	a5,0(a1)
ffffffffc020428c:	c594                	sw	a3,8(a1)
ffffffffc020428e:	4685                	li	a3,1
ffffffffc0204290:	c394                	sw	a3,0(a5)
ffffffffc0204292:	0ec7a623          	sw	a2,236(a5)
ffffffffc0204296:	611c                	ld	a5,0(a0)
ffffffffc0204298:	e988                	sd	a0,16(a1)
ffffffffc020429a:	e118                	sd	a4,0(a0)
ffffffffc020429c:	e798                	sd	a4,8(a5)
ffffffffc020429e:	f188                	sd	a0,32(a1)
ffffffffc02042a0:	ed9c                	sd	a5,24(a1)
ffffffffc02042a2:	8082                	ret
ffffffffc02042a4:	1141                	addi	sp,sp,-16
ffffffffc02042a6:	00008697          	auipc	a3,0x8
ffffffffc02042aa:	ba268693          	addi	a3,a3,-1118 # ffffffffc020be48 <default_pmm_manager+0xb10>
ffffffffc02042ae:	00006617          	auipc	a2,0x6
ffffffffc02042b2:	5a260613          	addi	a2,a2,1442 # ffffffffc020a850 <commands+0x210>
ffffffffc02042b6:	07400593          	li	a1,116
ffffffffc02042ba:	00008517          	auipc	a0,0x8
ffffffffc02042be:	b3650513          	addi	a0,a0,-1226 # ffffffffc020bdf0 <default_pmm_manager+0xab8>
ffffffffc02042c2:	e406                	sd	ra,8(sp)
ffffffffc02042c4:	9dafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02042c8 <get_fd_array.part.0>:
ffffffffc02042c8:	1141                	addi	sp,sp,-16
ffffffffc02042ca:	00008697          	auipc	a3,0x8
ffffffffc02042ce:	b8e68693          	addi	a3,a3,-1138 # ffffffffc020be58 <default_pmm_manager+0xb20>
ffffffffc02042d2:	00006617          	auipc	a2,0x6
ffffffffc02042d6:	57e60613          	addi	a2,a2,1406 # ffffffffc020a850 <commands+0x210>
ffffffffc02042da:	45d1                	li	a1,20
ffffffffc02042dc:	00008517          	auipc	a0,0x8
ffffffffc02042e0:	bac50513          	addi	a0,a0,-1108 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc02042e4:	e406                	sd	ra,8(sp)
ffffffffc02042e6:	9b8fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02042ea <fd_array_alloc>:
ffffffffc02042ea:	00091797          	auipc	a5,0x91
ffffffffc02042ee:	5ce7b783          	ld	a5,1486(a5) # ffffffffc02958b8 <current>
ffffffffc02042f2:	1487b783          	ld	a5,328(a5)
ffffffffc02042f6:	1141                	addi	sp,sp,-16
ffffffffc02042f8:	e406                	sd	ra,8(sp)
ffffffffc02042fa:	c3a5                	beqz	a5,ffffffffc020435a <fd_array_alloc+0x70>
ffffffffc02042fc:	4b98                	lw	a4,16(a5)
ffffffffc02042fe:	04e05e63          	blez	a4,ffffffffc020435a <fd_array_alloc+0x70>
ffffffffc0204302:	775d                	lui	a4,0xffff7
ffffffffc0204304:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd611d1>
ffffffffc0204308:	679c                	ld	a5,8(a5)
ffffffffc020430a:	02e50863          	beq	a0,a4,ffffffffc020433a <fd_array_alloc+0x50>
ffffffffc020430e:	04700713          	li	a4,71
ffffffffc0204312:	04a76263          	bltu	a4,a0,ffffffffc0204356 <fd_array_alloc+0x6c>
ffffffffc0204316:	00351713          	slli	a4,a0,0x3
ffffffffc020431a:	40a70533          	sub	a0,a4,a0
ffffffffc020431e:	050e                	slli	a0,a0,0x3
ffffffffc0204320:	97aa                	add	a5,a5,a0
ffffffffc0204322:	4398                	lw	a4,0(a5)
ffffffffc0204324:	e71d                	bnez	a4,ffffffffc0204352 <fd_array_alloc+0x68>
ffffffffc0204326:	5b88                	lw	a0,48(a5)
ffffffffc0204328:	e91d                	bnez	a0,ffffffffc020435e <fd_array_alloc+0x74>
ffffffffc020432a:	4705                	li	a4,1
ffffffffc020432c:	c398                	sw	a4,0(a5)
ffffffffc020432e:	0207b423          	sd	zero,40(a5)
ffffffffc0204332:	e19c                	sd	a5,0(a1)
ffffffffc0204334:	60a2                	ld	ra,8(sp)
ffffffffc0204336:	0141                	addi	sp,sp,16
ffffffffc0204338:	8082                	ret
ffffffffc020433a:	6685                	lui	a3,0x1
ffffffffc020433c:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204340:	96be                	add	a3,a3,a5
ffffffffc0204342:	4398                	lw	a4,0(a5)
ffffffffc0204344:	d36d                	beqz	a4,ffffffffc0204326 <fd_array_alloc+0x3c>
ffffffffc0204346:	03878793          	addi	a5,a5,56
ffffffffc020434a:	fef69ce3          	bne	a3,a5,ffffffffc0204342 <fd_array_alloc+0x58>
ffffffffc020434e:	5529                	li	a0,-22
ffffffffc0204350:	b7d5                	j	ffffffffc0204334 <fd_array_alloc+0x4a>
ffffffffc0204352:	5545                	li	a0,-15
ffffffffc0204354:	b7c5                	j	ffffffffc0204334 <fd_array_alloc+0x4a>
ffffffffc0204356:	5575                	li	a0,-3
ffffffffc0204358:	bff1                	j	ffffffffc0204334 <fd_array_alloc+0x4a>
ffffffffc020435a:	f6fff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>
ffffffffc020435e:	00008697          	auipc	a3,0x8
ffffffffc0204362:	b3a68693          	addi	a3,a3,-1222 # ffffffffc020be98 <default_pmm_manager+0xb60>
ffffffffc0204366:	00006617          	auipc	a2,0x6
ffffffffc020436a:	4ea60613          	addi	a2,a2,1258 # ffffffffc020a850 <commands+0x210>
ffffffffc020436e:	03b00593          	li	a1,59
ffffffffc0204372:	00008517          	auipc	a0,0x8
ffffffffc0204376:	b1650513          	addi	a0,a0,-1258 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc020437a:	924fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020437e <fd_array_free>:
ffffffffc020437e:	411c                	lw	a5,0(a0)
ffffffffc0204380:	1141                	addi	sp,sp,-16
ffffffffc0204382:	e022                	sd	s0,0(sp)
ffffffffc0204384:	e406                	sd	ra,8(sp)
ffffffffc0204386:	4705                	li	a4,1
ffffffffc0204388:	842a                	mv	s0,a0
ffffffffc020438a:	04e78063          	beq	a5,a4,ffffffffc02043ca <fd_array_free+0x4c>
ffffffffc020438e:	470d                	li	a4,3
ffffffffc0204390:	04e79563          	bne	a5,a4,ffffffffc02043da <fd_array_free+0x5c>
ffffffffc0204394:	591c                	lw	a5,48(a0)
ffffffffc0204396:	c38d                	beqz	a5,ffffffffc02043b8 <fd_array_free+0x3a>
ffffffffc0204398:	00008697          	auipc	a3,0x8
ffffffffc020439c:	b0068693          	addi	a3,a3,-1280 # ffffffffc020be98 <default_pmm_manager+0xb60>
ffffffffc02043a0:	00006617          	auipc	a2,0x6
ffffffffc02043a4:	4b060613          	addi	a2,a2,1200 # ffffffffc020a850 <commands+0x210>
ffffffffc02043a8:	04500593          	li	a1,69
ffffffffc02043ac:	00008517          	auipc	a0,0x8
ffffffffc02043b0:	adc50513          	addi	a0,a0,-1316 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc02043b4:	8eafc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02043b8:	7408                	ld	a0,40(s0)
ffffffffc02043ba:	643020ef          	jal	ra,ffffffffc02071fc <vfs_close>
ffffffffc02043be:	60a2                	ld	ra,8(sp)
ffffffffc02043c0:	00042023          	sw	zero,0(s0)
ffffffffc02043c4:	6402                	ld	s0,0(sp)
ffffffffc02043c6:	0141                	addi	sp,sp,16
ffffffffc02043c8:	8082                	ret
ffffffffc02043ca:	591c                	lw	a5,48(a0)
ffffffffc02043cc:	f7f1                	bnez	a5,ffffffffc0204398 <fd_array_free+0x1a>
ffffffffc02043ce:	60a2                	ld	ra,8(sp)
ffffffffc02043d0:	00042023          	sw	zero,0(s0)
ffffffffc02043d4:	6402                	ld	s0,0(sp)
ffffffffc02043d6:	0141                	addi	sp,sp,16
ffffffffc02043d8:	8082                	ret
ffffffffc02043da:	00008697          	auipc	a3,0x8
ffffffffc02043de:	af668693          	addi	a3,a3,-1290 # ffffffffc020bed0 <default_pmm_manager+0xb98>
ffffffffc02043e2:	00006617          	auipc	a2,0x6
ffffffffc02043e6:	46e60613          	addi	a2,a2,1134 # ffffffffc020a850 <commands+0x210>
ffffffffc02043ea:	04400593          	li	a1,68
ffffffffc02043ee:	00008517          	auipc	a0,0x8
ffffffffc02043f2:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc02043f6:	8a8fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02043fa <fd_array_release>:
ffffffffc02043fa:	4118                	lw	a4,0(a0)
ffffffffc02043fc:	1141                	addi	sp,sp,-16
ffffffffc02043fe:	e406                	sd	ra,8(sp)
ffffffffc0204400:	4685                	li	a3,1
ffffffffc0204402:	3779                	addiw	a4,a4,-2
ffffffffc0204404:	04e6e063          	bltu	a3,a4,ffffffffc0204444 <fd_array_release+0x4a>
ffffffffc0204408:	5918                	lw	a4,48(a0)
ffffffffc020440a:	00e05d63          	blez	a4,ffffffffc0204424 <fd_array_release+0x2a>
ffffffffc020440e:	fff7069b          	addiw	a3,a4,-1
ffffffffc0204412:	d914                	sw	a3,48(a0)
ffffffffc0204414:	c681                	beqz	a3,ffffffffc020441c <fd_array_release+0x22>
ffffffffc0204416:	60a2                	ld	ra,8(sp)
ffffffffc0204418:	0141                	addi	sp,sp,16
ffffffffc020441a:	8082                	ret
ffffffffc020441c:	60a2                	ld	ra,8(sp)
ffffffffc020441e:	0141                	addi	sp,sp,16
ffffffffc0204420:	f5fff06f          	j	ffffffffc020437e <fd_array_free>
ffffffffc0204424:	00008697          	auipc	a3,0x8
ffffffffc0204428:	b1c68693          	addi	a3,a3,-1252 # ffffffffc020bf40 <default_pmm_manager+0xc08>
ffffffffc020442c:	00006617          	auipc	a2,0x6
ffffffffc0204430:	42460613          	addi	a2,a2,1060 # ffffffffc020a850 <commands+0x210>
ffffffffc0204434:	05600593          	li	a1,86
ffffffffc0204438:	00008517          	auipc	a0,0x8
ffffffffc020443c:	a5050513          	addi	a0,a0,-1456 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204440:	85efc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204444:	00008697          	auipc	a3,0x8
ffffffffc0204448:	ac468693          	addi	a3,a3,-1340 # ffffffffc020bf08 <default_pmm_manager+0xbd0>
ffffffffc020444c:	00006617          	auipc	a2,0x6
ffffffffc0204450:	40460613          	addi	a2,a2,1028 # ffffffffc020a850 <commands+0x210>
ffffffffc0204454:	05500593          	li	a1,85
ffffffffc0204458:	00008517          	auipc	a0,0x8
ffffffffc020445c:	a3050513          	addi	a0,a0,-1488 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204460:	83efc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204464 <fd_array_open.part.0>:
ffffffffc0204464:	1141                	addi	sp,sp,-16
ffffffffc0204466:	00008697          	auipc	a3,0x8
ffffffffc020446a:	af268693          	addi	a3,a3,-1294 # ffffffffc020bf58 <default_pmm_manager+0xc20>
ffffffffc020446e:	00006617          	auipc	a2,0x6
ffffffffc0204472:	3e260613          	addi	a2,a2,994 # ffffffffc020a850 <commands+0x210>
ffffffffc0204476:	05f00593          	li	a1,95
ffffffffc020447a:	00008517          	auipc	a0,0x8
ffffffffc020447e:	a0e50513          	addi	a0,a0,-1522 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204482:	e406                	sd	ra,8(sp)
ffffffffc0204484:	81afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204488 <fd_array_init>:
ffffffffc0204488:	4781                	li	a5,0
ffffffffc020448a:	04800713          	li	a4,72
ffffffffc020448e:	cd1c                	sw	a5,24(a0)
ffffffffc0204490:	02052823          	sw	zero,48(a0)
ffffffffc0204494:	00052023          	sw	zero,0(a0)
ffffffffc0204498:	2785                	addiw	a5,a5,1
ffffffffc020449a:	03850513          	addi	a0,a0,56
ffffffffc020449e:	fee798e3          	bne	a5,a4,ffffffffc020448e <fd_array_init+0x6>
ffffffffc02044a2:	8082                	ret

ffffffffc02044a4 <fd_array_close>:
ffffffffc02044a4:	4118                	lw	a4,0(a0)
ffffffffc02044a6:	1141                	addi	sp,sp,-16
ffffffffc02044a8:	e406                	sd	ra,8(sp)
ffffffffc02044aa:	e022                	sd	s0,0(sp)
ffffffffc02044ac:	4789                	li	a5,2
ffffffffc02044ae:	04f71a63          	bne	a4,a5,ffffffffc0204502 <fd_array_close+0x5e>
ffffffffc02044b2:	591c                	lw	a5,48(a0)
ffffffffc02044b4:	842a                	mv	s0,a0
ffffffffc02044b6:	02f05663          	blez	a5,ffffffffc02044e2 <fd_array_close+0x3e>
ffffffffc02044ba:	37fd                	addiw	a5,a5,-1
ffffffffc02044bc:	470d                	li	a4,3
ffffffffc02044be:	c118                	sw	a4,0(a0)
ffffffffc02044c0:	d91c                	sw	a5,48(a0)
ffffffffc02044c2:	0007871b          	sext.w	a4,a5
ffffffffc02044c6:	c709                	beqz	a4,ffffffffc02044d0 <fd_array_close+0x2c>
ffffffffc02044c8:	60a2                	ld	ra,8(sp)
ffffffffc02044ca:	6402                	ld	s0,0(sp)
ffffffffc02044cc:	0141                	addi	sp,sp,16
ffffffffc02044ce:	8082                	ret
ffffffffc02044d0:	7508                	ld	a0,40(a0)
ffffffffc02044d2:	52b020ef          	jal	ra,ffffffffc02071fc <vfs_close>
ffffffffc02044d6:	60a2                	ld	ra,8(sp)
ffffffffc02044d8:	00042023          	sw	zero,0(s0)
ffffffffc02044dc:	6402                	ld	s0,0(sp)
ffffffffc02044de:	0141                	addi	sp,sp,16
ffffffffc02044e0:	8082                	ret
ffffffffc02044e2:	00008697          	auipc	a3,0x8
ffffffffc02044e6:	a5e68693          	addi	a3,a3,-1442 # ffffffffc020bf40 <default_pmm_manager+0xc08>
ffffffffc02044ea:	00006617          	auipc	a2,0x6
ffffffffc02044ee:	36660613          	addi	a2,a2,870 # ffffffffc020a850 <commands+0x210>
ffffffffc02044f2:	06800593          	li	a1,104
ffffffffc02044f6:	00008517          	auipc	a0,0x8
ffffffffc02044fa:	99250513          	addi	a0,a0,-1646 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc02044fe:	fa1fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204502:	00008697          	auipc	a3,0x8
ffffffffc0204506:	9ae68693          	addi	a3,a3,-1618 # ffffffffc020beb0 <default_pmm_manager+0xb78>
ffffffffc020450a:	00006617          	auipc	a2,0x6
ffffffffc020450e:	34660613          	addi	a2,a2,838 # ffffffffc020a850 <commands+0x210>
ffffffffc0204512:	06700593          	li	a1,103
ffffffffc0204516:	00008517          	auipc	a0,0x8
ffffffffc020451a:	97250513          	addi	a0,a0,-1678 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc020451e:	f81fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204522 <fd_array_dup>:
ffffffffc0204522:	7179                	addi	sp,sp,-48
ffffffffc0204524:	e84a                	sd	s2,16(sp)
ffffffffc0204526:	00052903          	lw	s2,0(a0)
ffffffffc020452a:	f406                	sd	ra,40(sp)
ffffffffc020452c:	f022                	sd	s0,32(sp)
ffffffffc020452e:	ec26                	sd	s1,24(sp)
ffffffffc0204530:	e44e                	sd	s3,8(sp)
ffffffffc0204532:	4785                	li	a5,1
ffffffffc0204534:	04f91663          	bne	s2,a5,ffffffffc0204580 <fd_array_dup+0x5e>
ffffffffc0204538:	0005a983          	lw	s3,0(a1)
ffffffffc020453c:	4789                	li	a5,2
ffffffffc020453e:	04f99163          	bne	s3,a5,ffffffffc0204580 <fd_array_dup+0x5e>
ffffffffc0204542:	7584                	ld	s1,40(a1)
ffffffffc0204544:	699c                	ld	a5,16(a1)
ffffffffc0204546:	7194                	ld	a3,32(a1)
ffffffffc0204548:	6598                	ld	a4,8(a1)
ffffffffc020454a:	842a                	mv	s0,a0
ffffffffc020454c:	e91c                	sd	a5,16(a0)
ffffffffc020454e:	f114                	sd	a3,32(a0)
ffffffffc0204550:	e518                	sd	a4,8(a0)
ffffffffc0204552:	8526                	mv	a0,s1
ffffffffc0204554:	406020ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0204558:	8526                	mv	a0,s1
ffffffffc020455a:	40c020ef          	jal	ra,ffffffffc0206966 <inode_open_inc>
ffffffffc020455e:	401c                	lw	a5,0(s0)
ffffffffc0204560:	f404                	sd	s1,40(s0)
ffffffffc0204562:	03279f63          	bne	a5,s2,ffffffffc02045a0 <fd_array_dup+0x7e>
ffffffffc0204566:	cc8d                	beqz	s1,ffffffffc02045a0 <fd_array_dup+0x7e>
ffffffffc0204568:	581c                	lw	a5,48(s0)
ffffffffc020456a:	01342023          	sw	s3,0(s0)
ffffffffc020456e:	70a2                	ld	ra,40(sp)
ffffffffc0204570:	2785                	addiw	a5,a5,1
ffffffffc0204572:	d81c                	sw	a5,48(s0)
ffffffffc0204574:	7402                	ld	s0,32(sp)
ffffffffc0204576:	64e2                	ld	s1,24(sp)
ffffffffc0204578:	6942                	ld	s2,16(sp)
ffffffffc020457a:	69a2                	ld	s3,8(sp)
ffffffffc020457c:	6145                	addi	sp,sp,48
ffffffffc020457e:	8082                	ret
ffffffffc0204580:	00008697          	auipc	a3,0x8
ffffffffc0204584:	a0868693          	addi	a3,a3,-1528 # ffffffffc020bf88 <default_pmm_manager+0xc50>
ffffffffc0204588:	00006617          	auipc	a2,0x6
ffffffffc020458c:	2c860613          	addi	a2,a2,712 # ffffffffc020a850 <commands+0x210>
ffffffffc0204590:	07300593          	li	a1,115
ffffffffc0204594:	00008517          	auipc	a0,0x8
ffffffffc0204598:	8f450513          	addi	a0,a0,-1804 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc020459c:	f03fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02045a0:	ec5ff0ef          	jal	ra,ffffffffc0204464 <fd_array_open.part.0>

ffffffffc02045a4 <file_testfd>:
ffffffffc02045a4:	04700793          	li	a5,71
ffffffffc02045a8:	04a7e263          	bltu	a5,a0,ffffffffc02045ec <file_testfd+0x48>
ffffffffc02045ac:	00091797          	auipc	a5,0x91
ffffffffc02045b0:	30c7b783          	ld	a5,780(a5) # ffffffffc02958b8 <current>
ffffffffc02045b4:	1487b783          	ld	a5,328(a5)
ffffffffc02045b8:	cf85                	beqz	a5,ffffffffc02045f0 <file_testfd+0x4c>
ffffffffc02045ba:	4b98                	lw	a4,16(a5)
ffffffffc02045bc:	02e05a63          	blez	a4,ffffffffc02045f0 <file_testfd+0x4c>
ffffffffc02045c0:	6798                	ld	a4,8(a5)
ffffffffc02045c2:	00351793          	slli	a5,a0,0x3
ffffffffc02045c6:	8f89                	sub	a5,a5,a0
ffffffffc02045c8:	078e                	slli	a5,a5,0x3
ffffffffc02045ca:	97ba                	add	a5,a5,a4
ffffffffc02045cc:	4394                	lw	a3,0(a5)
ffffffffc02045ce:	4709                	li	a4,2
ffffffffc02045d0:	00e69e63          	bne	a3,a4,ffffffffc02045ec <file_testfd+0x48>
ffffffffc02045d4:	4f98                	lw	a4,24(a5)
ffffffffc02045d6:	00a71b63          	bne	a4,a0,ffffffffc02045ec <file_testfd+0x48>
ffffffffc02045da:	c199                	beqz	a1,ffffffffc02045e0 <file_testfd+0x3c>
ffffffffc02045dc:	6788                	ld	a0,8(a5)
ffffffffc02045de:	c901                	beqz	a0,ffffffffc02045ee <file_testfd+0x4a>
ffffffffc02045e0:	4505                	li	a0,1
ffffffffc02045e2:	c611                	beqz	a2,ffffffffc02045ee <file_testfd+0x4a>
ffffffffc02045e4:	6b88                	ld	a0,16(a5)
ffffffffc02045e6:	00a03533          	snez	a0,a0
ffffffffc02045ea:	8082                	ret
ffffffffc02045ec:	4501                	li	a0,0
ffffffffc02045ee:	8082                	ret
ffffffffc02045f0:	1141                	addi	sp,sp,-16
ffffffffc02045f2:	e406                	sd	ra,8(sp)
ffffffffc02045f4:	cd5ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc02045f8 <file_open>:
ffffffffc02045f8:	711d                	addi	sp,sp,-96
ffffffffc02045fa:	ec86                	sd	ra,88(sp)
ffffffffc02045fc:	e8a2                	sd	s0,80(sp)
ffffffffc02045fe:	e4a6                	sd	s1,72(sp)
ffffffffc0204600:	e0ca                	sd	s2,64(sp)
ffffffffc0204602:	fc4e                	sd	s3,56(sp)
ffffffffc0204604:	f852                	sd	s4,48(sp)
ffffffffc0204606:	0035f793          	andi	a5,a1,3
ffffffffc020460a:	470d                	li	a4,3
ffffffffc020460c:	0ce78163          	beq	a5,a4,ffffffffc02046ce <file_open+0xd6>
ffffffffc0204610:	078e                	slli	a5,a5,0x3
ffffffffc0204612:	00008717          	auipc	a4,0x8
ffffffffc0204616:	be670713          	addi	a4,a4,-1050 # ffffffffc020c1f8 <CSWTCH.79>
ffffffffc020461a:	892a                	mv	s2,a0
ffffffffc020461c:	00008697          	auipc	a3,0x8
ffffffffc0204620:	bc468693          	addi	a3,a3,-1084 # ffffffffc020c1e0 <CSWTCH.78>
ffffffffc0204624:	755d                	lui	a0,0xffff7
ffffffffc0204626:	96be                	add	a3,a3,a5
ffffffffc0204628:	84ae                	mv	s1,a1
ffffffffc020462a:	97ba                	add	a5,a5,a4
ffffffffc020462c:	858a                	mv	a1,sp
ffffffffc020462e:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd611d1>
ffffffffc0204632:	0006ba03          	ld	s4,0(a3)
ffffffffc0204636:	0007b983          	ld	s3,0(a5)
ffffffffc020463a:	cb1ff0ef          	jal	ra,ffffffffc02042ea <fd_array_alloc>
ffffffffc020463e:	842a                	mv	s0,a0
ffffffffc0204640:	c911                	beqz	a0,ffffffffc0204654 <file_open+0x5c>
ffffffffc0204642:	60e6                	ld	ra,88(sp)
ffffffffc0204644:	8522                	mv	a0,s0
ffffffffc0204646:	6446                	ld	s0,80(sp)
ffffffffc0204648:	64a6                	ld	s1,72(sp)
ffffffffc020464a:	6906                	ld	s2,64(sp)
ffffffffc020464c:	79e2                	ld	s3,56(sp)
ffffffffc020464e:	7a42                	ld	s4,48(sp)
ffffffffc0204650:	6125                	addi	sp,sp,96
ffffffffc0204652:	8082                	ret
ffffffffc0204654:	0030                	addi	a2,sp,8
ffffffffc0204656:	85a6                	mv	a1,s1
ffffffffc0204658:	854a                	mv	a0,s2
ffffffffc020465a:	1fd020ef          	jal	ra,ffffffffc0207056 <vfs_open>
ffffffffc020465e:	842a                	mv	s0,a0
ffffffffc0204660:	e13d                	bnez	a0,ffffffffc02046c6 <file_open+0xce>
ffffffffc0204662:	6782                	ld	a5,0(sp)
ffffffffc0204664:	0204f493          	andi	s1,s1,32
ffffffffc0204668:	6422                	ld	s0,8(sp)
ffffffffc020466a:	0207b023          	sd	zero,32(a5)
ffffffffc020466e:	c885                	beqz	s1,ffffffffc020469e <file_open+0xa6>
ffffffffc0204670:	c03d                	beqz	s0,ffffffffc02046d6 <file_open+0xde>
ffffffffc0204672:	783c                	ld	a5,112(s0)
ffffffffc0204674:	c3ad                	beqz	a5,ffffffffc02046d6 <file_open+0xde>
ffffffffc0204676:	779c                	ld	a5,40(a5)
ffffffffc0204678:	cfb9                	beqz	a5,ffffffffc02046d6 <file_open+0xde>
ffffffffc020467a:	8522                	mv	a0,s0
ffffffffc020467c:	00008597          	auipc	a1,0x8
ffffffffc0204680:	99458593          	addi	a1,a1,-1644 # ffffffffc020c010 <default_pmm_manager+0xcd8>
ffffffffc0204684:	2ee020ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0204688:	783c                	ld	a5,112(s0)
ffffffffc020468a:	6522                	ld	a0,8(sp)
ffffffffc020468c:	080c                	addi	a1,sp,16
ffffffffc020468e:	779c                	ld	a5,40(a5)
ffffffffc0204690:	9782                	jalr	a5
ffffffffc0204692:	842a                	mv	s0,a0
ffffffffc0204694:	e515                	bnez	a0,ffffffffc02046c0 <file_open+0xc8>
ffffffffc0204696:	6782                	ld	a5,0(sp)
ffffffffc0204698:	7722                	ld	a4,40(sp)
ffffffffc020469a:	6422                	ld	s0,8(sp)
ffffffffc020469c:	f398                	sd	a4,32(a5)
ffffffffc020469e:	4394                	lw	a3,0(a5)
ffffffffc02046a0:	f780                	sd	s0,40(a5)
ffffffffc02046a2:	0147b423          	sd	s4,8(a5)
ffffffffc02046a6:	0137b823          	sd	s3,16(a5)
ffffffffc02046aa:	4705                	li	a4,1
ffffffffc02046ac:	02e69363          	bne	a3,a4,ffffffffc02046d2 <file_open+0xda>
ffffffffc02046b0:	c00d                	beqz	s0,ffffffffc02046d2 <file_open+0xda>
ffffffffc02046b2:	5b98                	lw	a4,48(a5)
ffffffffc02046b4:	4689                	li	a3,2
ffffffffc02046b6:	4f80                	lw	s0,24(a5)
ffffffffc02046b8:	2705                	addiw	a4,a4,1
ffffffffc02046ba:	c394                	sw	a3,0(a5)
ffffffffc02046bc:	db98                	sw	a4,48(a5)
ffffffffc02046be:	b751                	j	ffffffffc0204642 <file_open+0x4a>
ffffffffc02046c0:	6522                	ld	a0,8(sp)
ffffffffc02046c2:	33b020ef          	jal	ra,ffffffffc02071fc <vfs_close>
ffffffffc02046c6:	6502                	ld	a0,0(sp)
ffffffffc02046c8:	cb7ff0ef          	jal	ra,ffffffffc020437e <fd_array_free>
ffffffffc02046cc:	bf9d                	j	ffffffffc0204642 <file_open+0x4a>
ffffffffc02046ce:	5475                	li	s0,-3
ffffffffc02046d0:	bf8d                	j	ffffffffc0204642 <file_open+0x4a>
ffffffffc02046d2:	d93ff0ef          	jal	ra,ffffffffc0204464 <fd_array_open.part.0>
ffffffffc02046d6:	00008697          	auipc	a3,0x8
ffffffffc02046da:	8ea68693          	addi	a3,a3,-1814 # ffffffffc020bfc0 <default_pmm_manager+0xc88>
ffffffffc02046de:	00006617          	auipc	a2,0x6
ffffffffc02046e2:	17260613          	addi	a2,a2,370 # ffffffffc020a850 <commands+0x210>
ffffffffc02046e6:	0b500593          	li	a1,181
ffffffffc02046ea:	00007517          	auipc	a0,0x7
ffffffffc02046ee:	79e50513          	addi	a0,a0,1950 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc02046f2:	dadfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02046f6 <file_close>:
ffffffffc02046f6:	04700713          	li	a4,71
ffffffffc02046fa:	04a76563          	bltu	a4,a0,ffffffffc0204744 <file_close+0x4e>
ffffffffc02046fe:	00091717          	auipc	a4,0x91
ffffffffc0204702:	1ba73703          	ld	a4,442(a4) # ffffffffc02958b8 <current>
ffffffffc0204706:	14873703          	ld	a4,328(a4)
ffffffffc020470a:	1141                	addi	sp,sp,-16
ffffffffc020470c:	e406                	sd	ra,8(sp)
ffffffffc020470e:	cf0d                	beqz	a4,ffffffffc0204748 <file_close+0x52>
ffffffffc0204710:	4b14                	lw	a3,16(a4)
ffffffffc0204712:	02d05b63          	blez	a3,ffffffffc0204748 <file_close+0x52>
ffffffffc0204716:	6718                	ld	a4,8(a4)
ffffffffc0204718:	87aa                	mv	a5,a0
ffffffffc020471a:	050e                	slli	a0,a0,0x3
ffffffffc020471c:	8d1d                	sub	a0,a0,a5
ffffffffc020471e:	050e                	slli	a0,a0,0x3
ffffffffc0204720:	953a                	add	a0,a0,a4
ffffffffc0204722:	4114                	lw	a3,0(a0)
ffffffffc0204724:	4709                	li	a4,2
ffffffffc0204726:	00e69b63          	bne	a3,a4,ffffffffc020473c <file_close+0x46>
ffffffffc020472a:	4d18                	lw	a4,24(a0)
ffffffffc020472c:	00f71863          	bne	a4,a5,ffffffffc020473c <file_close+0x46>
ffffffffc0204730:	d75ff0ef          	jal	ra,ffffffffc02044a4 <fd_array_close>
ffffffffc0204734:	60a2                	ld	ra,8(sp)
ffffffffc0204736:	4501                	li	a0,0
ffffffffc0204738:	0141                	addi	sp,sp,16
ffffffffc020473a:	8082                	ret
ffffffffc020473c:	60a2                	ld	ra,8(sp)
ffffffffc020473e:	5575                	li	a0,-3
ffffffffc0204740:	0141                	addi	sp,sp,16
ffffffffc0204742:	8082                	ret
ffffffffc0204744:	5575                	li	a0,-3
ffffffffc0204746:	8082                	ret
ffffffffc0204748:	b81ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc020474c <file_read>:
ffffffffc020474c:	715d                	addi	sp,sp,-80
ffffffffc020474e:	e486                	sd	ra,72(sp)
ffffffffc0204750:	e0a2                	sd	s0,64(sp)
ffffffffc0204752:	fc26                	sd	s1,56(sp)
ffffffffc0204754:	f84a                	sd	s2,48(sp)
ffffffffc0204756:	f44e                	sd	s3,40(sp)
ffffffffc0204758:	f052                	sd	s4,32(sp)
ffffffffc020475a:	0006b023          	sd	zero,0(a3)
ffffffffc020475e:	04700793          	li	a5,71
ffffffffc0204762:	0aa7e463          	bltu	a5,a0,ffffffffc020480a <file_read+0xbe>
ffffffffc0204766:	00091797          	auipc	a5,0x91
ffffffffc020476a:	1527b783          	ld	a5,338(a5) # ffffffffc02958b8 <current>
ffffffffc020476e:	1487b783          	ld	a5,328(a5)
ffffffffc0204772:	cfd1                	beqz	a5,ffffffffc020480e <file_read+0xc2>
ffffffffc0204774:	4b98                	lw	a4,16(a5)
ffffffffc0204776:	08e05c63          	blez	a4,ffffffffc020480e <file_read+0xc2>
ffffffffc020477a:	6780                	ld	s0,8(a5)
ffffffffc020477c:	00351793          	slli	a5,a0,0x3
ffffffffc0204780:	8f89                	sub	a5,a5,a0
ffffffffc0204782:	078e                	slli	a5,a5,0x3
ffffffffc0204784:	943e                	add	s0,s0,a5
ffffffffc0204786:	00042983          	lw	s3,0(s0)
ffffffffc020478a:	4789                	li	a5,2
ffffffffc020478c:	06f99f63          	bne	s3,a5,ffffffffc020480a <file_read+0xbe>
ffffffffc0204790:	4c1c                	lw	a5,24(s0)
ffffffffc0204792:	06a79c63          	bne	a5,a0,ffffffffc020480a <file_read+0xbe>
ffffffffc0204796:	641c                	ld	a5,8(s0)
ffffffffc0204798:	cbad                	beqz	a5,ffffffffc020480a <file_read+0xbe>
ffffffffc020479a:	581c                	lw	a5,48(s0)
ffffffffc020479c:	8a36                	mv	s4,a3
ffffffffc020479e:	7014                	ld	a3,32(s0)
ffffffffc02047a0:	2785                	addiw	a5,a5,1
ffffffffc02047a2:	850a                	mv	a0,sp
ffffffffc02047a4:	d81c                	sw	a5,48(s0)
ffffffffc02047a6:	792000ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc02047aa:	02843903          	ld	s2,40(s0)
ffffffffc02047ae:	84aa                	mv	s1,a0
ffffffffc02047b0:	06090163          	beqz	s2,ffffffffc0204812 <file_read+0xc6>
ffffffffc02047b4:	07093783          	ld	a5,112(s2)
ffffffffc02047b8:	cfa9                	beqz	a5,ffffffffc0204812 <file_read+0xc6>
ffffffffc02047ba:	6f9c                	ld	a5,24(a5)
ffffffffc02047bc:	cbb9                	beqz	a5,ffffffffc0204812 <file_read+0xc6>
ffffffffc02047be:	00008597          	auipc	a1,0x8
ffffffffc02047c2:	8aa58593          	addi	a1,a1,-1878 # ffffffffc020c068 <default_pmm_manager+0xd30>
ffffffffc02047c6:	854a                	mv	a0,s2
ffffffffc02047c8:	1aa020ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02047cc:	07093783          	ld	a5,112(s2)
ffffffffc02047d0:	7408                	ld	a0,40(s0)
ffffffffc02047d2:	85a6                	mv	a1,s1
ffffffffc02047d4:	6f9c                	ld	a5,24(a5)
ffffffffc02047d6:	9782                	jalr	a5
ffffffffc02047d8:	689c                	ld	a5,16(s1)
ffffffffc02047da:	6c94                	ld	a3,24(s1)
ffffffffc02047dc:	4018                	lw	a4,0(s0)
ffffffffc02047de:	84aa                	mv	s1,a0
ffffffffc02047e0:	8f95                	sub	a5,a5,a3
ffffffffc02047e2:	03370063          	beq	a4,s3,ffffffffc0204802 <file_read+0xb6>
ffffffffc02047e6:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc02047ea:	8522                	mv	a0,s0
ffffffffc02047ec:	c0fff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc02047f0:	60a6                	ld	ra,72(sp)
ffffffffc02047f2:	6406                	ld	s0,64(sp)
ffffffffc02047f4:	7942                	ld	s2,48(sp)
ffffffffc02047f6:	79a2                	ld	s3,40(sp)
ffffffffc02047f8:	7a02                	ld	s4,32(sp)
ffffffffc02047fa:	8526                	mv	a0,s1
ffffffffc02047fc:	74e2                	ld	s1,56(sp)
ffffffffc02047fe:	6161                	addi	sp,sp,80
ffffffffc0204800:	8082                	ret
ffffffffc0204802:	7018                	ld	a4,32(s0)
ffffffffc0204804:	973e                	add	a4,a4,a5
ffffffffc0204806:	f018                	sd	a4,32(s0)
ffffffffc0204808:	bff9                	j	ffffffffc02047e6 <file_read+0x9a>
ffffffffc020480a:	54f5                	li	s1,-3
ffffffffc020480c:	b7d5                	j	ffffffffc02047f0 <file_read+0xa4>
ffffffffc020480e:	abbff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>
ffffffffc0204812:	00008697          	auipc	a3,0x8
ffffffffc0204816:	80668693          	addi	a3,a3,-2042 # ffffffffc020c018 <default_pmm_manager+0xce0>
ffffffffc020481a:	00006617          	auipc	a2,0x6
ffffffffc020481e:	03660613          	addi	a2,a2,54 # ffffffffc020a850 <commands+0x210>
ffffffffc0204822:	0de00593          	li	a1,222
ffffffffc0204826:	00007517          	auipc	a0,0x7
ffffffffc020482a:	66250513          	addi	a0,a0,1634 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc020482e:	c71fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204832 <file_write>:
ffffffffc0204832:	715d                	addi	sp,sp,-80
ffffffffc0204834:	e486                	sd	ra,72(sp)
ffffffffc0204836:	e0a2                	sd	s0,64(sp)
ffffffffc0204838:	fc26                	sd	s1,56(sp)
ffffffffc020483a:	f84a                	sd	s2,48(sp)
ffffffffc020483c:	f44e                	sd	s3,40(sp)
ffffffffc020483e:	f052                	sd	s4,32(sp)
ffffffffc0204840:	0006b023          	sd	zero,0(a3)
ffffffffc0204844:	04700793          	li	a5,71
ffffffffc0204848:	0aa7e463          	bltu	a5,a0,ffffffffc02048f0 <file_write+0xbe>
ffffffffc020484c:	00091797          	auipc	a5,0x91
ffffffffc0204850:	06c7b783          	ld	a5,108(a5) # ffffffffc02958b8 <current>
ffffffffc0204854:	1487b783          	ld	a5,328(a5)
ffffffffc0204858:	cfd1                	beqz	a5,ffffffffc02048f4 <file_write+0xc2>
ffffffffc020485a:	4b98                	lw	a4,16(a5)
ffffffffc020485c:	08e05c63          	blez	a4,ffffffffc02048f4 <file_write+0xc2>
ffffffffc0204860:	6780                	ld	s0,8(a5)
ffffffffc0204862:	00351793          	slli	a5,a0,0x3
ffffffffc0204866:	8f89                	sub	a5,a5,a0
ffffffffc0204868:	078e                	slli	a5,a5,0x3
ffffffffc020486a:	943e                	add	s0,s0,a5
ffffffffc020486c:	00042983          	lw	s3,0(s0)
ffffffffc0204870:	4789                	li	a5,2
ffffffffc0204872:	06f99f63          	bne	s3,a5,ffffffffc02048f0 <file_write+0xbe>
ffffffffc0204876:	4c1c                	lw	a5,24(s0)
ffffffffc0204878:	06a79c63          	bne	a5,a0,ffffffffc02048f0 <file_write+0xbe>
ffffffffc020487c:	681c                	ld	a5,16(s0)
ffffffffc020487e:	cbad                	beqz	a5,ffffffffc02048f0 <file_write+0xbe>
ffffffffc0204880:	581c                	lw	a5,48(s0)
ffffffffc0204882:	8a36                	mv	s4,a3
ffffffffc0204884:	7014                	ld	a3,32(s0)
ffffffffc0204886:	2785                	addiw	a5,a5,1
ffffffffc0204888:	850a                	mv	a0,sp
ffffffffc020488a:	d81c                	sw	a5,48(s0)
ffffffffc020488c:	6ac000ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc0204890:	02843903          	ld	s2,40(s0)
ffffffffc0204894:	84aa                	mv	s1,a0
ffffffffc0204896:	06090163          	beqz	s2,ffffffffc02048f8 <file_write+0xc6>
ffffffffc020489a:	07093783          	ld	a5,112(s2)
ffffffffc020489e:	cfa9                	beqz	a5,ffffffffc02048f8 <file_write+0xc6>
ffffffffc02048a0:	739c                	ld	a5,32(a5)
ffffffffc02048a2:	cbb9                	beqz	a5,ffffffffc02048f8 <file_write+0xc6>
ffffffffc02048a4:	00008597          	auipc	a1,0x8
ffffffffc02048a8:	81c58593          	addi	a1,a1,-2020 # ffffffffc020c0c0 <default_pmm_manager+0xd88>
ffffffffc02048ac:	854a                	mv	a0,s2
ffffffffc02048ae:	0c4020ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02048b2:	07093783          	ld	a5,112(s2)
ffffffffc02048b6:	7408                	ld	a0,40(s0)
ffffffffc02048b8:	85a6                	mv	a1,s1
ffffffffc02048ba:	739c                	ld	a5,32(a5)
ffffffffc02048bc:	9782                	jalr	a5
ffffffffc02048be:	689c                	ld	a5,16(s1)
ffffffffc02048c0:	6c94                	ld	a3,24(s1)
ffffffffc02048c2:	4018                	lw	a4,0(s0)
ffffffffc02048c4:	84aa                	mv	s1,a0
ffffffffc02048c6:	8f95                	sub	a5,a5,a3
ffffffffc02048c8:	03370063          	beq	a4,s3,ffffffffc02048e8 <file_write+0xb6>
ffffffffc02048cc:	00fa3023          	sd	a5,0(s4)
ffffffffc02048d0:	8522                	mv	a0,s0
ffffffffc02048d2:	b29ff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc02048d6:	60a6                	ld	ra,72(sp)
ffffffffc02048d8:	6406                	ld	s0,64(sp)
ffffffffc02048da:	7942                	ld	s2,48(sp)
ffffffffc02048dc:	79a2                	ld	s3,40(sp)
ffffffffc02048de:	7a02                	ld	s4,32(sp)
ffffffffc02048e0:	8526                	mv	a0,s1
ffffffffc02048e2:	74e2                	ld	s1,56(sp)
ffffffffc02048e4:	6161                	addi	sp,sp,80
ffffffffc02048e6:	8082                	ret
ffffffffc02048e8:	7018                	ld	a4,32(s0)
ffffffffc02048ea:	973e                	add	a4,a4,a5
ffffffffc02048ec:	f018                	sd	a4,32(s0)
ffffffffc02048ee:	bff9                	j	ffffffffc02048cc <file_write+0x9a>
ffffffffc02048f0:	54f5                	li	s1,-3
ffffffffc02048f2:	b7d5                	j	ffffffffc02048d6 <file_write+0xa4>
ffffffffc02048f4:	9d5ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>
ffffffffc02048f8:	00007697          	auipc	a3,0x7
ffffffffc02048fc:	77868693          	addi	a3,a3,1912 # ffffffffc020c070 <default_pmm_manager+0xd38>
ffffffffc0204900:	00006617          	auipc	a2,0x6
ffffffffc0204904:	f5060613          	addi	a2,a2,-176 # ffffffffc020a850 <commands+0x210>
ffffffffc0204908:	0f800593          	li	a1,248
ffffffffc020490c:	00007517          	auipc	a0,0x7
ffffffffc0204910:	57c50513          	addi	a0,a0,1404 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204914:	b8bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204918 <file_seek>:
ffffffffc0204918:	7139                	addi	sp,sp,-64
ffffffffc020491a:	fc06                	sd	ra,56(sp)
ffffffffc020491c:	f822                	sd	s0,48(sp)
ffffffffc020491e:	f426                	sd	s1,40(sp)
ffffffffc0204920:	f04a                	sd	s2,32(sp)
ffffffffc0204922:	04700793          	li	a5,71
ffffffffc0204926:	08a7e863          	bltu	a5,a0,ffffffffc02049b6 <file_seek+0x9e>
ffffffffc020492a:	00091797          	auipc	a5,0x91
ffffffffc020492e:	f8e7b783          	ld	a5,-114(a5) # ffffffffc02958b8 <current>
ffffffffc0204932:	1487b783          	ld	a5,328(a5)
ffffffffc0204936:	cfdd                	beqz	a5,ffffffffc02049f4 <file_seek+0xdc>
ffffffffc0204938:	4b98                	lw	a4,16(a5)
ffffffffc020493a:	0ae05d63          	blez	a4,ffffffffc02049f4 <file_seek+0xdc>
ffffffffc020493e:	6780                	ld	s0,8(a5)
ffffffffc0204940:	00351793          	slli	a5,a0,0x3
ffffffffc0204944:	8f89                	sub	a5,a5,a0
ffffffffc0204946:	078e                	slli	a5,a5,0x3
ffffffffc0204948:	943e                	add	s0,s0,a5
ffffffffc020494a:	4018                	lw	a4,0(s0)
ffffffffc020494c:	4789                	li	a5,2
ffffffffc020494e:	06f71463          	bne	a4,a5,ffffffffc02049b6 <file_seek+0x9e>
ffffffffc0204952:	4c1c                	lw	a5,24(s0)
ffffffffc0204954:	06a79163          	bne	a5,a0,ffffffffc02049b6 <file_seek+0x9e>
ffffffffc0204958:	581c                	lw	a5,48(s0)
ffffffffc020495a:	4685                	li	a3,1
ffffffffc020495c:	892e                	mv	s2,a1
ffffffffc020495e:	2785                	addiw	a5,a5,1
ffffffffc0204960:	d81c                	sw	a5,48(s0)
ffffffffc0204962:	02d60063          	beq	a2,a3,ffffffffc0204982 <file_seek+0x6a>
ffffffffc0204966:	06e60063          	beq	a2,a4,ffffffffc02049c6 <file_seek+0xae>
ffffffffc020496a:	54f5                	li	s1,-3
ffffffffc020496c:	ce11                	beqz	a2,ffffffffc0204988 <file_seek+0x70>
ffffffffc020496e:	8522                	mv	a0,s0
ffffffffc0204970:	a8bff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc0204974:	70e2                	ld	ra,56(sp)
ffffffffc0204976:	7442                	ld	s0,48(sp)
ffffffffc0204978:	7902                	ld	s2,32(sp)
ffffffffc020497a:	8526                	mv	a0,s1
ffffffffc020497c:	74a2                	ld	s1,40(sp)
ffffffffc020497e:	6121                	addi	sp,sp,64
ffffffffc0204980:	8082                	ret
ffffffffc0204982:	701c                	ld	a5,32(s0)
ffffffffc0204984:	00f58933          	add	s2,a1,a5
ffffffffc0204988:	7404                	ld	s1,40(s0)
ffffffffc020498a:	c4bd                	beqz	s1,ffffffffc02049f8 <file_seek+0xe0>
ffffffffc020498c:	78bc                	ld	a5,112(s1)
ffffffffc020498e:	c7ad                	beqz	a5,ffffffffc02049f8 <file_seek+0xe0>
ffffffffc0204990:	6fbc                	ld	a5,88(a5)
ffffffffc0204992:	c3bd                	beqz	a5,ffffffffc02049f8 <file_seek+0xe0>
ffffffffc0204994:	8526                	mv	a0,s1
ffffffffc0204996:	00007597          	auipc	a1,0x7
ffffffffc020499a:	78258593          	addi	a1,a1,1922 # ffffffffc020c118 <default_pmm_manager+0xde0>
ffffffffc020499e:	7d5010ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02049a2:	78bc                	ld	a5,112(s1)
ffffffffc02049a4:	7408                	ld	a0,40(s0)
ffffffffc02049a6:	85ca                	mv	a1,s2
ffffffffc02049a8:	6fbc                	ld	a5,88(a5)
ffffffffc02049aa:	9782                	jalr	a5
ffffffffc02049ac:	84aa                	mv	s1,a0
ffffffffc02049ae:	f161                	bnez	a0,ffffffffc020496e <file_seek+0x56>
ffffffffc02049b0:	03243023          	sd	s2,32(s0)
ffffffffc02049b4:	bf6d                	j	ffffffffc020496e <file_seek+0x56>
ffffffffc02049b6:	70e2                	ld	ra,56(sp)
ffffffffc02049b8:	7442                	ld	s0,48(sp)
ffffffffc02049ba:	54f5                	li	s1,-3
ffffffffc02049bc:	7902                	ld	s2,32(sp)
ffffffffc02049be:	8526                	mv	a0,s1
ffffffffc02049c0:	74a2                	ld	s1,40(sp)
ffffffffc02049c2:	6121                	addi	sp,sp,64
ffffffffc02049c4:	8082                	ret
ffffffffc02049c6:	7404                	ld	s1,40(s0)
ffffffffc02049c8:	c8a1                	beqz	s1,ffffffffc0204a18 <file_seek+0x100>
ffffffffc02049ca:	78bc                	ld	a5,112(s1)
ffffffffc02049cc:	c7b1                	beqz	a5,ffffffffc0204a18 <file_seek+0x100>
ffffffffc02049ce:	779c                	ld	a5,40(a5)
ffffffffc02049d0:	c7a1                	beqz	a5,ffffffffc0204a18 <file_seek+0x100>
ffffffffc02049d2:	8526                	mv	a0,s1
ffffffffc02049d4:	00007597          	auipc	a1,0x7
ffffffffc02049d8:	63c58593          	addi	a1,a1,1596 # ffffffffc020c010 <default_pmm_manager+0xcd8>
ffffffffc02049dc:	797010ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02049e0:	78bc                	ld	a5,112(s1)
ffffffffc02049e2:	7408                	ld	a0,40(s0)
ffffffffc02049e4:	858a                	mv	a1,sp
ffffffffc02049e6:	779c                	ld	a5,40(a5)
ffffffffc02049e8:	9782                	jalr	a5
ffffffffc02049ea:	84aa                	mv	s1,a0
ffffffffc02049ec:	f149                	bnez	a0,ffffffffc020496e <file_seek+0x56>
ffffffffc02049ee:	67e2                	ld	a5,24(sp)
ffffffffc02049f0:	993e                	add	s2,s2,a5
ffffffffc02049f2:	bf59                	j	ffffffffc0204988 <file_seek+0x70>
ffffffffc02049f4:	8d5ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>
ffffffffc02049f8:	00007697          	auipc	a3,0x7
ffffffffc02049fc:	6d068693          	addi	a3,a3,1744 # ffffffffc020c0c8 <default_pmm_manager+0xd90>
ffffffffc0204a00:	00006617          	auipc	a2,0x6
ffffffffc0204a04:	e5060613          	addi	a2,a2,-432 # ffffffffc020a850 <commands+0x210>
ffffffffc0204a08:	11a00593          	li	a1,282
ffffffffc0204a0c:	00007517          	auipc	a0,0x7
ffffffffc0204a10:	47c50513          	addi	a0,a0,1148 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204a14:	a8bfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a18:	00007697          	auipc	a3,0x7
ffffffffc0204a1c:	5a868693          	addi	a3,a3,1448 # ffffffffc020bfc0 <default_pmm_manager+0xc88>
ffffffffc0204a20:	00006617          	auipc	a2,0x6
ffffffffc0204a24:	e3060613          	addi	a2,a2,-464 # ffffffffc020a850 <commands+0x210>
ffffffffc0204a28:	11200593          	li	a1,274
ffffffffc0204a2c:	00007517          	auipc	a0,0x7
ffffffffc0204a30:	45c50513          	addi	a0,a0,1116 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204a34:	a6bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204a38 <file_fstat>:
ffffffffc0204a38:	1101                	addi	sp,sp,-32
ffffffffc0204a3a:	ec06                	sd	ra,24(sp)
ffffffffc0204a3c:	e822                	sd	s0,16(sp)
ffffffffc0204a3e:	e426                	sd	s1,8(sp)
ffffffffc0204a40:	e04a                	sd	s2,0(sp)
ffffffffc0204a42:	04700793          	li	a5,71
ffffffffc0204a46:	06a7ef63          	bltu	a5,a0,ffffffffc0204ac4 <file_fstat+0x8c>
ffffffffc0204a4a:	00091797          	auipc	a5,0x91
ffffffffc0204a4e:	e6e7b783          	ld	a5,-402(a5) # ffffffffc02958b8 <current>
ffffffffc0204a52:	1487b783          	ld	a5,328(a5)
ffffffffc0204a56:	cfd9                	beqz	a5,ffffffffc0204af4 <file_fstat+0xbc>
ffffffffc0204a58:	4b98                	lw	a4,16(a5)
ffffffffc0204a5a:	08e05d63          	blez	a4,ffffffffc0204af4 <file_fstat+0xbc>
ffffffffc0204a5e:	6780                	ld	s0,8(a5)
ffffffffc0204a60:	00351793          	slli	a5,a0,0x3
ffffffffc0204a64:	8f89                	sub	a5,a5,a0
ffffffffc0204a66:	078e                	slli	a5,a5,0x3
ffffffffc0204a68:	943e                	add	s0,s0,a5
ffffffffc0204a6a:	4018                	lw	a4,0(s0)
ffffffffc0204a6c:	4789                	li	a5,2
ffffffffc0204a6e:	04f71b63          	bne	a4,a5,ffffffffc0204ac4 <file_fstat+0x8c>
ffffffffc0204a72:	4c1c                	lw	a5,24(s0)
ffffffffc0204a74:	04a79863          	bne	a5,a0,ffffffffc0204ac4 <file_fstat+0x8c>
ffffffffc0204a78:	581c                	lw	a5,48(s0)
ffffffffc0204a7a:	02843903          	ld	s2,40(s0)
ffffffffc0204a7e:	2785                	addiw	a5,a5,1
ffffffffc0204a80:	d81c                	sw	a5,48(s0)
ffffffffc0204a82:	04090963          	beqz	s2,ffffffffc0204ad4 <file_fstat+0x9c>
ffffffffc0204a86:	07093783          	ld	a5,112(s2)
ffffffffc0204a8a:	c7a9                	beqz	a5,ffffffffc0204ad4 <file_fstat+0x9c>
ffffffffc0204a8c:	779c                	ld	a5,40(a5)
ffffffffc0204a8e:	c3b9                	beqz	a5,ffffffffc0204ad4 <file_fstat+0x9c>
ffffffffc0204a90:	84ae                	mv	s1,a1
ffffffffc0204a92:	854a                	mv	a0,s2
ffffffffc0204a94:	00007597          	auipc	a1,0x7
ffffffffc0204a98:	57c58593          	addi	a1,a1,1404 # ffffffffc020c010 <default_pmm_manager+0xcd8>
ffffffffc0204a9c:	6d7010ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0204aa0:	07093783          	ld	a5,112(s2)
ffffffffc0204aa4:	7408                	ld	a0,40(s0)
ffffffffc0204aa6:	85a6                	mv	a1,s1
ffffffffc0204aa8:	779c                	ld	a5,40(a5)
ffffffffc0204aaa:	9782                	jalr	a5
ffffffffc0204aac:	87aa                	mv	a5,a0
ffffffffc0204aae:	8522                	mv	a0,s0
ffffffffc0204ab0:	843e                	mv	s0,a5
ffffffffc0204ab2:	949ff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc0204ab6:	60e2                	ld	ra,24(sp)
ffffffffc0204ab8:	8522                	mv	a0,s0
ffffffffc0204aba:	6442                	ld	s0,16(sp)
ffffffffc0204abc:	64a2                	ld	s1,8(sp)
ffffffffc0204abe:	6902                	ld	s2,0(sp)
ffffffffc0204ac0:	6105                	addi	sp,sp,32
ffffffffc0204ac2:	8082                	ret
ffffffffc0204ac4:	5475                	li	s0,-3
ffffffffc0204ac6:	60e2                	ld	ra,24(sp)
ffffffffc0204ac8:	8522                	mv	a0,s0
ffffffffc0204aca:	6442                	ld	s0,16(sp)
ffffffffc0204acc:	64a2                	ld	s1,8(sp)
ffffffffc0204ace:	6902                	ld	s2,0(sp)
ffffffffc0204ad0:	6105                	addi	sp,sp,32
ffffffffc0204ad2:	8082                	ret
ffffffffc0204ad4:	00007697          	auipc	a3,0x7
ffffffffc0204ad8:	4ec68693          	addi	a3,a3,1260 # ffffffffc020bfc0 <default_pmm_manager+0xc88>
ffffffffc0204adc:	00006617          	auipc	a2,0x6
ffffffffc0204ae0:	d7460613          	addi	a2,a2,-652 # ffffffffc020a850 <commands+0x210>
ffffffffc0204ae4:	12c00593          	li	a1,300
ffffffffc0204ae8:	00007517          	auipc	a0,0x7
ffffffffc0204aec:	3a050513          	addi	a0,a0,928 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204af0:	9affb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204af4:	fd4ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc0204af8 <file_fsync>:
ffffffffc0204af8:	1101                	addi	sp,sp,-32
ffffffffc0204afa:	ec06                	sd	ra,24(sp)
ffffffffc0204afc:	e822                	sd	s0,16(sp)
ffffffffc0204afe:	e426                	sd	s1,8(sp)
ffffffffc0204b00:	04700793          	li	a5,71
ffffffffc0204b04:	06a7e863          	bltu	a5,a0,ffffffffc0204b74 <file_fsync+0x7c>
ffffffffc0204b08:	00091797          	auipc	a5,0x91
ffffffffc0204b0c:	db07b783          	ld	a5,-592(a5) # ffffffffc02958b8 <current>
ffffffffc0204b10:	1487b783          	ld	a5,328(a5)
ffffffffc0204b14:	c7d9                	beqz	a5,ffffffffc0204ba2 <file_fsync+0xaa>
ffffffffc0204b16:	4b98                	lw	a4,16(a5)
ffffffffc0204b18:	08e05563          	blez	a4,ffffffffc0204ba2 <file_fsync+0xaa>
ffffffffc0204b1c:	6780                	ld	s0,8(a5)
ffffffffc0204b1e:	00351793          	slli	a5,a0,0x3
ffffffffc0204b22:	8f89                	sub	a5,a5,a0
ffffffffc0204b24:	078e                	slli	a5,a5,0x3
ffffffffc0204b26:	943e                	add	s0,s0,a5
ffffffffc0204b28:	4018                	lw	a4,0(s0)
ffffffffc0204b2a:	4789                	li	a5,2
ffffffffc0204b2c:	04f71463          	bne	a4,a5,ffffffffc0204b74 <file_fsync+0x7c>
ffffffffc0204b30:	4c1c                	lw	a5,24(s0)
ffffffffc0204b32:	04a79163          	bne	a5,a0,ffffffffc0204b74 <file_fsync+0x7c>
ffffffffc0204b36:	581c                	lw	a5,48(s0)
ffffffffc0204b38:	7404                	ld	s1,40(s0)
ffffffffc0204b3a:	2785                	addiw	a5,a5,1
ffffffffc0204b3c:	d81c                	sw	a5,48(s0)
ffffffffc0204b3e:	c0b1                	beqz	s1,ffffffffc0204b82 <file_fsync+0x8a>
ffffffffc0204b40:	78bc                	ld	a5,112(s1)
ffffffffc0204b42:	c3a1                	beqz	a5,ffffffffc0204b82 <file_fsync+0x8a>
ffffffffc0204b44:	7b9c                	ld	a5,48(a5)
ffffffffc0204b46:	cf95                	beqz	a5,ffffffffc0204b82 <file_fsync+0x8a>
ffffffffc0204b48:	00007597          	auipc	a1,0x7
ffffffffc0204b4c:	62858593          	addi	a1,a1,1576 # ffffffffc020c170 <default_pmm_manager+0xe38>
ffffffffc0204b50:	8526                	mv	a0,s1
ffffffffc0204b52:	621010ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0204b56:	78bc                	ld	a5,112(s1)
ffffffffc0204b58:	7408                	ld	a0,40(s0)
ffffffffc0204b5a:	7b9c                	ld	a5,48(a5)
ffffffffc0204b5c:	9782                	jalr	a5
ffffffffc0204b5e:	87aa                	mv	a5,a0
ffffffffc0204b60:	8522                	mv	a0,s0
ffffffffc0204b62:	843e                	mv	s0,a5
ffffffffc0204b64:	897ff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc0204b68:	60e2                	ld	ra,24(sp)
ffffffffc0204b6a:	8522                	mv	a0,s0
ffffffffc0204b6c:	6442                	ld	s0,16(sp)
ffffffffc0204b6e:	64a2                	ld	s1,8(sp)
ffffffffc0204b70:	6105                	addi	sp,sp,32
ffffffffc0204b72:	8082                	ret
ffffffffc0204b74:	5475                	li	s0,-3
ffffffffc0204b76:	60e2                	ld	ra,24(sp)
ffffffffc0204b78:	8522                	mv	a0,s0
ffffffffc0204b7a:	6442                	ld	s0,16(sp)
ffffffffc0204b7c:	64a2                	ld	s1,8(sp)
ffffffffc0204b7e:	6105                	addi	sp,sp,32
ffffffffc0204b80:	8082                	ret
ffffffffc0204b82:	00007697          	auipc	a3,0x7
ffffffffc0204b86:	59e68693          	addi	a3,a3,1438 # ffffffffc020c120 <default_pmm_manager+0xde8>
ffffffffc0204b8a:	00006617          	auipc	a2,0x6
ffffffffc0204b8e:	cc660613          	addi	a2,a2,-826 # ffffffffc020a850 <commands+0x210>
ffffffffc0204b92:	13a00593          	li	a1,314
ffffffffc0204b96:	00007517          	auipc	a0,0x7
ffffffffc0204b9a:	2f250513          	addi	a0,a0,754 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204b9e:	901fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ba2:	f26ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc0204ba6 <file_getdirentry>:
ffffffffc0204ba6:	715d                	addi	sp,sp,-80
ffffffffc0204ba8:	e486                	sd	ra,72(sp)
ffffffffc0204baa:	e0a2                	sd	s0,64(sp)
ffffffffc0204bac:	fc26                	sd	s1,56(sp)
ffffffffc0204bae:	f84a                	sd	s2,48(sp)
ffffffffc0204bb0:	f44e                	sd	s3,40(sp)
ffffffffc0204bb2:	04700793          	li	a5,71
ffffffffc0204bb6:	0aa7e063          	bltu	a5,a0,ffffffffc0204c56 <file_getdirentry+0xb0>
ffffffffc0204bba:	00091797          	auipc	a5,0x91
ffffffffc0204bbe:	cfe7b783          	ld	a5,-770(a5) # ffffffffc02958b8 <current>
ffffffffc0204bc2:	1487b783          	ld	a5,328(a5)
ffffffffc0204bc6:	c3e9                	beqz	a5,ffffffffc0204c88 <file_getdirentry+0xe2>
ffffffffc0204bc8:	4b98                	lw	a4,16(a5)
ffffffffc0204bca:	0ae05f63          	blez	a4,ffffffffc0204c88 <file_getdirentry+0xe2>
ffffffffc0204bce:	6780                	ld	s0,8(a5)
ffffffffc0204bd0:	00351793          	slli	a5,a0,0x3
ffffffffc0204bd4:	8f89                	sub	a5,a5,a0
ffffffffc0204bd6:	078e                	slli	a5,a5,0x3
ffffffffc0204bd8:	943e                	add	s0,s0,a5
ffffffffc0204bda:	4018                	lw	a4,0(s0)
ffffffffc0204bdc:	4789                	li	a5,2
ffffffffc0204bde:	06f71c63          	bne	a4,a5,ffffffffc0204c56 <file_getdirentry+0xb0>
ffffffffc0204be2:	4c1c                	lw	a5,24(s0)
ffffffffc0204be4:	06a79963          	bne	a5,a0,ffffffffc0204c56 <file_getdirentry+0xb0>
ffffffffc0204be8:	581c                	lw	a5,48(s0)
ffffffffc0204bea:	6194                	ld	a3,0(a1)
ffffffffc0204bec:	84ae                	mv	s1,a1
ffffffffc0204bee:	2785                	addiw	a5,a5,1
ffffffffc0204bf0:	10000613          	li	a2,256
ffffffffc0204bf4:	d81c                	sw	a5,48(s0)
ffffffffc0204bf6:	05a1                	addi	a1,a1,8
ffffffffc0204bf8:	850a                	mv	a0,sp
ffffffffc0204bfa:	33e000ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc0204bfe:	02843983          	ld	s3,40(s0)
ffffffffc0204c02:	892a                	mv	s2,a0
ffffffffc0204c04:	06098263          	beqz	s3,ffffffffc0204c68 <file_getdirentry+0xc2>
ffffffffc0204c08:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc0204c0c:	cfb1                	beqz	a5,ffffffffc0204c68 <file_getdirentry+0xc2>
ffffffffc0204c0e:	63bc                	ld	a5,64(a5)
ffffffffc0204c10:	cfa1                	beqz	a5,ffffffffc0204c68 <file_getdirentry+0xc2>
ffffffffc0204c12:	854e                	mv	a0,s3
ffffffffc0204c14:	00007597          	auipc	a1,0x7
ffffffffc0204c18:	5bc58593          	addi	a1,a1,1468 # ffffffffc020c1d0 <default_pmm_manager+0xe98>
ffffffffc0204c1c:	557010ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0204c20:	0709b783          	ld	a5,112(s3)
ffffffffc0204c24:	7408                	ld	a0,40(s0)
ffffffffc0204c26:	85ca                	mv	a1,s2
ffffffffc0204c28:	63bc                	ld	a5,64(a5)
ffffffffc0204c2a:	9782                	jalr	a5
ffffffffc0204c2c:	89aa                	mv	s3,a0
ffffffffc0204c2e:	e909                	bnez	a0,ffffffffc0204c40 <file_getdirentry+0x9a>
ffffffffc0204c30:	609c                	ld	a5,0(s1)
ffffffffc0204c32:	01093683          	ld	a3,16(s2)
ffffffffc0204c36:	01893703          	ld	a4,24(s2)
ffffffffc0204c3a:	97b6                	add	a5,a5,a3
ffffffffc0204c3c:	8f99                	sub	a5,a5,a4
ffffffffc0204c3e:	e09c                	sd	a5,0(s1)
ffffffffc0204c40:	8522                	mv	a0,s0
ffffffffc0204c42:	fb8ff0ef          	jal	ra,ffffffffc02043fa <fd_array_release>
ffffffffc0204c46:	60a6                	ld	ra,72(sp)
ffffffffc0204c48:	6406                	ld	s0,64(sp)
ffffffffc0204c4a:	74e2                	ld	s1,56(sp)
ffffffffc0204c4c:	7942                	ld	s2,48(sp)
ffffffffc0204c4e:	854e                	mv	a0,s3
ffffffffc0204c50:	79a2                	ld	s3,40(sp)
ffffffffc0204c52:	6161                	addi	sp,sp,80
ffffffffc0204c54:	8082                	ret
ffffffffc0204c56:	60a6                	ld	ra,72(sp)
ffffffffc0204c58:	6406                	ld	s0,64(sp)
ffffffffc0204c5a:	59f5                	li	s3,-3
ffffffffc0204c5c:	74e2                	ld	s1,56(sp)
ffffffffc0204c5e:	7942                	ld	s2,48(sp)
ffffffffc0204c60:	854e                	mv	a0,s3
ffffffffc0204c62:	79a2                	ld	s3,40(sp)
ffffffffc0204c64:	6161                	addi	sp,sp,80
ffffffffc0204c66:	8082                	ret
ffffffffc0204c68:	00007697          	auipc	a3,0x7
ffffffffc0204c6c:	51068693          	addi	a3,a3,1296 # ffffffffc020c178 <default_pmm_manager+0xe40>
ffffffffc0204c70:	00006617          	auipc	a2,0x6
ffffffffc0204c74:	be060613          	addi	a2,a2,-1056 # ffffffffc020a850 <commands+0x210>
ffffffffc0204c78:	14a00593          	li	a1,330
ffffffffc0204c7c:	00007517          	auipc	a0,0x7
ffffffffc0204c80:	20c50513          	addi	a0,a0,524 # ffffffffc020be88 <default_pmm_manager+0xb50>
ffffffffc0204c84:	81bfb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204c88:	e40ff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc0204c8c <file_dup>:
ffffffffc0204c8c:	04700713          	li	a4,71
ffffffffc0204c90:	06a76463          	bltu	a4,a0,ffffffffc0204cf8 <file_dup+0x6c>
ffffffffc0204c94:	00091717          	auipc	a4,0x91
ffffffffc0204c98:	c2473703          	ld	a4,-988(a4) # ffffffffc02958b8 <current>
ffffffffc0204c9c:	14873703          	ld	a4,328(a4)
ffffffffc0204ca0:	1101                	addi	sp,sp,-32
ffffffffc0204ca2:	ec06                	sd	ra,24(sp)
ffffffffc0204ca4:	e822                	sd	s0,16(sp)
ffffffffc0204ca6:	cb39                	beqz	a4,ffffffffc0204cfc <file_dup+0x70>
ffffffffc0204ca8:	4b14                	lw	a3,16(a4)
ffffffffc0204caa:	04d05963          	blez	a3,ffffffffc0204cfc <file_dup+0x70>
ffffffffc0204cae:	6700                	ld	s0,8(a4)
ffffffffc0204cb0:	00351713          	slli	a4,a0,0x3
ffffffffc0204cb4:	8f09                	sub	a4,a4,a0
ffffffffc0204cb6:	070e                	slli	a4,a4,0x3
ffffffffc0204cb8:	943a                	add	s0,s0,a4
ffffffffc0204cba:	4014                	lw	a3,0(s0)
ffffffffc0204cbc:	4709                	li	a4,2
ffffffffc0204cbe:	02e69863          	bne	a3,a4,ffffffffc0204cee <file_dup+0x62>
ffffffffc0204cc2:	4c18                	lw	a4,24(s0)
ffffffffc0204cc4:	02a71563          	bne	a4,a0,ffffffffc0204cee <file_dup+0x62>
ffffffffc0204cc8:	852e                	mv	a0,a1
ffffffffc0204cca:	002c                	addi	a1,sp,8
ffffffffc0204ccc:	e1eff0ef          	jal	ra,ffffffffc02042ea <fd_array_alloc>
ffffffffc0204cd0:	c509                	beqz	a0,ffffffffc0204cda <file_dup+0x4e>
ffffffffc0204cd2:	60e2                	ld	ra,24(sp)
ffffffffc0204cd4:	6442                	ld	s0,16(sp)
ffffffffc0204cd6:	6105                	addi	sp,sp,32
ffffffffc0204cd8:	8082                	ret
ffffffffc0204cda:	6522                	ld	a0,8(sp)
ffffffffc0204cdc:	85a2                	mv	a1,s0
ffffffffc0204cde:	845ff0ef          	jal	ra,ffffffffc0204522 <fd_array_dup>
ffffffffc0204ce2:	67a2                	ld	a5,8(sp)
ffffffffc0204ce4:	60e2                	ld	ra,24(sp)
ffffffffc0204ce6:	6442                	ld	s0,16(sp)
ffffffffc0204ce8:	4f88                	lw	a0,24(a5)
ffffffffc0204cea:	6105                	addi	sp,sp,32
ffffffffc0204cec:	8082                	ret
ffffffffc0204cee:	60e2                	ld	ra,24(sp)
ffffffffc0204cf0:	6442                	ld	s0,16(sp)
ffffffffc0204cf2:	5575                	li	a0,-3
ffffffffc0204cf4:	6105                	addi	sp,sp,32
ffffffffc0204cf6:	8082                	ret
ffffffffc0204cf8:	5575                	li	a0,-3
ffffffffc0204cfa:	8082                	ret
ffffffffc0204cfc:	dccff0ef          	jal	ra,ffffffffc02042c8 <get_fd_array.part.0>

ffffffffc0204d00 <fs_init>:
ffffffffc0204d00:	1141                	addi	sp,sp,-16
ffffffffc0204d02:	e406                	sd	ra,8(sp)
ffffffffc0204d04:	68d010ef          	jal	ra,ffffffffc0206b90 <vfs_init>
ffffffffc0204d08:	365020ef          	jal	ra,ffffffffc020786c <dev_init>
ffffffffc0204d0c:	60a2                	ld	ra,8(sp)
ffffffffc0204d0e:	0141                	addi	sp,sp,16
ffffffffc0204d10:	4b40306f          	j	ffffffffc02081c4 <sfs_init>

ffffffffc0204d14 <fs_cleanup>:
ffffffffc0204d14:	0ce0206f          	j	ffffffffc0206de2 <vfs_cleanup>

ffffffffc0204d18 <lock_files>:
ffffffffc0204d18:	0561                	addi	a0,a0,24
ffffffffc0204d1a:	ba0ff06f          	j	ffffffffc02040ba <down>

ffffffffc0204d1e <unlock_files>:
ffffffffc0204d1e:	0561                	addi	a0,a0,24
ffffffffc0204d20:	b96ff06f          	j	ffffffffc02040b6 <up>

ffffffffc0204d24 <files_create>:
ffffffffc0204d24:	1141                	addi	sp,sp,-16
ffffffffc0204d26:	6505                	lui	a0,0x1
ffffffffc0204d28:	e022                	sd	s0,0(sp)
ffffffffc0204d2a:	e406                	sd	ra,8(sp)
ffffffffc0204d2c:	a62fd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0204d30:	842a                	mv	s0,a0
ffffffffc0204d32:	cd19                	beqz	a0,ffffffffc0204d50 <files_create+0x2c>
ffffffffc0204d34:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc0204d38:	00043023          	sd	zero,0(s0)
ffffffffc0204d3c:	0561                	addi	a0,a0,24
ffffffffc0204d3e:	e41c                	sd	a5,8(s0)
ffffffffc0204d40:	00042823          	sw	zero,16(s0)
ffffffffc0204d44:	4585                	li	a1,1
ffffffffc0204d46:	b6aff0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0204d4a:	6408                	ld	a0,8(s0)
ffffffffc0204d4c:	f3cff0ef          	jal	ra,ffffffffc0204488 <fd_array_init>
ffffffffc0204d50:	60a2                	ld	ra,8(sp)
ffffffffc0204d52:	8522                	mv	a0,s0
ffffffffc0204d54:	6402                	ld	s0,0(sp)
ffffffffc0204d56:	0141                	addi	sp,sp,16
ffffffffc0204d58:	8082                	ret

ffffffffc0204d5a <files_destroy>:
ffffffffc0204d5a:	7179                	addi	sp,sp,-48
ffffffffc0204d5c:	f406                	sd	ra,40(sp)
ffffffffc0204d5e:	f022                	sd	s0,32(sp)
ffffffffc0204d60:	ec26                	sd	s1,24(sp)
ffffffffc0204d62:	e84a                	sd	s2,16(sp)
ffffffffc0204d64:	e44e                	sd	s3,8(sp)
ffffffffc0204d66:	c52d                	beqz	a0,ffffffffc0204dd0 <files_destroy+0x76>
ffffffffc0204d68:	491c                	lw	a5,16(a0)
ffffffffc0204d6a:	89aa                	mv	s3,a0
ffffffffc0204d6c:	e3b5                	bnez	a5,ffffffffc0204dd0 <files_destroy+0x76>
ffffffffc0204d6e:	6108                	ld	a0,0(a0)
ffffffffc0204d70:	c119                	beqz	a0,ffffffffc0204d76 <files_destroy+0x1c>
ffffffffc0204d72:	4b7010ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0204d76:	0089b403          	ld	s0,8(s3)
ffffffffc0204d7a:	6485                	lui	s1,0x1
ffffffffc0204d7c:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204d80:	94a2                	add	s1,s1,s0
ffffffffc0204d82:	4909                	li	s2,2
ffffffffc0204d84:	401c                	lw	a5,0(s0)
ffffffffc0204d86:	03278063          	beq	a5,s2,ffffffffc0204da6 <files_destroy+0x4c>
ffffffffc0204d8a:	e39d                	bnez	a5,ffffffffc0204db0 <files_destroy+0x56>
ffffffffc0204d8c:	03840413          	addi	s0,s0,56
ffffffffc0204d90:	fe849ae3          	bne	s1,s0,ffffffffc0204d84 <files_destroy+0x2a>
ffffffffc0204d94:	7402                	ld	s0,32(sp)
ffffffffc0204d96:	70a2                	ld	ra,40(sp)
ffffffffc0204d98:	64e2                	ld	s1,24(sp)
ffffffffc0204d9a:	6942                	ld	s2,16(sp)
ffffffffc0204d9c:	854e                	mv	a0,s3
ffffffffc0204d9e:	69a2                	ld	s3,8(sp)
ffffffffc0204da0:	6145                	addi	sp,sp,48
ffffffffc0204da2:	a9cfd06f          	j	ffffffffc020203e <kfree>
ffffffffc0204da6:	8522                	mv	a0,s0
ffffffffc0204da8:	efcff0ef          	jal	ra,ffffffffc02044a4 <fd_array_close>
ffffffffc0204dac:	401c                	lw	a5,0(s0)
ffffffffc0204dae:	bff1                	j	ffffffffc0204d8a <files_destroy+0x30>
ffffffffc0204db0:	00007697          	auipc	a3,0x7
ffffffffc0204db4:	4a068693          	addi	a3,a3,1184 # ffffffffc020c250 <CSWTCH.79+0x58>
ffffffffc0204db8:	00006617          	auipc	a2,0x6
ffffffffc0204dbc:	a9860613          	addi	a2,a2,-1384 # ffffffffc020a850 <commands+0x210>
ffffffffc0204dc0:	03d00593          	li	a1,61
ffffffffc0204dc4:	00007517          	auipc	a0,0x7
ffffffffc0204dc8:	47c50513          	addi	a0,a0,1148 # ffffffffc020c240 <CSWTCH.79+0x48>
ffffffffc0204dcc:	ed2fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204dd0:	00007697          	auipc	a3,0x7
ffffffffc0204dd4:	44068693          	addi	a3,a3,1088 # ffffffffc020c210 <CSWTCH.79+0x18>
ffffffffc0204dd8:	00006617          	auipc	a2,0x6
ffffffffc0204ddc:	a7860613          	addi	a2,a2,-1416 # ffffffffc020a850 <commands+0x210>
ffffffffc0204de0:	03300593          	li	a1,51
ffffffffc0204de4:	00007517          	auipc	a0,0x7
ffffffffc0204de8:	45c50513          	addi	a0,a0,1116 # ffffffffc020c240 <CSWTCH.79+0x48>
ffffffffc0204dec:	eb2fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204df0 <files_closeall>:
ffffffffc0204df0:	1101                	addi	sp,sp,-32
ffffffffc0204df2:	ec06                	sd	ra,24(sp)
ffffffffc0204df4:	e822                	sd	s0,16(sp)
ffffffffc0204df6:	e426                	sd	s1,8(sp)
ffffffffc0204df8:	e04a                	sd	s2,0(sp)
ffffffffc0204dfa:	c129                	beqz	a0,ffffffffc0204e3c <files_closeall+0x4c>
ffffffffc0204dfc:	491c                	lw	a5,16(a0)
ffffffffc0204dfe:	02f05f63          	blez	a5,ffffffffc0204e3c <files_closeall+0x4c>
ffffffffc0204e02:	6504                	ld	s1,8(a0)
ffffffffc0204e04:	6785                	lui	a5,0x1
ffffffffc0204e06:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204e0a:	07048413          	addi	s0,s1,112
ffffffffc0204e0e:	4909                	li	s2,2
ffffffffc0204e10:	94be                	add	s1,s1,a5
ffffffffc0204e12:	a029                	j	ffffffffc0204e1c <files_closeall+0x2c>
ffffffffc0204e14:	03840413          	addi	s0,s0,56
ffffffffc0204e18:	00848c63          	beq	s1,s0,ffffffffc0204e30 <files_closeall+0x40>
ffffffffc0204e1c:	401c                	lw	a5,0(s0)
ffffffffc0204e1e:	ff279be3          	bne	a5,s2,ffffffffc0204e14 <files_closeall+0x24>
ffffffffc0204e22:	8522                	mv	a0,s0
ffffffffc0204e24:	03840413          	addi	s0,s0,56
ffffffffc0204e28:	e7cff0ef          	jal	ra,ffffffffc02044a4 <fd_array_close>
ffffffffc0204e2c:	fe8498e3          	bne	s1,s0,ffffffffc0204e1c <files_closeall+0x2c>
ffffffffc0204e30:	60e2                	ld	ra,24(sp)
ffffffffc0204e32:	6442                	ld	s0,16(sp)
ffffffffc0204e34:	64a2                	ld	s1,8(sp)
ffffffffc0204e36:	6902                	ld	s2,0(sp)
ffffffffc0204e38:	6105                	addi	sp,sp,32
ffffffffc0204e3a:	8082                	ret
ffffffffc0204e3c:	00007697          	auipc	a3,0x7
ffffffffc0204e40:	01c68693          	addi	a3,a3,28 # ffffffffc020be58 <default_pmm_manager+0xb20>
ffffffffc0204e44:	00006617          	auipc	a2,0x6
ffffffffc0204e48:	a0c60613          	addi	a2,a2,-1524 # ffffffffc020a850 <commands+0x210>
ffffffffc0204e4c:	04500593          	li	a1,69
ffffffffc0204e50:	00007517          	auipc	a0,0x7
ffffffffc0204e54:	3f050513          	addi	a0,a0,1008 # ffffffffc020c240 <CSWTCH.79+0x48>
ffffffffc0204e58:	e46fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204e5c <dup_files>:
ffffffffc0204e5c:	7179                	addi	sp,sp,-48
ffffffffc0204e5e:	f406                	sd	ra,40(sp)
ffffffffc0204e60:	f022                	sd	s0,32(sp)
ffffffffc0204e62:	ec26                	sd	s1,24(sp)
ffffffffc0204e64:	e84a                	sd	s2,16(sp)
ffffffffc0204e66:	e44e                	sd	s3,8(sp)
ffffffffc0204e68:	e052                	sd	s4,0(sp)
ffffffffc0204e6a:	c52d                	beqz	a0,ffffffffc0204ed4 <dup_files+0x78>
ffffffffc0204e6c:	842e                	mv	s0,a1
ffffffffc0204e6e:	c1bd                	beqz	a1,ffffffffc0204ed4 <dup_files+0x78>
ffffffffc0204e70:	491c                	lw	a5,16(a0)
ffffffffc0204e72:	84aa                	mv	s1,a0
ffffffffc0204e74:	e3c1                	bnez	a5,ffffffffc0204ef4 <dup_files+0x98>
ffffffffc0204e76:	499c                	lw	a5,16(a1)
ffffffffc0204e78:	06f05e63          	blez	a5,ffffffffc0204ef4 <dup_files+0x98>
ffffffffc0204e7c:	6188                	ld	a0,0(a1)
ffffffffc0204e7e:	e088                	sd	a0,0(s1)
ffffffffc0204e80:	c119                	beqz	a0,ffffffffc0204e86 <dup_files+0x2a>
ffffffffc0204e82:	2d9010ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0204e86:	6400                	ld	s0,8(s0)
ffffffffc0204e88:	6905                	lui	s2,0x1
ffffffffc0204e8a:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0204e8e:	6484                	ld	s1,8(s1)
ffffffffc0204e90:	9922                	add	s2,s2,s0
ffffffffc0204e92:	4989                	li	s3,2
ffffffffc0204e94:	4a05                	li	s4,1
ffffffffc0204e96:	a039                	j	ffffffffc0204ea4 <dup_files+0x48>
ffffffffc0204e98:	03840413          	addi	s0,s0,56
ffffffffc0204e9c:	03848493          	addi	s1,s1,56
ffffffffc0204ea0:	02890163          	beq	s2,s0,ffffffffc0204ec2 <dup_files+0x66>
ffffffffc0204ea4:	401c                	lw	a5,0(s0)
ffffffffc0204ea6:	ff3799e3          	bne	a5,s3,ffffffffc0204e98 <dup_files+0x3c>
ffffffffc0204eaa:	0144a023          	sw	s4,0(s1)
ffffffffc0204eae:	85a2                	mv	a1,s0
ffffffffc0204eb0:	8526                	mv	a0,s1
ffffffffc0204eb2:	03840413          	addi	s0,s0,56
ffffffffc0204eb6:	e6cff0ef          	jal	ra,ffffffffc0204522 <fd_array_dup>
ffffffffc0204eba:	03848493          	addi	s1,s1,56
ffffffffc0204ebe:	fe8913e3          	bne	s2,s0,ffffffffc0204ea4 <dup_files+0x48>
ffffffffc0204ec2:	70a2                	ld	ra,40(sp)
ffffffffc0204ec4:	7402                	ld	s0,32(sp)
ffffffffc0204ec6:	64e2                	ld	s1,24(sp)
ffffffffc0204ec8:	6942                	ld	s2,16(sp)
ffffffffc0204eca:	69a2                	ld	s3,8(sp)
ffffffffc0204ecc:	6a02                	ld	s4,0(sp)
ffffffffc0204ece:	4501                	li	a0,0
ffffffffc0204ed0:	6145                	addi	sp,sp,48
ffffffffc0204ed2:	8082                	ret
ffffffffc0204ed4:	00007697          	auipc	a3,0x7
ffffffffc0204ed8:	39468693          	addi	a3,a3,916 # ffffffffc020c268 <CSWTCH.79+0x70>
ffffffffc0204edc:	00006617          	auipc	a2,0x6
ffffffffc0204ee0:	97460613          	addi	a2,a2,-1676 # ffffffffc020a850 <commands+0x210>
ffffffffc0204ee4:	05300593          	li	a1,83
ffffffffc0204ee8:	00007517          	auipc	a0,0x7
ffffffffc0204eec:	35850513          	addi	a0,a0,856 # ffffffffc020c240 <CSWTCH.79+0x48>
ffffffffc0204ef0:	daefb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ef4:	00007697          	auipc	a3,0x7
ffffffffc0204ef8:	39468693          	addi	a3,a3,916 # ffffffffc020c288 <CSWTCH.79+0x90>
ffffffffc0204efc:	00006617          	auipc	a2,0x6
ffffffffc0204f00:	95460613          	addi	a2,a2,-1708 # ffffffffc020a850 <commands+0x210>
ffffffffc0204f04:	05400593          	li	a1,84
ffffffffc0204f08:	00007517          	auipc	a0,0x7
ffffffffc0204f0c:	33850513          	addi	a0,a0,824 # ffffffffc020c240 <CSWTCH.79+0x48>
ffffffffc0204f10:	d8efb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204f14 <iobuf_skip.part.0>:
ffffffffc0204f14:	1141                	addi	sp,sp,-16
ffffffffc0204f16:	00007697          	auipc	a3,0x7
ffffffffc0204f1a:	3a268693          	addi	a3,a3,930 # ffffffffc020c2b8 <CSWTCH.79+0xc0>
ffffffffc0204f1e:	00006617          	auipc	a2,0x6
ffffffffc0204f22:	93260613          	addi	a2,a2,-1742 # ffffffffc020a850 <commands+0x210>
ffffffffc0204f26:	04a00593          	li	a1,74
ffffffffc0204f2a:	00007517          	auipc	a0,0x7
ffffffffc0204f2e:	3a650513          	addi	a0,a0,934 # ffffffffc020c2d0 <CSWTCH.79+0xd8>
ffffffffc0204f32:	e406                	sd	ra,8(sp)
ffffffffc0204f34:	d6afb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204f38 <iobuf_init>:
ffffffffc0204f38:	e10c                	sd	a1,0(a0)
ffffffffc0204f3a:	e514                	sd	a3,8(a0)
ffffffffc0204f3c:	ed10                	sd	a2,24(a0)
ffffffffc0204f3e:	e910                	sd	a2,16(a0)
ffffffffc0204f40:	8082                	ret

ffffffffc0204f42 <iobuf_move>:
ffffffffc0204f42:	7179                	addi	sp,sp,-48
ffffffffc0204f44:	ec26                	sd	s1,24(sp)
ffffffffc0204f46:	6d04                	ld	s1,24(a0)
ffffffffc0204f48:	f022                	sd	s0,32(sp)
ffffffffc0204f4a:	e84a                	sd	s2,16(sp)
ffffffffc0204f4c:	e44e                	sd	s3,8(sp)
ffffffffc0204f4e:	f406                	sd	ra,40(sp)
ffffffffc0204f50:	842a                	mv	s0,a0
ffffffffc0204f52:	8932                	mv	s2,a2
ffffffffc0204f54:	852e                	mv	a0,a1
ffffffffc0204f56:	89ba                	mv	s3,a4
ffffffffc0204f58:	00967363          	bgeu	a2,s1,ffffffffc0204f5e <iobuf_move+0x1c>
ffffffffc0204f5c:	84b2                	mv	s1,a2
ffffffffc0204f5e:	c495                	beqz	s1,ffffffffc0204f8a <iobuf_move+0x48>
ffffffffc0204f60:	600c                	ld	a1,0(s0)
ffffffffc0204f62:	c681                	beqz	a3,ffffffffc0204f6a <iobuf_move+0x28>
ffffffffc0204f64:	87ae                	mv	a5,a1
ffffffffc0204f66:	85aa                	mv	a1,a0
ffffffffc0204f68:	853e                	mv	a0,a5
ffffffffc0204f6a:	8626                	mv	a2,s1
ffffffffc0204f6c:	40e050ef          	jal	ra,ffffffffc020a37a <memmove>
ffffffffc0204f70:	6c1c                	ld	a5,24(s0)
ffffffffc0204f72:	0297ea63          	bltu	a5,s1,ffffffffc0204fa6 <iobuf_move+0x64>
ffffffffc0204f76:	6014                	ld	a3,0(s0)
ffffffffc0204f78:	6418                	ld	a4,8(s0)
ffffffffc0204f7a:	8f85                	sub	a5,a5,s1
ffffffffc0204f7c:	96a6                	add	a3,a3,s1
ffffffffc0204f7e:	9726                	add	a4,a4,s1
ffffffffc0204f80:	e014                	sd	a3,0(s0)
ffffffffc0204f82:	e418                	sd	a4,8(s0)
ffffffffc0204f84:	ec1c                	sd	a5,24(s0)
ffffffffc0204f86:	40990933          	sub	s2,s2,s1
ffffffffc0204f8a:	00098463          	beqz	s3,ffffffffc0204f92 <iobuf_move+0x50>
ffffffffc0204f8e:	0099b023          	sd	s1,0(s3)
ffffffffc0204f92:	4501                	li	a0,0
ffffffffc0204f94:	00091b63          	bnez	s2,ffffffffc0204faa <iobuf_move+0x68>
ffffffffc0204f98:	70a2                	ld	ra,40(sp)
ffffffffc0204f9a:	7402                	ld	s0,32(sp)
ffffffffc0204f9c:	64e2                	ld	s1,24(sp)
ffffffffc0204f9e:	6942                	ld	s2,16(sp)
ffffffffc0204fa0:	69a2                	ld	s3,8(sp)
ffffffffc0204fa2:	6145                	addi	sp,sp,48
ffffffffc0204fa4:	8082                	ret
ffffffffc0204fa6:	f6fff0ef          	jal	ra,ffffffffc0204f14 <iobuf_skip.part.0>
ffffffffc0204faa:	5571                	li	a0,-4
ffffffffc0204fac:	b7f5                	j	ffffffffc0204f98 <iobuf_move+0x56>

ffffffffc0204fae <iobuf_skip>:
ffffffffc0204fae:	6d1c                	ld	a5,24(a0)
ffffffffc0204fb0:	00b7eb63          	bltu	a5,a1,ffffffffc0204fc6 <iobuf_skip+0x18>
ffffffffc0204fb4:	6114                	ld	a3,0(a0)
ffffffffc0204fb6:	6518                	ld	a4,8(a0)
ffffffffc0204fb8:	8f8d                	sub	a5,a5,a1
ffffffffc0204fba:	96ae                	add	a3,a3,a1
ffffffffc0204fbc:	95ba                	add	a1,a1,a4
ffffffffc0204fbe:	e114                	sd	a3,0(a0)
ffffffffc0204fc0:	e50c                	sd	a1,8(a0)
ffffffffc0204fc2:	ed1c                	sd	a5,24(a0)
ffffffffc0204fc4:	8082                	ret
ffffffffc0204fc6:	1141                	addi	sp,sp,-16
ffffffffc0204fc8:	e406                	sd	ra,8(sp)
ffffffffc0204fca:	f4bff0ef          	jal	ra,ffffffffc0204f14 <iobuf_skip.part.0>

ffffffffc0204fce <copy_path>:
ffffffffc0204fce:	7139                	addi	sp,sp,-64
ffffffffc0204fd0:	f04a                	sd	s2,32(sp)
ffffffffc0204fd2:	00091917          	auipc	s2,0x91
ffffffffc0204fd6:	8e690913          	addi	s2,s2,-1818 # ffffffffc02958b8 <current>
ffffffffc0204fda:	00093703          	ld	a4,0(s2)
ffffffffc0204fde:	ec4e                	sd	s3,24(sp)
ffffffffc0204fe0:	89aa                	mv	s3,a0
ffffffffc0204fe2:	6505                	lui	a0,0x1
ffffffffc0204fe4:	f426                	sd	s1,40(sp)
ffffffffc0204fe6:	e852                	sd	s4,16(sp)
ffffffffc0204fe8:	fc06                	sd	ra,56(sp)
ffffffffc0204fea:	f822                	sd	s0,48(sp)
ffffffffc0204fec:	e456                	sd	s5,8(sp)
ffffffffc0204fee:	02873a03          	ld	s4,40(a4)
ffffffffc0204ff2:	84ae                	mv	s1,a1
ffffffffc0204ff4:	f9bfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0204ff8:	c141                	beqz	a0,ffffffffc0205078 <copy_path+0xaa>
ffffffffc0204ffa:	842a                	mv	s0,a0
ffffffffc0204ffc:	040a0563          	beqz	s4,ffffffffc0205046 <copy_path+0x78>
ffffffffc0205000:	038a0a93          	addi	s5,s4,56
ffffffffc0205004:	8556                	mv	a0,s5
ffffffffc0205006:	8b4ff0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020500a:	00093783          	ld	a5,0(s2)
ffffffffc020500e:	cba1                	beqz	a5,ffffffffc020505e <copy_path+0x90>
ffffffffc0205010:	43dc                	lw	a5,4(a5)
ffffffffc0205012:	6685                	lui	a3,0x1
ffffffffc0205014:	8626                	mv	a2,s1
ffffffffc0205016:	04fa2823          	sw	a5,80(s4)
ffffffffc020501a:	85a2                	mv	a1,s0
ffffffffc020501c:	8552                	mv	a0,s4
ffffffffc020501e:	ec5fe0ef          	jal	ra,ffffffffc0203ee2 <copy_string>
ffffffffc0205022:	c529                	beqz	a0,ffffffffc020506c <copy_path+0x9e>
ffffffffc0205024:	8556                	mv	a0,s5
ffffffffc0205026:	890ff0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc020502a:	040a2823          	sw	zero,80(s4)
ffffffffc020502e:	0089b023          	sd	s0,0(s3)
ffffffffc0205032:	4501                	li	a0,0
ffffffffc0205034:	70e2                	ld	ra,56(sp)
ffffffffc0205036:	7442                	ld	s0,48(sp)
ffffffffc0205038:	74a2                	ld	s1,40(sp)
ffffffffc020503a:	7902                	ld	s2,32(sp)
ffffffffc020503c:	69e2                	ld	s3,24(sp)
ffffffffc020503e:	6a42                	ld	s4,16(sp)
ffffffffc0205040:	6aa2                	ld	s5,8(sp)
ffffffffc0205042:	6121                	addi	sp,sp,64
ffffffffc0205044:	8082                	ret
ffffffffc0205046:	85aa                	mv	a1,a0
ffffffffc0205048:	6685                	lui	a3,0x1
ffffffffc020504a:	8626                	mv	a2,s1
ffffffffc020504c:	4501                	li	a0,0
ffffffffc020504e:	e95fe0ef          	jal	ra,ffffffffc0203ee2 <copy_string>
ffffffffc0205052:	fd71                	bnez	a0,ffffffffc020502e <copy_path+0x60>
ffffffffc0205054:	8522                	mv	a0,s0
ffffffffc0205056:	fe9fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020505a:	5575                	li	a0,-3
ffffffffc020505c:	bfe1                	j	ffffffffc0205034 <copy_path+0x66>
ffffffffc020505e:	6685                	lui	a3,0x1
ffffffffc0205060:	8626                	mv	a2,s1
ffffffffc0205062:	85a2                	mv	a1,s0
ffffffffc0205064:	8552                	mv	a0,s4
ffffffffc0205066:	e7dfe0ef          	jal	ra,ffffffffc0203ee2 <copy_string>
ffffffffc020506a:	fd4d                	bnez	a0,ffffffffc0205024 <copy_path+0x56>
ffffffffc020506c:	8556                	mv	a0,s5
ffffffffc020506e:	848ff0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205072:	040a2823          	sw	zero,80(s4)
ffffffffc0205076:	bff9                	j	ffffffffc0205054 <copy_path+0x86>
ffffffffc0205078:	5571                	li	a0,-4
ffffffffc020507a:	bf6d                	j	ffffffffc0205034 <copy_path+0x66>

ffffffffc020507c <sysfile_open>:
ffffffffc020507c:	7179                	addi	sp,sp,-48
ffffffffc020507e:	872a                	mv	a4,a0
ffffffffc0205080:	ec26                	sd	s1,24(sp)
ffffffffc0205082:	0028                	addi	a0,sp,8
ffffffffc0205084:	84ae                	mv	s1,a1
ffffffffc0205086:	85ba                	mv	a1,a4
ffffffffc0205088:	f022                	sd	s0,32(sp)
ffffffffc020508a:	f406                	sd	ra,40(sp)
ffffffffc020508c:	f43ff0ef          	jal	ra,ffffffffc0204fce <copy_path>
ffffffffc0205090:	842a                	mv	s0,a0
ffffffffc0205092:	e909                	bnez	a0,ffffffffc02050a4 <sysfile_open+0x28>
ffffffffc0205094:	6522                	ld	a0,8(sp)
ffffffffc0205096:	85a6                	mv	a1,s1
ffffffffc0205098:	d60ff0ef          	jal	ra,ffffffffc02045f8 <file_open>
ffffffffc020509c:	842a                	mv	s0,a0
ffffffffc020509e:	6522                	ld	a0,8(sp)
ffffffffc02050a0:	f9ffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02050a4:	70a2                	ld	ra,40(sp)
ffffffffc02050a6:	8522                	mv	a0,s0
ffffffffc02050a8:	7402                	ld	s0,32(sp)
ffffffffc02050aa:	64e2                	ld	s1,24(sp)
ffffffffc02050ac:	6145                	addi	sp,sp,48
ffffffffc02050ae:	8082                	ret

ffffffffc02050b0 <sysfile_close>:
ffffffffc02050b0:	e46ff06f          	j	ffffffffc02046f6 <file_close>

ffffffffc02050b4 <sysfile_read>:
ffffffffc02050b4:	7159                	addi	sp,sp,-112
ffffffffc02050b6:	f0a2                	sd	s0,96(sp)
ffffffffc02050b8:	f486                	sd	ra,104(sp)
ffffffffc02050ba:	eca6                	sd	s1,88(sp)
ffffffffc02050bc:	e8ca                	sd	s2,80(sp)
ffffffffc02050be:	e4ce                	sd	s3,72(sp)
ffffffffc02050c0:	e0d2                	sd	s4,64(sp)
ffffffffc02050c2:	fc56                	sd	s5,56(sp)
ffffffffc02050c4:	f85a                	sd	s6,48(sp)
ffffffffc02050c6:	f45e                	sd	s7,40(sp)
ffffffffc02050c8:	f062                	sd	s8,32(sp)
ffffffffc02050ca:	ec66                	sd	s9,24(sp)
ffffffffc02050cc:	4401                	li	s0,0
ffffffffc02050ce:	ee19                	bnez	a2,ffffffffc02050ec <sysfile_read+0x38>
ffffffffc02050d0:	70a6                	ld	ra,104(sp)
ffffffffc02050d2:	8522                	mv	a0,s0
ffffffffc02050d4:	7406                	ld	s0,96(sp)
ffffffffc02050d6:	64e6                	ld	s1,88(sp)
ffffffffc02050d8:	6946                	ld	s2,80(sp)
ffffffffc02050da:	69a6                	ld	s3,72(sp)
ffffffffc02050dc:	6a06                	ld	s4,64(sp)
ffffffffc02050de:	7ae2                	ld	s5,56(sp)
ffffffffc02050e0:	7b42                	ld	s6,48(sp)
ffffffffc02050e2:	7ba2                	ld	s7,40(sp)
ffffffffc02050e4:	7c02                	ld	s8,32(sp)
ffffffffc02050e6:	6ce2                	ld	s9,24(sp)
ffffffffc02050e8:	6165                	addi	sp,sp,112
ffffffffc02050ea:	8082                	ret
ffffffffc02050ec:	00090c97          	auipc	s9,0x90
ffffffffc02050f0:	7ccc8c93          	addi	s9,s9,1996 # ffffffffc02958b8 <current>
ffffffffc02050f4:	000cb783          	ld	a5,0(s9)
ffffffffc02050f8:	84b2                	mv	s1,a2
ffffffffc02050fa:	8b2e                	mv	s6,a1
ffffffffc02050fc:	4601                	li	a2,0
ffffffffc02050fe:	4585                	li	a1,1
ffffffffc0205100:	0287b903          	ld	s2,40(a5)
ffffffffc0205104:	8aaa                	mv	s5,a0
ffffffffc0205106:	c9eff0ef          	jal	ra,ffffffffc02045a4 <file_testfd>
ffffffffc020510a:	c959                	beqz	a0,ffffffffc02051a0 <sysfile_read+0xec>
ffffffffc020510c:	6505                	lui	a0,0x1
ffffffffc020510e:	e81fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205112:	89aa                	mv	s3,a0
ffffffffc0205114:	c941                	beqz	a0,ffffffffc02051a4 <sysfile_read+0xf0>
ffffffffc0205116:	4b81                	li	s7,0
ffffffffc0205118:	6a05                	lui	s4,0x1
ffffffffc020511a:	03890c13          	addi	s8,s2,56
ffffffffc020511e:	0744ec63          	bltu	s1,s4,ffffffffc0205196 <sysfile_read+0xe2>
ffffffffc0205122:	e452                	sd	s4,8(sp)
ffffffffc0205124:	6605                	lui	a2,0x1
ffffffffc0205126:	0034                	addi	a3,sp,8
ffffffffc0205128:	85ce                	mv	a1,s3
ffffffffc020512a:	8556                	mv	a0,s5
ffffffffc020512c:	e20ff0ef          	jal	ra,ffffffffc020474c <file_read>
ffffffffc0205130:	66a2                	ld	a3,8(sp)
ffffffffc0205132:	842a                	mv	s0,a0
ffffffffc0205134:	ca9d                	beqz	a3,ffffffffc020516a <sysfile_read+0xb6>
ffffffffc0205136:	00090c63          	beqz	s2,ffffffffc020514e <sysfile_read+0x9a>
ffffffffc020513a:	8562                	mv	a0,s8
ffffffffc020513c:	f7ffe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0205140:	000cb783          	ld	a5,0(s9)
ffffffffc0205144:	cfa1                	beqz	a5,ffffffffc020519c <sysfile_read+0xe8>
ffffffffc0205146:	43dc                	lw	a5,4(a5)
ffffffffc0205148:	66a2                	ld	a3,8(sp)
ffffffffc020514a:	04f92823          	sw	a5,80(s2)
ffffffffc020514e:	864e                	mv	a2,s3
ffffffffc0205150:	85da                	mv	a1,s6
ffffffffc0205152:	854a                	mv	a0,s2
ffffffffc0205154:	d5dfe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc0205158:	c50d                	beqz	a0,ffffffffc0205182 <sysfile_read+0xce>
ffffffffc020515a:	67a2                	ld	a5,8(sp)
ffffffffc020515c:	04f4e663          	bltu	s1,a5,ffffffffc02051a8 <sysfile_read+0xf4>
ffffffffc0205160:	9b3e                	add	s6,s6,a5
ffffffffc0205162:	8c9d                	sub	s1,s1,a5
ffffffffc0205164:	9bbe                	add	s7,s7,a5
ffffffffc0205166:	02091263          	bnez	s2,ffffffffc020518a <sysfile_read+0xd6>
ffffffffc020516a:	e401                	bnez	s0,ffffffffc0205172 <sysfile_read+0xbe>
ffffffffc020516c:	67a2                	ld	a5,8(sp)
ffffffffc020516e:	c391                	beqz	a5,ffffffffc0205172 <sysfile_read+0xbe>
ffffffffc0205170:	f4dd                	bnez	s1,ffffffffc020511e <sysfile_read+0x6a>
ffffffffc0205172:	854e                	mv	a0,s3
ffffffffc0205174:	ecbfc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205178:	f40b8ce3          	beqz	s7,ffffffffc02050d0 <sysfile_read+0x1c>
ffffffffc020517c:	000b841b          	sext.w	s0,s7
ffffffffc0205180:	bf81                	j	ffffffffc02050d0 <sysfile_read+0x1c>
ffffffffc0205182:	e011                	bnez	s0,ffffffffc0205186 <sysfile_read+0xd2>
ffffffffc0205184:	5475                	li	s0,-3
ffffffffc0205186:	fe0906e3          	beqz	s2,ffffffffc0205172 <sysfile_read+0xbe>
ffffffffc020518a:	8562                	mv	a0,s8
ffffffffc020518c:	f2bfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205190:	04092823          	sw	zero,80(s2)
ffffffffc0205194:	bfd9                	j	ffffffffc020516a <sysfile_read+0xb6>
ffffffffc0205196:	e426                	sd	s1,8(sp)
ffffffffc0205198:	8626                	mv	a2,s1
ffffffffc020519a:	b771                	j	ffffffffc0205126 <sysfile_read+0x72>
ffffffffc020519c:	66a2                	ld	a3,8(sp)
ffffffffc020519e:	bf45                	j	ffffffffc020514e <sysfile_read+0x9a>
ffffffffc02051a0:	5475                	li	s0,-3
ffffffffc02051a2:	b73d                	j	ffffffffc02050d0 <sysfile_read+0x1c>
ffffffffc02051a4:	5471                	li	s0,-4
ffffffffc02051a6:	b72d                	j	ffffffffc02050d0 <sysfile_read+0x1c>
ffffffffc02051a8:	00007697          	auipc	a3,0x7
ffffffffc02051ac:	13868693          	addi	a3,a3,312 # ffffffffc020c2e0 <CSWTCH.79+0xe8>
ffffffffc02051b0:	00005617          	auipc	a2,0x5
ffffffffc02051b4:	6a060613          	addi	a2,a2,1696 # ffffffffc020a850 <commands+0x210>
ffffffffc02051b8:	05500593          	li	a1,85
ffffffffc02051bc:	00007517          	auipc	a0,0x7
ffffffffc02051c0:	13450513          	addi	a0,a0,308 # ffffffffc020c2f0 <CSWTCH.79+0xf8>
ffffffffc02051c4:	adafb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02051c8 <sysfile_write>:
ffffffffc02051c8:	7159                	addi	sp,sp,-112
ffffffffc02051ca:	e8ca                	sd	s2,80(sp)
ffffffffc02051cc:	f486                	sd	ra,104(sp)
ffffffffc02051ce:	f0a2                	sd	s0,96(sp)
ffffffffc02051d0:	eca6                	sd	s1,88(sp)
ffffffffc02051d2:	e4ce                	sd	s3,72(sp)
ffffffffc02051d4:	e0d2                	sd	s4,64(sp)
ffffffffc02051d6:	fc56                	sd	s5,56(sp)
ffffffffc02051d8:	f85a                	sd	s6,48(sp)
ffffffffc02051da:	f45e                	sd	s7,40(sp)
ffffffffc02051dc:	f062                	sd	s8,32(sp)
ffffffffc02051de:	ec66                	sd	s9,24(sp)
ffffffffc02051e0:	4901                	li	s2,0
ffffffffc02051e2:	ee19                	bnez	a2,ffffffffc0205200 <sysfile_write+0x38>
ffffffffc02051e4:	70a6                	ld	ra,104(sp)
ffffffffc02051e6:	7406                	ld	s0,96(sp)
ffffffffc02051e8:	64e6                	ld	s1,88(sp)
ffffffffc02051ea:	69a6                	ld	s3,72(sp)
ffffffffc02051ec:	6a06                	ld	s4,64(sp)
ffffffffc02051ee:	7ae2                	ld	s5,56(sp)
ffffffffc02051f0:	7b42                	ld	s6,48(sp)
ffffffffc02051f2:	7ba2                	ld	s7,40(sp)
ffffffffc02051f4:	7c02                	ld	s8,32(sp)
ffffffffc02051f6:	6ce2                	ld	s9,24(sp)
ffffffffc02051f8:	854a                	mv	a0,s2
ffffffffc02051fa:	6946                	ld	s2,80(sp)
ffffffffc02051fc:	6165                	addi	sp,sp,112
ffffffffc02051fe:	8082                	ret
ffffffffc0205200:	00090c17          	auipc	s8,0x90
ffffffffc0205204:	6b8c0c13          	addi	s8,s8,1720 # ffffffffc02958b8 <current>
ffffffffc0205208:	000c3783          	ld	a5,0(s8)
ffffffffc020520c:	8432                	mv	s0,a2
ffffffffc020520e:	89ae                	mv	s3,a1
ffffffffc0205210:	4605                	li	a2,1
ffffffffc0205212:	4581                	li	a1,0
ffffffffc0205214:	7784                	ld	s1,40(a5)
ffffffffc0205216:	8baa                	mv	s7,a0
ffffffffc0205218:	b8cff0ef          	jal	ra,ffffffffc02045a4 <file_testfd>
ffffffffc020521c:	cd59                	beqz	a0,ffffffffc02052ba <sysfile_write+0xf2>
ffffffffc020521e:	6505                	lui	a0,0x1
ffffffffc0205220:	d6ffc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205224:	8a2a                	mv	s4,a0
ffffffffc0205226:	cd41                	beqz	a0,ffffffffc02052be <sysfile_write+0xf6>
ffffffffc0205228:	4c81                	li	s9,0
ffffffffc020522a:	6a85                	lui	s5,0x1
ffffffffc020522c:	03848b13          	addi	s6,s1,56
ffffffffc0205230:	05546a63          	bltu	s0,s5,ffffffffc0205284 <sysfile_write+0xbc>
ffffffffc0205234:	e456                	sd	s5,8(sp)
ffffffffc0205236:	c8a9                	beqz	s1,ffffffffc0205288 <sysfile_write+0xc0>
ffffffffc0205238:	855a                	mv	a0,s6
ffffffffc020523a:	e81fe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020523e:	000c3783          	ld	a5,0(s8)
ffffffffc0205242:	c399                	beqz	a5,ffffffffc0205248 <sysfile_write+0x80>
ffffffffc0205244:	43dc                	lw	a5,4(a5)
ffffffffc0205246:	c8bc                	sw	a5,80(s1)
ffffffffc0205248:	66a2                	ld	a3,8(sp)
ffffffffc020524a:	4701                	li	a4,0
ffffffffc020524c:	864e                	mv	a2,s3
ffffffffc020524e:	85d2                	mv	a1,s4
ffffffffc0205250:	8526                	mv	a0,s1
ffffffffc0205252:	c2bfe0ef          	jal	ra,ffffffffc0203e7c <copy_from_user>
ffffffffc0205256:	c139                	beqz	a0,ffffffffc020529c <sysfile_write+0xd4>
ffffffffc0205258:	855a                	mv	a0,s6
ffffffffc020525a:	e5dfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc020525e:	0404a823          	sw	zero,80(s1)
ffffffffc0205262:	6622                	ld	a2,8(sp)
ffffffffc0205264:	0034                	addi	a3,sp,8
ffffffffc0205266:	85d2                	mv	a1,s4
ffffffffc0205268:	855e                	mv	a0,s7
ffffffffc020526a:	dc8ff0ef          	jal	ra,ffffffffc0204832 <file_write>
ffffffffc020526e:	67a2                	ld	a5,8(sp)
ffffffffc0205270:	892a                	mv	s2,a0
ffffffffc0205272:	ef85                	bnez	a5,ffffffffc02052aa <sysfile_write+0xe2>
ffffffffc0205274:	8552                	mv	a0,s4
ffffffffc0205276:	dc9fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020527a:	f60c85e3          	beqz	s9,ffffffffc02051e4 <sysfile_write+0x1c>
ffffffffc020527e:	000c891b          	sext.w	s2,s9
ffffffffc0205282:	b78d                	j	ffffffffc02051e4 <sysfile_write+0x1c>
ffffffffc0205284:	e422                	sd	s0,8(sp)
ffffffffc0205286:	f8cd                	bnez	s1,ffffffffc0205238 <sysfile_write+0x70>
ffffffffc0205288:	66a2                	ld	a3,8(sp)
ffffffffc020528a:	4701                	li	a4,0
ffffffffc020528c:	864e                	mv	a2,s3
ffffffffc020528e:	85d2                	mv	a1,s4
ffffffffc0205290:	4501                	li	a0,0
ffffffffc0205292:	bebfe0ef          	jal	ra,ffffffffc0203e7c <copy_from_user>
ffffffffc0205296:	f571                	bnez	a0,ffffffffc0205262 <sysfile_write+0x9a>
ffffffffc0205298:	5975                	li	s2,-3
ffffffffc020529a:	bfe9                	j	ffffffffc0205274 <sysfile_write+0xac>
ffffffffc020529c:	855a                	mv	a0,s6
ffffffffc020529e:	e19fe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02052a2:	5975                	li	s2,-3
ffffffffc02052a4:	0404a823          	sw	zero,80(s1)
ffffffffc02052a8:	b7f1                	j	ffffffffc0205274 <sysfile_write+0xac>
ffffffffc02052aa:	00f46c63          	bltu	s0,a5,ffffffffc02052c2 <sysfile_write+0xfa>
ffffffffc02052ae:	99be                	add	s3,s3,a5
ffffffffc02052b0:	8c1d                	sub	s0,s0,a5
ffffffffc02052b2:	9cbe                	add	s9,s9,a5
ffffffffc02052b4:	f161                	bnez	a0,ffffffffc0205274 <sysfile_write+0xac>
ffffffffc02052b6:	fc2d                	bnez	s0,ffffffffc0205230 <sysfile_write+0x68>
ffffffffc02052b8:	bf75                	j	ffffffffc0205274 <sysfile_write+0xac>
ffffffffc02052ba:	5975                	li	s2,-3
ffffffffc02052bc:	b725                	j	ffffffffc02051e4 <sysfile_write+0x1c>
ffffffffc02052be:	5971                	li	s2,-4
ffffffffc02052c0:	b715                	j	ffffffffc02051e4 <sysfile_write+0x1c>
ffffffffc02052c2:	00007697          	auipc	a3,0x7
ffffffffc02052c6:	01e68693          	addi	a3,a3,30 # ffffffffc020c2e0 <CSWTCH.79+0xe8>
ffffffffc02052ca:	00005617          	auipc	a2,0x5
ffffffffc02052ce:	58660613          	addi	a2,a2,1414 # ffffffffc020a850 <commands+0x210>
ffffffffc02052d2:	08a00593          	li	a1,138
ffffffffc02052d6:	00007517          	auipc	a0,0x7
ffffffffc02052da:	01a50513          	addi	a0,a0,26 # ffffffffc020c2f0 <CSWTCH.79+0xf8>
ffffffffc02052de:	9c0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02052e2 <sysfile_seek>:
ffffffffc02052e2:	e36ff06f          	j	ffffffffc0204918 <file_seek>

ffffffffc02052e6 <sysfile_fstat>:
ffffffffc02052e6:	715d                	addi	sp,sp,-80
ffffffffc02052e8:	f44e                	sd	s3,40(sp)
ffffffffc02052ea:	00090997          	auipc	s3,0x90
ffffffffc02052ee:	5ce98993          	addi	s3,s3,1486 # ffffffffc02958b8 <current>
ffffffffc02052f2:	0009b703          	ld	a4,0(s3)
ffffffffc02052f6:	fc26                	sd	s1,56(sp)
ffffffffc02052f8:	84ae                	mv	s1,a1
ffffffffc02052fa:	858a                	mv	a1,sp
ffffffffc02052fc:	e0a2                	sd	s0,64(sp)
ffffffffc02052fe:	f84a                	sd	s2,48(sp)
ffffffffc0205300:	e486                	sd	ra,72(sp)
ffffffffc0205302:	02873903          	ld	s2,40(a4)
ffffffffc0205306:	f052                	sd	s4,32(sp)
ffffffffc0205308:	f30ff0ef          	jal	ra,ffffffffc0204a38 <file_fstat>
ffffffffc020530c:	842a                	mv	s0,a0
ffffffffc020530e:	e91d                	bnez	a0,ffffffffc0205344 <sysfile_fstat+0x5e>
ffffffffc0205310:	04090363          	beqz	s2,ffffffffc0205356 <sysfile_fstat+0x70>
ffffffffc0205314:	03890a13          	addi	s4,s2,56
ffffffffc0205318:	8552                	mv	a0,s4
ffffffffc020531a:	da1fe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020531e:	0009b783          	ld	a5,0(s3)
ffffffffc0205322:	c3b9                	beqz	a5,ffffffffc0205368 <sysfile_fstat+0x82>
ffffffffc0205324:	43dc                	lw	a5,4(a5)
ffffffffc0205326:	02000693          	li	a3,32
ffffffffc020532a:	860a                	mv	a2,sp
ffffffffc020532c:	04f92823          	sw	a5,80(s2)
ffffffffc0205330:	85a6                	mv	a1,s1
ffffffffc0205332:	854a                	mv	a0,s2
ffffffffc0205334:	b7dfe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc0205338:	c121                	beqz	a0,ffffffffc0205378 <sysfile_fstat+0x92>
ffffffffc020533a:	8552                	mv	a0,s4
ffffffffc020533c:	d7bfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205340:	04092823          	sw	zero,80(s2)
ffffffffc0205344:	60a6                	ld	ra,72(sp)
ffffffffc0205346:	8522                	mv	a0,s0
ffffffffc0205348:	6406                	ld	s0,64(sp)
ffffffffc020534a:	74e2                	ld	s1,56(sp)
ffffffffc020534c:	7942                	ld	s2,48(sp)
ffffffffc020534e:	79a2                	ld	s3,40(sp)
ffffffffc0205350:	7a02                	ld	s4,32(sp)
ffffffffc0205352:	6161                	addi	sp,sp,80
ffffffffc0205354:	8082                	ret
ffffffffc0205356:	02000693          	li	a3,32
ffffffffc020535a:	860a                	mv	a2,sp
ffffffffc020535c:	85a6                	mv	a1,s1
ffffffffc020535e:	b53fe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc0205362:	f16d                	bnez	a0,ffffffffc0205344 <sysfile_fstat+0x5e>
ffffffffc0205364:	5475                	li	s0,-3
ffffffffc0205366:	bff9                	j	ffffffffc0205344 <sysfile_fstat+0x5e>
ffffffffc0205368:	02000693          	li	a3,32
ffffffffc020536c:	860a                	mv	a2,sp
ffffffffc020536e:	85a6                	mv	a1,s1
ffffffffc0205370:	854a                	mv	a0,s2
ffffffffc0205372:	b3ffe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc0205376:	f171                	bnez	a0,ffffffffc020533a <sysfile_fstat+0x54>
ffffffffc0205378:	8552                	mv	a0,s4
ffffffffc020537a:	d3dfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc020537e:	5475                	li	s0,-3
ffffffffc0205380:	04092823          	sw	zero,80(s2)
ffffffffc0205384:	b7c1                	j	ffffffffc0205344 <sysfile_fstat+0x5e>

ffffffffc0205386 <sysfile_fsync>:
ffffffffc0205386:	f72ff06f          	j	ffffffffc0204af8 <file_fsync>

ffffffffc020538a <sysfile_getcwd>:
ffffffffc020538a:	715d                	addi	sp,sp,-80
ffffffffc020538c:	f44e                	sd	s3,40(sp)
ffffffffc020538e:	00090997          	auipc	s3,0x90
ffffffffc0205392:	52a98993          	addi	s3,s3,1322 # ffffffffc02958b8 <current>
ffffffffc0205396:	0009b783          	ld	a5,0(s3)
ffffffffc020539a:	f84a                	sd	s2,48(sp)
ffffffffc020539c:	e486                	sd	ra,72(sp)
ffffffffc020539e:	e0a2                	sd	s0,64(sp)
ffffffffc02053a0:	fc26                	sd	s1,56(sp)
ffffffffc02053a2:	f052                	sd	s4,32(sp)
ffffffffc02053a4:	0287b903          	ld	s2,40(a5)
ffffffffc02053a8:	cda9                	beqz	a1,ffffffffc0205402 <sysfile_getcwd+0x78>
ffffffffc02053aa:	842e                	mv	s0,a1
ffffffffc02053ac:	84aa                	mv	s1,a0
ffffffffc02053ae:	04090363          	beqz	s2,ffffffffc02053f4 <sysfile_getcwd+0x6a>
ffffffffc02053b2:	03890a13          	addi	s4,s2,56
ffffffffc02053b6:	8552                	mv	a0,s4
ffffffffc02053b8:	d03fe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc02053bc:	0009b783          	ld	a5,0(s3)
ffffffffc02053c0:	c781                	beqz	a5,ffffffffc02053c8 <sysfile_getcwd+0x3e>
ffffffffc02053c2:	43dc                	lw	a5,4(a5)
ffffffffc02053c4:	04f92823          	sw	a5,80(s2)
ffffffffc02053c8:	4685                	li	a3,1
ffffffffc02053ca:	8622                	mv	a2,s0
ffffffffc02053cc:	85a6                	mv	a1,s1
ffffffffc02053ce:	854a                	mv	a0,s2
ffffffffc02053d0:	a19fe0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc02053d4:	e90d                	bnez	a0,ffffffffc0205406 <sysfile_getcwd+0x7c>
ffffffffc02053d6:	5475                	li	s0,-3
ffffffffc02053d8:	8552                	mv	a0,s4
ffffffffc02053da:	cddfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02053de:	04092823          	sw	zero,80(s2)
ffffffffc02053e2:	60a6                	ld	ra,72(sp)
ffffffffc02053e4:	8522                	mv	a0,s0
ffffffffc02053e6:	6406                	ld	s0,64(sp)
ffffffffc02053e8:	74e2                	ld	s1,56(sp)
ffffffffc02053ea:	7942                	ld	s2,48(sp)
ffffffffc02053ec:	79a2                	ld	s3,40(sp)
ffffffffc02053ee:	7a02                	ld	s4,32(sp)
ffffffffc02053f0:	6161                	addi	sp,sp,80
ffffffffc02053f2:	8082                	ret
ffffffffc02053f4:	862e                	mv	a2,a1
ffffffffc02053f6:	4685                	li	a3,1
ffffffffc02053f8:	85aa                	mv	a1,a0
ffffffffc02053fa:	4501                	li	a0,0
ffffffffc02053fc:	9edfe0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0205400:	ed09                	bnez	a0,ffffffffc020541a <sysfile_getcwd+0x90>
ffffffffc0205402:	5475                	li	s0,-3
ffffffffc0205404:	bff9                	j	ffffffffc02053e2 <sysfile_getcwd+0x58>
ffffffffc0205406:	8622                	mv	a2,s0
ffffffffc0205408:	4681                	li	a3,0
ffffffffc020540a:	85a6                	mv	a1,s1
ffffffffc020540c:	850a                	mv	a0,sp
ffffffffc020540e:	b2bff0ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc0205412:	106020ef          	jal	ra,ffffffffc0207518 <vfs_getcwd>
ffffffffc0205416:	842a                	mv	s0,a0
ffffffffc0205418:	b7c1                	j	ffffffffc02053d8 <sysfile_getcwd+0x4e>
ffffffffc020541a:	8622                	mv	a2,s0
ffffffffc020541c:	4681                	li	a3,0
ffffffffc020541e:	85a6                	mv	a1,s1
ffffffffc0205420:	850a                	mv	a0,sp
ffffffffc0205422:	b17ff0ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc0205426:	0f2020ef          	jal	ra,ffffffffc0207518 <vfs_getcwd>
ffffffffc020542a:	842a                	mv	s0,a0
ffffffffc020542c:	bf5d                	j	ffffffffc02053e2 <sysfile_getcwd+0x58>

ffffffffc020542e <sysfile_getdirentry>:
ffffffffc020542e:	7139                	addi	sp,sp,-64
ffffffffc0205430:	e852                	sd	s4,16(sp)
ffffffffc0205432:	00090a17          	auipc	s4,0x90
ffffffffc0205436:	486a0a13          	addi	s4,s4,1158 # ffffffffc02958b8 <current>
ffffffffc020543a:	000a3703          	ld	a4,0(s4)
ffffffffc020543e:	ec4e                	sd	s3,24(sp)
ffffffffc0205440:	89aa                	mv	s3,a0
ffffffffc0205442:	10800513          	li	a0,264
ffffffffc0205446:	f426                	sd	s1,40(sp)
ffffffffc0205448:	f04a                	sd	s2,32(sp)
ffffffffc020544a:	fc06                	sd	ra,56(sp)
ffffffffc020544c:	f822                	sd	s0,48(sp)
ffffffffc020544e:	e456                	sd	s5,8(sp)
ffffffffc0205450:	7704                	ld	s1,40(a4)
ffffffffc0205452:	892e                	mv	s2,a1
ffffffffc0205454:	b3bfc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205458:	c169                	beqz	a0,ffffffffc020551a <sysfile_getdirentry+0xec>
ffffffffc020545a:	842a                	mv	s0,a0
ffffffffc020545c:	c8c1                	beqz	s1,ffffffffc02054ec <sysfile_getdirentry+0xbe>
ffffffffc020545e:	03848a93          	addi	s5,s1,56
ffffffffc0205462:	8556                	mv	a0,s5
ffffffffc0205464:	c57fe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0205468:	000a3783          	ld	a5,0(s4)
ffffffffc020546c:	c399                	beqz	a5,ffffffffc0205472 <sysfile_getdirentry+0x44>
ffffffffc020546e:	43dc                	lw	a5,4(a5)
ffffffffc0205470:	c8bc                	sw	a5,80(s1)
ffffffffc0205472:	4705                	li	a4,1
ffffffffc0205474:	46a1                	li	a3,8
ffffffffc0205476:	864a                	mv	a2,s2
ffffffffc0205478:	85a2                	mv	a1,s0
ffffffffc020547a:	8526                	mv	a0,s1
ffffffffc020547c:	a01fe0ef          	jal	ra,ffffffffc0203e7c <copy_from_user>
ffffffffc0205480:	e505                	bnez	a0,ffffffffc02054a8 <sysfile_getdirentry+0x7a>
ffffffffc0205482:	8556                	mv	a0,s5
ffffffffc0205484:	c33fe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205488:	59f5                	li	s3,-3
ffffffffc020548a:	0404a823          	sw	zero,80(s1)
ffffffffc020548e:	8522                	mv	a0,s0
ffffffffc0205490:	baffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205494:	70e2                	ld	ra,56(sp)
ffffffffc0205496:	7442                	ld	s0,48(sp)
ffffffffc0205498:	74a2                	ld	s1,40(sp)
ffffffffc020549a:	7902                	ld	s2,32(sp)
ffffffffc020549c:	6a42                	ld	s4,16(sp)
ffffffffc020549e:	6aa2                	ld	s5,8(sp)
ffffffffc02054a0:	854e                	mv	a0,s3
ffffffffc02054a2:	69e2                	ld	s3,24(sp)
ffffffffc02054a4:	6121                	addi	sp,sp,64
ffffffffc02054a6:	8082                	ret
ffffffffc02054a8:	8556                	mv	a0,s5
ffffffffc02054aa:	c0dfe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02054ae:	854e                	mv	a0,s3
ffffffffc02054b0:	85a2                	mv	a1,s0
ffffffffc02054b2:	0404a823          	sw	zero,80(s1)
ffffffffc02054b6:	ef0ff0ef          	jal	ra,ffffffffc0204ba6 <file_getdirentry>
ffffffffc02054ba:	89aa                	mv	s3,a0
ffffffffc02054bc:	f969                	bnez	a0,ffffffffc020548e <sysfile_getdirentry+0x60>
ffffffffc02054be:	8556                	mv	a0,s5
ffffffffc02054c0:	bfbfe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc02054c4:	000a3783          	ld	a5,0(s4)
ffffffffc02054c8:	c399                	beqz	a5,ffffffffc02054ce <sysfile_getdirentry+0xa0>
ffffffffc02054ca:	43dc                	lw	a5,4(a5)
ffffffffc02054cc:	c8bc                	sw	a5,80(s1)
ffffffffc02054ce:	10800693          	li	a3,264
ffffffffc02054d2:	8622                	mv	a2,s0
ffffffffc02054d4:	85ca                	mv	a1,s2
ffffffffc02054d6:	8526                	mv	a0,s1
ffffffffc02054d8:	9d9fe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc02054dc:	e111                	bnez	a0,ffffffffc02054e0 <sysfile_getdirentry+0xb2>
ffffffffc02054de:	59f5                	li	s3,-3
ffffffffc02054e0:	8556                	mv	a0,s5
ffffffffc02054e2:	bd5fe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02054e6:	0404a823          	sw	zero,80(s1)
ffffffffc02054ea:	b755                	j	ffffffffc020548e <sysfile_getdirentry+0x60>
ffffffffc02054ec:	85aa                	mv	a1,a0
ffffffffc02054ee:	4705                	li	a4,1
ffffffffc02054f0:	46a1                	li	a3,8
ffffffffc02054f2:	864a                	mv	a2,s2
ffffffffc02054f4:	4501                	li	a0,0
ffffffffc02054f6:	987fe0ef          	jal	ra,ffffffffc0203e7c <copy_from_user>
ffffffffc02054fa:	cd11                	beqz	a0,ffffffffc0205516 <sysfile_getdirentry+0xe8>
ffffffffc02054fc:	854e                	mv	a0,s3
ffffffffc02054fe:	85a2                	mv	a1,s0
ffffffffc0205500:	ea6ff0ef          	jal	ra,ffffffffc0204ba6 <file_getdirentry>
ffffffffc0205504:	89aa                	mv	s3,a0
ffffffffc0205506:	f541                	bnez	a0,ffffffffc020548e <sysfile_getdirentry+0x60>
ffffffffc0205508:	10800693          	li	a3,264
ffffffffc020550c:	8622                	mv	a2,s0
ffffffffc020550e:	85ca                	mv	a1,s2
ffffffffc0205510:	9a1fe0ef          	jal	ra,ffffffffc0203eb0 <copy_to_user>
ffffffffc0205514:	fd2d                	bnez	a0,ffffffffc020548e <sysfile_getdirentry+0x60>
ffffffffc0205516:	59f5                	li	s3,-3
ffffffffc0205518:	bf9d                	j	ffffffffc020548e <sysfile_getdirentry+0x60>
ffffffffc020551a:	59f1                	li	s3,-4
ffffffffc020551c:	bfa5                	j	ffffffffc0205494 <sysfile_getdirentry+0x66>

ffffffffc020551e <sysfile_dup>:
ffffffffc020551e:	f6eff06f          	j	ffffffffc0204c8c <file_dup>

ffffffffc0205522 <kernel_thread_entry>:
ffffffffc0205522:	8526                	mv	a0,s1
ffffffffc0205524:	9402                	jalr	s0
ffffffffc0205526:	1c4000ef          	jal	ra,ffffffffc02056ea <do_exit>

ffffffffc020552a <put_pgdir.isra.0>:
ffffffffc020552a:	1141                	addi	sp,sp,-16
ffffffffc020552c:	e406                	sd	ra,8(sp)
ffffffffc020552e:	c02007b7          	lui	a5,0xc0200
ffffffffc0205532:	02f56e63          	bltu	a0,a5,ffffffffc020556e <put_pgdir.isra.0+0x44>
ffffffffc0205536:	00090697          	auipc	a3,0x90
ffffffffc020553a:	37a6b683          	ld	a3,890(a3) # ffffffffc02958b0 <va_pa_offset>
ffffffffc020553e:	8d15                	sub	a0,a0,a3
ffffffffc0205540:	8131                	srli	a0,a0,0xc
ffffffffc0205542:	00090797          	auipc	a5,0x90
ffffffffc0205546:	3567b783          	ld	a5,854(a5) # ffffffffc0295898 <npage>
ffffffffc020554a:	02f57f63          	bgeu	a0,a5,ffffffffc0205588 <put_pgdir.isra.0+0x5e>
ffffffffc020554e:	00009697          	auipc	a3,0x9
ffffffffc0205552:	f826b683          	ld	a3,-126(a3) # ffffffffc020e4d0 <nbase>
ffffffffc0205556:	60a2                	ld	ra,8(sp)
ffffffffc0205558:	8d15                	sub	a0,a0,a3
ffffffffc020555a:	00090797          	auipc	a5,0x90
ffffffffc020555e:	3467b783          	ld	a5,838(a5) # ffffffffc02958a0 <pages>
ffffffffc0205562:	051a                	slli	a0,a0,0x6
ffffffffc0205564:	4585                	li	a1,1
ffffffffc0205566:	953e                	add	a0,a0,a5
ffffffffc0205568:	0141                	addi	sp,sp,16
ffffffffc020556a:	c41fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc020556e:	86aa                	mv	a3,a0
ffffffffc0205570:	00006617          	auipc	a2,0x6
ffffffffc0205574:	ea860613          	addi	a2,a2,-344 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc0205578:	07700593          	li	a1,119
ffffffffc020557c:	00006517          	auipc	a0,0x6
ffffffffc0205580:	e1c50513          	addi	a0,a0,-484 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0205584:	f1bfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205588:	00006617          	auipc	a2,0x6
ffffffffc020558c:	eb860613          	addi	a2,a2,-328 # ffffffffc020b440 <default_pmm_manager+0x108>
ffffffffc0205590:	06900593          	li	a1,105
ffffffffc0205594:	00006517          	auipc	a0,0x6
ffffffffc0205598:	e0450513          	addi	a0,a0,-508 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc020559c:	f03fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02055a0 <proc_run>:
ffffffffc02055a0:	8082                	ret

ffffffffc02055a2 <do_fork>:
ffffffffc02055a2:	00090717          	auipc	a4,0x90
ffffffffc02055a6:	32e72703          	lw	a4,814(a4) # ffffffffc02958d0 <nr_process>
ffffffffc02055aa:	6785                	lui	a5,0x1
ffffffffc02055ac:	00f74463          	blt	a4,a5,ffffffffc02055b4 <do_fork+0x12>
ffffffffc02055b0:	556d                	li	a0,-5
ffffffffc02055b2:	8082                	ret
ffffffffc02055b4:	1101                	addi	sp,sp,-32
ffffffffc02055b6:	00090717          	auipc	a4,0x90
ffffffffc02055ba:	30273703          	ld	a4,770(a4) # ffffffffc02958b8 <current>
ffffffffc02055be:	e822                	sd	s0,16(sp)
ffffffffc02055c0:	14873403          	ld	s0,328(a4)
ffffffffc02055c4:	ec06                	sd	ra,24(sp)
ffffffffc02055c6:	e426                	sd	s1,8(sp)
ffffffffc02055c8:	c049                	beqz	s0,ffffffffc020564a <do_fork+0xa8>
ffffffffc02055ca:	80078793          	addi	a5,a5,-2048 # 800 <_binary_bin_swap_img_size-0x7500>
ffffffffc02055ce:	8d7d                	and	a0,a0,a5
ffffffffc02055d0:	e911                	bnez	a0,ffffffffc02055e4 <do_fork+0x42>
ffffffffc02055d2:	f52ff0ef          	jal	ra,ffffffffc0204d24 <files_create>
ffffffffc02055d6:	84aa                	mv	s1,a0
ffffffffc02055d8:	c505                	beqz	a0,ffffffffc0205600 <do_fork+0x5e>
ffffffffc02055da:	85a2                	mv	a1,s0
ffffffffc02055dc:	881ff0ef          	jal	ra,ffffffffc0204e5c <dup_files>
ffffffffc02055e0:	8426                	mv	s0,s1
ffffffffc02055e2:	ed01                	bnez	a0,ffffffffc02055fa <do_fork+0x58>
ffffffffc02055e4:	481c                	lw	a5,16(s0)
ffffffffc02055e6:	5571                	li	a0,-4
ffffffffc02055e8:	2785                	addiw	a5,a5,1
ffffffffc02055ea:	c81c                	sw	a5,16(s0)
ffffffffc02055ec:	14803423          	sd	s0,328(zero) # 148 <_binary_bin_swap_img_size-0x7bb8>
ffffffffc02055f0:	60e2                	ld	ra,24(sp)
ffffffffc02055f2:	6442                	ld	s0,16(sp)
ffffffffc02055f4:	64a2                	ld	s1,8(sp)
ffffffffc02055f6:	6105                	addi	sp,sp,32
ffffffffc02055f8:	8082                	ret
ffffffffc02055fa:	8526                	mv	a0,s1
ffffffffc02055fc:	f5eff0ef          	jal	ra,ffffffffc0204d5a <files_destroy>
ffffffffc0205600:	01003683          	ld	a3,16(zero) # 10 <_binary_bin_swap_img_size-0x7cf0>
ffffffffc0205604:	c02007b7          	lui	a5,0xc0200
ffffffffc0205608:	06f6ed63          	bltu	a3,a5,ffffffffc0205682 <do_fork+0xe0>
ffffffffc020560c:	00090797          	auipc	a5,0x90
ffffffffc0205610:	2a47b783          	ld	a5,676(a5) # ffffffffc02958b0 <va_pa_offset>
ffffffffc0205614:	8e9d                	sub	a3,a3,a5
ffffffffc0205616:	82b1                	srli	a3,a3,0xc
ffffffffc0205618:	00090797          	auipc	a5,0x90
ffffffffc020561c:	2807b783          	ld	a5,640(a5) # ffffffffc0295898 <npage>
ffffffffc0205620:	04f6f563          	bgeu	a3,a5,ffffffffc020566a <do_fork+0xc8>
ffffffffc0205624:	00009517          	auipc	a0,0x9
ffffffffc0205628:	eac53503          	ld	a0,-340(a0) # ffffffffc020e4d0 <nbase>
ffffffffc020562c:	8e89                	sub	a3,a3,a0
ffffffffc020562e:	069a                	slli	a3,a3,0x6
ffffffffc0205630:	00090517          	auipc	a0,0x90
ffffffffc0205634:	27053503          	ld	a0,624(a0) # ffffffffc02958a0 <pages>
ffffffffc0205638:	9536                	add	a0,a0,a3
ffffffffc020563a:	4589                	li	a1,2
ffffffffc020563c:	b6ffc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205640:	4501                	li	a0,0
ffffffffc0205642:	9fdfc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205646:	5571                	li	a0,-4
ffffffffc0205648:	b765                	j	ffffffffc02055f0 <do_fork+0x4e>
ffffffffc020564a:	00007697          	auipc	a3,0x7
ffffffffc020564e:	cbe68693          	addi	a3,a3,-834 # ffffffffc020c308 <CSWTCH.79+0x110>
ffffffffc0205652:	00005617          	auipc	a2,0x5
ffffffffc0205656:	1fe60613          	addi	a2,a2,510 # ffffffffc020a850 <commands+0x210>
ffffffffc020565a:	1c100593          	li	a1,449
ffffffffc020565e:	00007517          	auipc	a0,0x7
ffffffffc0205662:	cc250513          	addi	a0,a0,-830 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205666:	e39fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020566a:	00006617          	auipc	a2,0x6
ffffffffc020566e:	dd660613          	addi	a2,a2,-554 # ffffffffc020b440 <default_pmm_manager+0x108>
ffffffffc0205672:	06900593          	li	a1,105
ffffffffc0205676:	00006517          	auipc	a0,0x6
ffffffffc020567a:	d2250513          	addi	a0,a0,-734 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc020567e:	e21fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205682:	00006617          	auipc	a2,0x6
ffffffffc0205686:	d9660613          	addi	a2,a2,-618 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc020568a:	07700593          	li	a1,119
ffffffffc020568e:	00006517          	auipc	a0,0x6
ffffffffc0205692:	d0a50513          	addi	a0,a0,-758 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0205696:	e09fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020569a <kernel_thread>:
ffffffffc020569a:	7129                	addi	sp,sp,-320
ffffffffc020569c:	fa22                	sd	s0,304(sp)
ffffffffc020569e:	f626                	sd	s1,296(sp)
ffffffffc02056a0:	f24a                	sd	s2,288(sp)
ffffffffc02056a2:	84ae                	mv	s1,a1
ffffffffc02056a4:	892a                	mv	s2,a0
ffffffffc02056a6:	8432                	mv	s0,a2
ffffffffc02056a8:	4581                	li	a1,0
ffffffffc02056aa:	12000613          	li	a2,288
ffffffffc02056ae:	850a                	mv	a0,sp
ffffffffc02056b0:	fe06                	sd	ra,312(sp)
ffffffffc02056b2:	4b7040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc02056b6:	e0ca                	sd	s2,64(sp)
ffffffffc02056b8:	e4a6                	sd	s1,72(sp)
ffffffffc02056ba:	100027f3          	csrr	a5,sstatus
ffffffffc02056be:	edd7f793          	andi	a5,a5,-291
ffffffffc02056c2:	1207e793          	ori	a5,a5,288
ffffffffc02056c6:	e23e                	sd	a5,256(sp)
ffffffffc02056c8:	860a                	mv	a2,sp
ffffffffc02056ca:	10046513          	ori	a0,s0,256
ffffffffc02056ce:	00000797          	auipc	a5,0x0
ffffffffc02056d2:	e5478793          	addi	a5,a5,-428 # ffffffffc0205522 <kernel_thread_entry>
ffffffffc02056d6:	4581                	li	a1,0
ffffffffc02056d8:	e63e                	sd	a5,264(sp)
ffffffffc02056da:	ec9ff0ef          	jal	ra,ffffffffc02055a2 <do_fork>
ffffffffc02056de:	70f2                	ld	ra,312(sp)
ffffffffc02056e0:	7452                	ld	s0,304(sp)
ffffffffc02056e2:	74b2                	ld	s1,296(sp)
ffffffffc02056e4:	7912                	ld	s2,288(sp)
ffffffffc02056e6:	6131                	addi	sp,sp,320
ffffffffc02056e8:	8082                	ret

ffffffffc02056ea <do_exit>:
ffffffffc02056ea:	7179                	addi	sp,sp,-48
ffffffffc02056ec:	f022                	sd	s0,32(sp)
ffffffffc02056ee:	00090417          	auipc	s0,0x90
ffffffffc02056f2:	1ca40413          	addi	s0,s0,458 # ffffffffc02958b8 <current>
ffffffffc02056f6:	601c                	ld	a5,0(s0)
ffffffffc02056f8:	f406                	sd	ra,40(sp)
ffffffffc02056fa:	ec26                	sd	s1,24(sp)
ffffffffc02056fc:	e84a                	sd	s2,16(sp)
ffffffffc02056fe:	e44e                	sd	s3,8(sp)
ffffffffc0205700:	e052                	sd	s4,0(sp)
ffffffffc0205702:	00090717          	auipc	a4,0x90
ffffffffc0205706:	1be73703          	ld	a4,446(a4) # ffffffffc02958c0 <idleproc>
ffffffffc020570a:	0ee78763          	beq	a5,a4,ffffffffc02057f8 <do_exit+0x10e>
ffffffffc020570e:	00090497          	auipc	s1,0x90
ffffffffc0205712:	1ba48493          	addi	s1,s1,442 # ffffffffc02958c8 <initproc>
ffffffffc0205716:	6098                	ld	a4,0(s1)
ffffffffc0205718:	10e78763          	beq	a5,a4,ffffffffc0205826 <do_exit+0x13c>
ffffffffc020571c:	0287b983          	ld	s3,40(a5)
ffffffffc0205720:	892a                	mv	s2,a0
ffffffffc0205722:	02098e63          	beqz	s3,ffffffffc020575e <do_exit+0x74>
ffffffffc0205726:	00090797          	auipc	a5,0x90
ffffffffc020572a:	1627b783          	ld	a5,354(a5) # ffffffffc0295888 <boot_pgdir_pa>
ffffffffc020572e:	577d                	li	a4,-1
ffffffffc0205730:	177e                	slli	a4,a4,0x3f
ffffffffc0205732:	83b1                	srli	a5,a5,0xc
ffffffffc0205734:	8fd9                	or	a5,a5,a4
ffffffffc0205736:	18079073          	csrw	satp,a5
ffffffffc020573a:	0309a783          	lw	a5,48(s3)
ffffffffc020573e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205742:	02e9a823          	sw	a4,48(s3)
ffffffffc0205746:	c769                	beqz	a4,ffffffffc0205810 <do_exit+0x126>
ffffffffc0205748:	601c                	ld	a5,0(s0)
ffffffffc020574a:	1487b503          	ld	a0,328(a5)
ffffffffc020574e:	0207b423          	sd	zero,40(a5)
ffffffffc0205752:	c511                	beqz	a0,ffffffffc020575e <do_exit+0x74>
ffffffffc0205754:	491c                	lw	a5,16(a0)
ffffffffc0205756:	fff7871b          	addiw	a4,a5,-1
ffffffffc020575a:	c918                	sw	a4,16(a0)
ffffffffc020575c:	cb59                	beqz	a4,ffffffffc02057f2 <do_exit+0x108>
ffffffffc020575e:	601c                	ld	a5,0(s0)
ffffffffc0205760:	470d                	li	a4,3
ffffffffc0205762:	c398                	sw	a4,0(a5)
ffffffffc0205764:	0f27a423          	sw	s2,232(a5)
ffffffffc0205768:	100027f3          	csrr	a5,sstatus
ffffffffc020576c:	8b89                	andi	a5,a5,2
ffffffffc020576e:	4a01                	li	s4,0
ffffffffc0205770:	e7f9                	bnez	a5,ffffffffc020583e <do_exit+0x154>
ffffffffc0205772:	6018                	ld	a4,0(s0)
ffffffffc0205774:	800007b7          	lui	a5,0x80000
ffffffffc0205778:	0785                	addi	a5,a5,1
ffffffffc020577a:	7308                	ld	a0,32(a4)
ffffffffc020577c:	0ec52703          	lw	a4,236(a0)
ffffffffc0205780:	0cf70363          	beq	a4,a5,ffffffffc0205846 <do_exit+0x15c>
ffffffffc0205784:	6018                	ld	a4,0(s0)
ffffffffc0205786:	7b7c                	ld	a5,240(a4)
ffffffffc0205788:	c3a1                	beqz	a5,ffffffffc02057c8 <do_exit+0xde>
ffffffffc020578a:	800009b7          	lui	s3,0x80000
ffffffffc020578e:	490d                	li	s2,3
ffffffffc0205790:	0985                	addi	s3,s3,1
ffffffffc0205792:	a021                	j	ffffffffc020579a <do_exit+0xb0>
ffffffffc0205794:	6018                	ld	a4,0(s0)
ffffffffc0205796:	7b7c                	ld	a5,240(a4)
ffffffffc0205798:	cb85                	beqz	a5,ffffffffc02057c8 <do_exit+0xde>
ffffffffc020579a:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc020579e:	6088                	ld	a0,0(s1)
ffffffffc02057a0:	fb74                	sd	a3,240(a4)
ffffffffc02057a2:	7978                	ld	a4,240(a0)
ffffffffc02057a4:	0e07bc23          	sd	zero,248(a5)
ffffffffc02057a8:	10e7b023          	sd	a4,256(a5)
ffffffffc02057ac:	c311                	beqz	a4,ffffffffc02057b0 <do_exit+0xc6>
ffffffffc02057ae:	ff7c                	sd	a5,248(a4)
ffffffffc02057b0:	4398                	lw	a4,0(a5)
ffffffffc02057b2:	f388                	sd	a0,32(a5)
ffffffffc02057b4:	f97c                	sd	a5,240(a0)
ffffffffc02057b6:	fd271fe3          	bne	a4,s2,ffffffffc0205794 <do_exit+0xaa>
ffffffffc02057ba:	0ec52783          	lw	a5,236(a0)
ffffffffc02057be:	fd379be3          	bne	a5,s3,ffffffffc0205794 <do_exit+0xaa>
ffffffffc02057c2:	3c5000ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc02057c6:	b7f9                	j	ffffffffc0205794 <do_exit+0xaa>
ffffffffc02057c8:	020a1263          	bnez	s4,ffffffffc02057ec <do_exit+0x102>
ffffffffc02057cc:	46d000ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc02057d0:	601c                	ld	a5,0(s0)
ffffffffc02057d2:	00007617          	auipc	a2,0x7
ffffffffc02057d6:	b8660613          	addi	a2,a2,-1146 # ffffffffc020c358 <CSWTCH.79+0x160>
ffffffffc02057da:	26c00593          	li	a1,620
ffffffffc02057de:	43d4                	lw	a3,4(a5)
ffffffffc02057e0:	00007517          	auipc	a0,0x7
ffffffffc02057e4:	b4050513          	addi	a0,a0,-1216 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc02057e8:	cb7fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02057ec:	c80fb0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02057f0:	bff1                	j	ffffffffc02057cc <do_exit+0xe2>
ffffffffc02057f2:	d68ff0ef          	jal	ra,ffffffffc0204d5a <files_destroy>
ffffffffc02057f6:	b7a5                	j	ffffffffc020575e <do_exit+0x74>
ffffffffc02057f8:	00007617          	auipc	a2,0x7
ffffffffc02057fc:	b4060613          	addi	a2,a2,-1216 # ffffffffc020c338 <CSWTCH.79+0x140>
ffffffffc0205800:	23700593          	li	a1,567
ffffffffc0205804:	00007517          	auipc	a0,0x7
ffffffffc0205808:	b1c50513          	addi	a0,a0,-1252 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc020580c:	c93fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205810:	854e                	mv	a0,s3
ffffffffc0205812:	a36fe0ef          	jal	ra,ffffffffc0203a48 <exit_mmap>
ffffffffc0205816:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020581a:	d11ff0ef          	jal	ra,ffffffffc020552a <put_pgdir.isra.0>
ffffffffc020581e:	854e                	mv	a0,s3
ffffffffc0205820:	9d6fe0ef          	jal	ra,ffffffffc02039f6 <mm_destroy>
ffffffffc0205824:	b715                	j	ffffffffc0205748 <do_exit+0x5e>
ffffffffc0205826:	00007617          	auipc	a2,0x7
ffffffffc020582a:	b2260613          	addi	a2,a2,-1246 # ffffffffc020c348 <CSWTCH.79+0x150>
ffffffffc020582e:	23b00593          	li	a1,571
ffffffffc0205832:	00007517          	auipc	a0,0x7
ffffffffc0205836:	aee50513          	addi	a0,a0,-1298 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc020583a:	c65fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020583e:	c34fb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205842:	4a05                	li	s4,1
ffffffffc0205844:	b73d                	j	ffffffffc0205772 <do_exit+0x88>
ffffffffc0205846:	341000ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc020584a:	bf2d                	j	ffffffffc0205784 <do_exit+0x9a>

ffffffffc020584c <do_wait.part.0>:
ffffffffc020584c:	715d                	addi	sp,sp,-80
ffffffffc020584e:	f84a                	sd	s2,48(sp)
ffffffffc0205850:	f44e                	sd	s3,40(sp)
ffffffffc0205852:	80000937          	lui	s2,0x80000
ffffffffc0205856:	6989                	lui	s3,0x2
ffffffffc0205858:	fc26                	sd	s1,56(sp)
ffffffffc020585a:	f052                	sd	s4,32(sp)
ffffffffc020585c:	ec56                	sd	s5,24(sp)
ffffffffc020585e:	e85a                	sd	s6,16(sp)
ffffffffc0205860:	e45e                	sd	s7,8(sp)
ffffffffc0205862:	e486                	sd	ra,72(sp)
ffffffffc0205864:	e0a2                	sd	s0,64(sp)
ffffffffc0205866:	84aa                	mv	s1,a0
ffffffffc0205868:	8a2e                	mv	s4,a1
ffffffffc020586a:	00090b97          	auipc	s7,0x90
ffffffffc020586e:	04eb8b93          	addi	s7,s7,78 # ffffffffc02958b8 <current>
ffffffffc0205872:	00050b1b          	sext.w	s6,a0
ffffffffc0205876:	fff50a9b          	addiw	s5,a0,-1
ffffffffc020587a:	19f9                	addi	s3,s3,-2
ffffffffc020587c:	0905                	addi	s2,s2,1
ffffffffc020587e:	ccbd                	beqz	s1,ffffffffc02058fc <do_wait.part.0+0xb0>
ffffffffc0205880:	0359e863          	bltu	s3,s5,ffffffffc02058b0 <do_wait.part.0+0x64>
ffffffffc0205884:	45a9                	li	a1,10
ffffffffc0205886:	855a                	mv	a0,s6
ffffffffc0205888:	5ac040ef          	jal	ra,ffffffffc0209e34 <hash32>
ffffffffc020588c:	02051793          	slli	a5,a0,0x20
ffffffffc0205890:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205894:	0008b797          	auipc	a5,0x8b
ffffffffc0205898:	f2478793          	addi	a5,a5,-220 # ffffffffc02907b8 <hash_list>
ffffffffc020589c:	953e                	add	a0,a0,a5
ffffffffc020589e:	842a                	mv	s0,a0
ffffffffc02058a0:	a029                	j	ffffffffc02058aa <do_wait.part.0+0x5e>
ffffffffc02058a2:	f2c42783          	lw	a5,-212(s0)
ffffffffc02058a6:	02978163          	beq	a5,s1,ffffffffc02058c8 <do_wait.part.0+0x7c>
ffffffffc02058aa:	6400                	ld	s0,8(s0)
ffffffffc02058ac:	fe851be3          	bne	a0,s0,ffffffffc02058a2 <do_wait.part.0+0x56>
ffffffffc02058b0:	5579                	li	a0,-2
ffffffffc02058b2:	60a6                	ld	ra,72(sp)
ffffffffc02058b4:	6406                	ld	s0,64(sp)
ffffffffc02058b6:	74e2                	ld	s1,56(sp)
ffffffffc02058b8:	7942                	ld	s2,48(sp)
ffffffffc02058ba:	79a2                	ld	s3,40(sp)
ffffffffc02058bc:	7a02                	ld	s4,32(sp)
ffffffffc02058be:	6ae2                	ld	s5,24(sp)
ffffffffc02058c0:	6b42                	ld	s6,16(sp)
ffffffffc02058c2:	6ba2                	ld	s7,8(sp)
ffffffffc02058c4:	6161                	addi	sp,sp,80
ffffffffc02058c6:	8082                	ret
ffffffffc02058c8:	000bb683          	ld	a3,0(s7)
ffffffffc02058cc:	f4843783          	ld	a5,-184(s0)
ffffffffc02058d0:	fed790e3          	bne	a5,a3,ffffffffc02058b0 <do_wait.part.0+0x64>
ffffffffc02058d4:	f2842703          	lw	a4,-216(s0)
ffffffffc02058d8:	478d                	li	a5,3
ffffffffc02058da:	0ef70b63          	beq	a4,a5,ffffffffc02059d0 <do_wait.part.0+0x184>
ffffffffc02058de:	4785                	li	a5,1
ffffffffc02058e0:	c29c                	sw	a5,0(a3)
ffffffffc02058e2:	0f26a623          	sw	s2,236(a3)
ffffffffc02058e6:	353000ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc02058ea:	000bb783          	ld	a5,0(s7)
ffffffffc02058ee:	0b07a783          	lw	a5,176(a5)
ffffffffc02058f2:	8b85                	andi	a5,a5,1
ffffffffc02058f4:	d7c9                	beqz	a5,ffffffffc020587e <do_wait.part.0+0x32>
ffffffffc02058f6:	555d                	li	a0,-9
ffffffffc02058f8:	df3ff0ef          	jal	ra,ffffffffc02056ea <do_exit>
ffffffffc02058fc:	000bb683          	ld	a3,0(s7)
ffffffffc0205900:	7ae0                	ld	s0,240(a3)
ffffffffc0205902:	d45d                	beqz	s0,ffffffffc02058b0 <do_wait.part.0+0x64>
ffffffffc0205904:	470d                	li	a4,3
ffffffffc0205906:	a021                	j	ffffffffc020590e <do_wait.part.0+0xc2>
ffffffffc0205908:	10043403          	ld	s0,256(s0)
ffffffffc020590c:	d869                	beqz	s0,ffffffffc02058de <do_wait.part.0+0x92>
ffffffffc020590e:	401c                	lw	a5,0(s0)
ffffffffc0205910:	fee79ce3          	bne	a5,a4,ffffffffc0205908 <do_wait.part.0+0xbc>
ffffffffc0205914:	00090797          	auipc	a5,0x90
ffffffffc0205918:	fac7b783          	ld	a5,-84(a5) # ffffffffc02958c0 <idleproc>
ffffffffc020591c:	0c878963          	beq	a5,s0,ffffffffc02059ee <do_wait.part.0+0x1a2>
ffffffffc0205920:	00090797          	auipc	a5,0x90
ffffffffc0205924:	fa87b783          	ld	a5,-88(a5) # ffffffffc02958c8 <initproc>
ffffffffc0205928:	0cf40363          	beq	s0,a5,ffffffffc02059ee <do_wait.part.0+0x1a2>
ffffffffc020592c:	000a0663          	beqz	s4,ffffffffc0205938 <do_wait.part.0+0xec>
ffffffffc0205930:	0e842783          	lw	a5,232(s0)
ffffffffc0205934:	00fa2023          	sw	a5,0(s4)
ffffffffc0205938:	100027f3          	csrr	a5,sstatus
ffffffffc020593c:	8b89                	andi	a5,a5,2
ffffffffc020593e:	4581                	li	a1,0
ffffffffc0205940:	e7c1                	bnez	a5,ffffffffc02059c8 <do_wait.part.0+0x17c>
ffffffffc0205942:	6c70                	ld	a2,216(s0)
ffffffffc0205944:	7074                	ld	a3,224(s0)
ffffffffc0205946:	10043703          	ld	a4,256(s0)
ffffffffc020594a:	7c7c                	ld	a5,248(s0)
ffffffffc020594c:	e614                	sd	a3,8(a2)
ffffffffc020594e:	e290                	sd	a2,0(a3)
ffffffffc0205950:	6470                	ld	a2,200(s0)
ffffffffc0205952:	6874                	ld	a3,208(s0)
ffffffffc0205954:	e614                	sd	a3,8(a2)
ffffffffc0205956:	e290                	sd	a2,0(a3)
ffffffffc0205958:	c319                	beqz	a4,ffffffffc020595e <do_wait.part.0+0x112>
ffffffffc020595a:	ff7c                	sd	a5,248(a4)
ffffffffc020595c:	7c7c                	ld	a5,248(s0)
ffffffffc020595e:	c3b5                	beqz	a5,ffffffffc02059c2 <do_wait.part.0+0x176>
ffffffffc0205960:	10e7b023          	sd	a4,256(a5)
ffffffffc0205964:	00090717          	auipc	a4,0x90
ffffffffc0205968:	f6c70713          	addi	a4,a4,-148 # ffffffffc02958d0 <nr_process>
ffffffffc020596c:	431c                	lw	a5,0(a4)
ffffffffc020596e:	37fd                	addiw	a5,a5,-1
ffffffffc0205970:	c31c                	sw	a5,0(a4)
ffffffffc0205972:	e5a9                	bnez	a1,ffffffffc02059bc <do_wait.part.0+0x170>
ffffffffc0205974:	6814                	ld	a3,16(s0)
ffffffffc0205976:	c02007b7          	lui	a5,0xc0200
ffffffffc020597a:	04f6ee63          	bltu	a3,a5,ffffffffc02059d6 <do_wait.part.0+0x18a>
ffffffffc020597e:	00090797          	auipc	a5,0x90
ffffffffc0205982:	f327b783          	ld	a5,-206(a5) # ffffffffc02958b0 <va_pa_offset>
ffffffffc0205986:	8e9d                	sub	a3,a3,a5
ffffffffc0205988:	82b1                	srli	a3,a3,0xc
ffffffffc020598a:	00090797          	auipc	a5,0x90
ffffffffc020598e:	f0e7b783          	ld	a5,-242(a5) # ffffffffc0295898 <npage>
ffffffffc0205992:	06f6fa63          	bgeu	a3,a5,ffffffffc0205a06 <do_wait.part.0+0x1ba>
ffffffffc0205996:	00009517          	auipc	a0,0x9
ffffffffc020599a:	b3a53503          	ld	a0,-1222(a0) # ffffffffc020e4d0 <nbase>
ffffffffc020599e:	8e89                	sub	a3,a3,a0
ffffffffc02059a0:	069a                	slli	a3,a3,0x6
ffffffffc02059a2:	00090517          	auipc	a0,0x90
ffffffffc02059a6:	efe53503          	ld	a0,-258(a0) # ffffffffc02958a0 <pages>
ffffffffc02059aa:	9536                	add	a0,a0,a3
ffffffffc02059ac:	4589                	li	a1,2
ffffffffc02059ae:	ffcfc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02059b2:	8522                	mv	a0,s0
ffffffffc02059b4:	e8afc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02059b8:	4501                	li	a0,0
ffffffffc02059ba:	bde5                	j	ffffffffc02058b2 <do_wait.part.0+0x66>
ffffffffc02059bc:	ab0fb0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02059c0:	bf55                	j	ffffffffc0205974 <do_wait.part.0+0x128>
ffffffffc02059c2:	701c                	ld	a5,32(s0)
ffffffffc02059c4:	fbf8                	sd	a4,240(a5)
ffffffffc02059c6:	bf79                	j	ffffffffc0205964 <do_wait.part.0+0x118>
ffffffffc02059c8:	aaafb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02059cc:	4585                	li	a1,1
ffffffffc02059ce:	bf95                	j	ffffffffc0205942 <do_wait.part.0+0xf6>
ffffffffc02059d0:	f2840413          	addi	s0,s0,-216
ffffffffc02059d4:	b781                	j	ffffffffc0205914 <do_wait.part.0+0xc8>
ffffffffc02059d6:	00006617          	auipc	a2,0x6
ffffffffc02059da:	a4260613          	addi	a2,a2,-1470 # ffffffffc020b418 <default_pmm_manager+0xe0>
ffffffffc02059de:	07700593          	li	a1,119
ffffffffc02059e2:	00006517          	auipc	a0,0x6
ffffffffc02059e6:	9b650513          	addi	a0,a0,-1610 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc02059ea:	ab5fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02059ee:	00007617          	auipc	a2,0x7
ffffffffc02059f2:	98a60613          	addi	a2,a2,-1654 # ffffffffc020c378 <CSWTCH.79+0x180>
ffffffffc02059f6:	35400593          	li	a1,852
ffffffffc02059fa:	00007517          	auipc	a0,0x7
ffffffffc02059fe:	92650513          	addi	a0,a0,-1754 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205a02:	a9dfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205a06:	00006617          	auipc	a2,0x6
ffffffffc0205a0a:	a3a60613          	addi	a2,a2,-1478 # ffffffffc020b440 <default_pmm_manager+0x108>
ffffffffc0205a0e:	06900593          	li	a1,105
ffffffffc0205a12:	00006517          	auipc	a0,0x6
ffffffffc0205a16:	98650513          	addi	a0,a0,-1658 # ffffffffc020b398 <default_pmm_manager+0x60>
ffffffffc0205a1a:	a85fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205a1e <init_main>:
ffffffffc0205a1e:	1141                	addi	sp,sp,-16
ffffffffc0205a20:	00007517          	auipc	a0,0x7
ffffffffc0205a24:	97850513          	addi	a0,a0,-1672 # ffffffffc020c398 <CSWTCH.79+0x1a0>
ffffffffc0205a28:	e406                	sd	ra,8(sp)
ffffffffc0205a2a:	17e010ef          	jal	ra,ffffffffc0206ba8 <vfs_set_bootfs>
ffffffffc0205a2e:	e179                	bnez	a0,ffffffffc0205af4 <init_main+0xd6>
ffffffffc0205a30:	fbafc0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0205a34:	d56fc0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc0205a38:	4601                	li	a2,0
ffffffffc0205a3a:	4581                	li	a1,0
ffffffffc0205a3c:	00000517          	auipc	a0,0x0
ffffffffc0205a40:	38850513          	addi	a0,a0,904 # ffffffffc0205dc4 <user_main>
ffffffffc0205a44:	c57ff0ef          	jal	ra,ffffffffc020569a <kernel_thread>
ffffffffc0205a48:	00a04563          	bgtz	a0,ffffffffc0205a52 <init_main+0x34>
ffffffffc0205a4c:	a841                	j	ffffffffc0205adc <init_main+0xbe>
ffffffffc0205a4e:	1eb000ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc0205a52:	4581                	li	a1,0
ffffffffc0205a54:	4501                	li	a0,0
ffffffffc0205a56:	df7ff0ef          	jal	ra,ffffffffc020584c <do_wait.part.0>
ffffffffc0205a5a:	d975                	beqz	a0,ffffffffc0205a4e <init_main+0x30>
ffffffffc0205a5c:	ab8ff0ef          	jal	ra,ffffffffc0204d14 <fs_cleanup>
ffffffffc0205a60:	00007517          	auipc	a0,0x7
ffffffffc0205a64:	98050513          	addi	a0,a0,-1664 # ffffffffc020c3e0 <CSWTCH.79+0x1e8>
ffffffffc0205a68:	f3efa0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0205a6c:	00090797          	auipc	a5,0x90
ffffffffc0205a70:	e5c7b783          	ld	a5,-420(a5) # ffffffffc02958c8 <initproc>
ffffffffc0205a74:	7bf8                	ld	a4,240(a5)
ffffffffc0205a76:	e339                	bnez	a4,ffffffffc0205abc <init_main+0x9e>
ffffffffc0205a78:	7ff8                	ld	a4,248(a5)
ffffffffc0205a7a:	e329                	bnez	a4,ffffffffc0205abc <init_main+0x9e>
ffffffffc0205a7c:	1007b703          	ld	a4,256(a5)
ffffffffc0205a80:	ef15                	bnez	a4,ffffffffc0205abc <init_main+0x9e>
ffffffffc0205a82:	00090697          	auipc	a3,0x90
ffffffffc0205a86:	e4e6a683          	lw	a3,-434(a3) # ffffffffc02958d0 <nr_process>
ffffffffc0205a8a:	4709                	li	a4,2
ffffffffc0205a8c:	0ce69163          	bne	a3,a4,ffffffffc0205b4e <init_main+0x130>
ffffffffc0205a90:	0008f717          	auipc	a4,0x8f
ffffffffc0205a94:	d2870713          	addi	a4,a4,-728 # ffffffffc02947b8 <proc_list>
ffffffffc0205a98:	6714                	ld	a3,8(a4)
ffffffffc0205a9a:	0c878793          	addi	a5,a5,200
ffffffffc0205a9e:	08d79863          	bne	a5,a3,ffffffffc0205b2e <init_main+0x110>
ffffffffc0205aa2:	6318                	ld	a4,0(a4)
ffffffffc0205aa4:	06e79563          	bne	a5,a4,ffffffffc0205b0e <init_main+0xf0>
ffffffffc0205aa8:	00007517          	auipc	a0,0x7
ffffffffc0205aac:	a2050513          	addi	a0,a0,-1504 # ffffffffc020c4c8 <CSWTCH.79+0x2d0>
ffffffffc0205ab0:	ef6fa0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0205ab4:	60a2                	ld	ra,8(sp)
ffffffffc0205ab6:	4501                	li	a0,0
ffffffffc0205ab8:	0141                	addi	sp,sp,16
ffffffffc0205aba:	8082                	ret
ffffffffc0205abc:	00007697          	auipc	a3,0x7
ffffffffc0205ac0:	94c68693          	addi	a3,a3,-1716 # ffffffffc020c408 <CSWTCH.79+0x210>
ffffffffc0205ac4:	00005617          	auipc	a2,0x5
ffffffffc0205ac8:	d8c60613          	addi	a2,a2,-628 # ffffffffc020a850 <commands+0x210>
ffffffffc0205acc:	3ca00593          	li	a1,970
ffffffffc0205ad0:	00007517          	auipc	a0,0x7
ffffffffc0205ad4:	85050513          	addi	a0,a0,-1968 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205ad8:	9c7fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205adc:	00007617          	auipc	a2,0x7
ffffffffc0205ae0:	8e460613          	addi	a2,a2,-1820 # ffffffffc020c3c0 <CSWTCH.79+0x1c8>
ffffffffc0205ae4:	3bd00593          	li	a1,957
ffffffffc0205ae8:	00007517          	auipc	a0,0x7
ffffffffc0205aec:	83850513          	addi	a0,a0,-1992 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205af0:	9affa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205af4:	86aa                	mv	a3,a0
ffffffffc0205af6:	00007617          	auipc	a2,0x7
ffffffffc0205afa:	8aa60613          	addi	a2,a2,-1878 # ffffffffc020c3a0 <CSWTCH.79+0x1a8>
ffffffffc0205afe:	3b500593          	li	a1,949
ffffffffc0205b02:	00007517          	auipc	a0,0x7
ffffffffc0205b06:	81e50513          	addi	a0,a0,-2018 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205b0a:	995fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b0e:	00007697          	auipc	a3,0x7
ffffffffc0205b12:	98a68693          	addi	a3,a3,-1654 # ffffffffc020c498 <CSWTCH.79+0x2a0>
ffffffffc0205b16:	00005617          	auipc	a2,0x5
ffffffffc0205b1a:	d3a60613          	addi	a2,a2,-710 # ffffffffc020a850 <commands+0x210>
ffffffffc0205b1e:	3cd00593          	li	a1,973
ffffffffc0205b22:	00006517          	auipc	a0,0x6
ffffffffc0205b26:	7fe50513          	addi	a0,a0,2046 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205b2a:	975fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b2e:	00007697          	auipc	a3,0x7
ffffffffc0205b32:	93a68693          	addi	a3,a3,-1734 # ffffffffc020c468 <CSWTCH.79+0x270>
ffffffffc0205b36:	00005617          	auipc	a2,0x5
ffffffffc0205b3a:	d1a60613          	addi	a2,a2,-742 # ffffffffc020a850 <commands+0x210>
ffffffffc0205b3e:	3cc00593          	li	a1,972
ffffffffc0205b42:	00006517          	auipc	a0,0x6
ffffffffc0205b46:	7de50513          	addi	a0,a0,2014 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205b4a:	955fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b4e:	00007697          	auipc	a3,0x7
ffffffffc0205b52:	90a68693          	addi	a3,a3,-1782 # ffffffffc020c458 <CSWTCH.79+0x260>
ffffffffc0205b56:	00005617          	auipc	a2,0x5
ffffffffc0205b5a:	cfa60613          	addi	a2,a2,-774 # ffffffffc020a850 <commands+0x210>
ffffffffc0205b5e:	3cb00593          	li	a1,971
ffffffffc0205b62:	00006517          	auipc	a0,0x6
ffffffffc0205b66:	7be50513          	addi	a0,a0,1982 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205b6a:	935fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205b6e <do_execve>:
ffffffffc0205b6e:	7149                	addi	sp,sp,-368
ffffffffc0205b70:	fa5a                	sd	s6,304(sp)
ffffffffc0205b72:	00090b17          	auipc	s6,0x90
ffffffffc0205b76:	d46b0b13          	addi	s6,s6,-698 # ffffffffc02958b8 <current>
ffffffffc0205b7a:	000b3683          	ld	a3,0(s6)
ffffffffc0205b7e:	f65e                	sd	s7,296(sp)
ffffffffc0205b80:	fff58b9b          	addiw	s7,a1,-1
ffffffffc0205b84:	fe56                	sd	s5,312(sp)
ffffffffc0205b86:	f686                	sd	ra,360(sp)
ffffffffc0205b88:	f2a2                	sd	s0,352(sp)
ffffffffc0205b8a:	eea6                	sd	s1,344(sp)
ffffffffc0205b8c:	eaca                	sd	s2,336(sp)
ffffffffc0205b8e:	e6ce                	sd	s3,328(sp)
ffffffffc0205b90:	e2d2                	sd	s4,320(sp)
ffffffffc0205b92:	f262                	sd	s8,288(sp)
ffffffffc0205b94:	ee66                	sd	s9,280(sp)
ffffffffc0205b96:	000b871b          	sext.w	a4,s7
ffffffffc0205b9a:	47fd                	li	a5,31
ffffffffc0205b9c:	0286ba83          	ld	s5,40(a3)
ffffffffc0205ba0:	20e7e263          	bltu	a5,a4,ffffffffc0205da4 <do_execve+0x236>
ffffffffc0205ba4:	89ae                	mv	s3,a1
ffffffffc0205ba6:	842a                	mv	s0,a0
ffffffffc0205ba8:	8cb2                	mv	s9,a2
ffffffffc0205baa:	4581                	li	a1,0
ffffffffc0205bac:	4641                	li	a2,16
ffffffffc0205bae:	850a                	mv	a0,sp
ffffffffc0205bb0:	7b8040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0205bb4:	000a8c63          	beqz	s5,ffffffffc0205bcc <do_execve+0x5e>
ffffffffc0205bb8:	038a8513          	addi	a0,s5,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc0205bbc:	cfefe0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0205bc0:	000b3783          	ld	a5,0(s6)
ffffffffc0205bc4:	c781                	beqz	a5,ffffffffc0205bcc <do_execve+0x5e>
ffffffffc0205bc6:	43dc                	lw	a5,4(a5)
ffffffffc0205bc8:	04faa823          	sw	a5,80(s5)
ffffffffc0205bcc:	1a040563          	beqz	s0,ffffffffc0205d76 <do_execve+0x208>
ffffffffc0205bd0:	46c1                	li	a3,16
ffffffffc0205bd2:	8622                	mv	a2,s0
ffffffffc0205bd4:	858a                	mv	a1,sp
ffffffffc0205bd6:	8556                	mv	a0,s5
ffffffffc0205bd8:	b0afe0ef          	jal	ra,ffffffffc0203ee2 <copy_string>
ffffffffc0205bdc:	1c050a63          	beqz	a0,ffffffffc0205db0 <do_execve+0x242>
ffffffffc0205be0:	00399c13          	slli	s8,s3,0x3
ffffffffc0205be4:	4681                	li	a3,0
ffffffffc0205be6:	8662                	mv	a2,s8
ffffffffc0205be8:	85e6                	mv	a1,s9
ffffffffc0205bea:	8556                	mv	a0,s5
ffffffffc0205bec:	9fcfe0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0205bf0:	84e6                	mv	s1,s9
ffffffffc0205bf2:	1a050b63          	beqz	a0,ffffffffc0205da8 <do_execve+0x23a>
ffffffffc0205bf6:	01010913          	addi	s2,sp,16
ffffffffc0205bfa:	4a01                	li	s4,0
ffffffffc0205bfc:	6505                	lui	a0,0x1
ffffffffc0205bfe:	b90fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205c02:	842a                	mv	s0,a0
ffffffffc0205c04:	12050163          	beqz	a0,ffffffffc0205d26 <do_execve+0x1b8>
ffffffffc0205c08:	6090                	ld	a2,0(s1)
ffffffffc0205c0a:	85aa                	mv	a1,a0
ffffffffc0205c0c:	6685                	lui	a3,0x1
ffffffffc0205c0e:	8556                	mv	a0,s5
ffffffffc0205c10:	ad2fe0ef          	jal	ra,ffffffffc0203ee2 <copy_string>
ffffffffc0205c14:	14050c63          	beqz	a0,ffffffffc0205d6c <do_execve+0x1fe>
ffffffffc0205c18:	00893023          	sd	s0,0(s2) # ffffffff80000000 <_binary_bin_sfs_img_size+0xffffffff7ff8ad00>
ffffffffc0205c1c:	2a05                	addiw	s4,s4,1
ffffffffc0205c1e:	0921                	addi	s2,s2,8
ffffffffc0205c20:	04a1                	addi	s1,s1,8
ffffffffc0205c22:	fd499de3          	bne	s3,s4,ffffffffc0205bfc <do_execve+0x8e>
ffffffffc0205c26:	000cb403          	ld	s0,0(s9)
ffffffffc0205c2a:	0a0a8b63          	beqz	s5,ffffffffc0205ce0 <do_execve+0x172>
ffffffffc0205c2e:	038a8513          	addi	a0,s5,56
ffffffffc0205c32:	c84fe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205c36:	000b3783          	ld	a5,0(s6)
ffffffffc0205c3a:	040aa823          	sw	zero,80(s5)
ffffffffc0205c3e:	1487b503          	ld	a0,328(a5)
ffffffffc0205c42:	9aeff0ef          	jal	ra,ffffffffc0204df0 <files_closeall>
ffffffffc0205c46:	4581                	li	a1,0
ffffffffc0205c48:	8522                	mv	a0,s0
ffffffffc0205c4a:	c32ff0ef          	jal	ra,ffffffffc020507c <sysfile_open>
ffffffffc0205c4e:	84aa                	mv	s1,a0
ffffffffc0205c50:	0a054563          	bltz	a0,ffffffffc0205cfa <do_execve+0x18c>
ffffffffc0205c54:	00090797          	auipc	a5,0x90
ffffffffc0205c58:	c347b783          	ld	a5,-972(a5) # ffffffffc0295888 <boot_pgdir_pa>
ffffffffc0205c5c:	577d                	li	a4,-1
ffffffffc0205c5e:	177e                	slli	a4,a4,0x3f
ffffffffc0205c60:	83b1                	srli	a5,a5,0xc
ffffffffc0205c62:	8fd9                	or	a5,a5,a4
ffffffffc0205c64:	18079073          	csrw	satp,a5
ffffffffc0205c68:	030aa783          	lw	a5,48(s5)
ffffffffc0205c6c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0205c70:	02eaa823          	sw	a4,48(s5)
ffffffffc0205c74:	10070d63          	beqz	a4,ffffffffc0205d8e <do_execve+0x220>
ffffffffc0205c78:	000b3783          	ld	a5,0(s6)
ffffffffc0205c7c:	0207b423          	sd	zero,40(a5)
ffffffffc0205c80:	ecad                	bnez	s1,ffffffffc0205cfa <do_execve+0x18c>
ffffffffc0205c82:	878a                	mv	a5,sp
ffffffffc0205c84:	9c3e                	add	s8,s8,a5
ffffffffc0205c86:	fff98413          	addi	s0,s3,-1 # 1fff <_binary_bin_swap_img_size-0x5d01>
ffffffffc0205c8a:	020b9793          	slli	a5,s7,0x20
ffffffffc0205c8e:	01d7db93          	srli	s7,a5,0x1d
ffffffffc0205c92:	040e                	slli	s0,s0,0x3
ffffffffc0205c94:	081c                	addi	a5,sp,16
ffffffffc0205c96:	943e                	add	s0,s0,a5
ffffffffc0205c98:	417c0bb3          	sub	s7,s8,s7
ffffffffc0205c9c:	6008                	ld	a0,0(s0)
ffffffffc0205c9e:	1461                	addi	s0,s0,-8
ffffffffc0205ca0:	b9efc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205ca4:	ff741ce3          	bne	s0,s7,ffffffffc0205c9c <do_execve+0x12e>
ffffffffc0205ca8:	000b3403          	ld	s0,0(s6)
ffffffffc0205cac:	4641                	li	a2,16
ffffffffc0205cae:	4581                	li	a1,0
ffffffffc0205cb0:	0b440413          	addi	s0,s0,180
ffffffffc0205cb4:	8522                	mv	a0,s0
ffffffffc0205cb6:	6b2040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0205cba:	463d                	li	a2,15
ffffffffc0205cbc:	858a                	mv	a1,sp
ffffffffc0205cbe:	8522                	mv	a0,s0
ffffffffc0205cc0:	6fa040ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0205cc4:	70b6                	ld	ra,360(sp)
ffffffffc0205cc6:	7416                	ld	s0,352(sp)
ffffffffc0205cc8:	6956                	ld	s2,336(sp)
ffffffffc0205cca:	69b6                	ld	s3,328(sp)
ffffffffc0205ccc:	6a16                	ld	s4,320(sp)
ffffffffc0205cce:	7af2                	ld	s5,312(sp)
ffffffffc0205cd0:	7b52                	ld	s6,304(sp)
ffffffffc0205cd2:	7bb2                	ld	s7,296(sp)
ffffffffc0205cd4:	7c12                	ld	s8,288(sp)
ffffffffc0205cd6:	6cf2                	ld	s9,280(sp)
ffffffffc0205cd8:	8526                	mv	a0,s1
ffffffffc0205cda:	64f6                	ld	s1,344(sp)
ffffffffc0205cdc:	6175                	addi	sp,sp,368
ffffffffc0205cde:	8082                	ret
ffffffffc0205ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0205ce4:	1487b503          	ld	a0,328(a5)
ffffffffc0205ce8:	908ff0ef          	jal	ra,ffffffffc0204df0 <files_closeall>
ffffffffc0205cec:	4581                	li	a1,0
ffffffffc0205cee:	8522                	mv	a0,s0
ffffffffc0205cf0:	b8cff0ef          	jal	ra,ffffffffc020507c <sysfile_open>
ffffffffc0205cf4:	84aa                	mv	s1,a0
ffffffffc0205cf6:	f80555e3          	bgez	a0,ffffffffc0205c80 <do_execve+0x112>
ffffffffc0205cfa:	020b9793          	slli	a5,s7,0x20
ffffffffc0205cfe:	fff98413          	addi	s0,s3,-1
ffffffffc0205d02:	890a                	mv	s2,sp
ffffffffc0205d04:	01d7db93          	srli	s7,a5,0x1d
ffffffffc0205d08:	040e                	slli	s0,s0,0x3
ffffffffc0205d0a:	9962                	add	s2,s2,s8
ffffffffc0205d0c:	081c                	addi	a5,sp,16
ffffffffc0205d0e:	943e                	add	s0,s0,a5
ffffffffc0205d10:	41790933          	sub	s2,s2,s7
ffffffffc0205d14:	6008                	ld	a0,0(s0)
ffffffffc0205d16:	1461                	addi	s0,s0,-8
ffffffffc0205d18:	b26fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205d1c:	fe891ce3          	bne	s2,s0,ffffffffc0205d14 <do_execve+0x1a6>
ffffffffc0205d20:	8526                	mv	a0,s1
ffffffffc0205d22:	9c9ff0ef          	jal	ra,ffffffffc02056ea <do_exit>
ffffffffc0205d26:	54f1                	li	s1,-4
ffffffffc0205d28:	020a0963          	beqz	s4,ffffffffc0205d5a <do_execve+0x1ec>
ffffffffc0205d2c:	003a1713          	slli	a4,s4,0x3
ffffffffc0205d30:	fffa079b          	addiw	a5,s4,-1
ffffffffc0205d34:	890a                	mv	s2,sp
ffffffffc0205d36:	993a                	add	s2,s2,a4
ffffffffc0205d38:	fffa0413          	addi	s0,s4,-1
ffffffffc0205d3c:	02079713          	slli	a4,a5,0x20
ffffffffc0205d40:	01d75793          	srli	a5,a4,0x1d
ffffffffc0205d44:	040e                	slli	s0,s0,0x3
ffffffffc0205d46:	0818                	addi	a4,sp,16
ffffffffc0205d48:	943a                	add	s0,s0,a4
ffffffffc0205d4a:	40f90933          	sub	s2,s2,a5
ffffffffc0205d4e:	6008                	ld	a0,0(s0)
ffffffffc0205d50:	1461                	addi	s0,s0,-8
ffffffffc0205d52:	aecfc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205d56:	fe891ce3          	bne	s2,s0,ffffffffc0205d4e <do_execve+0x1e0>
ffffffffc0205d5a:	f60a85e3          	beqz	s5,ffffffffc0205cc4 <do_execve+0x156>
ffffffffc0205d5e:	038a8513          	addi	a0,s5,56
ffffffffc0205d62:	b54fe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205d66:	040aa823          	sw	zero,80(s5)
ffffffffc0205d6a:	bfa9                	j	ffffffffc0205cc4 <do_execve+0x156>
ffffffffc0205d6c:	8522                	mv	a0,s0
ffffffffc0205d6e:	ad0fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205d72:	54f5                	li	s1,-3
ffffffffc0205d74:	bf55                	j	ffffffffc0205d28 <do_execve+0x1ba>
ffffffffc0205d76:	000b3783          	ld	a5,0(s6)
ffffffffc0205d7a:	00006617          	auipc	a2,0x6
ffffffffc0205d7e:	76e60613          	addi	a2,a2,1902 # ffffffffc020c4e8 <CSWTCH.79+0x2f0>
ffffffffc0205d82:	45c1                	li	a1,16
ffffffffc0205d84:	43d4                	lw	a3,4(a5)
ffffffffc0205d86:	850a                	mv	a0,sp
ffffffffc0205d88:	4f0040ef          	jal	ra,ffffffffc020a278 <snprintf>
ffffffffc0205d8c:	bd91                	j	ffffffffc0205be0 <do_execve+0x72>
ffffffffc0205d8e:	8556                	mv	a0,s5
ffffffffc0205d90:	cb9fd0ef          	jal	ra,ffffffffc0203a48 <exit_mmap>
ffffffffc0205d94:	018ab503          	ld	a0,24(s5)
ffffffffc0205d98:	f92ff0ef          	jal	ra,ffffffffc020552a <put_pgdir.isra.0>
ffffffffc0205d9c:	8556                	mv	a0,s5
ffffffffc0205d9e:	c59fd0ef          	jal	ra,ffffffffc02039f6 <mm_destroy>
ffffffffc0205da2:	bdd9                	j	ffffffffc0205c78 <do_execve+0x10a>
ffffffffc0205da4:	54f5                	li	s1,-3
ffffffffc0205da6:	bf39                	j	ffffffffc0205cc4 <do_execve+0x156>
ffffffffc0205da8:	54f5                	li	s1,-3
ffffffffc0205daa:	fa0a9ae3          	bnez	s5,ffffffffc0205d5e <do_execve+0x1f0>
ffffffffc0205dae:	bf19                	j	ffffffffc0205cc4 <do_execve+0x156>
ffffffffc0205db0:	fe0a8ae3          	beqz	s5,ffffffffc0205da4 <do_execve+0x236>
ffffffffc0205db4:	038a8513          	addi	a0,s5,56
ffffffffc0205db8:	afefe0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0205dbc:	54f5                	li	s1,-3
ffffffffc0205dbe:	040aa823          	sw	zero,80(s5)
ffffffffc0205dc2:	b709                	j	ffffffffc0205cc4 <do_execve+0x156>

ffffffffc0205dc4 <user_main>:
ffffffffc0205dc4:	7179                	addi	sp,sp,-48
ffffffffc0205dc6:	e84a                	sd	s2,16(sp)
ffffffffc0205dc8:	00090917          	auipc	s2,0x90
ffffffffc0205dcc:	af090913          	addi	s2,s2,-1296 # ffffffffc02958b8 <current>
ffffffffc0205dd0:	00093783          	ld	a5,0(s2)
ffffffffc0205dd4:	00006617          	auipc	a2,0x6
ffffffffc0205dd8:	72460613          	addi	a2,a2,1828 # ffffffffc020c4f8 <CSWTCH.79+0x300>
ffffffffc0205ddc:	00006517          	auipc	a0,0x6
ffffffffc0205de0:	72450513          	addi	a0,a0,1828 # ffffffffc020c500 <CSWTCH.79+0x308>
ffffffffc0205de4:	43cc                	lw	a1,4(a5)
ffffffffc0205de6:	f406                	sd	ra,40(sp)
ffffffffc0205de8:	f022                	sd	s0,32(sp)
ffffffffc0205dea:	ec26                	sd	s1,24(sp)
ffffffffc0205dec:	e032                	sd	a2,0(sp)
ffffffffc0205dee:	e402                	sd	zero,8(sp)
ffffffffc0205df0:	bb6fa0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0205df4:	6782                	ld	a5,0(sp)
ffffffffc0205df6:	cfb9                	beqz	a5,ffffffffc0205e54 <user_main+0x90>
ffffffffc0205df8:	003c                	addi	a5,sp,8
ffffffffc0205dfa:	4401                	li	s0,0
ffffffffc0205dfc:	6398                	ld	a4,0(a5)
ffffffffc0205dfe:	0405                	addi	s0,s0,1
ffffffffc0205e00:	07a1                	addi	a5,a5,8
ffffffffc0205e02:	ff6d                	bnez	a4,ffffffffc0205dfc <user_main+0x38>
ffffffffc0205e04:	00093783          	ld	a5,0(s2)
ffffffffc0205e08:	12000613          	li	a2,288
ffffffffc0205e0c:	6b84                	ld	s1,16(a5)
ffffffffc0205e0e:	73cc                	ld	a1,160(a5)
ffffffffc0205e10:	6789                	lui	a5,0x2
ffffffffc0205e12:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205e16:	94be                	add	s1,s1,a5
ffffffffc0205e18:	8526                	mv	a0,s1
ffffffffc0205e1a:	5a0040ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0205e1e:	00093783          	ld	a5,0(s2)
ffffffffc0205e22:	860a                	mv	a2,sp
ffffffffc0205e24:	0004059b          	sext.w	a1,s0
ffffffffc0205e28:	f3c4                	sd	s1,160(a5)
ffffffffc0205e2a:	00006517          	auipc	a0,0x6
ffffffffc0205e2e:	6ce50513          	addi	a0,a0,1742 # ffffffffc020c4f8 <CSWTCH.79+0x300>
ffffffffc0205e32:	d3dff0ef          	jal	ra,ffffffffc0205b6e <do_execve>
ffffffffc0205e36:	8126                	mv	sp,s1
ffffffffc0205e38:	c18fb06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0205e3c:	00006617          	auipc	a2,0x6
ffffffffc0205e40:	6ec60613          	addi	a2,a2,1772 # ffffffffc020c528 <CSWTCH.79+0x330>
ffffffffc0205e44:	3ab00593          	li	a1,939
ffffffffc0205e48:	00006517          	auipc	a0,0x6
ffffffffc0205e4c:	4d850513          	addi	a0,a0,1240 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0205e50:	e4efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205e54:	4401                	li	s0,0
ffffffffc0205e56:	b77d                	j	ffffffffc0205e04 <user_main+0x40>

ffffffffc0205e58 <do_yield>:
ffffffffc0205e58:	00090797          	auipc	a5,0x90
ffffffffc0205e5c:	a607b783          	ld	a5,-1440(a5) # ffffffffc02958b8 <current>
ffffffffc0205e60:	4705                	li	a4,1
ffffffffc0205e62:	ef98                	sd	a4,24(a5)
ffffffffc0205e64:	4501                	li	a0,0
ffffffffc0205e66:	8082                	ret

ffffffffc0205e68 <do_wait>:
ffffffffc0205e68:	1101                	addi	sp,sp,-32
ffffffffc0205e6a:	e822                	sd	s0,16(sp)
ffffffffc0205e6c:	e426                	sd	s1,8(sp)
ffffffffc0205e6e:	ec06                	sd	ra,24(sp)
ffffffffc0205e70:	842e                	mv	s0,a1
ffffffffc0205e72:	84aa                	mv	s1,a0
ffffffffc0205e74:	c999                	beqz	a1,ffffffffc0205e8a <do_wait+0x22>
ffffffffc0205e76:	00090797          	auipc	a5,0x90
ffffffffc0205e7a:	a427b783          	ld	a5,-1470(a5) # ffffffffc02958b8 <current>
ffffffffc0205e7e:	7788                	ld	a0,40(a5)
ffffffffc0205e80:	4685                	li	a3,1
ffffffffc0205e82:	4611                	li	a2,4
ffffffffc0205e84:	f65fd0ef          	jal	ra,ffffffffc0203de8 <user_mem_check>
ffffffffc0205e88:	c909                	beqz	a0,ffffffffc0205e9a <do_wait+0x32>
ffffffffc0205e8a:	85a2                	mv	a1,s0
ffffffffc0205e8c:	6442                	ld	s0,16(sp)
ffffffffc0205e8e:	60e2                	ld	ra,24(sp)
ffffffffc0205e90:	8526                	mv	a0,s1
ffffffffc0205e92:	64a2                	ld	s1,8(sp)
ffffffffc0205e94:	6105                	addi	sp,sp,32
ffffffffc0205e96:	9b7ff06f          	j	ffffffffc020584c <do_wait.part.0>
ffffffffc0205e9a:	60e2                	ld	ra,24(sp)
ffffffffc0205e9c:	6442                	ld	s0,16(sp)
ffffffffc0205e9e:	64a2                	ld	s1,8(sp)
ffffffffc0205ea0:	5575                	li	a0,-3
ffffffffc0205ea2:	6105                	addi	sp,sp,32
ffffffffc0205ea4:	8082                	ret

ffffffffc0205ea6 <do_kill>:
ffffffffc0205ea6:	1141                	addi	sp,sp,-16
ffffffffc0205ea8:	6789                	lui	a5,0x2
ffffffffc0205eaa:	e406                	sd	ra,8(sp)
ffffffffc0205eac:	e022                	sd	s0,0(sp)
ffffffffc0205eae:	fff5071b          	addiw	a4,a0,-1
ffffffffc0205eb2:	17f9                	addi	a5,a5,-2
ffffffffc0205eb4:	02e7e963          	bltu	a5,a4,ffffffffc0205ee6 <do_kill+0x40>
ffffffffc0205eb8:	842a                	mv	s0,a0
ffffffffc0205eba:	45a9                	li	a1,10
ffffffffc0205ebc:	2501                	sext.w	a0,a0
ffffffffc0205ebe:	777030ef          	jal	ra,ffffffffc0209e34 <hash32>
ffffffffc0205ec2:	02051793          	slli	a5,a0,0x20
ffffffffc0205ec6:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205eca:	0008b797          	auipc	a5,0x8b
ffffffffc0205ece:	8ee78793          	addi	a5,a5,-1810 # ffffffffc02907b8 <hash_list>
ffffffffc0205ed2:	953e                	add	a0,a0,a5
ffffffffc0205ed4:	87aa                	mv	a5,a0
ffffffffc0205ed6:	a029                	j	ffffffffc0205ee0 <do_kill+0x3a>
ffffffffc0205ed8:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0205edc:	00870b63          	beq	a4,s0,ffffffffc0205ef2 <do_kill+0x4c>
ffffffffc0205ee0:	679c                	ld	a5,8(a5)
ffffffffc0205ee2:	fef51be3          	bne	a0,a5,ffffffffc0205ed8 <do_kill+0x32>
ffffffffc0205ee6:	5475                	li	s0,-3
ffffffffc0205ee8:	60a2                	ld	ra,8(sp)
ffffffffc0205eea:	8522                	mv	a0,s0
ffffffffc0205eec:	6402                	ld	s0,0(sp)
ffffffffc0205eee:	0141                	addi	sp,sp,16
ffffffffc0205ef0:	8082                	ret
ffffffffc0205ef2:	fd87a703          	lw	a4,-40(a5)
ffffffffc0205ef6:	00177693          	andi	a3,a4,1
ffffffffc0205efa:	e295                	bnez	a3,ffffffffc0205f1e <do_kill+0x78>
ffffffffc0205efc:	4bd4                	lw	a3,20(a5)
ffffffffc0205efe:	00176713          	ori	a4,a4,1
ffffffffc0205f02:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0205f06:	4401                	li	s0,0
ffffffffc0205f08:	fe06d0e3          	bgez	a3,ffffffffc0205ee8 <do_kill+0x42>
ffffffffc0205f0c:	f2878513          	addi	a0,a5,-216
ffffffffc0205f10:	476000ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc0205f14:	60a2                	ld	ra,8(sp)
ffffffffc0205f16:	8522                	mv	a0,s0
ffffffffc0205f18:	6402                	ld	s0,0(sp)
ffffffffc0205f1a:	0141                	addi	sp,sp,16
ffffffffc0205f1c:	8082                	ret
ffffffffc0205f1e:	545d                	li	s0,-9
ffffffffc0205f20:	b7e1                	j	ffffffffc0205ee8 <do_kill+0x42>

ffffffffc0205f22 <proc_init>:
ffffffffc0205f22:	1101                	addi	sp,sp,-32
ffffffffc0205f24:	e426                	sd	s1,8(sp)
ffffffffc0205f26:	0008f797          	auipc	a5,0x8f
ffffffffc0205f2a:	89278793          	addi	a5,a5,-1902 # ffffffffc02947b8 <proc_list>
ffffffffc0205f2e:	ec06                	sd	ra,24(sp)
ffffffffc0205f30:	e822                	sd	s0,16(sp)
ffffffffc0205f32:	e04a                	sd	s2,0(sp)
ffffffffc0205f34:	0008b497          	auipc	s1,0x8b
ffffffffc0205f38:	88448493          	addi	s1,s1,-1916 # ffffffffc02907b8 <hash_list>
ffffffffc0205f3c:	e79c                	sd	a5,8(a5)
ffffffffc0205f3e:	e39c                	sd	a5,0(a5)
ffffffffc0205f40:	0008f717          	auipc	a4,0x8f
ffffffffc0205f44:	87870713          	addi	a4,a4,-1928 # ffffffffc02947b8 <proc_list>
ffffffffc0205f48:	87a6                	mv	a5,s1
ffffffffc0205f4a:	e79c                	sd	a5,8(a5)
ffffffffc0205f4c:	e39c                	sd	a5,0(a5)
ffffffffc0205f4e:	07c1                	addi	a5,a5,16
ffffffffc0205f50:	fee79de3          	bne	a5,a4,ffffffffc0205f4a <proc_init+0x28>
ffffffffc0205f54:	15000513          	li	a0,336
ffffffffc0205f58:	836fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205f5c:	842a                	mv	s0,a0
ffffffffc0205f5e:	1a050b63          	beqz	a0,ffffffffc0206114 <proc_init+0x1f2>
ffffffffc0205f62:	57fd                	li	a5,-1
ffffffffc0205f64:	1782                	slli	a5,a5,0x20
ffffffffc0205f66:	e11c                	sd	a5,0(a0)
ffffffffc0205f68:	07000613          	li	a2,112
ffffffffc0205f6c:	4581                	li	a1,0
ffffffffc0205f6e:	00052423          	sw	zero,8(a0)
ffffffffc0205f72:	00053823          	sd	zero,16(a0)
ffffffffc0205f76:	00053c23          	sd	zero,24(a0)
ffffffffc0205f7a:	02053023          	sd	zero,32(a0)
ffffffffc0205f7e:	02053423          	sd	zero,40(a0)
ffffffffc0205f82:	03050513          	addi	a0,a0,48
ffffffffc0205f86:	3e2040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0205f8a:	00090797          	auipc	a5,0x90
ffffffffc0205f8e:	8fe7b783          	ld	a5,-1794(a5) # ffffffffc0295888 <boot_pgdir_pa>
ffffffffc0205f92:	463d                	li	a2,15
ffffffffc0205f94:	4581                	li	a1,0
ffffffffc0205f96:	f45c                	sd	a5,168(s0)
ffffffffc0205f98:	0a043023          	sd	zero,160(s0)
ffffffffc0205f9c:	0a042823          	sw	zero,176(s0)
ffffffffc0205fa0:	0b440513          	addi	a0,s0,180
ffffffffc0205fa4:	3c4040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0205fa8:	11040793          	addi	a5,s0,272
ffffffffc0205fac:	00090917          	auipc	s2,0x90
ffffffffc0205fb0:	91490913          	addi	s2,s2,-1772 # ffffffffc02958c0 <idleproc>
ffffffffc0205fb4:	00893023          	sd	s0,0(s2)
ffffffffc0205fb8:	10f43c23          	sd	a5,280(s0)
ffffffffc0205fbc:	10f43823          	sd	a5,272(s0)
ffffffffc0205fc0:	4789                	li	a5,2
ffffffffc0205fc2:	e01c                	sd	a5,0(s0)
ffffffffc0205fc4:	0000a797          	auipc	a5,0xa
ffffffffc0205fc8:	03c78793          	addi	a5,a5,60 # ffffffffc0210000 <bootstack>
ffffffffc0205fcc:	e81c                	sd	a5,16(s0)
ffffffffc0205fce:	4785                	li	a5,1
ffffffffc0205fd0:	0e042623          	sw	zero,236(s0)
ffffffffc0205fd4:	0e043c23          	sd	zero,248(s0)
ffffffffc0205fd8:	10043023          	sd	zero,256(s0)
ffffffffc0205fdc:	0e043823          	sd	zero,240(s0)
ffffffffc0205fe0:	10043423          	sd	zero,264(s0)
ffffffffc0205fe4:	12042023          	sw	zero,288(s0)
ffffffffc0205fe8:	12043423          	sd	zero,296(s0)
ffffffffc0205fec:	12043823          	sd	zero,304(s0)
ffffffffc0205ff0:	12043c23          	sd	zero,312(s0)
ffffffffc0205ff4:	14043023          	sd	zero,320(s0)
ffffffffc0205ff8:	ec1c                	sd	a5,24(s0)
ffffffffc0205ffa:	d2bfe0ef          	jal	ra,ffffffffc0204d24 <files_create>
ffffffffc0205ffe:	14a43423          	sd	a0,328(s0)
ffffffffc0206002:	0e050d63          	beqz	a0,ffffffffc02060fc <proc_init+0x1da>
ffffffffc0206006:	00093403          	ld	s0,0(s2)
ffffffffc020600a:	4641                	li	a2,16
ffffffffc020600c:	4581                	li	a1,0
ffffffffc020600e:	14843703          	ld	a4,328(s0)
ffffffffc0206012:	0b440413          	addi	s0,s0,180
ffffffffc0206016:	8522                	mv	a0,s0
ffffffffc0206018:	4b1c                	lw	a5,16(a4)
ffffffffc020601a:	2785                	addiw	a5,a5,1
ffffffffc020601c:	cb1c                	sw	a5,16(a4)
ffffffffc020601e:	34a040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0206022:	463d                	li	a2,15
ffffffffc0206024:	00006597          	auipc	a1,0x6
ffffffffc0206028:	54c58593          	addi	a1,a1,1356 # ffffffffc020c570 <CSWTCH.79+0x378>
ffffffffc020602c:	8522                	mv	a0,s0
ffffffffc020602e:	38c040ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0206032:	00090717          	auipc	a4,0x90
ffffffffc0206036:	89e70713          	addi	a4,a4,-1890 # ffffffffc02958d0 <nr_process>
ffffffffc020603a:	431c                	lw	a5,0(a4)
ffffffffc020603c:	00093683          	ld	a3,0(s2)
ffffffffc0206040:	4601                	li	a2,0
ffffffffc0206042:	2785                	addiw	a5,a5,1
ffffffffc0206044:	4581                	li	a1,0
ffffffffc0206046:	00000517          	auipc	a0,0x0
ffffffffc020604a:	9d850513          	addi	a0,a0,-1576 # ffffffffc0205a1e <init_main>
ffffffffc020604e:	c31c                	sw	a5,0(a4)
ffffffffc0206050:	00090797          	auipc	a5,0x90
ffffffffc0206054:	86d7b423          	sd	a3,-1944(a5) # ffffffffc02958b8 <current>
ffffffffc0206058:	e42ff0ef          	jal	ra,ffffffffc020569a <kernel_thread>
ffffffffc020605c:	842a                	mv	s0,a0
ffffffffc020605e:	08a05363          	blez	a0,ffffffffc02060e4 <proc_init+0x1c2>
ffffffffc0206062:	6789                	lui	a5,0x2
ffffffffc0206064:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206068:	17f9                	addi	a5,a5,-2
ffffffffc020606a:	2501                	sext.w	a0,a0
ffffffffc020606c:	02e7e363          	bltu	a5,a4,ffffffffc0206092 <proc_init+0x170>
ffffffffc0206070:	45a9                	li	a1,10
ffffffffc0206072:	5c3030ef          	jal	ra,ffffffffc0209e34 <hash32>
ffffffffc0206076:	02051793          	slli	a5,a0,0x20
ffffffffc020607a:	01c7d693          	srli	a3,a5,0x1c
ffffffffc020607e:	96a6                	add	a3,a3,s1
ffffffffc0206080:	87b6                	mv	a5,a3
ffffffffc0206082:	a029                	j	ffffffffc020608c <proc_init+0x16a>
ffffffffc0206084:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206088:	04870b63          	beq	a4,s0,ffffffffc02060de <proc_init+0x1bc>
ffffffffc020608c:	679c                	ld	a5,8(a5)
ffffffffc020608e:	fef69be3          	bne	a3,a5,ffffffffc0206084 <proc_init+0x162>
ffffffffc0206092:	4781                	li	a5,0
ffffffffc0206094:	0b478493          	addi	s1,a5,180
ffffffffc0206098:	4641                	li	a2,16
ffffffffc020609a:	4581                	li	a1,0
ffffffffc020609c:	00090417          	auipc	s0,0x90
ffffffffc02060a0:	82c40413          	addi	s0,s0,-2004 # ffffffffc02958c8 <initproc>
ffffffffc02060a4:	8526                	mv	a0,s1
ffffffffc02060a6:	e01c                	sd	a5,0(s0)
ffffffffc02060a8:	2c0040ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc02060ac:	463d                	li	a2,15
ffffffffc02060ae:	00006597          	auipc	a1,0x6
ffffffffc02060b2:	4ea58593          	addi	a1,a1,1258 # ffffffffc020c598 <CSWTCH.79+0x3a0>
ffffffffc02060b6:	8526                	mv	a0,s1
ffffffffc02060b8:	302040ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc02060bc:	00093783          	ld	a5,0(s2)
ffffffffc02060c0:	cbd1                	beqz	a5,ffffffffc0206154 <proc_init+0x232>
ffffffffc02060c2:	43dc                	lw	a5,4(a5)
ffffffffc02060c4:	ebc1                	bnez	a5,ffffffffc0206154 <proc_init+0x232>
ffffffffc02060c6:	601c                	ld	a5,0(s0)
ffffffffc02060c8:	c7b5                	beqz	a5,ffffffffc0206134 <proc_init+0x212>
ffffffffc02060ca:	43d8                	lw	a4,4(a5)
ffffffffc02060cc:	4785                	li	a5,1
ffffffffc02060ce:	06f71363          	bne	a4,a5,ffffffffc0206134 <proc_init+0x212>
ffffffffc02060d2:	60e2                	ld	ra,24(sp)
ffffffffc02060d4:	6442                	ld	s0,16(sp)
ffffffffc02060d6:	64a2                	ld	s1,8(sp)
ffffffffc02060d8:	6902                	ld	s2,0(sp)
ffffffffc02060da:	6105                	addi	sp,sp,32
ffffffffc02060dc:	8082                	ret
ffffffffc02060de:	f2878793          	addi	a5,a5,-216
ffffffffc02060e2:	bf4d                	j	ffffffffc0206094 <proc_init+0x172>
ffffffffc02060e4:	00006617          	auipc	a2,0x6
ffffffffc02060e8:	49460613          	addi	a2,a2,1172 # ffffffffc020c578 <CSWTCH.79+0x380>
ffffffffc02060ec:	3f700593          	li	a1,1015
ffffffffc02060f0:	00006517          	auipc	a0,0x6
ffffffffc02060f4:	23050513          	addi	a0,a0,560 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc02060f8:	ba6fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02060fc:	00006617          	auipc	a2,0x6
ffffffffc0206100:	44c60613          	addi	a2,a2,1100 # ffffffffc020c548 <CSWTCH.79+0x350>
ffffffffc0206104:	3eb00593          	li	a1,1003
ffffffffc0206108:	00006517          	auipc	a0,0x6
ffffffffc020610c:	21850513          	addi	a0,a0,536 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0206110:	b8efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206114:	00006617          	auipc	a2,0x6
ffffffffc0206118:	4dc60613          	addi	a2,a2,1244 # ffffffffc020c5f0 <CSWTCH.79+0x3f8>
ffffffffc020611c:	3e100593          	li	a1,993
ffffffffc0206120:	00006517          	auipc	a0,0x6
ffffffffc0206124:	20050513          	addi	a0,a0,512 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0206128:	0008f797          	auipc	a5,0x8f
ffffffffc020612c:	7807bc23          	sd	zero,1944(a5) # ffffffffc02958c0 <idleproc>
ffffffffc0206130:	b6efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206134:	00006697          	auipc	a3,0x6
ffffffffc0206138:	49468693          	addi	a3,a3,1172 # ffffffffc020c5c8 <CSWTCH.79+0x3d0>
ffffffffc020613c:	00004617          	auipc	a2,0x4
ffffffffc0206140:	71460613          	addi	a2,a2,1812 # ffffffffc020a850 <commands+0x210>
ffffffffc0206144:	3fe00593          	li	a1,1022
ffffffffc0206148:	00006517          	auipc	a0,0x6
ffffffffc020614c:	1d850513          	addi	a0,a0,472 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0206150:	b4efa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206154:	00006697          	auipc	a3,0x6
ffffffffc0206158:	44c68693          	addi	a3,a3,1100 # ffffffffc020c5a0 <CSWTCH.79+0x3a8>
ffffffffc020615c:	00004617          	auipc	a2,0x4
ffffffffc0206160:	6f460613          	addi	a2,a2,1780 # ffffffffc020a850 <commands+0x210>
ffffffffc0206164:	3fd00593          	li	a1,1021
ffffffffc0206168:	00006517          	auipc	a0,0x6
ffffffffc020616c:	1b850513          	addi	a0,a0,440 # ffffffffc020c320 <CSWTCH.79+0x128>
ffffffffc0206170:	b2efa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206174 <cpu_idle>:
ffffffffc0206174:	1141                	addi	sp,sp,-16
ffffffffc0206176:	e022                	sd	s0,0(sp)
ffffffffc0206178:	e406                	sd	ra,8(sp)
ffffffffc020617a:	0008f417          	auipc	s0,0x8f
ffffffffc020617e:	73e40413          	addi	s0,s0,1854 # ffffffffc02958b8 <current>
ffffffffc0206182:	6018                	ld	a4,0(s0)
ffffffffc0206184:	6f1c                	ld	a5,24(a4)
ffffffffc0206186:	dffd                	beqz	a5,ffffffffc0206184 <cpu_idle+0x10>
ffffffffc0206188:	2b0000ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc020618c:	bfdd                	j	ffffffffc0206182 <cpu_idle+0xe>

ffffffffc020618e <lab6_set_priority>:
ffffffffc020618e:	1141                	addi	sp,sp,-16
ffffffffc0206190:	e022                	sd	s0,0(sp)
ffffffffc0206192:	85aa                	mv	a1,a0
ffffffffc0206194:	842a                	mv	s0,a0
ffffffffc0206196:	00006517          	auipc	a0,0x6
ffffffffc020619a:	47250513          	addi	a0,a0,1138 # ffffffffc020c608 <CSWTCH.79+0x410>
ffffffffc020619e:	e406                	sd	ra,8(sp)
ffffffffc02061a0:	806fa0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02061a4:	0008f797          	auipc	a5,0x8f
ffffffffc02061a8:	7147b783          	ld	a5,1812(a5) # ffffffffc02958b8 <current>
ffffffffc02061ac:	e801                	bnez	s0,ffffffffc02061bc <lab6_set_priority+0x2e>
ffffffffc02061ae:	60a2                	ld	ra,8(sp)
ffffffffc02061b0:	6402                	ld	s0,0(sp)
ffffffffc02061b2:	4705                	li	a4,1
ffffffffc02061b4:	14e7a223          	sw	a4,324(a5)
ffffffffc02061b8:	0141                	addi	sp,sp,16
ffffffffc02061ba:	8082                	ret
ffffffffc02061bc:	60a2                	ld	ra,8(sp)
ffffffffc02061be:	1487a223          	sw	s0,324(a5)
ffffffffc02061c2:	6402                	ld	s0,0(sp)
ffffffffc02061c4:	0141                	addi	sp,sp,16
ffffffffc02061c6:	8082                	ret

ffffffffc02061c8 <do_sleep>:
ffffffffc02061c8:	c539                	beqz	a0,ffffffffc0206216 <do_sleep+0x4e>
ffffffffc02061ca:	7179                	addi	sp,sp,-48
ffffffffc02061cc:	f022                	sd	s0,32(sp)
ffffffffc02061ce:	f406                	sd	ra,40(sp)
ffffffffc02061d0:	842a                	mv	s0,a0
ffffffffc02061d2:	100027f3          	csrr	a5,sstatus
ffffffffc02061d6:	8b89                	andi	a5,a5,2
ffffffffc02061d8:	e3a9                	bnez	a5,ffffffffc020621a <do_sleep+0x52>
ffffffffc02061da:	0008f797          	auipc	a5,0x8f
ffffffffc02061de:	6de7b783          	ld	a5,1758(a5) # ffffffffc02958b8 <current>
ffffffffc02061e2:	0818                	addi	a4,sp,16
ffffffffc02061e4:	c02a                	sw	a0,0(sp)
ffffffffc02061e6:	ec3a                	sd	a4,24(sp)
ffffffffc02061e8:	e83a                	sd	a4,16(sp)
ffffffffc02061ea:	e43e                	sd	a5,8(sp)
ffffffffc02061ec:	4705                	li	a4,1
ffffffffc02061ee:	c398                	sw	a4,0(a5)
ffffffffc02061f0:	80000737          	lui	a4,0x80000
ffffffffc02061f4:	840a                	mv	s0,sp
ffffffffc02061f6:	0709                	addi	a4,a4,2
ffffffffc02061f8:	0ee7a623          	sw	a4,236(a5)
ffffffffc02061fc:	8522                	mv	a0,s0
ffffffffc02061fe:	2fa000ef          	jal	ra,ffffffffc02064f8 <add_timer>
ffffffffc0206202:	236000ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc0206206:	8522                	mv	a0,s0
ffffffffc0206208:	3b8000ef          	jal	ra,ffffffffc02065c0 <del_timer>
ffffffffc020620c:	70a2                	ld	ra,40(sp)
ffffffffc020620e:	7402                	ld	s0,32(sp)
ffffffffc0206210:	4501                	li	a0,0
ffffffffc0206212:	6145                	addi	sp,sp,48
ffffffffc0206214:	8082                	ret
ffffffffc0206216:	4501                	li	a0,0
ffffffffc0206218:	8082                	ret
ffffffffc020621a:	a59fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020621e:	0008f797          	auipc	a5,0x8f
ffffffffc0206222:	69a7b783          	ld	a5,1690(a5) # ffffffffc02958b8 <current>
ffffffffc0206226:	0818                	addi	a4,sp,16
ffffffffc0206228:	c022                	sw	s0,0(sp)
ffffffffc020622a:	e43e                	sd	a5,8(sp)
ffffffffc020622c:	ec3a                	sd	a4,24(sp)
ffffffffc020622e:	e83a                	sd	a4,16(sp)
ffffffffc0206230:	4705                	li	a4,1
ffffffffc0206232:	c398                	sw	a4,0(a5)
ffffffffc0206234:	80000737          	lui	a4,0x80000
ffffffffc0206238:	0709                	addi	a4,a4,2
ffffffffc020623a:	840a                	mv	s0,sp
ffffffffc020623c:	8522                	mv	a0,s0
ffffffffc020623e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0206242:	2b6000ef          	jal	ra,ffffffffc02064f8 <add_timer>
ffffffffc0206246:	a27fa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020624a:	bf65                	j	ffffffffc0206202 <do_sleep+0x3a>

ffffffffc020624c <RR_init>:
ffffffffc020624c:	e508                	sd	a0,8(a0)
ffffffffc020624e:	e108                	sd	a0,0(a0)
ffffffffc0206250:	00052823          	sw	zero,16(a0)
ffffffffc0206254:	8082                	ret

ffffffffc0206256 <RR_pick_next>:
ffffffffc0206256:	651c                	ld	a5,8(a0)
ffffffffc0206258:	00f50563          	beq	a0,a5,ffffffffc0206262 <RR_pick_next+0xc>
ffffffffc020625c:	ef078513          	addi	a0,a5,-272
ffffffffc0206260:	8082                	ret
ffffffffc0206262:	4501                	li	a0,0
ffffffffc0206264:	8082                	ret

ffffffffc0206266 <RR_proc_tick>:
ffffffffc0206266:	1205a783          	lw	a5,288(a1)
ffffffffc020626a:	00f05563          	blez	a5,ffffffffc0206274 <RR_proc_tick+0xe>
ffffffffc020626e:	37fd                	addiw	a5,a5,-1
ffffffffc0206270:	12f5a023          	sw	a5,288(a1)
ffffffffc0206274:	e399                	bnez	a5,ffffffffc020627a <RR_proc_tick+0x14>
ffffffffc0206276:	4785                	li	a5,1
ffffffffc0206278:	ed9c                	sd	a5,24(a1)
ffffffffc020627a:	8082                	ret

ffffffffc020627c <RR_dequeue>:
ffffffffc020627c:	1185b703          	ld	a4,280(a1)
ffffffffc0206280:	11058793          	addi	a5,a1,272
ffffffffc0206284:	02e78363          	beq	a5,a4,ffffffffc02062aa <RR_dequeue+0x2e>
ffffffffc0206288:	1085b683          	ld	a3,264(a1)
ffffffffc020628c:	00a69f63          	bne	a3,a0,ffffffffc02062aa <RR_dequeue+0x2e>
ffffffffc0206290:	1105b503          	ld	a0,272(a1)
ffffffffc0206294:	4a90                	lw	a2,16(a3)
ffffffffc0206296:	e518                	sd	a4,8(a0)
ffffffffc0206298:	e308                	sd	a0,0(a4)
ffffffffc020629a:	10f5bc23          	sd	a5,280(a1)
ffffffffc020629e:	10f5b823          	sd	a5,272(a1)
ffffffffc02062a2:	fff6079b          	addiw	a5,a2,-1
ffffffffc02062a6:	ca9c                	sw	a5,16(a3)
ffffffffc02062a8:	8082                	ret
ffffffffc02062aa:	1141                	addi	sp,sp,-16
ffffffffc02062ac:	00006697          	auipc	a3,0x6
ffffffffc02062b0:	37468693          	addi	a3,a3,884 # ffffffffc020c620 <CSWTCH.79+0x428>
ffffffffc02062b4:	00004617          	auipc	a2,0x4
ffffffffc02062b8:	59c60613          	addi	a2,a2,1436 # ffffffffc020a850 <commands+0x210>
ffffffffc02062bc:	03c00593          	li	a1,60
ffffffffc02062c0:	00006517          	auipc	a0,0x6
ffffffffc02062c4:	39850513          	addi	a0,a0,920 # ffffffffc020c658 <CSWTCH.79+0x460>
ffffffffc02062c8:	e406                	sd	ra,8(sp)
ffffffffc02062ca:	9d4fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02062ce <RR_enqueue>:
ffffffffc02062ce:	1185b703          	ld	a4,280(a1)
ffffffffc02062d2:	11058793          	addi	a5,a1,272
ffffffffc02062d6:	02e79d63          	bne	a5,a4,ffffffffc0206310 <RR_enqueue+0x42>
ffffffffc02062da:	6118                	ld	a4,0(a0)
ffffffffc02062dc:	1205a683          	lw	a3,288(a1)
ffffffffc02062e0:	e11c                	sd	a5,0(a0)
ffffffffc02062e2:	e71c                	sd	a5,8(a4)
ffffffffc02062e4:	10a5bc23          	sd	a0,280(a1)
ffffffffc02062e8:	10e5b823          	sd	a4,272(a1)
ffffffffc02062ec:	495c                	lw	a5,20(a0)
ffffffffc02062ee:	ea89                	bnez	a3,ffffffffc0206300 <RR_enqueue+0x32>
ffffffffc02062f0:	12f5a023          	sw	a5,288(a1)
ffffffffc02062f4:	491c                	lw	a5,16(a0)
ffffffffc02062f6:	10a5b423          	sd	a0,264(a1)
ffffffffc02062fa:	2785                	addiw	a5,a5,1
ffffffffc02062fc:	c91c                	sw	a5,16(a0)
ffffffffc02062fe:	8082                	ret
ffffffffc0206300:	fed7c8e3          	blt	a5,a3,ffffffffc02062f0 <RR_enqueue+0x22>
ffffffffc0206304:	491c                	lw	a5,16(a0)
ffffffffc0206306:	10a5b423          	sd	a0,264(a1)
ffffffffc020630a:	2785                	addiw	a5,a5,1
ffffffffc020630c:	c91c                	sw	a5,16(a0)
ffffffffc020630e:	8082                	ret
ffffffffc0206310:	1141                	addi	sp,sp,-16
ffffffffc0206312:	00006697          	auipc	a3,0x6
ffffffffc0206316:	36668693          	addi	a3,a3,870 # ffffffffc020c678 <CSWTCH.79+0x480>
ffffffffc020631a:	00004617          	auipc	a2,0x4
ffffffffc020631e:	53660613          	addi	a2,a2,1334 # ffffffffc020a850 <commands+0x210>
ffffffffc0206322:	02800593          	li	a1,40
ffffffffc0206326:	00006517          	auipc	a0,0x6
ffffffffc020632a:	33250513          	addi	a0,a0,818 # ffffffffc020c658 <CSWTCH.79+0x460>
ffffffffc020632e:	e406                	sd	ra,8(sp)
ffffffffc0206330:	96efa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206334 <sched_init>:
ffffffffc0206334:	1141                	addi	sp,sp,-16
ffffffffc0206336:	0008a717          	auipc	a4,0x8a
ffffffffc020633a:	cea70713          	addi	a4,a4,-790 # ffffffffc0290020 <default_sched_class>
ffffffffc020633e:	e022                	sd	s0,0(sp)
ffffffffc0206340:	e406                	sd	ra,8(sp)
ffffffffc0206342:	0008e797          	auipc	a5,0x8e
ffffffffc0206346:	4a678793          	addi	a5,a5,1190 # ffffffffc02947e8 <timer_list>
ffffffffc020634a:	6714                	ld	a3,8(a4)
ffffffffc020634c:	0008e517          	auipc	a0,0x8e
ffffffffc0206350:	47c50513          	addi	a0,a0,1148 # ffffffffc02947c8 <__rq>
ffffffffc0206354:	e79c                	sd	a5,8(a5)
ffffffffc0206356:	e39c                	sd	a5,0(a5)
ffffffffc0206358:	4795                	li	a5,5
ffffffffc020635a:	c95c                	sw	a5,20(a0)
ffffffffc020635c:	0008f417          	auipc	s0,0x8f
ffffffffc0206360:	58440413          	addi	s0,s0,1412 # ffffffffc02958e0 <sched_class>
ffffffffc0206364:	0008f797          	auipc	a5,0x8f
ffffffffc0206368:	56a7ba23          	sd	a0,1396(a5) # ffffffffc02958d8 <rq>
ffffffffc020636c:	e018                	sd	a4,0(s0)
ffffffffc020636e:	9682                	jalr	a3
ffffffffc0206370:	601c                	ld	a5,0(s0)
ffffffffc0206372:	6402                	ld	s0,0(sp)
ffffffffc0206374:	60a2                	ld	ra,8(sp)
ffffffffc0206376:	638c                	ld	a1,0(a5)
ffffffffc0206378:	00006517          	auipc	a0,0x6
ffffffffc020637c:	33050513          	addi	a0,a0,816 # ffffffffc020c6a8 <CSWTCH.79+0x4b0>
ffffffffc0206380:	0141                	addi	sp,sp,16
ffffffffc0206382:	e25f906f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0206386 <wakeup_proc>:
ffffffffc0206386:	4118                	lw	a4,0(a0)
ffffffffc0206388:	1101                	addi	sp,sp,-32
ffffffffc020638a:	ec06                	sd	ra,24(sp)
ffffffffc020638c:	e822                	sd	s0,16(sp)
ffffffffc020638e:	e426                	sd	s1,8(sp)
ffffffffc0206390:	478d                	li	a5,3
ffffffffc0206392:	08f70363          	beq	a4,a5,ffffffffc0206418 <wakeup_proc+0x92>
ffffffffc0206396:	842a                	mv	s0,a0
ffffffffc0206398:	100027f3          	csrr	a5,sstatus
ffffffffc020639c:	8b89                	andi	a5,a5,2
ffffffffc020639e:	4481                	li	s1,0
ffffffffc02063a0:	e7bd                	bnez	a5,ffffffffc020640e <wakeup_proc+0x88>
ffffffffc02063a2:	4789                	li	a5,2
ffffffffc02063a4:	04f70863          	beq	a4,a5,ffffffffc02063f4 <wakeup_proc+0x6e>
ffffffffc02063a8:	c01c                	sw	a5,0(s0)
ffffffffc02063aa:	0e042623          	sw	zero,236(s0)
ffffffffc02063ae:	0008f797          	auipc	a5,0x8f
ffffffffc02063b2:	50a7b783          	ld	a5,1290(a5) # ffffffffc02958b8 <current>
ffffffffc02063b6:	02878363          	beq	a5,s0,ffffffffc02063dc <wakeup_proc+0x56>
ffffffffc02063ba:	0008f797          	auipc	a5,0x8f
ffffffffc02063be:	5067b783          	ld	a5,1286(a5) # ffffffffc02958c0 <idleproc>
ffffffffc02063c2:	00f40d63          	beq	s0,a5,ffffffffc02063dc <wakeup_proc+0x56>
ffffffffc02063c6:	0008f797          	auipc	a5,0x8f
ffffffffc02063ca:	51a7b783          	ld	a5,1306(a5) # ffffffffc02958e0 <sched_class>
ffffffffc02063ce:	6b9c                	ld	a5,16(a5)
ffffffffc02063d0:	85a2                	mv	a1,s0
ffffffffc02063d2:	0008f517          	auipc	a0,0x8f
ffffffffc02063d6:	50653503          	ld	a0,1286(a0) # ffffffffc02958d8 <rq>
ffffffffc02063da:	9782                	jalr	a5
ffffffffc02063dc:	e491                	bnez	s1,ffffffffc02063e8 <wakeup_proc+0x62>
ffffffffc02063de:	60e2                	ld	ra,24(sp)
ffffffffc02063e0:	6442                	ld	s0,16(sp)
ffffffffc02063e2:	64a2                	ld	s1,8(sp)
ffffffffc02063e4:	6105                	addi	sp,sp,32
ffffffffc02063e6:	8082                	ret
ffffffffc02063e8:	6442                	ld	s0,16(sp)
ffffffffc02063ea:	60e2                	ld	ra,24(sp)
ffffffffc02063ec:	64a2                	ld	s1,8(sp)
ffffffffc02063ee:	6105                	addi	sp,sp,32
ffffffffc02063f0:	87dfa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02063f4:	00006617          	auipc	a2,0x6
ffffffffc02063f8:	30460613          	addi	a2,a2,772 # ffffffffc020c6f8 <CSWTCH.79+0x500>
ffffffffc02063fc:	05200593          	li	a1,82
ffffffffc0206400:	00006517          	auipc	a0,0x6
ffffffffc0206404:	2e050513          	addi	a0,a0,736 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc0206408:	8fefa0ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020640c:	bfc1                	j	ffffffffc02063dc <wakeup_proc+0x56>
ffffffffc020640e:	865fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206412:	4018                	lw	a4,0(s0)
ffffffffc0206414:	4485                	li	s1,1
ffffffffc0206416:	b771                	j	ffffffffc02063a2 <wakeup_proc+0x1c>
ffffffffc0206418:	00006697          	auipc	a3,0x6
ffffffffc020641c:	2a868693          	addi	a3,a3,680 # ffffffffc020c6c0 <CSWTCH.79+0x4c8>
ffffffffc0206420:	00004617          	auipc	a2,0x4
ffffffffc0206424:	43060613          	addi	a2,a2,1072 # ffffffffc020a850 <commands+0x210>
ffffffffc0206428:	04300593          	li	a1,67
ffffffffc020642c:	00006517          	auipc	a0,0x6
ffffffffc0206430:	2b450513          	addi	a0,a0,692 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc0206434:	86afa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206438 <schedule>:
ffffffffc0206438:	7179                	addi	sp,sp,-48
ffffffffc020643a:	f406                	sd	ra,40(sp)
ffffffffc020643c:	f022                	sd	s0,32(sp)
ffffffffc020643e:	ec26                	sd	s1,24(sp)
ffffffffc0206440:	e84a                	sd	s2,16(sp)
ffffffffc0206442:	e44e                	sd	s3,8(sp)
ffffffffc0206444:	e052                	sd	s4,0(sp)
ffffffffc0206446:	100027f3          	csrr	a5,sstatus
ffffffffc020644a:	8b89                	andi	a5,a5,2
ffffffffc020644c:	4a01                	li	s4,0
ffffffffc020644e:	e3cd                	bnez	a5,ffffffffc02064f0 <schedule+0xb8>
ffffffffc0206450:	0008f497          	auipc	s1,0x8f
ffffffffc0206454:	46848493          	addi	s1,s1,1128 # ffffffffc02958b8 <current>
ffffffffc0206458:	608c                	ld	a1,0(s1)
ffffffffc020645a:	0008f997          	auipc	s3,0x8f
ffffffffc020645e:	48698993          	addi	s3,s3,1158 # ffffffffc02958e0 <sched_class>
ffffffffc0206462:	0008f917          	auipc	s2,0x8f
ffffffffc0206466:	47690913          	addi	s2,s2,1142 # ffffffffc02958d8 <rq>
ffffffffc020646a:	4194                	lw	a3,0(a1)
ffffffffc020646c:	0005bc23          	sd	zero,24(a1)
ffffffffc0206470:	4709                	li	a4,2
ffffffffc0206472:	0009b783          	ld	a5,0(s3)
ffffffffc0206476:	00093503          	ld	a0,0(s2)
ffffffffc020647a:	04e68e63          	beq	a3,a4,ffffffffc02064d6 <schedule+0x9e>
ffffffffc020647e:	739c                	ld	a5,32(a5)
ffffffffc0206480:	9782                	jalr	a5
ffffffffc0206482:	842a                	mv	s0,a0
ffffffffc0206484:	c521                	beqz	a0,ffffffffc02064cc <schedule+0x94>
ffffffffc0206486:	0009b783          	ld	a5,0(s3)
ffffffffc020648a:	00093503          	ld	a0,0(s2)
ffffffffc020648e:	85a2                	mv	a1,s0
ffffffffc0206490:	6f9c                	ld	a5,24(a5)
ffffffffc0206492:	9782                	jalr	a5
ffffffffc0206494:	441c                	lw	a5,8(s0)
ffffffffc0206496:	6098                	ld	a4,0(s1)
ffffffffc0206498:	2785                	addiw	a5,a5,1
ffffffffc020649a:	c41c                	sw	a5,8(s0)
ffffffffc020649c:	00870563          	beq	a4,s0,ffffffffc02064a6 <schedule+0x6e>
ffffffffc02064a0:	8522                	mv	a0,s0
ffffffffc02064a2:	8feff0ef          	jal	ra,ffffffffc02055a0 <proc_run>
ffffffffc02064a6:	000a1a63          	bnez	s4,ffffffffc02064ba <schedule+0x82>
ffffffffc02064aa:	70a2                	ld	ra,40(sp)
ffffffffc02064ac:	7402                	ld	s0,32(sp)
ffffffffc02064ae:	64e2                	ld	s1,24(sp)
ffffffffc02064b0:	6942                	ld	s2,16(sp)
ffffffffc02064b2:	69a2                	ld	s3,8(sp)
ffffffffc02064b4:	6a02                	ld	s4,0(sp)
ffffffffc02064b6:	6145                	addi	sp,sp,48
ffffffffc02064b8:	8082                	ret
ffffffffc02064ba:	7402                	ld	s0,32(sp)
ffffffffc02064bc:	70a2                	ld	ra,40(sp)
ffffffffc02064be:	64e2                	ld	s1,24(sp)
ffffffffc02064c0:	6942                	ld	s2,16(sp)
ffffffffc02064c2:	69a2                	ld	s3,8(sp)
ffffffffc02064c4:	6a02                	ld	s4,0(sp)
ffffffffc02064c6:	6145                	addi	sp,sp,48
ffffffffc02064c8:	fa4fa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02064cc:	0008f417          	auipc	s0,0x8f
ffffffffc02064d0:	3f443403          	ld	s0,1012(s0) # ffffffffc02958c0 <idleproc>
ffffffffc02064d4:	b7c1                	j	ffffffffc0206494 <schedule+0x5c>
ffffffffc02064d6:	0008f717          	auipc	a4,0x8f
ffffffffc02064da:	3ea73703          	ld	a4,1002(a4) # ffffffffc02958c0 <idleproc>
ffffffffc02064de:	fae580e3          	beq	a1,a4,ffffffffc020647e <schedule+0x46>
ffffffffc02064e2:	6b9c                	ld	a5,16(a5)
ffffffffc02064e4:	9782                	jalr	a5
ffffffffc02064e6:	0009b783          	ld	a5,0(s3)
ffffffffc02064ea:	00093503          	ld	a0,0(s2)
ffffffffc02064ee:	bf41                	j	ffffffffc020647e <schedule+0x46>
ffffffffc02064f0:	f82fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02064f4:	4a05                	li	s4,1
ffffffffc02064f6:	bfa9                	j	ffffffffc0206450 <schedule+0x18>

ffffffffc02064f8 <add_timer>:
ffffffffc02064f8:	1141                	addi	sp,sp,-16
ffffffffc02064fa:	e022                	sd	s0,0(sp)
ffffffffc02064fc:	e406                	sd	ra,8(sp)
ffffffffc02064fe:	842a                	mv	s0,a0
ffffffffc0206500:	100027f3          	csrr	a5,sstatus
ffffffffc0206504:	8b89                	andi	a5,a5,2
ffffffffc0206506:	4501                	li	a0,0
ffffffffc0206508:	eba5                	bnez	a5,ffffffffc0206578 <add_timer+0x80>
ffffffffc020650a:	401c                	lw	a5,0(s0)
ffffffffc020650c:	cbb5                	beqz	a5,ffffffffc0206580 <add_timer+0x88>
ffffffffc020650e:	6418                	ld	a4,8(s0)
ffffffffc0206510:	cb25                	beqz	a4,ffffffffc0206580 <add_timer+0x88>
ffffffffc0206512:	6c18                	ld	a4,24(s0)
ffffffffc0206514:	01040593          	addi	a1,s0,16
ffffffffc0206518:	08e59463          	bne	a1,a4,ffffffffc02065a0 <add_timer+0xa8>
ffffffffc020651c:	0008e617          	auipc	a2,0x8e
ffffffffc0206520:	2cc60613          	addi	a2,a2,716 # ffffffffc02947e8 <timer_list>
ffffffffc0206524:	6618                	ld	a4,8(a2)
ffffffffc0206526:	00c71863          	bne	a4,a2,ffffffffc0206536 <add_timer+0x3e>
ffffffffc020652a:	a80d                	j	ffffffffc020655c <add_timer+0x64>
ffffffffc020652c:	6718                	ld	a4,8(a4)
ffffffffc020652e:	9f95                	subw	a5,a5,a3
ffffffffc0206530:	c01c                	sw	a5,0(s0)
ffffffffc0206532:	02c70563          	beq	a4,a2,ffffffffc020655c <add_timer+0x64>
ffffffffc0206536:	ff072683          	lw	a3,-16(a4)
ffffffffc020653a:	fed7f9e3          	bgeu	a5,a3,ffffffffc020652c <add_timer+0x34>
ffffffffc020653e:	40f687bb          	subw	a5,a3,a5
ffffffffc0206542:	fef72823          	sw	a5,-16(a4)
ffffffffc0206546:	631c                	ld	a5,0(a4)
ffffffffc0206548:	e30c                	sd	a1,0(a4)
ffffffffc020654a:	e78c                	sd	a1,8(a5)
ffffffffc020654c:	ec18                	sd	a4,24(s0)
ffffffffc020654e:	e81c                	sd	a5,16(s0)
ffffffffc0206550:	c105                	beqz	a0,ffffffffc0206570 <add_timer+0x78>
ffffffffc0206552:	6402                	ld	s0,0(sp)
ffffffffc0206554:	60a2                	ld	ra,8(sp)
ffffffffc0206556:	0141                	addi	sp,sp,16
ffffffffc0206558:	f14fa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020655c:	0008e717          	auipc	a4,0x8e
ffffffffc0206560:	28c70713          	addi	a4,a4,652 # ffffffffc02947e8 <timer_list>
ffffffffc0206564:	631c                	ld	a5,0(a4)
ffffffffc0206566:	e30c                	sd	a1,0(a4)
ffffffffc0206568:	e78c                	sd	a1,8(a5)
ffffffffc020656a:	ec18                	sd	a4,24(s0)
ffffffffc020656c:	e81c                	sd	a5,16(s0)
ffffffffc020656e:	f175                	bnez	a0,ffffffffc0206552 <add_timer+0x5a>
ffffffffc0206570:	60a2                	ld	ra,8(sp)
ffffffffc0206572:	6402                	ld	s0,0(sp)
ffffffffc0206574:	0141                	addi	sp,sp,16
ffffffffc0206576:	8082                	ret
ffffffffc0206578:	efafa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020657c:	4505                	li	a0,1
ffffffffc020657e:	b771                	j	ffffffffc020650a <add_timer+0x12>
ffffffffc0206580:	00006697          	auipc	a3,0x6
ffffffffc0206584:	19868693          	addi	a3,a3,408 # ffffffffc020c718 <CSWTCH.79+0x520>
ffffffffc0206588:	00004617          	auipc	a2,0x4
ffffffffc020658c:	2c860613          	addi	a2,a2,712 # ffffffffc020a850 <commands+0x210>
ffffffffc0206590:	07a00593          	li	a1,122
ffffffffc0206594:	00006517          	auipc	a0,0x6
ffffffffc0206598:	14c50513          	addi	a0,a0,332 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc020659c:	f03f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02065a0:	00006697          	auipc	a3,0x6
ffffffffc02065a4:	1a868693          	addi	a3,a3,424 # ffffffffc020c748 <CSWTCH.79+0x550>
ffffffffc02065a8:	00004617          	auipc	a2,0x4
ffffffffc02065ac:	2a860613          	addi	a2,a2,680 # ffffffffc020a850 <commands+0x210>
ffffffffc02065b0:	07b00593          	li	a1,123
ffffffffc02065b4:	00006517          	auipc	a0,0x6
ffffffffc02065b8:	12c50513          	addi	a0,a0,300 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc02065bc:	ee3f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02065c0 <del_timer>:
ffffffffc02065c0:	1101                	addi	sp,sp,-32
ffffffffc02065c2:	e822                	sd	s0,16(sp)
ffffffffc02065c4:	ec06                	sd	ra,24(sp)
ffffffffc02065c6:	e426                	sd	s1,8(sp)
ffffffffc02065c8:	842a                	mv	s0,a0
ffffffffc02065ca:	100027f3          	csrr	a5,sstatus
ffffffffc02065ce:	8b89                	andi	a5,a5,2
ffffffffc02065d0:	01050493          	addi	s1,a0,16
ffffffffc02065d4:	eb9d                	bnez	a5,ffffffffc020660a <del_timer+0x4a>
ffffffffc02065d6:	6d1c                	ld	a5,24(a0)
ffffffffc02065d8:	02978463          	beq	a5,s1,ffffffffc0206600 <del_timer+0x40>
ffffffffc02065dc:	4114                	lw	a3,0(a0)
ffffffffc02065de:	6918                	ld	a4,16(a0)
ffffffffc02065e0:	ce81                	beqz	a3,ffffffffc02065f8 <del_timer+0x38>
ffffffffc02065e2:	0008e617          	auipc	a2,0x8e
ffffffffc02065e6:	20660613          	addi	a2,a2,518 # ffffffffc02947e8 <timer_list>
ffffffffc02065ea:	00c78763          	beq	a5,a2,ffffffffc02065f8 <del_timer+0x38>
ffffffffc02065ee:	ff07a603          	lw	a2,-16(a5)
ffffffffc02065f2:	9eb1                	addw	a3,a3,a2
ffffffffc02065f4:	fed7a823          	sw	a3,-16(a5)
ffffffffc02065f8:	e71c                	sd	a5,8(a4)
ffffffffc02065fa:	e398                	sd	a4,0(a5)
ffffffffc02065fc:	ec04                	sd	s1,24(s0)
ffffffffc02065fe:	e804                	sd	s1,16(s0)
ffffffffc0206600:	60e2                	ld	ra,24(sp)
ffffffffc0206602:	6442                	ld	s0,16(sp)
ffffffffc0206604:	64a2                	ld	s1,8(sp)
ffffffffc0206606:	6105                	addi	sp,sp,32
ffffffffc0206608:	8082                	ret
ffffffffc020660a:	e68fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020660e:	6c1c                	ld	a5,24(s0)
ffffffffc0206610:	02978463          	beq	a5,s1,ffffffffc0206638 <del_timer+0x78>
ffffffffc0206614:	4014                	lw	a3,0(s0)
ffffffffc0206616:	6818                	ld	a4,16(s0)
ffffffffc0206618:	ce81                	beqz	a3,ffffffffc0206630 <del_timer+0x70>
ffffffffc020661a:	0008e617          	auipc	a2,0x8e
ffffffffc020661e:	1ce60613          	addi	a2,a2,462 # ffffffffc02947e8 <timer_list>
ffffffffc0206622:	00c78763          	beq	a5,a2,ffffffffc0206630 <del_timer+0x70>
ffffffffc0206626:	ff07a603          	lw	a2,-16(a5)
ffffffffc020662a:	9eb1                	addw	a3,a3,a2
ffffffffc020662c:	fed7a823          	sw	a3,-16(a5)
ffffffffc0206630:	e71c                	sd	a5,8(a4)
ffffffffc0206632:	e398                	sd	a4,0(a5)
ffffffffc0206634:	ec04                	sd	s1,24(s0)
ffffffffc0206636:	e804                	sd	s1,16(s0)
ffffffffc0206638:	6442                	ld	s0,16(sp)
ffffffffc020663a:	60e2                	ld	ra,24(sp)
ffffffffc020663c:	64a2                	ld	s1,8(sp)
ffffffffc020663e:	6105                	addi	sp,sp,32
ffffffffc0206640:	e2cfa06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc0206644 <run_timer_list>:
ffffffffc0206644:	7139                	addi	sp,sp,-64
ffffffffc0206646:	fc06                	sd	ra,56(sp)
ffffffffc0206648:	f822                	sd	s0,48(sp)
ffffffffc020664a:	f426                	sd	s1,40(sp)
ffffffffc020664c:	f04a                	sd	s2,32(sp)
ffffffffc020664e:	ec4e                	sd	s3,24(sp)
ffffffffc0206650:	e852                	sd	s4,16(sp)
ffffffffc0206652:	e456                	sd	s5,8(sp)
ffffffffc0206654:	e05a                	sd	s6,0(sp)
ffffffffc0206656:	100027f3          	csrr	a5,sstatus
ffffffffc020665a:	8b89                	andi	a5,a5,2
ffffffffc020665c:	4b01                	li	s6,0
ffffffffc020665e:	efe9                	bnez	a5,ffffffffc0206738 <run_timer_list+0xf4>
ffffffffc0206660:	0008e997          	auipc	s3,0x8e
ffffffffc0206664:	18898993          	addi	s3,s3,392 # ffffffffc02947e8 <timer_list>
ffffffffc0206668:	0089b403          	ld	s0,8(s3)
ffffffffc020666c:	07340a63          	beq	s0,s3,ffffffffc02066e0 <run_timer_list+0x9c>
ffffffffc0206670:	ff042783          	lw	a5,-16(s0)
ffffffffc0206674:	ff040913          	addi	s2,s0,-16
ffffffffc0206678:	0e078763          	beqz	a5,ffffffffc0206766 <run_timer_list+0x122>
ffffffffc020667c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206680:	fee42823          	sw	a4,-16(s0)
ffffffffc0206684:	ef31                	bnez	a4,ffffffffc02066e0 <run_timer_list+0x9c>
ffffffffc0206686:	00006a97          	auipc	s5,0x6
ffffffffc020668a:	12aa8a93          	addi	s5,s5,298 # ffffffffc020c7b0 <CSWTCH.79+0x5b8>
ffffffffc020668e:	00006a17          	auipc	s4,0x6
ffffffffc0206692:	052a0a13          	addi	s4,s4,82 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc0206696:	a005                	j	ffffffffc02066b6 <run_timer_list+0x72>
ffffffffc0206698:	0a07d763          	bgez	a5,ffffffffc0206746 <run_timer_list+0x102>
ffffffffc020669c:	8526                	mv	a0,s1
ffffffffc020669e:	ce9ff0ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc02066a2:	854a                	mv	a0,s2
ffffffffc02066a4:	f1dff0ef          	jal	ra,ffffffffc02065c0 <del_timer>
ffffffffc02066a8:	03340c63          	beq	s0,s3,ffffffffc02066e0 <run_timer_list+0x9c>
ffffffffc02066ac:	ff042783          	lw	a5,-16(s0)
ffffffffc02066b0:	ff040913          	addi	s2,s0,-16
ffffffffc02066b4:	e795                	bnez	a5,ffffffffc02066e0 <run_timer_list+0x9c>
ffffffffc02066b6:	00893483          	ld	s1,8(s2)
ffffffffc02066ba:	6400                	ld	s0,8(s0)
ffffffffc02066bc:	0ec4a783          	lw	a5,236(s1)
ffffffffc02066c0:	ffe1                	bnez	a5,ffffffffc0206698 <run_timer_list+0x54>
ffffffffc02066c2:	40d4                	lw	a3,4(s1)
ffffffffc02066c4:	8656                	mv	a2,s5
ffffffffc02066c6:	0ba00593          	li	a1,186
ffffffffc02066ca:	8552                	mv	a0,s4
ffffffffc02066cc:	e3bf90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02066d0:	8526                	mv	a0,s1
ffffffffc02066d2:	cb5ff0ef          	jal	ra,ffffffffc0206386 <wakeup_proc>
ffffffffc02066d6:	854a                	mv	a0,s2
ffffffffc02066d8:	ee9ff0ef          	jal	ra,ffffffffc02065c0 <del_timer>
ffffffffc02066dc:	fd3418e3          	bne	s0,s3,ffffffffc02066ac <run_timer_list+0x68>
ffffffffc02066e0:	0008f597          	auipc	a1,0x8f
ffffffffc02066e4:	1d85b583          	ld	a1,472(a1) # ffffffffc02958b8 <current>
ffffffffc02066e8:	c18d                	beqz	a1,ffffffffc020670a <run_timer_list+0xc6>
ffffffffc02066ea:	0008f797          	auipc	a5,0x8f
ffffffffc02066ee:	1d67b783          	ld	a5,470(a5) # ffffffffc02958c0 <idleproc>
ffffffffc02066f2:	04f58763          	beq	a1,a5,ffffffffc0206740 <run_timer_list+0xfc>
ffffffffc02066f6:	0008f797          	auipc	a5,0x8f
ffffffffc02066fa:	1ea7b783          	ld	a5,490(a5) # ffffffffc02958e0 <sched_class>
ffffffffc02066fe:	779c                	ld	a5,40(a5)
ffffffffc0206700:	0008f517          	auipc	a0,0x8f
ffffffffc0206704:	1d853503          	ld	a0,472(a0) # ffffffffc02958d8 <rq>
ffffffffc0206708:	9782                	jalr	a5
ffffffffc020670a:	000b1c63          	bnez	s6,ffffffffc0206722 <run_timer_list+0xde>
ffffffffc020670e:	70e2                	ld	ra,56(sp)
ffffffffc0206710:	7442                	ld	s0,48(sp)
ffffffffc0206712:	74a2                	ld	s1,40(sp)
ffffffffc0206714:	7902                	ld	s2,32(sp)
ffffffffc0206716:	69e2                	ld	s3,24(sp)
ffffffffc0206718:	6a42                	ld	s4,16(sp)
ffffffffc020671a:	6aa2                	ld	s5,8(sp)
ffffffffc020671c:	6b02                	ld	s6,0(sp)
ffffffffc020671e:	6121                	addi	sp,sp,64
ffffffffc0206720:	8082                	ret
ffffffffc0206722:	7442                	ld	s0,48(sp)
ffffffffc0206724:	70e2                	ld	ra,56(sp)
ffffffffc0206726:	74a2                	ld	s1,40(sp)
ffffffffc0206728:	7902                	ld	s2,32(sp)
ffffffffc020672a:	69e2                	ld	s3,24(sp)
ffffffffc020672c:	6a42                	ld	s4,16(sp)
ffffffffc020672e:	6aa2                	ld	s5,8(sp)
ffffffffc0206730:	6b02                	ld	s6,0(sp)
ffffffffc0206732:	6121                	addi	sp,sp,64
ffffffffc0206734:	d38fa06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0206738:	d3afa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020673c:	4b05                	li	s6,1
ffffffffc020673e:	b70d                	j	ffffffffc0206660 <run_timer_list+0x1c>
ffffffffc0206740:	4785                	li	a5,1
ffffffffc0206742:	ed9c                	sd	a5,24(a1)
ffffffffc0206744:	b7d9                	j	ffffffffc020670a <run_timer_list+0xc6>
ffffffffc0206746:	00006697          	auipc	a3,0x6
ffffffffc020674a:	04268693          	addi	a3,a3,66 # ffffffffc020c788 <CSWTCH.79+0x590>
ffffffffc020674e:	00004617          	auipc	a2,0x4
ffffffffc0206752:	10260613          	addi	a2,a2,258 # ffffffffc020a850 <commands+0x210>
ffffffffc0206756:	0b600593          	li	a1,182
ffffffffc020675a:	00006517          	auipc	a0,0x6
ffffffffc020675e:	f8650513          	addi	a0,a0,-122 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc0206762:	d3df90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206766:	00006697          	auipc	a3,0x6
ffffffffc020676a:	00a68693          	addi	a3,a3,10 # ffffffffc020c770 <CSWTCH.79+0x578>
ffffffffc020676e:	00004617          	auipc	a2,0x4
ffffffffc0206772:	0e260613          	addi	a2,a2,226 # ffffffffc020a850 <commands+0x210>
ffffffffc0206776:	0ae00593          	li	a1,174
ffffffffc020677a:	00006517          	auipc	a0,0x6
ffffffffc020677e:	f6650513          	addi	a0,a0,-154 # ffffffffc020c6e0 <CSWTCH.79+0x4e8>
ffffffffc0206782:	d1df90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206786 <sys_getpid>:
ffffffffc0206786:	0008f797          	auipc	a5,0x8f
ffffffffc020678a:	1327b783          	ld	a5,306(a5) # ffffffffc02958b8 <current>
ffffffffc020678e:	43c8                	lw	a0,4(a5)
ffffffffc0206790:	8082                	ret

ffffffffc0206792 <sys_pgdir>:
ffffffffc0206792:	4501                	li	a0,0
ffffffffc0206794:	8082                	ret

ffffffffc0206796 <sys_gettime>:
ffffffffc0206796:	0008f797          	auipc	a5,0x8f
ffffffffc020679a:	0d27b783          	ld	a5,210(a5) # ffffffffc0295868 <ticks>
ffffffffc020679e:	0027951b          	slliw	a0,a5,0x2
ffffffffc02067a2:	9d3d                	addw	a0,a0,a5
ffffffffc02067a4:	0015151b          	slliw	a0,a0,0x1
ffffffffc02067a8:	8082                	ret

ffffffffc02067aa <sys_lab6_set_priority>:
ffffffffc02067aa:	4108                	lw	a0,0(a0)
ffffffffc02067ac:	1141                	addi	sp,sp,-16
ffffffffc02067ae:	e406                	sd	ra,8(sp)
ffffffffc02067b0:	9dfff0ef          	jal	ra,ffffffffc020618e <lab6_set_priority>
ffffffffc02067b4:	60a2                	ld	ra,8(sp)
ffffffffc02067b6:	4501                	li	a0,0
ffffffffc02067b8:	0141                	addi	sp,sp,16
ffffffffc02067ba:	8082                	ret

ffffffffc02067bc <sys_dup>:
ffffffffc02067bc:	450c                	lw	a1,8(a0)
ffffffffc02067be:	4108                	lw	a0,0(a0)
ffffffffc02067c0:	d5ffe06f          	j	ffffffffc020551e <sysfile_dup>

ffffffffc02067c4 <sys_getdirentry>:
ffffffffc02067c4:	650c                	ld	a1,8(a0)
ffffffffc02067c6:	4108                	lw	a0,0(a0)
ffffffffc02067c8:	c67fe06f          	j	ffffffffc020542e <sysfile_getdirentry>

ffffffffc02067cc <sys_getcwd>:
ffffffffc02067cc:	650c                	ld	a1,8(a0)
ffffffffc02067ce:	6108                	ld	a0,0(a0)
ffffffffc02067d0:	bbbfe06f          	j	ffffffffc020538a <sysfile_getcwd>

ffffffffc02067d4 <sys_fsync>:
ffffffffc02067d4:	4108                	lw	a0,0(a0)
ffffffffc02067d6:	bb1fe06f          	j	ffffffffc0205386 <sysfile_fsync>

ffffffffc02067da <sys_fstat>:
ffffffffc02067da:	650c                	ld	a1,8(a0)
ffffffffc02067dc:	4108                	lw	a0,0(a0)
ffffffffc02067de:	b09fe06f          	j	ffffffffc02052e6 <sysfile_fstat>

ffffffffc02067e2 <sys_seek>:
ffffffffc02067e2:	4910                	lw	a2,16(a0)
ffffffffc02067e4:	650c                	ld	a1,8(a0)
ffffffffc02067e6:	4108                	lw	a0,0(a0)
ffffffffc02067e8:	afbfe06f          	j	ffffffffc02052e2 <sysfile_seek>

ffffffffc02067ec <sys_write>:
ffffffffc02067ec:	6910                	ld	a2,16(a0)
ffffffffc02067ee:	650c                	ld	a1,8(a0)
ffffffffc02067f0:	4108                	lw	a0,0(a0)
ffffffffc02067f2:	9d7fe06f          	j	ffffffffc02051c8 <sysfile_write>

ffffffffc02067f6 <sys_read>:
ffffffffc02067f6:	6910                	ld	a2,16(a0)
ffffffffc02067f8:	650c                	ld	a1,8(a0)
ffffffffc02067fa:	4108                	lw	a0,0(a0)
ffffffffc02067fc:	8b9fe06f          	j	ffffffffc02050b4 <sysfile_read>

ffffffffc0206800 <sys_close>:
ffffffffc0206800:	4108                	lw	a0,0(a0)
ffffffffc0206802:	8affe06f          	j	ffffffffc02050b0 <sysfile_close>

ffffffffc0206806 <sys_open>:
ffffffffc0206806:	450c                	lw	a1,8(a0)
ffffffffc0206808:	6108                	ld	a0,0(a0)
ffffffffc020680a:	873fe06f          	j	ffffffffc020507c <sysfile_open>

ffffffffc020680e <sys_putc>:
ffffffffc020680e:	4108                	lw	a0,0(a0)
ffffffffc0206810:	1141                	addi	sp,sp,-16
ffffffffc0206812:	e406                	sd	ra,8(sp)
ffffffffc0206814:	9cff90ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0206818:	60a2                	ld	ra,8(sp)
ffffffffc020681a:	4501                	li	a0,0
ffffffffc020681c:	0141                	addi	sp,sp,16
ffffffffc020681e:	8082                	ret

ffffffffc0206820 <sys_kill>:
ffffffffc0206820:	4108                	lw	a0,0(a0)
ffffffffc0206822:	e84ff06f          	j	ffffffffc0205ea6 <do_kill>

ffffffffc0206826 <sys_sleep>:
ffffffffc0206826:	4108                	lw	a0,0(a0)
ffffffffc0206828:	9a1ff06f          	j	ffffffffc02061c8 <do_sleep>

ffffffffc020682c <sys_yield>:
ffffffffc020682c:	e2cff06f          	j	ffffffffc0205e58 <do_yield>

ffffffffc0206830 <sys_exec>:
ffffffffc0206830:	6910                	ld	a2,16(a0)
ffffffffc0206832:	450c                	lw	a1,8(a0)
ffffffffc0206834:	6108                	ld	a0,0(a0)
ffffffffc0206836:	b38ff06f          	j	ffffffffc0205b6e <do_execve>

ffffffffc020683a <sys_wait>:
ffffffffc020683a:	650c                	ld	a1,8(a0)
ffffffffc020683c:	4108                	lw	a0,0(a0)
ffffffffc020683e:	e2aff06f          	j	ffffffffc0205e68 <do_wait>

ffffffffc0206842 <sys_fork>:
ffffffffc0206842:	0008f797          	auipc	a5,0x8f
ffffffffc0206846:	0767b783          	ld	a5,118(a5) # ffffffffc02958b8 <current>
ffffffffc020684a:	73d0                	ld	a2,160(a5)
ffffffffc020684c:	4501                	li	a0,0
ffffffffc020684e:	6a0c                	ld	a1,16(a2)
ffffffffc0206850:	d53fe06f          	j	ffffffffc02055a2 <do_fork>

ffffffffc0206854 <sys_exit>:
ffffffffc0206854:	4108                	lw	a0,0(a0)
ffffffffc0206856:	e95fe06f          	j	ffffffffc02056ea <do_exit>

ffffffffc020685a <syscall>:
ffffffffc020685a:	715d                	addi	sp,sp,-80
ffffffffc020685c:	fc26                	sd	s1,56(sp)
ffffffffc020685e:	0008f497          	auipc	s1,0x8f
ffffffffc0206862:	05a48493          	addi	s1,s1,90 # ffffffffc02958b8 <current>
ffffffffc0206866:	6098                	ld	a4,0(s1)
ffffffffc0206868:	e0a2                	sd	s0,64(sp)
ffffffffc020686a:	f84a                	sd	s2,48(sp)
ffffffffc020686c:	7340                	ld	s0,160(a4)
ffffffffc020686e:	e486                	sd	ra,72(sp)
ffffffffc0206870:	0ff00793          	li	a5,255
ffffffffc0206874:	05042903          	lw	s2,80(s0)
ffffffffc0206878:	0327ee63          	bltu	a5,s2,ffffffffc02068b4 <syscall+0x5a>
ffffffffc020687c:	00391713          	slli	a4,s2,0x3
ffffffffc0206880:	00006797          	auipc	a5,0x6
ffffffffc0206884:	f9878793          	addi	a5,a5,-104 # ffffffffc020c818 <syscalls>
ffffffffc0206888:	97ba                	add	a5,a5,a4
ffffffffc020688a:	639c                	ld	a5,0(a5)
ffffffffc020688c:	c785                	beqz	a5,ffffffffc02068b4 <syscall+0x5a>
ffffffffc020688e:	6c28                	ld	a0,88(s0)
ffffffffc0206890:	702c                	ld	a1,96(s0)
ffffffffc0206892:	7430                	ld	a2,104(s0)
ffffffffc0206894:	7834                	ld	a3,112(s0)
ffffffffc0206896:	7c38                	ld	a4,120(s0)
ffffffffc0206898:	e42a                	sd	a0,8(sp)
ffffffffc020689a:	e82e                	sd	a1,16(sp)
ffffffffc020689c:	ec32                	sd	a2,24(sp)
ffffffffc020689e:	f036                	sd	a3,32(sp)
ffffffffc02068a0:	f43a                	sd	a4,40(sp)
ffffffffc02068a2:	0028                	addi	a0,sp,8
ffffffffc02068a4:	9782                	jalr	a5
ffffffffc02068a6:	60a6                	ld	ra,72(sp)
ffffffffc02068a8:	e828                	sd	a0,80(s0)
ffffffffc02068aa:	6406                	ld	s0,64(sp)
ffffffffc02068ac:	74e2                	ld	s1,56(sp)
ffffffffc02068ae:	7942                	ld	s2,48(sp)
ffffffffc02068b0:	6161                	addi	sp,sp,80
ffffffffc02068b2:	8082                	ret
ffffffffc02068b4:	8522                	mv	a0,s0
ffffffffc02068b6:	ed4fa0ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc02068ba:	609c                	ld	a5,0(s1)
ffffffffc02068bc:	86ca                	mv	a3,s2
ffffffffc02068be:	00006617          	auipc	a2,0x6
ffffffffc02068c2:	f1260613          	addi	a2,a2,-238 # ffffffffc020c7d0 <CSWTCH.79+0x5d8>
ffffffffc02068c6:	43d8                	lw	a4,4(a5)
ffffffffc02068c8:	0d800593          	li	a1,216
ffffffffc02068cc:	0b478793          	addi	a5,a5,180
ffffffffc02068d0:	00006517          	auipc	a0,0x6
ffffffffc02068d4:	f3050513          	addi	a0,a0,-208 # ffffffffc020c800 <CSWTCH.79+0x608>
ffffffffc02068d8:	bc7f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02068dc <__alloc_inode>:
ffffffffc02068dc:	1141                	addi	sp,sp,-16
ffffffffc02068de:	e022                	sd	s0,0(sp)
ffffffffc02068e0:	842a                	mv	s0,a0
ffffffffc02068e2:	07800513          	li	a0,120
ffffffffc02068e6:	e406                	sd	ra,8(sp)
ffffffffc02068e8:	ea6fb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02068ec:	c111                	beqz	a0,ffffffffc02068f0 <__alloc_inode+0x14>
ffffffffc02068ee:	cd20                	sw	s0,88(a0)
ffffffffc02068f0:	60a2                	ld	ra,8(sp)
ffffffffc02068f2:	6402                	ld	s0,0(sp)
ffffffffc02068f4:	0141                	addi	sp,sp,16
ffffffffc02068f6:	8082                	ret

ffffffffc02068f8 <inode_init>:
ffffffffc02068f8:	4785                	li	a5,1
ffffffffc02068fa:	06052023          	sw	zero,96(a0)
ffffffffc02068fe:	f92c                	sd	a1,112(a0)
ffffffffc0206900:	f530                	sd	a2,104(a0)
ffffffffc0206902:	cd7c                	sw	a5,92(a0)
ffffffffc0206904:	8082                	ret

ffffffffc0206906 <inode_kill>:
ffffffffc0206906:	4d78                	lw	a4,92(a0)
ffffffffc0206908:	1141                	addi	sp,sp,-16
ffffffffc020690a:	e406                	sd	ra,8(sp)
ffffffffc020690c:	e719                	bnez	a4,ffffffffc020691a <inode_kill+0x14>
ffffffffc020690e:	513c                	lw	a5,96(a0)
ffffffffc0206910:	e78d                	bnez	a5,ffffffffc020693a <inode_kill+0x34>
ffffffffc0206912:	60a2                	ld	ra,8(sp)
ffffffffc0206914:	0141                	addi	sp,sp,16
ffffffffc0206916:	f28fb06f          	j	ffffffffc020203e <kfree>
ffffffffc020691a:	00006697          	auipc	a3,0x6
ffffffffc020691e:	6fe68693          	addi	a3,a3,1790 # ffffffffc020d018 <syscalls+0x800>
ffffffffc0206922:	00004617          	auipc	a2,0x4
ffffffffc0206926:	f2e60613          	addi	a2,a2,-210 # ffffffffc020a850 <commands+0x210>
ffffffffc020692a:	02900593          	li	a1,41
ffffffffc020692e:	00006517          	auipc	a0,0x6
ffffffffc0206932:	70a50513          	addi	a0,a0,1802 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206936:	b69f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020693a:	00006697          	auipc	a3,0x6
ffffffffc020693e:	71668693          	addi	a3,a3,1814 # ffffffffc020d050 <syscalls+0x838>
ffffffffc0206942:	00004617          	auipc	a2,0x4
ffffffffc0206946:	f0e60613          	addi	a2,a2,-242 # ffffffffc020a850 <commands+0x210>
ffffffffc020694a:	02a00593          	li	a1,42
ffffffffc020694e:	00006517          	auipc	a0,0x6
ffffffffc0206952:	6ea50513          	addi	a0,a0,1770 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206956:	b49f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020695a <inode_ref_inc>:
ffffffffc020695a:	4d7c                	lw	a5,92(a0)
ffffffffc020695c:	2785                	addiw	a5,a5,1
ffffffffc020695e:	cd7c                	sw	a5,92(a0)
ffffffffc0206960:	0007851b          	sext.w	a0,a5
ffffffffc0206964:	8082                	ret

ffffffffc0206966 <inode_open_inc>:
ffffffffc0206966:	513c                	lw	a5,96(a0)
ffffffffc0206968:	2785                	addiw	a5,a5,1
ffffffffc020696a:	d13c                	sw	a5,96(a0)
ffffffffc020696c:	0007851b          	sext.w	a0,a5
ffffffffc0206970:	8082                	ret

ffffffffc0206972 <inode_check>:
ffffffffc0206972:	1141                	addi	sp,sp,-16
ffffffffc0206974:	e406                	sd	ra,8(sp)
ffffffffc0206976:	c90d                	beqz	a0,ffffffffc02069a8 <inode_check+0x36>
ffffffffc0206978:	793c                	ld	a5,112(a0)
ffffffffc020697a:	c79d                	beqz	a5,ffffffffc02069a8 <inode_check+0x36>
ffffffffc020697c:	6398                	ld	a4,0(a5)
ffffffffc020697e:	4625d7b7          	lui	a5,0x4625d
ffffffffc0206982:	0786                	slli	a5,a5,0x1
ffffffffc0206984:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc0206988:	08f71063          	bne	a4,a5,ffffffffc0206a08 <inode_check+0x96>
ffffffffc020698c:	4d78                	lw	a4,92(a0)
ffffffffc020698e:	513c                	lw	a5,96(a0)
ffffffffc0206990:	04f74c63          	blt	a4,a5,ffffffffc02069e8 <inode_check+0x76>
ffffffffc0206994:	0407ca63          	bltz	a5,ffffffffc02069e8 <inode_check+0x76>
ffffffffc0206998:	66c1                	lui	a3,0x10
ffffffffc020699a:	02d75763          	bge	a4,a3,ffffffffc02069c8 <inode_check+0x56>
ffffffffc020699e:	02d7d563          	bge	a5,a3,ffffffffc02069c8 <inode_check+0x56>
ffffffffc02069a2:	60a2                	ld	ra,8(sp)
ffffffffc02069a4:	0141                	addi	sp,sp,16
ffffffffc02069a6:	8082                	ret
ffffffffc02069a8:	00006697          	auipc	a3,0x6
ffffffffc02069ac:	6c868693          	addi	a3,a3,1736 # ffffffffc020d070 <syscalls+0x858>
ffffffffc02069b0:	00004617          	auipc	a2,0x4
ffffffffc02069b4:	ea060613          	addi	a2,a2,-352 # ffffffffc020a850 <commands+0x210>
ffffffffc02069b8:	06e00593          	li	a1,110
ffffffffc02069bc:	00006517          	auipc	a0,0x6
ffffffffc02069c0:	67c50513          	addi	a0,a0,1660 # ffffffffc020d038 <syscalls+0x820>
ffffffffc02069c4:	adbf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02069c8:	00006697          	auipc	a3,0x6
ffffffffc02069cc:	72868693          	addi	a3,a3,1832 # ffffffffc020d0f0 <syscalls+0x8d8>
ffffffffc02069d0:	00004617          	auipc	a2,0x4
ffffffffc02069d4:	e8060613          	addi	a2,a2,-384 # ffffffffc020a850 <commands+0x210>
ffffffffc02069d8:	07200593          	li	a1,114
ffffffffc02069dc:	00006517          	auipc	a0,0x6
ffffffffc02069e0:	65c50513          	addi	a0,a0,1628 # ffffffffc020d038 <syscalls+0x820>
ffffffffc02069e4:	abbf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02069e8:	00006697          	auipc	a3,0x6
ffffffffc02069ec:	6d868693          	addi	a3,a3,1752 # ffffffffc020d0c0 <syscalls+0x8a8>
ffffffffc02069f0:	00004617          	auipc	a2,0x4
ffffffffc02069f4:	e6060613          	addi	a2,a2,-416 # ffffffffc020a850 <commands+0x210>
ffffffffc02069f8:	07100593          	li	a1,113
ffffffffc02069fc:	00006517          	auipc	a0,0x6
ffffffffc0206a00:	63c50513          	addi	a0,a0,1596 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206a04:	a9bf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206a08:	00006697          	auipc	a3,0x6
ffffffffc0206a0c:	69068693          	addi	a3,a3,1680 # ffffffffc020d098 <syscalls+0x880>
ffffffffc0206a10:	00004617          	auipc	a2,0x4
ffffffffc0206a14:	e4060613          	addi	a2,a2,-448 # ffffffffc020a850 <commands+0x210>
ffffffffc0206a18:	06f00593          	li	a1,111
ffffffffc0206a1c:	00006517          	auipc	a0,0x6
ffffffffc0206a20:	61c50513          	addi	a0,a0,1564 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206a24:	a7bf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206a28 <inode_ref_dec>:
ffffffffc0206a28:	4d7c                	lw	a5,92(a0)
ffffffffc0206a2a:	1101                	addi	sp,sp,-32
ffffffffc0206a2c:	ec06                	sd	ra,24(sp)
ffffffffc0206a2e:	e822                	sd	s0,16(sp)
ffffffffc0206a30:	e426                	sd	s1,8(sp)
ffffffffc0206a32:	e04a                	sd	s2,0(sp)
ffffffffc0206a34:	06f05e63          	blez	a5,ffffffffc0206ab0 <inode_ref_dec+0x88>
ffffffffc0206a38:	fff7849b          	addiw	s1,a5,-1
ffffffffc0206a3c:	cd64                	sw	s1,92(a0)
ffffffffc0206a3e:	842a                	mv	s0,a0
ffffffffc0206a40:	e09d                	bnez	s1,ffffffffc0206a66 <inode_ref_dec+0x3e>
ffffffffc0206a42:	793c                	ld	a5,112(a0)
ffffffffc0206a44:	c7b1                	beqz	a5,ffffffffc0206a90 <inode_ref_dec+0x68>
ffffffffc0206a46:	0487b903          	ld	s2,72(a5)
ffffffffc0206a4a:	04090363          	beqz	s2,ffffffffc0206a90 <inode_ref_dec+0x68>
ffffffffc0206a4e:	00006597          	auipc	a1,0x6
ffffffffc0206a52:	75258593          	addi	a1,a1,1874 # ffffffffc020d1a0 <syscalls+0x988>
ffffffffc0206a56:	f1dff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0206a5a:	8522                	mv	a0,s0
ffffffffc0206a5c:	9902                	jalr	s2
ffffffffc0206a5e:	c501                	beqz	a0,ffffffffc0206a66 <inode_ref_dec+0x3e>
ffffffffc0206a60:	57c5                	li	a5,-15
ffffffffc0206a62:	00f51963          	bne	a0,a5,ffffffffc0206a74 <inode_ref_dec+0x4c>
ffffffffc0206a66:	60e2                	ld	ra,24(sp)
ffffffffc0206a68:	6442                	ld	s0,16(sp)
ffffffffc0206a6a:	6902                	ld	s2,0(sp)
ffffffffc0206a6c:	8526                	mv	a0,s1
ffffffffc0206a6e:	64a2                	ld	s1,8(sp)
ffffffffc0206a70:	6105                	addi	sp,sp,32
ffffffffc0206a72:	8082                	ret
ffffffffc0206a74:	85aa                	mv	a1,a0
ffffffffc0206a76:	00006517          	auipc	a0,0x6
ffffffffc0206a7a:	73250513          	addi	a0,a0,1842 # ffffffffc020d1a8 <syscalls+0x990>
ffffffffc0206a7e:	f28f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206a82:	60e2                	ld	ra,24(sp)
ffffffffc0206a84:	6442                	ld	s0,16(sp)
ffffffffc0206a86:	6902                	ld	s2,0(sp)
ffffffffc0206a88:	8526                	mv	a0,s1
ffffffffc0206a8a:	64a2                	ld	s1,8(sp)
ffffffffc0206a8c:	6105                	addi	sp,sp,32
ffffffffc0206a8e:	8082                	ret
ffffffffc0206a90:	00006697          	auipc	a3,0x6
ffffffffc0206a94:	6c068693          	addi	a3,a3,1728 # ffffffffc020d150 <syscalls+0x938>
ffffffffc0206a98:	00004617          	auipc	a2,0x4
ffffffffc0206a9c:	db860613          	addi	a2,a2,-584 # ffffffffc020a850 <commands+0x210>
ffffffffc0206aa0:	04400593          	li	a1,68
ffffffffc0206aa4:	00006517          	auipc	a0,0x6
ffffffffc0206aa8:	59450513          	addi	a0,a0,1428 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206aac:	9f3f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ab0:	00006697          	auipc	a3,0x6
ffffffffc0206ab4:	68068693          	addi	a3,a3,1664 # ffffffffc020d130 <syscalls+0x918>
ffffffffc0206ab8:	00004617          	auipc	a2,0x4
ffffffffc0206abc:	d9860613          	addi	a2,a2,-616 # ffffffffc020a850 <commands+0x210>
ffffffffc0206ac0:	03f00593          	li	a1,63
ffffffffc0206ac4:	00006517          	auipc	a0,0x6
ffffffffc0206ac8:	57450513          	addi	a0,a0,1396 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206acc:	9d3f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206ad0 <inode_open_dec>:
ffffffffc0206ad0:	513c                	lw	a5,96(a0)
ffffffffc0206ad2:	1101                	addi	sp,sp,-32
ffffffffc0206ad4:	ec06                	sd	ra,24(sp)
ffffffffc0206ad6:	e822                	sd	s0,16(sp)
ffffffffc0206ad8:	e426                	sd	s1,8(sp)
ffffffffc0206ada:	e04a                	sd	s2,0(sp)
ffffffffc0206adc:	06f05b63          	blez	a5,ffffffffc0206b52 <inode_open_dec+0x82>
ffffffffc0206ae0:	fff7849b          	addiw	s1,a5,-1
ffffffffc0206ae4:	d124                	sw	s1,96(a0)
ffffffffc0206ae6:	842a                	mv	s0,a0
ffffffffc0206ae8:	e085                	bnez	s1,ffffffffc0206b08 <inode_open_dec+0x38>
ffffffffc0206aea:	793c                	ld	a5,112(a0)
ffffffffc0206aec:	c3b9                	beqz	a5,ffffffffc0206b32 <inode_open_dec+0x62>
ffffffffc0206aee:	0107b903          	ld	s2,16(a5)
ffffffffc0206af2:	04090063          	beqz	s2,ffffffffc0206b32 <inode_open_dec+0x62>
ffffffffc0206af6:	00006597          	auipc	a1,0x6
ffffffffc0206afa:	74258593          	addi	a1,a1,1858 # ffffffffc020d238 <syscalls+0xa20>
ffffffffc0206afe:	e75ff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0206b02:	8522                	mv	a0,s0
ffffffffc0206b04:	9902                	jalr	s2
ffffffffc0206b06:	e901                	bnez	a0,ffffffffc0206b16 <inode_open_dec+0x46>
ffffffffc0206b08:	60e2                	ld	ra,24(sp)
ffffffffc0206b0a:	6442                	ld	s0,16(sp)
ffffffffc0206b0c:	6902                	ld	s2,0(sp)
ffffffffc0206b0e:	8526                	mv	a0,s1
ffffffffc0206b10:	64a2                	ld	s1,8(sp)
ffffffffc0206b12:	6105                	addi	sp,sp,32
ffffffffc0206b14:	8082                	ret
ffffffffc0206b16:	85aa                	mv	a1,a0
ffffffffc0206b18:	00006517          	auipc	a0,0x6
ffffffffc0206b1c:	72850513          	addi	a0,a0,1832 # ffffffffc020d240 <syscalls+0xa28>
ffffffffc0206b20:	e86f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206b24:	60e2                	ld	ra,24(sp)
ffffffffc0206b26:	6442                	ld	s0,16(sp)
ffffffffc0206b28:	6902                	ld	s2,0(sp)
ffffffffc0206b2a:	8526                	mv	a0,s1
ffffffffc0206b2c:	64a2                	ld	s1,8(sp)
ffffffffc0206b2e:	6105                	addi	sp,sp,32
ffffffffc0206b30:	8082                	ret
ffffffffc0206b32:	00006697          	auipc	a3,0x6
ffffffffc0206b36:	6b668693          	addi	a3,a3,1718 # ffffffffc020d1e8 <syscalls+0x9d0>
ffffffffc0206b3a:	00004617          	auipc	a2,0x4
ffffffffc0206b3e:	d1660613          	addi	a2,a2,-746 # ffffffffc020a850 <commands+0x210>
ffffffffc0206b42:	06100593          	li	a1,97
ffffffffc0206b46:	00006517          	auipc	a0,0x6
ffffffffc0206b4a:	4f250513          	addi	a0,a0,1266 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206b4e:	951f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206b52:	00006697          	auipc	a3,0x6
ffffffffc0206b56:	67668693          	addi	a3,a3,1654 # ffffffffc020d1c8 <syscalls+0x9b0>
ffffffffc0206b5a:	00004617          	auipc	a2,0x4
ffffffffc0206b5e:	cf660613          	addi	a2,a2,-778 # ffffffffc020a850 <commands+0x210>
ffffffffc0206b62:	05c00593          	li	a1,92
ffffffffc0206b66:	00006517          	auipc	a0,0x6
ffffffffc0206b6a:	4d250513          	addi	a0,a0,1234 # ffffffffc020d038 <syscalls+0x820>
ffffffffc0206b6e:	931f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206b72 <__alloc_fs>:
ffffffffc0206b72:	1141                	addi	sp,sp,-16
ffffffffc0206b74:	e022                	sd	s0,0(sp)
ffffffffc0206b76:	842a                	mv	s0,a0
ffffffffc0206b78:	0d800513          	li	a0,216
ffffffffc0206b7c:	e406                	sd	ra,8(sp)
ffffffffc0206b7e:	c10fb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206b82:	c119                	beqz	a0,ffffffffc0206b88 <__alloc_fs+0x16>
ffffffffc0206b84:	0a852823          	sw	s0,176(a0)
ffffffffc0206b88:	60a2                	ld	ra,8(sp)
ffffffffc0206b8a:	6402                	ld	s0,0(sp)
ffffffffc0206b8c:	0141                	addi	sp,sp,16
ffffffffc0206b8e:	8082                	ret

ffffffffc0206b90 <vfs_init>:
ffffffffc0206b90:	1141                	addi	sp,sp,-16
ffffffffc0206b92:	4585                	li	a1,1
ffffffffc0206b94:	0008e517          	auipc	a0,0x8e
ffffffffc0206b98:	c6450513          	addi	a0,a0,-924 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206b9c:	e406                	sd	ra,8(sp)
ffffffffc0206b9e:	d12fd0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0206ba2:	60a2                	ld	ra,8(sp)
ffffffffc0206ba4:	0141                	addi	sp,sp,16
ffffffffc0206ba6:	a40d                	j	ffffffffc0206dc8 <vfs_devlist_init>

ffffffffc0206ba8 <vfs_set_bootfs>:
ffffffffc0206ba8:	7179                	addi	sp,sp,-48
ffffffffc0206baa:	f022                	sd	s0,32(sp)
ffffffffc0206bac:	f406                	sd	ra,40(sp)
ffffffffc0206bae:	ec26                	sd	s1,24(sp)
ffffffffc0206bb0:	e402                	sd	zero,8(sp)
ffffffffc0206bb2:	842a                	mv	s0,a0
ffffffffc0206bb4:	c915                	beqz	a0,ffffffffc0206be8 <vfs_set_bootfs+0x40>
ffffffffc0206bb6:	03a00593          	li	a1,58
ffffffffc0206bba:	798030ef          	jal	ra,ffffffffc020a352 <strchr>
ffffffffc0206bbe:	c135                	beqz	a0,ffffffffc0206c22 <vfs_set_bootfs+0x7a>
ffffffffc0206bc0:	00154783          	lbu	a5,1(a0)
ffffffffc0206bc4:	efb9                	bnez	a5,ffffffffc0206c22 <vfs_set_bootfs+0x7a>
ffffffffc0206bc6:	8522                	mv	a0,s0
ffffffffc0206bc8:	11f000ef          	jal	ra,ffffffffc02074e6 <vfs_chdir>
ffffffffc0206bcc:	842a                	mv	s0,a0
ffffffffc0206bce:	c519                	beqz	a0,ffffffffc0206bdc <vfs_set_bootfs+0x34>
ffffffffc0206bd0:	70a2                	ld	ra,40(sp)
ffffffffc0206bd2:	8522                	mv	a0,s0
ffffffffc0206bd4:	7402                	ld	s0,32(sp)
ffffffffc0206bd6:	64e2                	ld	s1,24(sp)
ffffffffc0206bd8:	6145                	addi	sp,sp,48
ffffffffc0206bda:	8082                	ret
ffffffffc0206bdc:	0028                	addi	a0,sp,8
ffffffffc0206bde:	013000ef          	jal	ra,ffffffffc02073f0 <vfs_get_curdir>
ffffffffc0206be2:	842a                	mv	s0,a0
ffffffffc0206be4:	f575                	bnez	a0,ffffffffc0206bd0 <vfs_set_bootfs+0x28>
ffffffffc0206be6:	6422                	ld	s0,8(sp)
ffffffffc0206be8:	0008e517          	auipc	a0,0x8e
ffffffffc0206bec:	c1050513          	addi	a0,a0,-1008 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206bf0:	ccafd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206bf4:	0008f797          	auipc	a5,0x8f
ffffffffc0206bf8:	cf478793          	addi	a5,a5,-780 # ffffffffc02958e8 <bootfs_node>
ffffffffc0206bfc:	6384                	ld	s1,0(a5)
ffffffffc0206bfe:	0008e517          	auipc	a0,0x8e
ffffffffc0206c02:	bfa50513          	addi	a0,a0,-1030 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206c06:	e380                	sd	s0,0(a5)
ffffffffc0206c08:	4401                	li	s0,0
ffffffffc0206c0a:	cacfd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206c0e:	d0e9                	beqz	s1,ffffffffc0206bd0 <vfs_set_bootfs+0x28>
ffffffffc0206c10:	8526                	mv	a0,s1
ffffffffc0206c12:	e17ff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0206c16:	70a2                	ld	ra,40(sp)
ffffffffc0206c18:	8522                	mv	a0,s0
ffffffffc0206c1a:	7402                	ld	s0,32(sp)
ffffffffc0206c1c:	64e2                	ld	s1,24(sp)
ffffffffc0206c1e:	6145                	addi	sp,sp,48
ffffffffc0206c20:	8082                	ret
ffffffffc0206c22:	5475                	li	s0,-3
ffffffffc0206c24:	b775                	j	ffffffffc0206bd0 <vfs_set_bootfs+0x28>

ffffffffc0206c26 <vfs_get_bootfs>:
ffffffffc0206c26:	1101                	addi	sp,sp,-32
ffffffffc0206c28:	e426                	sd	s1,8(sp)
ffffffffc0206c2a:	0008f497          	auipc	s1,0x8f
ffffffffc0206c2e:	cbe48493          	addi	s1,s1,-834 # ffffffffc02958e8 <bootfs_node>
ffffffffc0206c32:	609c                	ld	a5,0(s1)
ffffffffc0206c34:	ec06                	sd	ra,24(sp)
ffffffffc0206c36:	e822                	sd	s0,16(sp)
ffffffffc0206c38:	c3a1                	beqz	a5,ffffffffc0206c78 <vfs_get_bootfs+0x52>
ffffffffc0206c3a:	842a                	mv	s0,a0
ffffffffc0206c3c:	0008e517          	auipc	a0,0x8e
ffffffffc0206c40:	bbc50513          	addi	a0,a0,-1092 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206c44:	c76fd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206c48:	6084                	ld	s1,0(s1)
ffffffffc0206c4a:	c08d                	beqz	s1,ffffffffc0206c6c <vfs_get_bootfs+0x46>
ffffffffc0206c4c:	8526                	mv	a0,s1
ffffffffc0206c4e:	d0dff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0206c52:	0008e517          	auipc	a0,0x8e
ffffffffc0206c56:	ba650513          	addi	a0,a0,-1114 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206c5a:	c5cfd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206c5e:	4501                	li	a0,0
ffffffffc0206c60:	e004                	sd	s1,0(s0)
ffffffffc0206c62:	60e2                	ld	ra,24(sp)
ffffffffc0206c64:	6442                	ld	s0,16(sp)
ffffffffc0206c66:	64a2                	ld	s1,8(sp)
ffffffffc0206c68:	6105                	addi	sp,sp,32
ffffffffc0206c6a:	8082                	ret
ffffffffc0206c6c:	0008e517          	auipc	a0,0x8e
ffffffffc0206c70:	b8c50513          	addi	a0,a0,-1140 # ffffffffc02947f8 <bootfs_sem>
ffffffffc0206c74:	c42fd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206c78:	5541                	li	a0,-16
ffffffffc0206c7a:	b7e5                	j	ffffffffc0206c62 <vfs_get_bootfs+0x3c>

ffffffffc0206c7c <vfs_do_add>:
ffffffffc0206c7c:	7139                	addi	sp,sp,-64
ffffffffc0206c7e:	fc06                	sd	ra,56(sp)
ffffffffc0206c80:	f822                	sd	s0,48(sp)
ffffffffc0206c82:	f426                	sd	s1,40(sp)
ffffffffc0206c84:	f04a                	sd	s2,32(sp)
ffffffffc0206c86:	ec4e                	sd	s3,24(sp)
ffffffffc0206c88:	e852                	sd	s4,16(sp)
ffffffffc0206c8a:	e456                	sd	s5,8(sp)
ffffffffc0206c8c:	e05a                	sd	s6,0(sp)
ffffffffc0206c8e:	0e050b63          	beqz	a0,ffffffffc0206d84 <vfs_do_add+0x108>
ffffffffc0206c92:	842a                	mv	s0,a0
ffffffffc0206c94:	8a2e                	mv	s4,a1
ffffffffc0206c96:	8b32                	mv	s6,a2
ffffffffc0206c98:	8ab6                	mv	s5,a3
ffffffffc0206c9a:	c5cd                	beqz	a1,ffffffffc0206d44 <vfs_do_add+0xc8>
ffffffffc0206c9c:	4db8                	lw	a4,88(a1)
ffffffffc0206c9e:	6785                	lui	a5,0x1
ffffffffc0206ca0:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0206ca4:	0af71163          	bne	a4,a5,ffffffffc0206d46 <vfs_do_add+0xca>
ffffffffc0206ca8:	8522                	mv	a0,s0
ffffffffc0206caa:	61c030ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc0206cae:	47fd                	li	a5,31
ffffffffc0206cb0:	0ca7e663          	bltu	a5,a0,ffffffffc0206d7c <vfs_do_add+0x100>
ffffffffc0206cb4:	8522                	mv	a0,s0
ffffffffc0206cb6:	d3ef90ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0206cba:	84aa                	mv	s1,a0
ffffffffc0206cbc:	c171                	beqz	a0,ffffffffc0206d80 <vfs_do_add+0x104>
ffffffffc0206cbe:	03000513          	li	a0,48
ffffffffc0206cc2:	accfb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206cc6:	89aa                	mv	s3,a0
ffffffffc0206cc8:	c92d                	beqz	a0,ffffffffc0206d3a <vfs_do_add+0xbe>
ffffffffc0206cca:	0008e517          	auipc	a0,0x8e
ffffffffc0206cce:	b5650513          	addi	a0,a0,-1194 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206cd2:	0008e917          	auipc	s2,0x8e
ffffffffc0206cd6:	b3e90913          	addi	s2,s2,-1218 # ffffffffc0294810 <vdev_list>
ffffffffc0206cda:	be0fd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206cde:	844a                	mv	s0,s2
ffffffffc0206ce0:	a039                	j	ffffffffc0206cee <vfs_do_add+0x72>
ffffffffc0206ce2:	fe043503          	ld	a0,-32(s0)
ffffffffc0206ce6:	85a6                	mv	a1,s1
ffffffffc0206ce8:	626030ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc0206cec:	cd2d                	beqz	a0,ffffffffc0206d66 <vfs_do_add+0xea>
ffffffffc0206cee:	6400                	ld	s0,8(s0)
ffffffffc0206cf0:	ff2419e3          	bne	s0,s2,ffffffffc0206ce2 <vfs_do_add+0x66>
ffffffffc0206cf4:	6418                	ld	a4,8(s0)
ffffffffc0206cf6:	02098793          	addi	a5,s3,32
ffffffffc0206cfa:	0099b023          	sd	s1,0(s3)
ffffffffc0206cfe:	0149b423          	sd	s4,8(s3)
ffffffffc0206d02:	0159bc23          	sd	s5,24(s3)
ffffffffc0206d06:	0169b823          	sd	s6,16(s3)
ffffffffc0206d0a:	e31c                	sd	a5,0(a4)
ffffffffc0206d0c:	0289b023          	sd	s0,32(s3)
ffffffffc0206d10:	02e9b423          	sd	a4,40(s3)
ffffffffc0206d14:	0008e517          	auipc	a0,0x8e
ffffffffc0206d18:	b0c50513          	addi	a0,a0,-1268 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206d1c:	e41c                	sd	a5,8(s0)
ffffffffc0206d1e:	4401                	li	s0,0
ffffffffc0206d20:	b96fd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206d24:	70e2                	ld	ra,56(sp)
ffffffffc0206d26:	8522                	mv	a0,s0
ffffffffc0206d28:	7442                	ld	s0,48(sp)
ffffffffc0206d2a:	74a2                	ld	s1,40(sp)
ffffffffc0206d2c:	7902                	ld	s2,32(sp)
ffffffffc0206d2e:	69e2                	ld	s3,24(sp)
ffffffffc0206d30:	6a42                	ld	s4,16(sp)
ffffffffc0206d32:	6aa2                	ld	s5,8(sp)
ffffffffc0206d34:	6b02                	ld	s6,0(sp)
ffffffffc0206d36:	6121                	addi	sp,sp,64
ffffffffc0206d38:	8082                	ret
ffffffffc0206d3a:	5471                	li	s0,-4
ffffffffc0206d3c:	8526                	mv	a0,s1
ffffffffc0206d3e:	b00fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206d42:	b7cd                	j	ffffffffc0206d24 <vfs_do_add+0xa8>
ffffffffc0206d44:	d2b5                	beqz	a3,ffffffffc0206ca8 <vfs_do_add+0x2c>
ffffffffc0206d46:	00006697          	auipc	a3,0x6
ffffffffc0206d4a:	54268693          	addi	a3,a3,1346 # ffffffffc020d288 <syscalls+0xa70>
ffffffffc0206d4e:	00004617          	auipc	a2,0x4
ffffffffc0206d52:	b0260613          	addi	a2,a2,-1278 # ffffffffc020a850 <commands+0x210>
ffffffffc0206d56:	08f00593          	li	a1,143
ffffffffc0206d5a:	00006517          	auipc	a0,0x6
ffffffffc0206d5e:	51650513          	addi	a0,a0,1302 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0206d62:	f3cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d66:	0008e517          	auipc	a0,0x8e
ffffffffc0206d6a:	aba50513          	addi	a0,a0,-1350 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206d6e:	b48fd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206d72:	854e                	mv	a0,s3
ffffffffc0206d74:	acafb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206d78:	5425                	li	s0,-23
ffffffffc0206d7a:	b7c9                	j	ffffffffc0206d3c <vfs_do_add+0xc0>
ffffffffc0206d7c:	5451                	li	s0,-12
ffffffffc0206d7e:	b75d                	j	ffffffffc0206d24 <vfs_do_add+0xa8>
ffffffffc0206d80:	5471                	li	s0,-4
ffffffffc0206d82:	b74d                	j	ffffffffc0206d24 <vfs_do_add+0xa8>
ffffffffc0206d84:	00006697          	auipc	a3,0x6
ffffffffc0206d88:	4dc68693          	addi	a3,a3,1244 # ffffffffc020d260 <syscalls+0xa48>
ffffffffc0206d8c:	00004617          	auipc	a2,0x4
ffffffffc0206d90:	ac460613          	addi	a2,a2,-1340 # ffffffffc020a850 <commands+0x210>
ffffffffc0206d94:	08e00593          	li	a1,142
ffffffffc0206d98:	00006517          	auipc	a0,0x6
ffffffffc0206d9c:	4d850513          	addi	a0,a0,1240 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0206da0:	efef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206da4 <find_mount.part.0>:
ffffffffc0206da4:	1141                	addi	sp,sp,-16
ffffffffc0206da6:	00006697          	auipc	a3,0x6
ffffffffc0206daa:	4ba68693          	addi	a3,a3,1210 # ffffffffc020d260 <syscalls+0xa48>
ffffffffc0206dae:	00004617          	auipc	a2,0x4
ffffffffc0206db2:	aa260613          	addi	a2,a2,-1374 # ffffffffc020a850 <commands+0x210>
ffffffffc0206db6:	0cd00593          	li	a1,205
ffffffffc0206dba:	00006517          	auipc	a0,0x6
ffffffffc0206dbe:	4b650513          	addi	a0,a0,1206 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0206dc2:	e406                	sd	ra,8(sp)
ffffffffc0206dc4:	edaf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206dc8 <vfs_devlist_init>:
ffffffffc0206dc8:	0008e797          	auipc	a5,0x8e
ffffffffc0206dcc:	a4878793          	addi	a5,a5,-1464 # ffffffffc0294810 <vdev_list>
ffffffffc0206dd0:	4585                	li	a1,1
ffffffffc0206dd2:	0008e517          	auipc	a0,0x8e
ffffffffc0206dd6:	a4e50513          	addi	a0,a0,-1458 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206dda:	e79c                	sd	a5,8(a5)
ffffffffc0206ddc:	e39c                	sd	a5,0(a5)
ffffffffc0206dde:	ad2fd06f          	j	ffffffffc02040b0 <sem_init>

ffffffffc0206de2 <vfs_cleanup>:
ffffffffc0206de2:	1101                	addi	sp,sp,-32
ffffffffc0206de4:	e426                	sd	s1,8(sp)
ffffffffc0206de6:	0008e497          	auipc	s1,0x8e
ffffffffc0206dea:	a2a48493          	addi	s1,s1,-1494 # ffffffffc0294810 <vdev_list>
ffffffffc0206dee:	649c                	ld	a5,8(s1)
ffffffffc0206df0:	ec06                	sd	ra,24(sp)
ffffffffc0206df2:	e822                	sd	s0,16(sp)
ffffffffc0206df4:	02978e63          	beq	a5,s1,ffffffffc0206e30 <vfs_cleanup+0x4e>
ffffffffc0206df8:	0008e517          	auipc	a0,0x8e
ffffffffc0206dfc:	a2850513          	addi	a0,a0,-1496 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206e00:	abafd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206e04:	6480                	ld	s0,8(s1)
ffffffffc0206e06:	00940b63          	beq	s0,s1,ffffffffc0206e1c <vfs_cleanup+0x3a>
ffffffffc0206e0a:	ff043783          	ld	a5,-16(s0)
ffffffffc0206e0e:	853e                	mv	a0,a5
ffffffffc0206e10:	c399                	beqz	a5,ffffffffc0206e16 <vfs_cleanup+0x34>
ffffffffc0206e12:	6bfc                	ld	a5,208(a5)
ffffffffc0206e14:	9782                	jalr	a5
ffffffffc0206e16:	6400                	ld	s0,8(s0)
ffffffffc0206e18:	fe9419e3          	bne	s0,s1,ffffffffc0206e0a <vfs_cleanup+0x28>
ffffffffc0206e1c:	6442                	ld	s0,16(sp)
ffffffffc0206e1e:	60e2                	ld	ra,24(sp)
ffffffffc0206e20:	64a2                	ld	s1,8(sp)
ffffffffc0206e22:	0008e517          	auipc	a0,0x8e
ffffffffc0206e26:	9fe50513          	addi	a0,a0,-1538 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206e2a:	6105                	addi	sp,sp,32
ffffffffc0206e2c:	a8afd06f          	j	ffffffffc02040b6 <up>
ffffffffc0206e30:	60e2                	ld	ra,24(sp)
ffffffffc0206e32:	6442                	ld	s0,16(sp)
ffffffffc0206e34:	64a2                	ld	s1,8(sp)
ffffffffc0206e36:	6105                	addi	sp,sp,32
ffffffffc0206e38:	8082                	ret

ffffffffc0206e3a <vfs_get_root>:
ffffffffc0206e3a:	7179                	addi	sp,sp,-48
ffffffffc0206e3c:	f406                	sd	ra,40(sp)
ffffffffc0206e3e:	f022                	sd	s0,32(sp)
ffffffffc0206e40:	ec26                	sd	s1,24(sp)
ffffffffc0206e42:	e84a                	sd	s2,16(sp)
ffffffffc0206e44:	e44e                	sd	s3,8(sp)
ffffffffc0206e46:	e052                	sd	s4,0(sp)
ffffffffc0206e48:	c541                	beqz	a0,ffffffffc0206ed0 <vfs_get_root+0x96>
ffffffffc0206e4a:	0008e917          	auipc	s2,0x8e
ffffffffc0206e4e:	9c690913          	addi	s2,s2,-1594 # ffffffffc0294810 <vdev_list>
ffffffffc0206e52:	00893783          	ld	a5,8(s2)
ffffffffc0206e56:	07278b63          	beq	a5,s2,ffffffffc0206ecc <vfs_get_root+0x92>
ffffffffc0206e5a:	89aa                	mv	s3,a0
ffffffffc0206e5c:	0008e517          	auipc	a0,0x8e
ffffffffc0206e60:	9c450513          	addi	a0,a0,-1596 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206e64:	8a2e                	mv	s4,a1
ffffffffc0206e66:	844a                	mv	s0,s2
ffffffffc0206e68:	a52fd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206e6c:	a801                	j	ffffffffc0206e7c <vfs_get_root+0x42>
ffffffffc0206e6e:	fe043583          	ld	a1,-32(s0)
ffffffffc0206e72:	854e                	mv	a0,s3
ffffffffc0206e74:	49a030ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc0206e78:	84aa                	mv	s1,a0
ffffffffc0206e7a:	c505                	beqz	a0,ffffffffc0206ea2 <vfs_get_root+0x68>
ffffffffc0206e7c:	6400                	ld	s0,8(s0)
ffffffffc0206e7e:	ff2418e3          	bne	s0,s2,ffffffffc0206e6e <vfs_get_root+0x34>
ffffffffc0206e82:	54cd                	li	s1,-13
ffffffffc0206e84:	0008e517          	auipc	a0,0x8e
ffffffffc0206e88:	99c50513          	addi	a0,a0,-1636 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206e8c:	a2afd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206e90:	70a2                	ld	ra,40(sp)
ffffffffc0206e92:	7402                	ld	s0,32(sp)
ffffffffc0206e94:	6942                	ld	s2,16(sp)
ffffffffc0206e96:	69a2                	ld	s3,8(sp)
ffffffffc0206e98:	6a02                	ld	s4,0(sp)
ffffffffc0206e9a:	8526                	mv	a0,s1
ffffffffc0206e9c:	64e2                	ld	s1,24(sp)
ffffffffc0206e9e:	6145                	addi	sp,sp,48
ffffffffc0206ea0:	8082                	ret
ffffffffc0206ea2:	ff043503          	ld	a0,-16(s0)
ffffffffc0206ea6:	c519                	beqz	a0,ffffffffc0206eb4 <vfs_get_root+0x7a>
ffffffffc0206ea8:	617c                	ld	a5,192(a0)
ffffffffc0206eaa:	9782                	jalr	a5
ffffffffc0206eac:	c519                	beqz	a0,ffffffffc0206eba <vfs_get_root+0x80>
ffffffffc0206eae:	00aa3023          	sd	a0,0(s4)
ffffffffc0206eb2:	bfc9                	j	ffffffffc0206e84 <vfs_get_root+0x4a>
ffffffffc0206eb4:	ff843783          	ld	a5,-8(s0)
ffffffffc0206eb8:	c399                	beqz	a5,ffffffffc0206ebe <vfs_get_root+0x84>
ffffffffc0206eba:	54c9                	li	s1,-14
ffffffffc0206ebc:	b7e1                	j	ffffffffc0206e84 <vfs_get_root+0x4a>
ffffffffc0206ebe:	fe843503          	ld	a0,-24(s0)
ffffffffc0206ec2:	a99ff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0206ec6:	fe843503          	ld	a0,-24(s0)
ffffffffc0206eca:	b7cd                	j	ffffffffc0206eac <vfs_get_root+0x72>
ffffffffc0206ecc:	54cd                	li	s1,-13
ffffffffc0206ece:	b7c9                	j	ffffffffc0206e90 <vfs_get_root+0x56>
ffffffffc0206ed0:	00006697          	auipc	a3,0x6
ffffffffc0206ed4:	39068693          	addi	a3,a3,912 # ffffffffc020d260 <syscalls+0xa48>
ffffffffc0206ed8:	00004617          	auipc	a2,0x4
ffffffffc0206edc:	97860613          	addi	a2,a2,-1672 # ffffffffc020a850 <commands+0x210>
ffffffffc0206ee0:	04500593          	li	a1,69
ffffffffc0206ee4:	00006517          	auipc	a0,0x6
ffffffffc0206ee8:	38c50513          	addi	a0,a0,908 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0206eec:	db2f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206ef0 <vfs_get_devname>:
ffffffffc0206ef0:	0008e697          	auipc	a3,0x8e
ffffffffc0206ef4:	92068693          	addi	a3,a3,-1760 # ffffffffc0294810 <vdev_list>
ffffffffc0206ef8:	87b6                	mv	a5,a3
ffffffffc0206efa:	e511                	bnez	a0,ffffffffc0206f06 <vfs_get_devname+0x16>
ffffffffc0206efc:	a829                	j	ffffffffc0206f16 <vfs_get_devname+0x26>
ffffffffc0206efe:	ff07b703          	ld	a4,-16(a5)
ffffffffc0206f02:	00a70763          	beq	a4,a0,ffffffffc0206f10 <vfs_get_devname+0x20>
ffffffffc0206f06:	679c                	ld	a5,8(a5)
ffffffffc0206f08:	fed79be3          	bne	a5,a3,ffffffffc0206efe <vfs_get_devname+0xe>
ffffffffc0206f0c:	4501                	li	a0,0
ffffffffc0206f0e:	8082                	ret
ffffffffc0206f10:	fe07b503          	ld	a0,-32(a5)
ffffffffc0206f14:	8082                	ret
ffffffffc0206f16:	1141                	addi	sp,sp,-16
ffffffffc0206f18:	00006697          	auipc	a3,0x6
ffffffffc0206f1c:	3d068693          	addi	a3,a3,976 # ffffffffc020d2e8 <syscalls+0xad0>
ffffffffc0206f20:	00004617          	auipc	a2,0x4
ffffffffc0206f24:	93060613          	addi	a2,a2,-1744 # ffffffffc020a850 <commands+0x210>
ffffffffc0206f28:	06a00593          	li	a1,106
ffffffffc0206f2c:	00006517          	auipc	a0,0x6
ffffffffc0206f30:	34450513          	addi	a0,a0,836 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0206f34:	e406                	sd	ra,8(sp)
ffffffffc0206f36:	d68f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0206f3a <vfs_add_dev>:
ffffffffc0206f3a:	86b2                	mv	a3,a2
ffffffffc0206f3c:	4601                	li	a2,0
ffffffffc0206f3e:	d3fff06f          	j	ffffffffc0206c7c <vfs_do_add>

ffffffffc0206f42 <vfs_mount>:
ffffffffc0206f42:	7179                	addi	sp,sp,-48
ffffffffc0206f44:	e84a                	sd	s2,16(sp)
ffffffffc0206f46:	892a                	mv	s2,a0
ffffffffc0206f48:	0008e517          	auipc	a0,0x8e
ffffffffc0206f4c:	8d850513          	addi	a0,a0,-1832 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206f50:	e44e                	sd	s3,8(sp)
ffffffffc0206f52:	f406                	sd	ra,40(sp)
ffffffffc0206f54:	f022                	sd	s0,32(sp)
ffffffffc0206f56:	ec26                	sd	s1,24(sp)
ffffffffc0206f58:	89ae                	mv	s3,a1
ffffffffc0206f5a:	960fd0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0206f5e:	08090a63          	beqz	s2,ffffffffc0206ff2 <vfs_mount+0xb0>
ffffffffc0206f62:	0008e497          	auipc	s1,0x8e
ffffffffc0206f66:	8ae48493          	addi	s1,s1,-1874 # ffffffffc0294810 <vdev_list>
ffffffffc0206f6a:	6480                	ld	s0,8(s1)
ffffffffc0206f6c:	00941663          	bne	s0,s1,ffffffffc0206f78 <vfs_mount+0x36>
ffffffffc0206f70:	a8ad                	j	ffffffffc0206fea <vfs_mount+0xa8>
ffffffffc0206f72:	6400                	ld	s0,8(s0)
ffffffffc0206f74:	06940b63          	beq	s0,s1,ffffffffc0206fea <vfs_mount+0xa8>
ffffffffc0206f78:	ff843783          	ld	a5,-8(s0)
ffffffffc0206f7c:	dbfd                	beqz	a5,ffffffffc0206f72 <vfs_mount+0x30>
ffffffffc0206f7e:	fe043503          	ld	a0,-32(s0)
ffffffffc0206f82:	85ca                	mv	a1,s2
ffffffffc0206f84:	38a030ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc0206f88:	f56d                	bnez	a0,ffffffffc0206f72 <vfs_mount+0x30>
ffffffffc0206f8a:	ff043783          	ld	a5,-16(s0)
ffffffffc0206f8e:	e3a5                	bnez	a5,ffffffffc0206fee <vfs_mount+0xac>
ffffffffc0206f90:	fe043783          	ld	a5,-32(s0)
ffffffffc0206f94:	c3c9                	beqz	a5,ffffffffc0207016 <vfs_mount+0xd4>
ffffffffc0206f96:	ff843783          	ld	a5,-8(s0)
ffffffffc0206f9a:	cfb5                	beqz	a5,ffffffffc0207016 <vfs_mount+0xd4>
ffffffffc0206f9c:	fe843503          	ld	a0,-24(s0)
ffffffffc0206fa0:	c939                	beqz	a0,ffffffffc0206ff6 <vfs_mount+0xb4>
ffffffffc0206fa2:	4d38                	lw	a4,88(a0)
ffffffffc0206fa4:	6785                	lui	a5,0x1
ffffffffc0206fa6:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0206faa:	04f71663          	bne	a4,a5,ffffffffc0206ff6 <vfs_mount+0xb4>
ffffffffc0206fae:	ff040593          	addi	a1,s0,-16
ffffffffc0206fb2:	9982                	jalr	s3
ffffffffc0206fb4:	84aa                	mv	s1,a0
ffffffffc0206fb6:	ed01                	bnez	a0,ffffffffc0206fce <vfs_mount+0x8c>
ffffffffc0206fb8:	ff043783          	ld	a5,-16(s0)
ffffffffc0206fbc:	cfad                	beqz	a5,ffffffffc0207036 <vfs_mount+0xf4>
ffffffffc0206fbe:	fe043583          	ld	a1,-32(s0)
ffffffffc0206fc2:	00006517          	auipc	a0,0x6
ffffffffc0206fc6:	3b650513          	addi	a0,a0,950 # ffffffffc020d378 <syscalls+0xb60>
ffffffffc0206fca:	9dcf90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206fce:	0008e517          	auipc	a0,0x8e
ffffffffc0206fd2:	85250513          	addi	a0,a0,-1966 # ffffffffc0294820 <vdev_list_sem>
ffffffffc0206fd6:	8e0fd0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0206fda:	70a2                	ld	ra,40(sp)
ffffffffc0206fdc:	7402                	ld	s0,32(sp)
ffffffffc0206fde:	6942                	ld	s2,16(sp)
ffffffffc0206fe0:	69a2                	ld	s3,8(sp)
ffffffffc0206fe2:	8526                	mv	a0,s1
ffffffffc0206fe4:	64e2                	ld	s1,24(sp)
ffffffffc0206fe6:	6145                	addi	sp,sp,48
ffffffffc0206fe8:	8082                	ret
ffffffffc0206fea:	54cd                	li	s1,-13
ffffffffc0206fec:	b7cd                	j	ffffffffc0206fce <vfs_mount+0x8c>
ffffffffc0206fee:	54c5                	li	s1,-15
ffffffffc0206ff0:	bff9                	j	ffffffffc0206fce <vfs_mount+0x8c>
ffffffffc0206ff2:	db3ff0ef          	jal	ra,ffffffffc0206da4 <find_mount.part.0>
ffffffffc0206ff6:	00006697          	auipc	a3,0x6
ffffffffc0206ffa:	33268693          	addi	a3,a3,818 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0206ffe:	00004617          	auipc	a2,0x4
ffffffffc0207002:	85260613          	addi	a2,a2,-1966 # ffffffffc020a850 <commands+0x210>
ffffffffc0207006:	0ed00593          	li	a1,237
ffffffffc020700a:	00006517          	auipc	a0,0x6
ffffffffc020700e:	26650513          	addi	a0,a0,614 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0207012:	c8cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207016:	00006697          	auipc	a3,0x6
ffffffffc020701a:	2e268693          	addi	a3,a3,738 # ffffffffc020d2f8 <syscalls+0xae0>
ffffffffc020701e:	00004617          	auipc	a2,0x4
ffffffffc0207022:	83260613          	addi	a2,a2,-1998 # ffffffffc020a850 <commands+0x210>
ffffffffc0207026:	0eb00593          	li	a1,235
ffffffffc020702a:	00006517          	auipc	a0,0x6
ffffffffc020702e:	24650513          	addi	a0,a0,582 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0207032:	c6cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207036:	00006697          	auipc	a3,0x6
ffffffffc020703a:	32a68693          	addi	a3,a3,810 # ffffffffc020d360 <syscalls+0xb48>
ffffffffc020703e:	00004617          	auipc	a2,0x4
ffffffffc0207042:	81260613          	addi	a2,a2,-2030 # ffffffffc020a850 <commands+0x210>
ffffffffc0207046:	0ef00593          	li	a1,239
ffffffffc020704a:	00006517          	auipc	a0,0x6
ffffffffc020704e:	22650513          	addi	a0,a0,550 # ffffffffc020d270 <syscalls+0xa58>
ffffffffc0207052:	c4cf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207056 <vfs_open>:
ffffffffc0207056:	711d                	addi	sp,sp,-96
ffffffffc0207058:	e4a6                	sd	s1,72(sp)
ffffffffc020705a:	e0ca                	sd	s2,64(sp)
ffffffffc020705c:	fc4e                	sd	s3,56(sp)
ffffffffc020705e:	ec86                	sd	ra,88(sp)
ffffffffc0207060:	e8a2                	sd	s0,80(sp)
ffffffffc0207062:	f852                	sd	s4,48(sp)
ffffffffc0207064:	f456                	sd	s5,40(sp)
ffffffffc0207066:	0035f793          	andi	a5,a1,3
ffffffffc020706a:	84ae                	mv	s1,a1
ffffffffc020706c:	892a                	mv	s2,a0
ffffffffc020706e:	89b2                	mv	s3,a2
ffffffffc0207070:	0e078663          	beqz	a5,ffffffffc020715c <vfs_open+0x106>
ffffffffc0207074:	470d                	li	a4,3
ffffffffc0207076:	0105fa93          	andi	s5,a1,16
ffffffffc020707a:	0ce78f63          	beq	a5,a4,ffffffffc0207158 <vfs_open+0x102>
ffffffffc020707e:	002c                	addi	a1,sp,8
ffffffffc0207080:	854a                	mv	a0,s2
ffffffffc0207082:	2ae000ef          	jal	ra,ffffffffc0207330 <vfs_lookup>
ffffffffc0207086:	842a                	mv	s0,a0
ffffffffc0207088:	0044fa13          	andi	s4,s1,4
ffffffffc020708c:	e159                	bnez	a0,ffffffffc0207112 <vfs_open+0xbc>
ffffffffc020708e:	00c4f793          	andi	a5,s1,12
ffffffffc0207092:	4731                	li	a4,12
ffffffffc0207094:	0ee78263          	beq	a5,a4,ffffffffc0207178 <vfs_open+0x122>
ffffffffc0207098:	6422                	ld	s0,8(sp)
ffffffffc020709a:	12040163          	beqz	s0,ffffffffc02071bc <vfs_open+0x166>
ffffffffc020709e:	783c                	ld	a5,112(s0)
ffffffffc02070a0:	cff1                	beqz	a5,ffffffffc020717c <vfs_open+0x126>
ffffffffc02070a2:	679c                	ld	a5,8(a5)
ffffffffc02070a4:	cfe1                	beqz	a5,ffffffffc020717c <vfs_open+0x126>
ffffffffc02070a6:	8522                	mv	a0,s0
ffffffffc02070a8:	00006597          	auipc	a1,0x6
ffffffffc02070ac:	3b058593          	addi	a1,a1,944 # ffffffffc020d458 <syscalls+0xc40>
ffffffffc02070b0:	8c3ff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02070b4:	783c                	ld	a5,112(s0)
ffffffffc02070b6:	6522                	ld	a0,8(sp)
ffffffffc02070b8:	85a6                	mv	a1,s1
ffffffffc02070ba:	679c                	ld	a5,8(a5)
ffffffffc02070bc:	9782                	jalr	a5
ffffffffc02070be:	842a                	mv	s0,a0
ffffffffc02070c0:	6522                	ld	a0,8(sp)
ffffffffc02070c2:	e845                	bnez	s0,ffffffffc0207172 <vfs_open+0x11c>
ffffffffc02070c4:	015a6a33          	or	s4,s4,s5
ffffffffc02070c8:	89fff0ef          	jal	ra,ffffffffc0206966 <inode_open_inc>
ffffffffc02070cc:	020a0663          	beqz	s4,ffffffffc02070f8 <vfs_open+0xa2>
ffffffffc02070d0:	64a2                	ld	s1,8(sp)
ffffffffc02070d2:	c4e9                	beqz	s1,ffffffffc020719c <vfs_open+0x146>
ffffffffc02070d4:	78bc                	ld	a5,112(s1)
ffffffffc02070d6:	c3f9                	beqz	a5,ffffffffc020719c <vfs_open+0x146>
ffffffffc02070d8:	73bc                	ld	a5,96(a5)
ffffffffc02070da:	c3e9                	beqz	a5,ffffffffc020719c <vfs_open+0x146>
ffffffffc02070dc:	00006597          	auipc	a1,0x6
ffffffffc02070e0:	3dc58593          	addi	a1,a1,988 # ffffffffc020d4b8 <syscalls+0xca0>
ffffffffc02070e4:	8526                	mv	a0,s1
ffffffffc02070e6:	88dff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02070ea:	78bc                	ld	a5,112(s1)
ffffffffc02070ec:	6522                	ld	a0,8(sp)
ffffffffc02070ee:	4581                	li	a1,0
ffffffffc02070f0:	73bc                	ld	a5,96(a5)
ffffffffc02070f2:	9782                	jalr	a5
ffffffffc02070f4:	87aa                	mv	a5,a0
ffffffffc02070f6:	e92d                	bnez	a0,ffffffffc0207168 <vfs_open+0x112>
ffffffffc02070f8:	67a2                	ld	a5,8(sp)
ffffffffc02070fa:	00f9b023          	sd	a5,0(s3)
ffffffffc02070fe:	60e6                	ld	ra,88(sp)
ffffffffc0207100:	8522                	mv	a0,s0
ffffffffc0207102:	6446                	ld	s0,80(sp)
ffffffffc0207104:	64a6                	ld	s1,72(sp)
ffffffffc0207106:	6906                	ld	s2,64(sp)
ffffffffc0207108:	79e2                	ld	s3,56(sp)
ffffffffc020710a:	7a42                	ld	s4,48(sp)
ffffffffc020710c:	7aa2                	ld	s5,40(sp)
ffffffffc020710e:	6125                	addi	sp,sp,96
ffffffffc0207110:	8082                	ret
ffffffffc0207112:	57c1                	li	a5,-16
ffffffffc0207114:	fef515e3          	bne	a0,a5,ffffffffc02070fe <vfs_open+0xa8>
ffffffffc0207118:	fe0a03e3          	beqz	s4,ffffffffc02070fe <vfs_open+0xa8>
ffffffffc020711c:	0810                	addi	a2,sp,16
ffffffffc020711e:	082c                	addi	a1,sp,24
ffffffffc0207120:	854a                	mv	a0,s2
ffffffffc0207122:	2a4000ef          	jal	ra,ffffffffc02073c6 <vfs_lookup_parent>
ffffffffc0207126:	842a                	mv	s0,a0
ffffffffc0207128:	f979                	bnez	a0,ffffffffc02070fe <vfs_open+0xa8>
ffffffffc020712a:	6462                	ld	s0,24(sp)
ffffffffc020712c:	c845                	beqz	s0,ffffffffc02071dc <vfs_open+0x186>
ffffffffc020712e:	783c                	ld	a5,112(s0)
ffffffffc0207130:	c7d5                	beqz	a5,ffffffffc02071dc <vfs_open+0x186>
ffffffffc0207132:	77bc                	ld	a5,104(a5)
ffffffffc0207134:	c7c5                	beqz	a5,ffffffffc02071dc <vfs_open+0x186>
ffffffffc0207136:	8522                	mv	a0,s0
ffffffffc0207138:	00006597          	auipc	a1,0x6
ffffffffc020713c:	2b858593          	addi	a1,a1,696 # ffffffffc020d3f0 <syscalls+0xbd8>
ffffffffc0207140:	833ff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0207144:	783c                	ld	a5,112(s0)
ffffffffc0207146:	65c2                	ld	a1,16(sp)
ffffffffc0207148:	6562                	ld	a0,24(sp)
ffffffffc020714a:	77bc                	ld	a5,104(a5)
ffffffffc020714c:	4034d613          	srai	a2,s1,0x3
ffffffffc0207150:	0034                	addi	a3,sp,8
ffffffffc0207152:	8a05                	andi	a2,a2,1
ffffffffc0207154:	9782                	jalr	a5
ffffffffc0207156:	b789                	j	ffffffffc0207098 <vfs_open+0x42>
ffffffffc0207158:	5475                	li	s0,-3
ffffffffc020715a:	b755                	j	ffffffffc02070fe <vfs_open+0xa8>
ffffffffc020715c:	0105fa93          	andi	s5,a1,16
ffffffffc0207160:	5475                	li	s0,-3
ffffffffc0207162:	f80a9ee3          	bnez	s5,ffffffffc02070fe <vfs_open+0xa8>
ffffffffc0207166:	bf21                	j	ffffffffc020707e <vfs_open+0x28>
ffffffffc0207168:	6522                	ld	a0,8(sp)
ffffffffc020716a:	843e                	mv	s0,a5
ffffffffc020716c:	965ff0ef          	jal	ra,ffffffffc0206ad0 <inode_open_dec>
ffffffffc0207170:	6522                	ld	a0,8(sp)
ffffffffc0207172:	8b7ff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0207176:	b761                	j	ffffffffc02070fe <vfs_open+0xa8>
ffffffffc0207178:	5425                	li	s0,-23
ffffffffc020717a:	b751                	j	ffffffffc02070fe <vfs_open+0xa8>
ffffffffc020717c:	00006697          	auipc	a3,0x6
ffffffffc0207180:	28c68693          	addi	a3,a3,652 # ffffffffc020d408 <syscalls+0xbf0>
ffffffffc0207184:	00003617          	auipc	a2,0x3
ffffffffc0207188:	6cc60613          	addi	a2,a2,1740 # ffffffffc020a850 <commands+0x210>
ffffffffc020718c:	03300593          	li	a1,51
ffffffffc0207190:	00006517          	auipc	a0,0x6
ffffffffc0207194:	24850513          	addi	a0,a0,584 # ffffffffc020d3d8 <syscalls+0xbc0>
ffffffffc0207198:	b06f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020719c:	00006697          	auipc	a3,0x6
ffffffffc02071a0:	2c468693          	addi	a3,a3,708 # ffffffffc020d460 <syscalls+0xc48>
ffffffffc02071a4:	00003617          	auipc	a2,0x3
ffffffffc02071a8:	6ac60613          	addi	a2,a2,1708 # ffffffffc020a850 <commands+0x210>
ffffffffc02071ac:	03a00593          	li	a1,58
ffffffffc02071b0:	00006517          	auipc	a0,0x6
ffffffffc02071b4:	22850513          	addi	a0,a0,552 # ffffffffc020d3d8 <syscalls+0xbc0>
ffffffffc02071b8:	ae6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02071bc:	00006697          	auipc	a3,0x6
ffffffffc02071c0:	23c68693          	addi	a3,a3,572 # ffffffffc020d3f8 <syscalls+0xbe0>
ffffffffc02071c4:	00003617          	auipc	a2,0x3
ffffffffc02071c8:	68c60613          	addi	a2,a2,1676 # ffffffffc020a850 <commands+0x210>
ffffffffc02071cc:	03100593          	li	a1,49
ffffffffc02071d0:	00006517          	auipc	a0,0x6
ffffffffc02071d4:	20850513          	addi	a0,a0,520 # ffffffffc020d3d8 <syscalls+0xbc0>
ffffffffc02071d8:	ac6f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02071dc:	00006697          	auipc	a3,0x6
ffffffffc02071e0:	1ac68693          	addi	a3,a3,428 # ffffffffc020d388 <syscalls+0xb70>
ffffffffc02071e4:	00003617          	auipc	a2,0x3
ffffffffc02071e8:	66c60613          	addi	a2,a2,1644 # ffffffffc020a850 <commands+0x210>
ffffffffc02071ec:	02c00593          	li	a1,44
ffffffffc02071f0:	00006517          	auipc	a0,0x6
ffffffffc02071f4:	1e850513          	addi	a0,a0,488 # ffffffffc020d3d8 <syscalls+0xbc0>
ffffffffc02071f8:	aa6f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02071fc <vfs_close>:
ffffffffc02071fc:	1141                	addi	sp,sp,-16
ffffffffc02071fe:	e406                	sd	ra,8(sp)
ffffffffc0207200:	e022                	sd	s0,0(sp)
ffffffffc0207202:	842a                	mv	s0,a0
ffffffffc0207204:	8cdff0ef          	jal	ra,ffffffffc0206ad0 <inode_open_dec>
ffffffffc0207208:	8522                	mv	a0,s0
ffffffffc020720a:	81fff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc020720e:	60a2                	ld	ra,8(sp)
ffffffffc0207210:	6402                	ld	s0,0(sp)
ffffffffc0207212:	4501                	li	a0,0
ffffffffc0207214:	0141                	addi	sp,sp,16
ffffffffc0207216:	8082                	ret

ffffffffc0207218 <get_device>:
ffffffffc0207218:	7179                	addi	sp,sp,-48
ffffffffc020721a:	ec26                	sd	s1,24(sp)
ffffffffc020721c:	e84a                	sd	s2,16(sp)
ffffffffc020721e:	f406                	sd	ra,40(sp)
ffffffffc0207220:	f022                	sd	s0,32(sp)
ffffffffc0207222:	00054303          	lbu	t1,0(a0)
ffffffffc0207226:	892e                	mv	s2,a1
ffffffffc0207228:	84b2                	mv	s1,a2
ffffffffc020722a:	02030463          	beqz	t1,ffffffffc0207252 <get_device+0x3a>
ffffffffc020722e:	00150413          	addi	s0,a0,1
ffffffffc0207232:	86a2                	mv	a3,s0
ffffffffc0207234:	879a                	mv	a5,t1
ffffffffc0207236:	4701                	li	a4,0
ffffffffc0207238:	03a00813          	li	a6,58
ffffffffc020723c:	02f00893          	li	a7,47
ffffffffc0207240:	03078263          	beq	a5,a6,ffffffffc0207264 <get_device+0x4c>
ffffffffc0207244:	05178963          	beq	a5,a7,ffffffffc0207296 <get_device+0x7e>
ffffffffc0207248:	0006c783          	lbu	a5,0(a3)
ffffffffc020724c:	2705                	addiw	a4,a4,1
ffffffffc020724e:	0685                	addi	a3,a3,1
ffffffffc0207250:	fbe5                	bnez	a5,ffffffffc0207240 <get_device+0x28>
ffffffffc0207252:	7402                	ld	s0,32(sp)
ffffffffc0207254:	00a93023          	sd	a0,0(s2)
ffffffffc0207258:	70a2                	ld	ra,40(sp)
ffffffffc020725a:	6942                	ld	s2,16(sp)
ffffffffc020725c:	8526                	mv	a0,s1
ffffffffc020725e:	64e2                	ld	s1,24(sp)
ffffffffc0207260:	6145                	addi	sp,sp,48
ffffffffc0207262:	a279                	j	ffffffffc02073f0 <vfs_get_curdir>
ffffffffc0207264:	cb15                	beqz	a4,ffffffffc0207298 <get_device+0x80>
ffffffffc0207266:	00e507b3          	add	a5,a0,a4
ffffffffc020726a:	0705                	addi	a4,a4,1
ffffffffc020726c:	00078023          	sb	zero,0(a5)
ffffffffc0207270:	972a                	add	a4,a4,a0
ffffffffc0207272:	02f00613          	li	a2,47
ffffffffc0207276:	00074783          	lbu	a5,0(a4)
ffffffffc020727a:	86ba                	mv	a3,a4
ffffffffc020727c:	0705                	addi	a4,a4,1
ffffffffc020727e:	fec78ce3          	beq	a5,a2,ffffffffc0207276 <get_device+0x5e>
ffffffffc0207282:	7402                	ld	s0,32(sp)
ffffffffc0207284:	70a2                	ld	ra,40(sp)
ffffffffc0207286:	00d93023          	sd	a3,0(s2)
ffffffffc020728a:	85a6                	mv	a1,s1
ffffffffc020728c:	6942                	ld	s2,16(sp)
ffffffffc020728e:	64e2                	ld	s1,24(sp)
ffffffffc0207290:	6145                	addi	sp,sp,48
ffffffffc0207292:	ba9ff06f          	j	ffffffffc0206e3a <vfs_get_root>
ffffffffc0207296:	ff55                	bnez	a4,ffffffffc0207252 <get_device+0x3a>
ffffffffc0207298:	02f00793          	li	a5,47
ffffffffc020729c:	04f30563          	beq	t1,a5,ffffffffc02072e6 <get_device+0xce>
ffffffffc02072a0:	03a00793          	li	a5,58
ffffffffc02072a4:	06f31663          	bne	t1,a5,ffffffffc0207310 <get_device+0xf8>
ffffffffc02072a8:	0028                	addi	a0,sp,8
ffffffffc02072aa:	146000ef          	jal	ra,ffffffffc02073f0 <vfs_get_curdir>
ffffffffc02072ae:	e515                	bnez	a0,ffffffffc02072da <get_device+0xc2>
ffffffffc02072b0:	67a2                	ld	a5,8(sp)
ffffffffc02072b2:	77a8                	ld	a0,104(a5)
ffffffffc02072b4:	cd15                	beqz	a0,ffffffffc02072f0 <get_device+0xd8>
ffffffffc02072b6:	617c                	ld	a5,192(a0)
ffffffffc02072b8:	9782                	jalr	a5
ffffffffc02072ba:	87aa                	mv	a5,a0
ffffffffc02072bc:	6522                	ld	a0,8(sp)
ffffffffc02072be:	e09c                	sd	a5,0(s1)
ffffffffc02072c0:	f68ff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02072c4:	02f00713          	li	a4,47
ffffffffc02072c8:	a011                	j	ffffffffc02072cc <get_device+0xb4>
ffffffffc02072ca:	0405                	addi	s0,s0,1
ffffffffc02072cc:	00044783          	lbu	a5,0(s0)
ffffffffc02072d0:	fee78de3          	beq	a5,a4,ffffffffc02072ca <get_device+0xb2>
ffffffffc02072d4:	00893023          	sd	s0,0(s2)
ffffffffc02072d8:	4501                	li	a0,0
ffffffffc02072da:	70a2                	ld	ra,40(sp)
ffffffffc02072dc:	7402                	ld	s0,32(sp)
ffffffffc02072de:	64e2                	ld	s1,24(sp)
ffffffffc02072e0:	6942                	ld	s2,16(sp)
ffffffffc02072e2:	6145                	addi	sp,sp,48
ffffffffc02072e4:	8082                	ret
ffffffffc02072e6:	8526                	mv	a0,s1
ffffffffc02072e8:	93fff0ef          	jal	ra,ffffffffc0206c26 <vfs_get_bootfs>
ffffffffc02072ec:	dd61                	beqz	a0,ffffffffc02072c4 <get_device+0xac>
ffffffffc02072ee:	b7f5                	j	ffffffffc02072da <get_device+0xc2>
ffffffffc02072f0:	00006697          	auipc	a3,0x6
ffffffffc02072f4:	20068693          	addi	a3,a3,512 # ffffffffc020d4f0 <syscalls+0xcd8>
ffffffffc02072f8:	00003617          	auipc	a2,0x3
ffffffffc02072fc:	55860613          	addi	a2,a2,1368 # ffffffffc020a850 <commands+0x210>
ffffffffc0207300:	03900593          	li	a1,57
ffffffffc0207304:	00006517          	auipc	a0,0x6
ffffffffc0207308:	1d450513          	addi	a0,a0,468 # ffffffffc020d4d8 <syscalls+0xcc0>
ffffffffc020730c:	992f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207310:	00006697          	auipc	a3,0x6
ffffffffc0207314:	1b868693          	addi	a3,a3,440 # ffffffffc020d4c8 <syscalls+0xcb0>
ffffffffc0207318:	00003617          	auipc	a2,0x3
ffffffffc020731c:	53860613          	addi	a2,a2,1336 # ffffffffc020a850 <commands+0x210>
ffffffffc0207320:	03300593          	li	a1,51
ffffffffc0207324:	00006517          	auipc	a0,0x6
ffffffffc0207328:	1b450513          	addi	a0,a0,436 # ffffffffc020d4d8 <syscalls+0xcc0>
ffffffffc020732c:	972f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207330 <vfs_lookup>:
ffffffffc0207330:	7139                	addi	sp,sp,-64
ffffffffc0207332:	f426                	sd	s1,40(sp)
ffffffffc0207334:	0830                	addi	a2,sp,24
ffffffffc0207336:	84ae                	mv	s1,a1
ffffffffc0207338:	002c                	addi	a1,sp,8
ffffffffc020733a:	f822                	sd	s0,48(sp)
ffffffffc020733c:	fc06                	sd	ra,56(sp)
ffffffffc020733e:	f04a                	sd	s2,32(sp)
ffffffffc0207340:	e42a                	sd	a0,8(sp)
ffffffffc0207342:	ed7ff0ef          	jal	ra,ffffffffc0207218 <get_device>
ffffffffc0207346:	842a                	mv	s0,a0
ffffffffc0207348:	ed1d                	bnez	a0,ffffffffc0207386 <vfs_lookup+0x56>
ffffffffc020734a:	67a2                	ld	a5,8(sp)
ffffffffc020734c:	6962                	ld	s2,24(sp)
ffffffffc020734e:	0007c783          	lbu	a5,0(a5)
ffffffffc0207352:	c3a9                	beqz	a5,ffffffffc0207394 <vfs_lookup+0x64>
ffffffffc0207354:	04090963          	beqz	s2,ffffffffc02073a6 <vfs_lookup+0x76>
ffffffffc0207358:	07093783          	ld	a5,112(s2)
ffffffffc020735c:	c7a9                	beqz	a5,ffffffffc02073a6 <vfs_lookup+0x76>
ffffffffc020735e:	7bbc                	ld	a5,112(a5)
ffffffffc0207360:	c3b9                	beqz	a5,ffffffffc02073a6 <vfs_lookup+0x76>
ffffffffc0207362:	854a                	mv	a0,s2
ffffffffc0207364:	00006597          	auipc	a1,0x6
ffffffffc0207368:	1f458593          	addi	a1,a1,500 # ffffffffc020d558 <syscalls+0xd40>
ffffffffc020736c:	e06ff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0207370:	07093783          	ld	a5,112(s2)
ffffffffc0207374:	65a2                	ld	a1,8(sp)
ffffffffc0207376:	6562                	ld	a0,24(sp)
ffffffffc0207378:	7bbc                	ld	a5,112(a5)
ffffffffc020737a:	8626                	mv	a2,s1
ffffffffc020737c:	9782                	jalr	a5
ffffffffc020737e:	842a                	mv	s0,a0
ffffffffc0207380:	6562                	ld	a0,24(sp)
ffffffffc0207382:	ea6ff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0207386:	70e2                	ld	ra,56(sp)
ffffffffc0207388:	8522                	mv	a0,s0
ffffffffc020738a:	7442                	ld	s0,48(sp)
ffffffffc020738c:	74a2                	ld	s1,40(sp)
ffffffffc020738e:	7902                	ld	s2,32(sp)
ffffffffc0207390:	6121                	addi	sp,sp,64
ffffffffc0207392:	8082                	ret
ffffffffc0207394:	70e2                	ld	ra,56(sp)
ffffffffc0207396:	8522                	mv	a0,s0
ffffffffc0207398:	7442                	ld	s0,48(sp)
ffffffffc020739a:	0124b023          	sd	s2,0(s1)
ffffffffc020739e:	74a2                	ld	s1,40(sp)
ffffffffc02073a0:	7902                	ld	s2,32(sp)
ffffffffc02073a2:	6121                	addi	sp,sp,64
ffffffffc02073a4:	8082                	ret
ffffffffc02073a6:	00006697          	auipc	a3,0x6
ffffffffc02073aa:	16268693          	addi	a3,a3,354 # ffffffffc020d508 <syscalls+0xcf0>
ffffffffc02073ae:	00003617          	auipc	a2,0x3
ffffffffc02073b2:	4a260613          	addi	a2,a2,1186 # ffffffffc020a850 <commands+0x210>
ffffffffc02073b6:	04f00593          	li	a1,79
ffffffffc02073ba:	00006517          	auipc	a0,0x6
ffffffffc02073be:	11e50513          	addi	a0,a0,286 # ffffffffc020d4d8 <syscalls+0xcc0>
ffffffffc02073c2:	8dcf90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02073c6 <vfs_lookup_parent>:
ffffffffc02073c6:	7139                	addi	sp,sp,-64
ffffffffc02073c8:	f822                	sd	s0,48(sp)
ffffffffc02073ca:	f426                	sd	s1,40(sp)
ffffffffc02073cc:	842e                	mv	s0,a1
ffffffffc02073ce:	84b2                	mv	s1,a2
ffffffffc02073d0:	002c                	addi	a1,sp,8
ffffffffc02073d2:	0830                	addi	a2,sp,24
ffffffffc02073d4:	fc06                	sd	ra,56(sp)
ffffffffc02073d6:	e42a                	sd	a0,8(sp)
ffffffffc02073d8:	e41ff0ef          	jal	ra,ffffffffc0207218 <get_device>
ffffffffc02073dc:	e509                	bnez	a0,ffffffffc02073e6 <vfs_lookup_parent+0x20>
ffffffffc02073de:	67a2                	ld	a5,8(sp)
ffffffffc02073e0:	e09c                	sd	a5,0(s1)
ffffffffc02073e2:	67e2                	ld	a5,24(sp)
ffffffffc02073e4:	e01c                	sd	a5,0(s0)
ffffffffc02073e6:	70e2                	ld	ra,56(sp)
ffffffffc02073e8:	7442                	ld	s0,48(sp)
ffffffffc02073ea:	74a2                	ld	s1,40(sp)
ffffffffc02073ec:	6121                	addi	sp,sp,64
ffffffffc02073ee:	8082                	ret

ffffffffc02073f0 <vfs_get_curdir>:
ffffffffc02073f0:	0008e797          	auipc	a5,0x8e
ffffffffc02073f4:	4c87b783          	ld	a5,1224(a5) # ffffffffc02958b8 <current>
ffffffffc02073f8:	1487b783          	ld	a5,328(a5)
ffffffffc02073fc:	1101                	addi	sp,sp,-32
ffffffffc02073fe:	e426                	sd	s1,8(sp)
ffffffffc0207400:	6384                	ld	s1,0(a5)
ffffffffc0207402:	ec06                	sd	ra,24(sp)
ffffffffc0207404:	e822                	sd	s0,16(sp)
ffffffffc0207406:	cc81                	beqz	s1,ffffffffc020741e <vfs_get_curdir+0x2e>
ffffffffc0207408:	842a                	mv	s0,a0
ffffffffc020740a:	8526                	mv	a0,s1
ffffffffc020740c:	d4eff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0207410:	4501                	li	a0,0
ffffffffc0207412:	e004                	sd	s1,0(s0)
ffffffffc0207414:	60e2                	ld	ra,24(sp)
ffffffffc0207416:	6442                	ld	s0,16(sp)
ffffffffc0207418:	64a2                	ld	s1,8(sp)
ffffffffc020741a:	6105                	addi	sp,sp,32
ffffffffc020741c:	8082                	ret
ffffffffc020741e:	5541                	li	a0,-16
ffffffffc0207420:	bfd5                	j	ffffffffc0207414 <vfs_get_curdir+0x24>

ffffffffc0207422 <vfs_set_curdir>:
ffffffffc0207422:	7139                	addi	sp,sp,-64
ffffffffc0207424:	f04a                	sd	s2,32(sp)
ffffffffc0207426:	0008e917          	auipc	s2,0x8e
ffffffffc020742a:	49290913          	addi	s2,s2,1170 # ffffffffc02958b8 <current>
ffffffffc020742e:	00093783          	ld	a5,0(s2)
ffffffffc0207432:	f822                	sd	s0,48(sp)
ffffffffc0207434:	842a                	mv	s0,a0
ffffffffc0207436:	1487b503          	ld	a0,328(a5)
ffffffffc020743a:	ec4e                	sd	s3,24(sp)
ffffffffc020743c:	fc06                	sd	ra,56(sp)
ffffffffc020743e:	f426                	sd	s1,40(sp)
ffffffffc0207440:	8d9fd0ef          	jal	ra,ffffffffc0204d18 <lock_files>
ffffffffc0207444:	00093783          	ld	a5,0(s2)
ffffffffc0207448:	1487b503          	ld	a0,328(a5)
ffffffffc020744c:	00053983          	ld	s3,0(a0)
ffffffffc0207450:	07340963          	beq	s0,s3,ffffffffc02074c2 <vfs_set_curdir+0xa0>
ffffffffc0207454:	cc39                	beqz	s0,ffffffffc02074b2 <vfs_set_curdir+0x90>
ffffffffc0207456:	783c                	ld	a5,112(s0)
ffffffffc0207458:	c7bd                	beqz	a5,ffffffffc02074c6 <vfs_set_curdir+0xa4>
ffffffffc020745a:	6bbc                	ld	a5,80(a5)
ffffffffc020745c:	c7ad                	beqz	a5,ffffffffc02074c6 <vfs_set_curdir+0xa4>
ffffffffc020745e:	00006597          	auipc	a1,0x6
ffffffffc0207462:	16a58593          	addi	a1,a1,362 # ffffffffc020d5c8 <syscalls+0xdb0>
ffffffffc0207466:	8522                	mv	a0,s0
ffffffffc0207468:	d0aff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc020746c:	783c                	ld	a5,112(s0)
ffffffffc020746e:	006c                	addi	a1,sp,12
ffffffffc0207470:	8522                	mv	a0,s0
ffffffffc0207472:	6bbc                	ld	a5,80(a5)
ffffffffc0207474:	9782                	jalr	a5
ffffffffc0207476:	84aa                	mv	s1,a0
ffffffffc0207478:	e901                	bnez	a0,ffffffffc0207488 <vfs_set_curdir+0x66>
ffffffffc020747a:	47b2                	lw	a5,12(sp)
ffffffffc020747c:	669d                	lui	a3,0x7
ffffffffc020747e:	6709                	lui	a4,0x2
ffffffffc0207480:	8ff5                	and	a5,a5,a3
ffffffffc0207482:	54b9                	li	s1,-18
ffffffffc0207484:	02e78063          	beq	a5,a4,ffffffffc02074a4 <vfs_set_curdir+0x82>
ffffffffc0207488:	00093783          	ld	a5,0(s2)
ffffffffc020748c:	1487b503          	ld	a0,328(a5)
ffffffffc0207490:	88ffd0ef          	jal	ra,ffffffffc0204d1e <unlock_files>
ffffffffc0207494:	70e2                	ld	ra,56(sp)
ffffffffc0207496:	7442                	ld	s0,48(sp)
ffffffffc0207498:	7902                	ld	s2,32(sp)
ffffffffc020749a:	69e2                	ld	s3,24(sp)
ffffffffc020749c:	8526                	mv	a0,s1
ffffffffc020749e:	74a2                	ld	s1,40(sp)
ffffffffc02074a0:	6121                	addi	sp,sp,64
ffffffffc02074a2:	8082                	ret
ffffffffc02074a4:	8522                	mv	a0,s0
ffffffffc02074a6:	cb4ff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc02074aa:	00093783          	ld	a5,0(s2)
ffffffffc02074ae:	1487b503          	ld	a0,328(a5)
ffffffffc02074b2:	e100                	sd	s0,0(a0)
ffffffffc02074b4:	4481                	li	s1,0
ffffffffc02074b6:	fc098de3          	beqz	s3,ffffffffc0207490 <vfs_set_curdir+0x6e>
ffffffffc02074ba:	854e                	mv	a0,s3
ffffffffc02074bc:	d6cff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02074c0:	b7e1                	j	ffffffffc0207488 <vfs_set_curdir+0x66>
ffffffffc02074c2:	4481                	li	s1,0
ffffffffc02074c4:	b7f1                	j	ffffffffc0207490 <vfs_set_curdir+0x6e>
ffffffffc02074c6:	00006697          	auipc	a3,0x6
ffffffffc02074ca:	09a68693          	addi	a3,a3,154 # ffffffffc020d560 <syscalls+0xd48>
ffffffffc02074ce:	00003617          	auipc	a2,0x3
ffffffffc02074d2:	38260613          	addi	a2,a2,898 # ffffffffc020a850 <commands+0x210>
ffffffffc02074d6:	04300593          	li	a1,67
ffffffffc02074da:	00006517          	auipc	a0,0x6
ffffffffc02074de:	0d650513          	addi	a0,a0,214 # ffffffffc020d5b0 <syscalls+0xd98>
ffffffffc02074e2:	fbdf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02074e6 <vfs_chdir>:
ffffffffc02074e6:	1101                	addi	sp,sp,-32
ffffffffc02074e8:	002c                	addi	a1,sp,8
ffffffffc02074ea:	e822                	sd	s0,16(sp)
ffffffffc02074ec:	ec06                	sd	ra,24(sp)
ffffffffc02074ee:	e43ff0ef          	jal	ra,ffffffffc0207330 <vfs_lookup>
ffffffffc02074f2:	842a                	mv	s0,a0
ffffffffc02074f4:	c511                	beqz	a0,ffffffffc0207500 <vfs_chdir+0x1a>
ffffffffc02074f6:	60e2                	ld	ra,24(sp)
ffffffffc02074f8:	8522                	mv	a0,s0
ffffffffc02074fa:	6442                	ld	s0,16(sp)
ffffffffc02074fc:	6105                	addi	sp,sp,32
ffffffffc02074fe:	8082                	ret
ffffffffc0207500:	6522                	ld	a0,8(sp)
ffffffffc0207502:	f21ff0ef          	jal	ra,ffffffffc0207422 <vfs_set_curdir>
ffffffffc0207506:	842a                	mv	s0,a0
ffffffffc0207508:	6522                	ld	a0,8(sp)
ffffffffc020750a:	d1eff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc020750e:	60e2                	ld	ra,24(sp)
ffffffffc0207510:	8522                	mv	a0,s0
ffffffffc0207512:	6442                	ld	s0,16(sp)
ffffffffc0207514:	6105                	addi	sp,sp,32
ffffffffc0207516:	8082                	ret

ffffffffc0207518 <vfs_getcwd>:
ffffffffc0207518:	0008e797          	auipc	a5,0x8e
ffffffffc020751c:	3a07b783          	ld	a5,928(a5) # ffffffffc02958b8 <current>
ffffffffc0207520:	1487b783          	ld	a5,328(a5)
ffffffffc0207524:	7179                	addi	sp,sp,-48
ffffffffc0207526:	ec26                	sd	s1,24(sp)
ffffffffc0207528:	6384                	ld	s1,0(a5)
ffffffffc020752a:	f406                	sd	ra,40(sp)
ffffffffc020752c:	f022                	sd	s0,32(sp)
ffffffffc020752e:	e84a                	sd	s2,16(sp)
ffffffffc0207530:	ccbd                	beqz	s1,ffffffffc02075ae <vfs_getcwd+0x96>
ffffffffc0207532:	892a                	mv	s2,a0
ffffffffc0207534:	8526                	mv	a0,s1
ffffffffc0207536:	c24ff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc020753a:	74a8                	ld	a0,104(s1)
ffffffffc020753c:	c93d                	beqz	a0,ffffffffc02075b2 <vfs_getcwd+0x9a>
ffffffffc020753e:	9b3ff0ef          	jal	ra,ffffffffc0206ef0 <vfs_get_devname>
ffffffffc0207542:	842a                	mv	s0,a0
ffffffffc0207544:	583020ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc0207548:	862a                	mv	a2,a0
ffffffffc020754a:	85a2                	mv	a1,s0
ffffffffc020754c:	4701                	li	a4,0
ffffffffc020754e:	4685                	li	a3,1
ffffffffc0207550:	854a                	mv	a0,s2
ffffffffc0207552:	9f1fd0ef          	jal	ra,ffffffffc0204f42 <iobuf_move>
ffffffffc0207556:	842a                	mv	s0,a0
ffffffffc0207558:	c919                	beqz	a0,ffffffffc020756e <vfs_getcwd+0x56>
ffffffffc020755a:	8526                	mv	a0,s1
ffffffffc020755c:	cccff0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0207560:	70a2                	ld	ra,40(sp)
ffffffffc0207562:	8522                	mv	a0,s0
ffffffffc0207564:	7402                	ld	s0,32(sp)
ffffffffc0207566:	64e2                	ld	s1,24(sp)
ffffffffc0207568:	6942                	ld	s2,16(sp)
ffffffffc020756a:	6145                	addi	sp,sp,48
ffffffffc020756c:	8082                	ret
ffffffffc020756e:	03a00793          	li	a5,58
ffffffffc0207572:	4701                	li	a4,0
ffffffffc0207574:	4685                	li	a3,1
ffffffffc0207576:	4605                	li	a2,1
ffffffffc0207578:	00f10593          	addi	a1,sp,15
ffffffffc020757c:	854a                	mv	a0,s2
ffffffffc020757e:	00f107a3          	sb	a5,15(sp)
ffffffffc0207582:	9c1fd0ef          	jal	ra,ffffffffc0204f42 <iobuf_move>
ffffffffc0207586:	842a                	mv	s0,a0
ffffffffc0207588:	f969                	bnez	a0,ffffffffc020755a <vfs_getcwd+0x42>
ffffffffc020758a:	78bc                	ld	a5,112(s1)
ffffffffc020758c:	c3b9                	beqz	a5,ffffffffc02075d2 <vfs_getcwd+0xba>
ffffffffc020758e:	7f9c                	ld	a5,56(a5)
ffffffffc0207590:	c3a9                	beqz	a5,ffffffffc02075d2 <vfs_getcwd+0xba>
ffffffffc0207592:	00006597          	auipc	a1,0x6
ffffffffc0207596:	09658593          	addi	a1,a1,150 # ffffffffc020d628 <syscalls+0xe10>
ffffffffc020759a:	8526                	mv	a0,s1
ffffffffc020759c:	bd6ff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02075a0:	78bc                	ld	a5,112(s1)
ffffffffc02075a2:	85ca                	mv	a1,s2
ffffffffc02075a4:	8526                	mv	a0,s1
ffffffffc02075a6:	7f9c                	ld	a5,56(a5)
ffffffffc02075a8:	9782                	jalr	a5
ffffffffc02075aa:	842a                	mv	s0,a0
ffffffffc02075ac:	b77d                	j	ffffffffc020755a <vfs_getcwd+0x42>
ffffffffc02075ae:	5441                	li	s0,-16
ffffffffc02075b0:	bf45                	j	ffffffffc0207560 <vfs_getcwd+0x48>
ffffffffc02075b2:	00006697          	auipc	a3,0x6
ffffffffc02075b6:	f3e68693          	addi	a3,a3,-194 # ffffffffc020d4f0 <syscalls+0xcd8>
ffffffffc02075ba:	00003617          	auipc	a2,0x3
ffffffffc02075be:	29660613          	addi	a2,a2,662 # ffffffffc020a850 <commands+0x210>
ffffffffc02075c2:	06e00593          	li	a1,110
ffffffffc02075c6:	00006517          	auipc	a0,0x6
ffffffffc02075ca:	fea50513          	addi	a0,a0,-22 # ffffffffc020d5b0 <syscalls+0xd98>
ffffffffc02075ce:	ed1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02075d2:	00006697          	auipc	a3,0x6
ffffffffc02075d6:	ffe68693          	addi	a3,a3,-2 # ffffffffc020d5d0 <syscalls+0xdb8>
ffffffffc02075da:	00003617          	auipc	a2,0x3
ffffffffc02075de:	27660613          	addi	a2,a2,630 # ffffffffc020a850 <commands+0x210>
ffffffffc02075e2:	07800593          	li	a1,120
ffffffffc02075e6:	00006517          	auipc	a0,0x6
ffffffffc02075ea:	fca50513          	addi	a0,a0,-54 # ffffffffc020d5b0 <syscalls+0xd98>
ffffffffc02075ee:	eb1f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02075f2 <dev_lookup>:
ffffffffc02075f2:	0005c783          	lbu	a5,0(a1)
ffffffffc02075f6:	e385                	bnez	a5,ffffffffc0207616 <dev_lookup+0x24>
ffffffffc02075f8:	1101                	addi	sp,sp,-32
ffffffffc02075fa:	e822                	sd	s0,16(sp)
ffffffffc02075fc:	e426                	sd	s1,8(sp)
ffffffffc02075fe:	ec06                	sd	ra,24(sp)
ffffffffc0207600:	84aa                	mv	s1,a0
ffffffffc0207602:	8432                	mv	s0,a2
ffffffffc0207604:	b56ff0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc0207608:	60e2                	ld	ra,24(sp)
ffffffffc020760a:	e004                	sd	s1,0(s0)
ffffffffc020760c:	6442                	ld	s0,16(sp)
ffffffffc020760e:	64a2                	ld	s1,8(sp)
ffffffffc0207610:	4501                	li	a0,0
ffffffffc0207612:	6105                	addi	sp,sp,32
ffffffffc0207614:	8082                	ret
ffffffffc0207616:	5541                	li	a0,-16
ffffffffc0207618:	8082                	ret

ffffffffc020761a <dev_fstat>:
ffffffffc020761a:	1101                	addi	sp,sp,-32
ffffffffc020761c:	e426                	sd	s1,8(sp)
ffffffffc020761e:	84ae                	mv	s1,a1
ffffffffc0207620:	e822                	sd	s0,16(sp)
ffffffffc0207622:	02000613          	li	a2,32
ffffffffc0207626:	842a                	mv	s0,a0
ffffffffc0207628:	4581                	li	a1,0
ffffffffc020762a:	8526                	mv	a0,s1
ffffffffc020762c:	ec06                	sd	ra,24(sp)
ffffffffc020762e:	53b020ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0207632:	c429                	beqz	s0,ffffffffc020767c <dev_fstat+0x62>
ffffffffc0207634:	783c                	ld	a5,112(s0)
ffffffffc0207636:	c3b9                	beqz	a5,ffffffffc020767c <dev_fstat+0x62>
ffffffffc0207638:	6bbc                	ld	a5,80(a5)
ffffffffc020763a:	c3a9                	beqz	a5,ffffffffc020767c <dev_fstat+0x62>
ffffffffc020763c:	00006597          	auipc	a1,0x6
ffffffffc0207640:	f8c58593          	addi	a1,a1,-116 # ffffffffc020d5c8 <syscalls+0xdb0>
ffffffffc0207644:	8522                	mv	a0,s0
ffffffffc0207646:	b2cff0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc020764a:	783c                	ld	a5,112(s0)
ffffffffc020764c:	85a6                	mv	a1,s1
ffffffffc020764e:	8522                	mv	a0,s0
ffffffffc0207650:	6bbc                	ld	a5,80(a5)
ffffffffc0207652:	9782                	jalr	a5
ffffffffc0207654:	ed19                	bnez	a0,ffffffffc0207672 <dev_fstat+0x58>
ffffffffc0207656:	4c38                	lw	a4,88(s0)
ffffffffc0207658:	6785                	lui	a5,0x1
ffffffffc020765a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020765e:	02f71f63          	bne	a4,a5,ffffffffc020769c <dev_fstat+0x82>
ffffffffc0207662:	6018                	ld	a4,0(s0)
ffffffffc0207664:	641c                	ld	a5,8(s0)
ffffffffc0207666:	4685                	li	a3,1
ffffffffc0207668:	e494                	sd	a3,8(s1)
ffffffffc020766a:	02e787b3          	mul	a5,a5,a4
ffffffffc020766e:	e898                	sd	a4,16(s1)
ffffffffc0207670:	ec9c                	sd	a5,24(s1)
ffffffffc0207672:	60e2                	ld	ra,24(sp)
ffffffffc0207674:	6442                	ld	s0,16(sp)
ffffffffc0207676:	64a2                	ld	s1,8(sp)
ffffffffc0207678:	6105                	addi	sp,sp,32
ffffffffc020767a:	8082                	ret
ffffffffc020767c:	00006697          	auipc	a3,0x6
ffffffffc0207680:	ee468693          	addi	a3,a3,-284 # ffffffffc020d560 <syscalls+0xd48>
ffffffffc0207684:	00003617          	auipc	a2,0x3
ffffffffc0207688:	1cc60613          	addi	a2,a2,460 # ffffffffc020a850 <commands+0x210>
ffffffffc020768c:	04200593          	li	a1,66
ffffffffc0207690:	00006517          	auipc	a0,0x6
ffffffffc0207694:	fa850513          	addi	a0,a0,-88 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc0207698:	e07f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020769c:	00006697          	auipc	a3,0x6
ffffffffc02076a0:	c8c68693          	addi	a3,a3,-884 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc02076a4:	00003617          	auipc	a2,0x3
ffffffffc02076a8:	1ac60613          	addi	a2,a2,428 # ffffffffc020a850 <commands+0x210>
ffffffffc02076ac:	04500593          	li	a1,69
ffffffffc02076b0:	00006517          	auipc	a0,0x6
ffffffffc02076b4:	f8850513          	addi	a0,a0,-120 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc02076b8:	de7f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076bc <dev_ioctl>:
ffffffffc02076bc:	c909                	beqz	a0,ffffffffc02076ce <dev_ioctl+0x12>
ffffffffc02076be:	4d34                	lw	a3,88(a0)
ffffffffc02076c0:	6705                	lui	a4,0x1
ffffffffc02076c2:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02076c6:	00e69463          	bne	a3,a4,ffffffffc02076ce <dev_ioctl+0x12>
ffffffffc02076ca:	751c                	ld	a5,40(a0)
ffffffffc02076cc:	8782                	jr	a5
ffffffffc02076ce:	1141                	addi	sp,sp,-16
ffffffffc02076d0:	00006697          	auipc	a3,0x6
ffffffffc02076d4:	c5868693          	addi	a3,a3,-936 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc02076d8:	00003617          	auipc	a2,0x3
ffffffffc02076dc:	17860613          	addi	a2,a2,376 # ffffffffc020a850 <commands+0x210>
ffffffffc02076e0:	03500593          	li	a1,53
ffffffffc02076e4:	00006517          	auipc	a0,0x6
ffffffffc02076e8:	f5450513          	addi	a0,a0,-172 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc02076ec:	e406                	sd	ra,8(sp)
ffffffffc02076ee:	db1f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02076f2 <dev_tryseek>:
ffffffffc02076f2:	c51d                	beqz	a0,ffffffffc0207720 <dev_tryseek+0x2e>
ffffffffc02076f4:	4d38                	lw	a4,88(a0)
ffffffffc02076f6:	6785                	lui	a5,0x1
ffffffffc02076f8:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02076fc:	02f71263          	bne	a4,a5,ffffffffc0207720 <dev_tryseek+0x2e>
ffffffffc0207700:	611c                	ld	a5,0(a0)
ffffffffc0207702:	cf89                	beqz	a5,ffffffffc020771c <dev_tryseek+0x2a>
ffffffffc0207704:	6518                	ld	a4,8(a0)
ffffffffc0207706:	02e5f6b3          	remu	a3,a1,a4
ffffffffc020770a:	ea89                	bnez	a3,ffffffffc020771c <dev_tryseek+0x2a>
ffffffffc020770c:	0005c863          	bltz	a1,ffffffffc020771c <dev_tryseek+0x2a>
ffffffffc0207710:	02e787b3          	mul	a5,a5,a4
ffffffffc0207714:	00f5f463          	bgeu	a1,a5,ffffffffc020771c <dev_tryseek+0x2a>
ffffffffc0207718:	4501                	li	a0,0
ffffffffc020771a:	8082                	ret
ffffffffc020771c:	5575                	li	a0,-3
ffffffffc020771e:	8082                	ret
ffffffffc0207720:	1141                	addi	sp,sp,-16
ffffffffc0207722:	00006697          	auipc	a3,0x6
ffffffffc0207726:	c0668693          	addi	a3,a3,-1018 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc020772a:	00003617          	auipc	a2,0x3
ffffffffc020772e:	12660613          	addi	a2,a2,294 # ffffffffc020a850 <commands+0x210>
ffffffffc0207732:	05f00593          	li	a1,95
ffffffffc0207736:	00006517          	auipc	a0,0x6
ffffffffc020773a:	f0250513          	addi	a0,a0,-254 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc020773e:	e406                	sd	ra,8(sp)
ffffffffc0207740:	d5ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207744 <dev_gettype>:
ffffffffc0207744:	c10d                	beqz	a0,ffffffffc0207766 <dev_gettype+0x22>
ffffffffc0207746:	4d38                	lw	a4,88(a0)
ffffffffc0207748:	6785                	lui	a5,0x1
ffffffffc020774a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020774e:	00f71c63          	bne	a4,a5,ffffffffc0207766 <dev_gettype+0x22>
ffffffffc0207752:	6118                	ld	a4,0(a0)
ffffffffc0207754:	6795                	lui	a5,0x5
ffffffffc0207756:	c701                	beqz	a4,ffffffffc020775e <dev_gettype+0x1a>
ffffffffc0207758:	c19c                	sw	a5,0(a1)
ffffffffc020775a:	4501                	li	a0,0
ffffffffc020775c:	8082                	ret
ffffffffc020775e:	6791                	lui	a5,0x4
ffffffffc0207760:	c19c                	sw	a5,0(a1)
ffffffffc0207762:	4501                	li	a0,0
ffffffffc0207764:	8082                	ret
ffffffffc0207766:	1141                	addi	sp,sp,-16
ffffffffc0207768:	00006697          	auipc	a3,0x6
ffffffffc020776c:	bc068693          	addi	a3,a3,-1088 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207770:	00003617          	auipc	a2,0x3
ffffffffc0207774:	0e060613          	addi	a2,a2,224 # ffffffffc020a850 <commands+0x210>
ffffffffc0207778:	05300593          	li	a1,83
ffffffffc020777c:	00006517          	auipc	a0,0x6
ffffffffc0207780:	ebc50513          	addi	a0,a0,-324 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc0207784:	e406                	sd	ra,8(sp)
ffffffffc0207786:	d19f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020778a <dev_write>:
ffffffffc020778a:	c911                	beqz	a0,ffffffffc020779e <dev_write+0x14>
ffffffffc020778c:	4d34                	lw	a3,88(a0)
ffffffffc020778e:	6705                	lui	a4,0x1
ffffffffc0207790:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207794:	00e69563          	bne	a3,a4,ffffffffc020779e <dev_write+0x14>
ffffffffc0207798:	711c                	ld	a5,32(a0)
ffffffffc020779a:	4605                	li	a2,1
ffffffffc020779c:	8782                	jr	a5
ffffffffc020779e:	1141                	addi	sp,sp,-16
ffffffffc02077a0:	00006697          	auipc	a3,0x6
ffffffffc02077a4:	b8868693          	addi	a3,a3,-1144 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc02077a8:	00003617          	auipc	a2,0x3
ffffffffc02077ac:	0a860613          	addi	a2,a2,168 # ffffffffc020a850 <commands+0x210>
ffffffffc02077b0:	02c00593          	li	a1,44
ffffffffc02077b4:	00006517          	auipc	a0,0x6
ffffffffc02077b8:	e8450513          	addi	a0,a0,-380 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc02077bc:	e406                	sd	ra,8(sp)
ffffffffc02077be:	ce1f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077c2 <dev_read>:
ffffffffc02077c2:	c911                	beqz	a0,ffffffffc02077d6 <dev_read+0x14>
ffffffffc02077c4:	4d34                	lw	a3,88(a0)
ffffffffc02077c6:	6705                	lui	a4,0x1
ffffffffc02077c8:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02077cc:	00e69563          	bne	a3,a4,ffffffffc02077d6 <dev_read+0x14>
ffffffffc02077d0:	711c                	ld	a5,32(a0)
ffffffffc02077d2:	4601                	li	a2,0
ffffffffc02077d4:	8782                	jr	a5
ffffffffc02077d6:	1141                	addi	sp,sp,-16
ffffffffc02077d8:	00006697          	auipc	a3,0x6
ffffffffc02077dc:	b5068693          	addi	a3,a3,-1200 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc02077e0:	00003617          	auipc	a2,0x3
ffffffffc02077e4:	07060613          	addi	a2,a2,112 # ffffffffc020a850 <commands+0x210>
ffffffffc02077e8:	02300593          	li	a1,35
ffffffffc02077ec:	00006517          	auipc	a0,0x6
ffffffffc02077f0:	e4c50513          	addi	a0,a0,-436 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc02077f4:	e406                	sd	ra,8(sp)
ffffffffc02077f6:	ca9f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02077fa <dev_close>:
ffffffffc02077fa:	c909                	beqz	a0,ffffffffc020780c <dev_close+0x12>
ffffffffc02077fc:	4d34                	lw	a3,88(a0)
ffffffffc02077fe:	6705                	lui	a4,0x1
ffffffffc0207800:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207804:	00e69463          	bne	a3,a4,ffffffffc020780c <dev_close+0x12>
ffffffffc0207808:	6d1c                	ld	a5,24(a0)
ffffffffc020780a:	8782                	jr	a5
ffffffffc020780c:	1141                	addi	sp,sp,-16
ffffffffc020780e:	00006697          	auipc	a3,0x6
ffffffffc0207812:	b1a68693          	addi	a3,a3,-1254 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207816:	00003617          	auipc	a2,0x3
ffffffffc020781a:	03a60613          	addi	a2,a2,58 # ffffffffc020a850 <commands+0x210>
ffffffffc020781e:	45e9                	li	a1,26
ffffffffc0207820:	00006517          	auipc	a0,0x6
ffffffffc0207824:	e1850513          	addi	a0,a0,-488 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc0207828:	e406                	sd	ra,8(sp)
ffffffffc020782a:	c75f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020782e <dev_open>:
ffffffffc020782e:	03c5f713          	andi	a4,a1,60
ffffffffc0207832:	eb11                	bnez	a4,ffffffffc0207846 <dev_open+0x18>
ffffffffc0207834:	c919                	beqz	a0,ffffffffc020784a <dev_open+0x1c>
ffffffffc0207836:	4d34                	lw	a3,88(a0)
ffffffffc0207838:	6705                	lui	a4,0x1
ffffffffc020783a:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020783e:	00e69663          	bne	a3,a4,ffffffffc020784a <dev_open+0x1c>
ffffffffc0207842:	691c                	ld	a5,16(a0)
ffffffffc0207844:	8782                	jr	a5
ffffffffc0207846:	5575                	li	a0,-3
ffffffffc0207848:	8082                	ret
ffffffffc020784a:	1141                	addi	sp,sp,-16
ffffffffc020784c:	00006697          	auipc	a3,0x6
ffffffffc0207850:	adc68693          	addi	a3,a3,-1316 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207854:	00003617          	auipc	a2,0x3
ffffffffc0207858:	ffc60613          	addi	a2,a2,-4 # ffffffffc020a850 <commands+0x210>
ffffffffc020785c:	45c5                	li	a1,17
ffffffffc020785e:	00006517          	auipc	a0,0x6
ffffffffc0207862:	dda50513          	addi	a0,a0,-550 # ffffffffc020d638 <syscalls+0xe20>
ffffffffc0207866:	e406                	sd	ra,8(sp)
ffffffffc0207868:	c37f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020786c <dev_init>:
ffffffffc020786c:	1141                	addi	sp,sp,-16
ffffffffc020786e:	e406                	sd	ra,8(sp)
ffffffffc0207870:	542000ef          	jal	ra,ffffffffc0207db2 <dev_init_stdin>
ffffffffc0207874:	65a000ef          	jal	ra,ffffffffc0207ece <dev_init_stdout>
ffffffffc0207878:	60a2                	ld	ra,8(sp)
ffffffffc020787a:	0141                	addi	sp,sp,16
ffffffffc020787c:	a439                	j	ffffffffc0207a8a <dev_init_disk0>

ffffffffc020787e <dev_create_inode>:
ffffffffc020787e:	6505                	lui	a0,0x1
ffffffffc0207880:	1141                	addi	sp,sp,-16
ffffffffc0207882:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207886:	e022                	sd	s0,0(sp)
ffffffffc0207888:	e406                	sd	ra,8(sp)
ffffffffc020788a:	852ff0ef          	jal	ra,ffffffffc02068dc <__alloc_inode>
ffffffffc020788e:	842a                	mv	s0,a0
ffffffffc0207890:	c901                	beqz	a0,ffffffffc02078a0 <dev_create_inode+0x22>
ffffffffc0207892:	4601                	li	a2,0
ffffffffc0207894:	00006597          	auipc	a1,0x6
ffffffffc0207898:	dbc58593          	addi	a1,a1,-580 # ffffffffc020d650 <dev_node_ops>
ffffffffc020789c:	85cff0ef          	jal	ra,ffffffffc02068f8 <inode_init>
ffffffffc02078a0:	60a2                	ld	ra,8(sp)
ffffffffc02078a2:	8522                	mv	a0,s0
ffffffffc02078a4:	6402                	ld	s0,0(sp)
ffffffffc02078a6:	0141                	addi	sp,sp,16
ffffffffc02078a8:	8082                	ret

ffffffffc02078aa <disk0_open>:
ffffffffc02078aa:	4501                	li	a0,0
ffffffffc02078ac:	8082                	ret

ffffffffc02078ae <disk0_close>:
ffffffffc02078ae:	4501                	li	a0,0
ffffffffc02078b0:	8082                	ret

ffffffffc02078b2 <disk0_ioctl>:
ffffffffc02078b2:	5531                	li	a0,-20
ffffffffc02078b4:	8082                	ret

ffffffffc02078b6 <disk0_io>:
ffffffffc02078b6:	659c                	ld	a5,8(a1)
ffffffffc02078b8:	7159                	addi	sp,sp,-112
ffffffffc02078ba:	eca6                	sd	s1,88(sp)
ffffffffc02078bc:	f45e                	sd	s7,40(sp)
ffffffffc02078be:	6d84                	ld	s1,24(a1)
ffffffffc02078c0:	6b85                	lui	s7,0x1
ffffffffc02078c2:	1bfd                	addi	s7,s7,-1
ffffffffc02078c4:	e4ce                	sd	s3,72(sp)
ffffffffc02078c6:	43f7d993          	srai	s3,a5,0x3f
ffffffffc02078ca:	0179f9b3          	and	s3,s3,s7
ffffffffc02078ce:	99be                	add	s3,s3,a5
ffffffffc02078d0:	8fc5                	or	a5,a5,s1
ffffffffc02078d2:	f486                	sd	ra,104(sp)
ffffffffc02078d4:	f0a2                	sd	s0,96(sp)
ffffffffc02078d6:	e8ca                	sd	s2,80(sp)
ffffffffc02078d8:	e0d2                	sd	s4,64(sp)
ffffffffc02078da:	fc56                	sd	s5,56(sp)
ffffffffc02078dc:	f85a                	sd	s6,48(sp)
ffffffffc02078de:	f062                	sd	s8,32(sp)
ffffffffc02078e0:	ec66                	sd	s9,24(sp)
ffffffffc02078e2:	e86a                	sd	s10,16(sp)
ffffffffc02078e4:	0177f7b3          	and	a5,a5,s7
ffffffffc02078e8:	10079d63          	bnez	a5,ffffffffc0207a02 <disk0_io+0x14c>
ffffffffc02078ec:	40c9d993          	srai	s3,s3,0xc
ffffffffc02078f0:	00c4d713          	srli	a4,s1,0xc
ffffffffc02078f4:	2981                	sext.w	s3,s3
ffffffffc02078f6:	2701                	sext.w	a4,a4
ffffffffc02078f8:	00e987bb          	addw	a5,s3,a4
ffffffffc02078fc:	6114                	ld	a3,0(a0)
ffffffffc02078fe:	1782                	slli	a5,a5,0x20
ffffffffc0207900:	9381                	srli	a5,a5,0x20
ffffffffc0207902:	10f6e063          	bltu	a3,a5,ffffffffc0207a02 <disk0_io+0x14c>
ffffffffc0207906:	4501                	li	a0,0
ffffffffc0207908:	ef19                	bnez	a4,ffffffffc0207926 <disk0_io+0x70>
ffffffffc020790a:	70a6                	ld	ra,104(sp)
ffffffffc020790c:	7406                	ld	s0,96(sp)
ffffffffc020790e:	64e6                	ld	s1,88(sp)
ffffffffc0207910:	6946                	ld	s2,80(sp)
ffffffffc0207912:	69a6                	ld	s3,72(sp)
ffffffffc0207914:	6a06                	ld	s4,64(sp)
ffffffffc0207916:	7ae2                	ld	s5,56(sp)
ffffffffc0207918:	7b42                	ld	s6,48(sp)
ffffffffc020791a:	7ba2                	ld	s7,40(sp)
ffffffffc020791c:	7c02                	ld	s8,32(sp)
ffffffffc020791e:	6ce2                	ld	s9,24(sp)
ffffffffc0207920:	6d42                	ld	s10,16(sp)
ffffffffc0207922:	6165                	addi	sp,sp,112
ffffffffc0207924:	8082                	ret
ffffffffc0207926:	0008d517          	auipc	a0,0x8d
ffffffffc020792a:	f1250513          	addi	a0,a0,-238 # ffffffffc0294838 <disk0_sem>
ffffffffc020792e:	8b2e                	mv	s6,a1
ffffffffc0207930:	8c32                	mv	s8,a2
ffffffffc0207932:	0008ea97          	auipc	s5,0x8e
ffffffffc0207936:	fbea8a93          	addi	s5,s5,-66 # ffffffffc02958f0 <disk0_buffer>
ffffffffc020793a:	f80fc0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020793e:	6c91                	lui	s9,0x4
ffffffffc0207940:	e4b9                	bnez	s1,ffffffffc020798e <disk0_io+0xd8>
ffffffffc0207942:	a845                	j	ffffffffc02079f2 <disk0_io+0x13c>
ffffffffc0207944:	00c4d413          	srli	s0,s1,0xc
ffffffffc0207948:	0034169b          	slliw	a3,s0,0x3
ffffffffc020794c:	00068d1b          	sext.w	s10,a3
ffffffffc0207950:	1682                	slli	a3,a3,0x20
ffffffffc0207952:	2401                	sext.w	s0,s0
ffffffffc0207954:	9281                	srli	a3,a3,0x20
ffffffffc0207956:	8926                	mv	s2,s1
ffffffffc0207958:	00399a1b          	slliw	s4,s3,0x3
ffffffffc020795c:	862e                	mv	a2,a1
ffffffffc020795e:	4509                	li	a0,2
ffffffffc0207960:	85d2                	mv	a1,s4
ffffffffc0207962:	9def90ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0207966:	e165                	bnez	a0,ffffffffc0207a46 <disk0_io+0x190>
ffffffffc0207968:	000ab583          	ld	a1,0(s5)
ffffffffc020796c:	0038                	addi	a4,sp,8
ffffffffc020796e:	4685                	li	a3,1
ffffffffc0207970:	864a                	mv	a2,s2
ffffffffc0207972:	855a                	mv	a0,s6
ffffffffc0207974:	dcefd0ef          	jal	ra,ffffffffc0204f42 <iobuf_move>
ffffffffc0207978:	67a2                	ld	a5,8(sp)
ffffffffc020797a:	09279663          	bne	a5,s2,ffffffffc0207a06 <disk0_io+0x150>
ffffffffc020797e:	017977b3          	and	a5,s2,s7
ffffffffc0207982:	e3d1                	bnez	a5,ffffffffc0207a06 <disk0_io+0x150>
ffffffffc0207984:	412484b3          	sub	s1,s1,s2
ffffffffc0207988:	013409bb          	addw	s3,s0,s3
ffffffffc020798c:	c0bd                	beqz	s1,ffffffffc02079f2 <disk0_io+0x13c>
ffffffffc020798e:	000ab583          	ld	a1,0(s5)
ffffffffc0207992:	000c1b63          	bnez	s8,ffffffffc02079a8 <disk0_io+0xf2>
ffffffffc0207996:	fb94e7e3          	bltu	s1,s9,ffffffffc0207944 <disk0_io+0x8e>
ffffffffc020799a:	02000693          	li	a3,32
ffffffffc020799e:	02000d13          	li	s10,32
ffffffffc02079a2:	4411                	li	s0,4
ffffffffc02079a4:	6911                	lui	s2,0x4
ffffffffc02079a6:	bf4d                	j	ffffffffc0207958 <disk0_io+0xa2>
ffffffffc02079a8:	0038                	addi	a4,sp,8
ffffffffc02079aa:	4681                	li	a3,0
ffffffffc02079ac:	6611                	lui	a2,0x4
ffffffffc02079ae:	855a                	mv	a0,s6
ffffffffc02079b0:	d92fd0ef          	jal	ra,ffffffffc0204f42 <iobuf_move>
ffffffffc02079b4:	6422                	ld	s0,8(sp)
ffffffffc02079b6:	c825                	beqz	s0,ffffffffc0207a26 <disk0_io+0x170>
ffffffffc02079b8:	0684e763          	bltu	s1,s0,ffffffffc0207a26 <disk0_io+0x170>
ffffffffc02079bc:	017477b3          	and	a5,s0,s7
ffffffffc02079c0:	e3bd                	bnez	a5,ffffffffc0207a26 <disk0_io+0x170>
ffffffffc02079c2:	8031                	srli	s0,s0,0xc
ffffffffc02079c4:	0034179b          	slliw	a5,s0,0x3
ffffffffc02079c8:	000ab603          	ld	a2,0(s5)
ffffffffc02079cc:	0039991b          	slliw	s2,s3,0x3
ffffffffc02079d0:	02079693          	slli	a3,a5,0x20
ffffffffc02079d4:	9281                	srli	a3,a3,0x20
ffffffffc02079d6:	85ca                	mv	a1,s2
ffffffffc02079d8:	4509                	li	a0,2
ffffffffc02079da:	2401                	sext.w	s0,s0
ffffffffc02079dc:	00078a1b          	sext.w	s4,a5
ffffffffc02079e0:	9f6f90ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc02079e4:	e151                	bnez	a0,ffffffffc0207a68 <disk0_io+0x1b2>
ffffffffc02079e6:	6922                	ld	s2,8(sp)
ffffffffc02079e8:	013409bb          	addw	s3,s0,s3
ffffffffc02079ec:	412484b3          	sub	s1,s1,s2
ffffffffc02079f0:	fcd9                	bnez	s1,ffffffffc020798e <disk0_io+0xd8>
ffffffffc02079f2:	0008d517          	auipc	a0,0x8d
ffffffffc02079f6:	e4650513          	addi	a0,a0,-442 # ffffffffc0294838 <disk0_sem>
ffffffffc02079fa:	ebcfc0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02079fe:	4501                	li	a0,0
ffffffffc0207a00:	b729                	j	ffffffffc020790a <disk0_io+0x54>
ffffffffc0207a02:	5575                	li	a0,-3
ffffffffc0207a04:	b719                	j	ffffffffc020790a <disk0_io+0x54>
ffffffffc0207a06:	00006697          	auipc	a3,0x6
ffffffffc0207a0a:	dc268693          	addi	a3,a3,-574 # ffffffffc020d7c8 <dev_node_ops+0x178>
ffffffffc0207a0e:	00003617          	auipc	a2,0x3
ffffffffc0207a12:	e4260613          	addi	a2,a2,-446 # ffffffffc020a850 <commands+0x210>
ffffffffc0207a16:	06200593          	li	a1,98
ffffffffc0207a1a:	00006517          	auipc	a0,0x6
ffffffffc0207a1e:	cf650513          	addi	a0,a0,-778 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207a22:	a7df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a26:	00006697          	auipc	a3,0x6
ffffffffc0207a2a:	caa68693          	addi	a3,a3,-854 # ffffffffc020d6d0 <dev_node_ops+0x80>
ffffffffc0207a2e:	00003617          	auipc	a2,0x3
ffffffffc0207a32:	e2260613          	addi	a2,a2,-478 # ffffffffc020a850 <commands+0x210>
ffffffffc0207a36:	05700593          	li	a1,87
ffffffffc0207a3a:	00006517          	auipc	a0,0x6
ffffffffc0207a3e:	cd650513          	addi	a0,a0,-810 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207a42:	a5df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a46:	88aa                	mv	a7,a0
ffffffffc0207a48:	886a                	mv	a6,s10
ffffffffc0207a4a:	87a2                	mv	a5,s0
ffffffffc0207a4c:	8752                	mv	a4,s4
ffffffffc0207a4e:	86ce                	mv	a3,s3
ffffffffc0207a50:	00006617          	auipc	a2,0x6
ffffffffc0207a54:	d3060613          	addi	a2,a2,-720 # ffffffffc020d780 <dev_node_ops+0x130>
ffffffffc0207a58:	02d00593          	li	a1,45
ffffffffc0207a5c:	00006517          	auipc	a0,0x6
ffffffffc0207a60:	cb450513          	addi	a0,a0,-844 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207a64:	a3bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a68:	88aa                	mv	a7,a0
ffffffffc0207a6a:	8852                	mv	a6,s4
ffffffffc0207a6c:	87a2                	mv	a5,s0
ffffffffc0207a6e:	874a                	mv	a4,s2
ffffffffc0207a70:	86ce                	mv	a3,s3
ffffffffc0207a72:	00006617          	auipc	a2,0x6
ffffffffc0207a76:	cbe60613          	addi	a2,a2,-834 # ffffffffc020d730 <dev_node_ops+0xe0>
ffffffffc0207a7a:	03700593          	li	a1,55
ffffffffc0207a7e:	00006517          	auipc	a0,0x6
ffffffffc0207a82:	c9250513          	addi	a0,a0,-878 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207a86:	a19f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a8a <dev_init_disk0>:
ffffffffc0207a8a:	1101                	addi	sp,sp,-32
ffffffffc0207a8c:	ec06                	sd	ra,24(sp)
ffffffffc0207a8e:	e822                	sd	s0,16(sp)
ffffffffc0207a90:	e426                	sd	s1,8(sp)
ffffffffc0207a92:	dedff0ef          	jal	ra,ffffffffc020787e <dev_create_inode>
ffffffffc0207a96:	c541                	beqz	a0,ffffffffc0207b1e <dev_init_disk0+0x94>
ffffffffc0207a98:	4d38                	lw	a4,88(a0)
ffffffffc0207a9a:	6485                	lui	s1,0x1
ffffffffc0207a9c:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207aa0:	842a                	mv	s0,a0
ffffffffc0207aa2:	0cf71f63          	bne	a4,a5,ffffffffc0207b80 <dev_init_disk0+0xf6>
ffffffffc0207aa6:	4509                	li	a0,2
ffffffffc0207aa8:	84cf90ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0207aac:	cd55                	beqz	a0,ffffffffc0207b68 <dev_init_disk0+0xde>
ffffffffc0207aae:	4509                	li	a0,2
ffffffffc0207ab0:	868f90ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0207ab4:	00355793          	srli	a5,a0,0x3
ffffffffc0207ab8:	e01c                	sd	a5,0(s0)
ffffffffc0207aba:	00000797          	auipc	a5,0x0
ffffffffc0207abe:	df078793          	addi	a5,a5,-528 # ffffffffc02078aa <disk0_open>
ffffffffc0207ac2:	e81c                	sd	a5,16(s0)
ffffffffc0207ac4:	00000797          	auipc	a5,0x0
ffffffffc0207ac8:	dea78793          	addi	a5,a5,-534 # ffffffffc02078ae <disk0_close>
ffffffffc0207acc:	ec1c                	sd	a5,24(s0)
ffffffffc0207ace:	00000797          	auipc	a5,0x0
ffffffffc0207ad2:	de878793          	addi	a5,a5,-536 # ffffffffc02078b6 <disk0_io>
ffffffffc0207ad6:	f01c                	sd	a5,32(s0)
ffffffffc0207ad8:	00000797          	auipc	a5,0x0
ffffffffc0207adc:	dda78793          	addi	a5,a5,-550 # ffffffffc02078b2 <disk0_ioctl>
ffffffffc0207ae0:	f41c                	sd	a5,40(s0)
ffffffffc0207ae2:	4585                	li	a1,1
ffffffffc0207ae4:	0008d517          	auipc	a0,0x8d
ffffffffc0207ae8:	d5450513          	addi	a0,a0,-684 # ffffffffc0294838 <disk0_sem>
ffffffffc0207aec:	e404                	sd	s1,8(s0)
ffffffffc0207aee:	dc2fc0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0207af2:	6511                	lui	a0,0x4
ffffffffc0207af4:	c9afa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207af8:	0008e797          	auipc	a5,0x8e
ffffffffc0207afc:	dea7bc23          	sd	a0,-520(a5) # ffffffffc02958f0 <disk0_buffer>
ffffffffc0207b00:	c921                	beqz	a0,ffffffffc0207b50 <dev_init_disk0+0xc6>
ffffffffc0207b02:	4605                	li	a2,1
ffffffffc0207b04:	85a2                	mv	a1,s0
ffffffffc0207b06:	00006517          	auipc	a0,0x6
ffffffffc0207b0a:	d5250513          	addi	a0,a0,-686 # ffffffffc020d858 <dev_node_ops+0x208>
ffffffffc0207b0e:	c2cff0ef          	jal	ra,ffffffffc0206f3a <vfs_add_dev>
ffffffffc0207b12:	e115                	bnez	a0,ffffffffc0207b36 <dev_init_disk0+0xac>
ffffffffc0207b14:	60e2                	ld	ra,24(sp)
ffffffffc0207b16:	6442                	ld	s0,16(sp)
ffffffffc0207b18:	64a2                	ld	s1,8(sp)
ffffffffc0207b1a:	6105                	addi	sp,sp,32
ffffffffc0207b1c:	8082                	ret
ffffffffc0207b1e:	00006617          	auipc	a2,0x6
ffffffffc0207b22:	cda60613          	addi	a2,a2,-806 # ffffffffc020d7f8 <dev_node_ops+0x1a8>
ffffffffc0207b26:	08700593          	li	a1,135
ffffffffc0207b2a:	00006517          	auipc	a0,0x6
ffffffffc0207b2e:	be650513          	addi	a0,a0,-1050 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207b32:	96df80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b36:	86aa                	mv	a3,a0
ffffffffc0207b38:	00006617          	auipc	a2,0x6
ffffffffc0207b3c:	d2860613          	addi	a2,a2,-728 # ffffffffc020d860 <dev_node_ops+0x210>
ffffffffc0207b40:	08d00593          	li	a1,141
ffffffffc0207b44:	00006517          	auipc	a0,0x6
ffffffffc0207b48:	bcc50513          	addi	a0,a0,-1076 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207b4c:	953f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b50:	00006617          	auipc	a2,0x6
ffffffffc0207b54:	ce860613          	addi	a2,a2,-792 # ffffffffc020d838 <dev_node_ops+0x1e8>
ffffffffc0207b58:	07f00593          	li	a1,127
ffffffffc0207b5c:	00006517          	auipc	a0,0x6
ffffffffc0207b60:	bb450513          	addi	a0,a0,-1100 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207b64:	93bf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b68:	00006617          	auipc	a2,0x6
ffffffffc0207b6c:	cb060613          	addi	a2,a2,-848 # ffffffffc020d818 <dev_node_ops+0x1c8>
ffffffffc0207b70:	07300593          	li	a1,115
ffffffffc0207b74:	00006517          	auipc	a0,0x6
ffffffffc0207b78:	b9c50513          	addi	a0,a0,-1124 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207b7c:	923f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207b80:	00005697          	auipc	a3,0x5
ffffffffc0207b84:	7a868693          	addi	a3,a3,1960 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207b88:	00003617          	auipc	a2,0x3
ffffffffc0207b8c:	cc860613          	addi	a2,a2,-824 # ffffffffc020a850 <commands+0x210>
ffffffffc0207b90:	08900593          	li	a1,137
ffffffffc0207b94:	00006517          	auipc	a0,0x6
ffffffffc0207b98:	b7c50513          	addi	a0,a0,-1156 # ffffffffc020d710 <dev_node_ops+0xc0>
ffffffffc0207b9c:	903f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ba0 <stdin_open>:
ffffffffc0207ba0:	4501                	li	a0,0
ffffffffc0207ba2:	e191                	bnez	a1,ffffffffc0207ba6 <stdin_open+0x6>
ffffffffc0207ba4:	8082                	ret
ffffffffc0207ba6:	5575                	li	a0,-3
ffffffffc0207ba8:	8082                	ret

ffffffffc0207baa <stdin_close>:
ffffffffc0207baa:	4501                	li	a0,0
ffffffffc0207bac:	8082                	ret

ffffffffc0207bae <stdin_ioctl>:
ffffffffc0207bae:	5575                	li	a0,-3
ffffffffc0207bb0:	8082                	ret

ffffffffc0207bb2 <stdin_io>:
ffffffffc0207bb2:	7135                	addi	sp,sp,-160
ffffffffc0207bb4:	ed06                	sd	ra,152(sp)
ffffffffc0207bb6:	e922                	sd	s0,144(sp)
ffffffffc0207bb8:	e526                	sd	s1,136(sp)
ffffffffc0207bba:	e14a                	sd	s2,128(sp)
ffffffffc0207bbc:	fcce                	sd	s3,120(sp)
ffffffffc0207bbe:	f8d2                	sd	s4,112(sp)
ffffffffc0207bc0:	f4d6                	sd	s5,104(sp)
ffffffffc0207bc2:	f0da                	sd	s6,96(sp)
ffffffffc0207bc4:	ecde                	sd	s7,88(sp)
ffffffffc0207bc6:	e8e2                	sd	s8,80(sp)
ffffffffc0207bc8:	e4e6                	sd	s9,72(sp)
ffffffffc0207bca:	e0ea                	sd	s10,64(sp)
ffffffffc0207bcc:	fc6e                	sd	s11,56(sp)
ffffffffc0207bce:	14061163          	bnez	a2,ffffffffc0207d10 <stdin_io+0x15e>
ffffffffc0207bd2:	0005bd83          	ld	s11,0(a1)
ffffffffc0207bd6:	0185bd03          	ld	s10,24(a1)
ffffffffc0207bda:	8b2e                	mv	s6,a1
ffffffffc0207bdc:	100027f3          	csrr	a5,sstatus
ffffffffc0207be0:	8b89                	andi	a5,a5,2
ffffffffc0207be2:	10079e63          	bnez	a5,ffffffffc0207cfe <stdin_io+0x14c>
ffffffffc0207be6:	4401                	li	s0,0
ffffffffc0207be8:	100d0963          	beqz	s10,ffffffffc0207cfa <stdin_io+0x148>
ffffffffc0207bec:	0008e997          	auipc	s3,0x8e
ffffffffc0207bf0:	d0c98993          	addi	s3,s3,-756 # ffffffffc02958f8 <p_rpos>
ffffffffc0207bf4:	0009b783          	ld	a5,0(s3)
ffffffffc0207bf8:	800004b7          	lui	s1,0x80000
ffffffffc0207bfc:	6c85                	lui	s9,0x1
ffffffffc0207bfe:	4a81                	li	s5,0
ffffffffc0207c00:	0008ea17          	auipc	s4,0x8e
ffffffffc0207c04:	d00a0a13          	addi	s4,s4,-768 # ffffffffc0295900 <p_wpos>
ffffffffc0207c08:	0491                	addi	s1,s1,4
ffffffffc0207c0a:	0008d917          	auipc	s2,0x8d
ffffffffc0207c0e:	c4690913          	addi	s2,s2,-954 # ffffffffc0294850 <__wait_queue>
ffffffffc0207c12:	1cfd                	addi	s9,s9,-1
ffffffffc0207c14:	000a3703          	ld	a4,0(s4)
ffffffffc0207c18:	000a8c1b          	sext.w	s8,s5
ffffffffc0207c1c:	8be2                	mv	s7,s8
ffffffffc0207c1e:	02e7d763          	bge	a5,a4,ffffffffc0207c4c <stdin_io+0x9a>
ffffffffc0207c22:	a859                	j	ffffffffc0207cb8 <stdin_io+0x106>
ffffffffc0207c24:	815fe0ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc0207c28:	100027f3          	csrr	a5,sstatus
ffffffffc0207c2c:	8b89                	andi	a5,a5,2
ffffffffc0207c2e:	4401                	li	s0,0
ffffffffc0207c30:	ef8d                	bnez	a5,ffffffffc0207c6a <stdin_io+0xb8>
ffffffffc0207c32:	0028                	addi	a0,sp,8
ffffffffc0207c34:	d18fc0ef          	jal	ra,ffffffffc020414c <wait_in_queue>
ffffffffc0207c38:	e121                	bnez	a0,ffffffffc0207c78 <stdin_io+0xc6>
ffffffffc0207c3a:	47c2                	lw	a5,16(sp)
ffffffffc0207c3c:	04979563          	bne	a5,s1,ffffffffc0207c86 <stdin_io+0xd4>
ffffffffc0207c40:	0009b783          	ld	a5,0(s3)
ffffffffc0207c44:	000a3703          	ld	a4,0(s4)
ffffffffc0207c48:	06e7c863          	blt	a5,a4,ffffffffc0207cb8 <stdin_io+0x106>
ffffffffc0207c4c:	8626                	mv	a2,s1
ffffffffc0207c4e:	002c                	addi	a1,sp,8
ffffffffc0207c50:	854a                	mv	a0,s2
ffffffffc0207c52:	e24fc0ef          	jal	ra,ffffffffc0204276 <wait_current_set>
ffffffffc0207c56:	d479                	beqz	s0,ffffffffc0207c24 <stdin_io+0x72>
ffffffffc0207c58:	814f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207c5c:	fdcfe0ef          	jal	ra,ffffffffc0206438 <schedule>
ffffffffc0207c60:	100027f3          	csrr	a5,sstatus
ffffffffc0207c64:	8b89                	andi	a5,a5,2
ffffffffc0207c66:	4401                	li	s0,0
ffffffffc0207c68:	d7e9                	beqz	a5,ffffffffc0207c32 <stdin_io+0x80>
ffffffffc0207c6a:	808f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207c6e:	0028                	addi	a0,sp,8
ffffffffc0207c70:	4405                	li	s0,1
ffffffffc0207c72:	cdafc0ef          	jal	ra,ffffffffc020414c <wait_in_queue>
ffffffffc0207c76:	d171                	beqz	a0,ffffffffc0207c3a <stdin_io+0x88>
ffffffffc0207c78:	002c                	addi	a1,sp,8
ffffffffc0207c7a:	854a                	mv	a0,s2
ffffffffc0207c7c:	c76fc0ef          	jal	ra,ffffffffc02040f2 <wait_queue_del>
ffffffffc0207c80:	47c2                	lw	a5,16(sp)
ffffffffc0207c82:	fa978fe3          	beq	a5,s1,ffffffffc0207c40 <stdin_io+0x8e>
ffffffffc0207c86:	e435                	bnez	s0,ffffffffc0207cf2 <stdin_io+0x140>
ffffffffc0207c88:	060b8963          	beqz	s7,ffffffffc0207cfa <stdin_io+0x148>
ffffffffc0207c8c:	018b3783          	ld	a5,24(s6)
ffffffffc0207c90:	41578ab3          	sub	s5,a5,s5
ffffffffc0207c94:	015b3c23          	sd	s5,24(s6)
ffffffffc0207c98:	60ea                	ld	ra,152(sp)
ffffffffc0207c9a:	644a                	ld	s0,144(sp)
ffffffffc0207c9c:	64aa                	ld	s1,136(sp)
ffffffffc0207c9e:	690a                	ld	s2,128(sp)
ffffffffc0207ca0:	79e6                	ld	s3,120(sp)
ffffffffc0207ca2:	7a46                	ld	s4,112(sp)
ffffffffc0207ca4:	7aa6                	ld	s5,104(sp)
ffffffffc0207ca6:	7b06                	ld	s6,96(sp)
ffffffffc0207ca8:	6c46                	ld	s8,80(sp)
ffffffffc0207caa:	6ca6                	ld	s9,72(sp)
ffffffffc0207cac:	6d06                	ld	s10,64(sp)
ffffffffc0207cae:	7de2                	ld	s11,56(sp)
ffffffffc0207cb0:	855e                	mv	a0,s7
ffffffffc0207cb2:	6be6                	ld	s7,88(sp)
ffffffffc0207cb4:	610d                	addi	sp,sp,160
ffffffffc0207cb6:	8082                	ret
ffffffffc0207cb8:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0207cbc:	03475693          	srli	a3,a4,0x34
ffffffffc0207cc0:	00d78733          	add	a4,a5,a3
ffffffffc0207cc4:	01977733          	and	a4,a4,s9
ffffffffc0207cc8:	8f15                	sub	a4,a4,a3
ffffffffc0207cca:	0008d697          	auipc	a3,0x8d
ffffffffc0207cce:	b9668693          	addi	a3,a3,-1130 # ffffffffc0294860 <stdin_buffer>
ffffffffc0207cd2:	9736                	add	a4,a4,a3
ffffffffc0207cd4:	00074683          	lbu	a3,0(a4)
ffffffffc0207cd8:	0785                	addi	a5,a5,1
ffffffffc0207cda:	015d8733          	add	a4,s11,s5
ffffffffc0207cde:	00d70023          	sb	a3,0(a4)
ffffffffc0207ce2:	00f9b023          	sd	a5,0(s3)
ffffffffc0207ce6:	0a85                	addi	s5,s5,1
ffffffffc0207ce8:	001c0b9b          	addiw	s7,s8,1
ffffffffc0207cec:	f3aae4e3          	bltu	s5,s10,ffffffffc0207c14 <stdin_io+0x62>
ffffffffc0207cf0:	dc51                	beqz	s0,ffffffffc0207c8c <stdin_io+0xda>
ffffffffc0207cf2:	f7bf80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207cf6:	f80b9be3          	bnez	s7,ffffffffc0207c8c <stdin_io+0xda>
ffffffffc0207cfa:	4b81                	li	s7,0
ffffffffc0207cfc:	bf71                	j	ffffffffc0207c98 <stdin_io+0xe6>
ffffffffc0207cfe:	f75f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207d02:	4405                	li	s0,1
ffffffffc0207d04:	ee0d14e3          	bnez	s10,ffffffffc0207bec <stdin_io+0x3a>
ffffffffc0207d08:	f65f80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0207d0c:	4b81                	li	s7,0
ffffffffc0207d0e:	b769                	j	ffffffffc0207c98 <stdin_io+0xe6>
ffffffffc0207d10:	5bf5                	li	s7,-3
ffffffffc0207d12:	b759                	j	ffffffffc0207c98 <stdin_io+0xe6>

ffffffffc0207d14 <dev_stdin_write>:
ffffffffc0207d14:	e111                	bnez	a0,ffffffffc0207d18 <dev_stdin_write+0x4>
ffffffffc0207d16:	8082                	ret
ffffffffc0207d18:	1101                	addi	sp,sp,-32
ffffffffc0207d1a:	e822                	sd	s0,16(sp)
ffffffffc0207d1c:	ec06                	sd	ra,24(sp)
ffffffffc0207d1e:	e426                	sd	s1,8(sp)
ffffffffc0207d20:	842a                	mv	s0,a0
ffffffffc0207d22:	100027f3          	csrr	a5,sstatus
ffffffffc0207d26:	8b89                	andi	a5,a5,2
ffffffffc0207d28:	4481                	li	s1,0
ffffffffc0207d2a:	e3c1                	bnez	a5,ffffffffc0207daa <dev_stdin_write+0x96>
ffffffffc0207d2c:	0008e597          	auipc	a1,0x8e
ffffffffc0207d30:	bd458593          	addi	a1,a1,-1068 # ffffffffc0295900 <p_wpos>
ffffffffc0207d34:	6198                	ld	a4,0(a1)
ffffffffc0207d36:	6605                	lui	a2,0x1
ffffffffc0207d38:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0207d3c:	43f75693          	srai	a3,a4,0x3f
ffffffffc0207d40:	92d1                	srli	a3,a3,0x34
ffffffffc0207d42:	00d707b3          	add	a5,a4,a3
ffffffffc0207d46:	8fe9                	and	a5,a5,a0
ffffffffc0207d48:	8f95                	sub	a5,a5,a3
ffffffffc0207d4a:	0008d697          	auipc	a3,0x8d
ffffffffc0207d4e:	b1668693          	addi	a3,a3,-1258 # ffffffffc0294860 <stdin_buffer>
ffffffffc0207d52:	97b6                	add	a5,a5,a3
ffffffffc0207d54:	00878023          	sb	s0,0(a5)
ffffffffc0207d58:	0008e797          	auipc	a5,0x8e
ffffffffc0207d5c:	ba07b783          	ld	a5,-1120(a5) # ffffffffc02958f8 <p_rpos>
ffffffffc0207d60:	40f707b3          	sub	a5,a4,a5
ffffffffc0207d64:	00c7d463          	bge	a5,a2,ffffffffc0207d6c <dev_stdin_write+0x58>
ffffffffc0207d68:	0705                	addi	a4,a4,1
ffffffffc0207d6a:	e198                	sd	a4,0(a1)
ffffffffc0207d6c:	0008d517          	auipc	a0,0x8d
ffffffffc0207d70:	ae450513          	addi	a0,a0,-1308 # ffffffffc0294850 <__wait_queue>
ffffffffc0207d74:	bccfc0ef          	jal	ra,ffffffffc0204140 <wait_queue_empty>
ffffffffc0207d78:	cd09                	beqz	a0,ffffffffc0207d92 <dev_stdin_write+0x7e>
ffffffffc0207d7a:	e491                	bnez	s1,ffffffffc0207d86 <dev_stdin_write+0x72>
ffffffffc0207d7c:	60e2                	ld	ra,24(sp)
ffffffffc0207d7e:	6442                	ld	s0,16(sp)
ffffffffc0207d80:	64a2                	ld	s1,8(sp)
ffffffffc0207d82:	6105                	addi	sp,sp,32
ffffffffc0207d84:	8082                	ret
ffffffffc0207d86:	6442                	ld	s0,16(sp)
ffffffffc0207d88:	60e2                	ld	ra,24(sp)
ffffffffc0207d8a:	64a2                	ld	s1,8(sp)
ffffffffc0207d8c:	6105                	addi	sp,sp,32
ffffffffc0207d8e:	edff806f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207d92:	800005b7          	lui	a1,0x80000
ffffffffc0207d96:	4605                	li	a2,1
ffffffffc0207d98:	0591                	addi	a1,a1,4
ffffffffc0207d9a:	0008d517          	auipc	a0,0x8d
ffffffffc0207d9e:	ab650513          	addi	a0,a0,-1354 # ffffffffc0294850 <__wait_queue>
ffffffffc0207da2:	c06fc0ef          	jal	ra,ffffffffc02041a8 <wakeup_queue>
ffffffffc0207da6:	d8f9                	beqz	s1,ffffffffc0207d7c <dev_stdin_write+0x68>
ffffffffc0207da8:	bff9                	j	ffffffffc0207d86 <dev_stdin_write+0x72>
ffffffffc0207daa:	ec9f80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207dae:	4485                	li	s1,1
ffffffffc0207db0:	bfb5                	j	ffffffffc0207d2c <dev_stdin_write+0x18>

ffffffffc0207db2 <dev_init_stdin>:
ffffffffc0207db2:	1141                	addi	sp,sp,-16
ffffffffc0207db4:	e406                	sd	ra,8(sp)
ffffffffc0207db6:	e022                	sd	s0,0(sp)
ffffffffc0207db8:	ac7ff0ef          	jal	ra,ffffffffc020787e <dev_create_inode>
ffffffffc0207dbc:	c93d                	beqz	a0,ffffffffc0207e32 <dev_init_stdin+0x80>
ffffffffc0207dbe:	4d38                	lw	a4,88(a0)
ffffffffc0207dc0:	6785                	lui	a5,0x1
ffffffffc0207dc2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207dc6:	842a                	mv	s0,a0
ffffffffc0207dc8:	08f71e63          	bne	a4,a5,ffffffffc0207e64 <dev_init_stdin+0xb2>
ffffffffc0207dcc:	4785                	li	a5,1
ffffffffc0207dce:	e41c                	sd	a5,8(s0)
ffffffffc0207dd0:	00000797          	auipc	a5,0x0
ffffffffc0207dd4:	dd078793          	addi	a5,a5,-560 # ffffffffc0207ba0 <stdin_open>
ffffffffc0207dd8:	e81c                	sd	a5,16(s0)
ffffffffc0207dda:	00000797          	auipc	a5,0x0
ffffffffc0207dde:	dd078793          	addi	a5,a5,-560 # ffffffffc0207baa <stdin_close>
ffffffffc0207de2:	ec1c                	sd	a5,24(s0)
ffffffffc0207de4:	00000797          	auipc	a5,0x0
ffffffffc0207de8:	dce78793          	addi	a5,a5,-562 # ffffffffc0207bb2 <stdin_io>
ffffffffc0207dec:	f01c                	sd	a5,32(s0)
ffffffffc0207dee:	00000797          	auipc	a5,0x0
ffffffffc0207df2:	dc078793          	addi	a5,a5,-576 # ffffffffc0207bae <stdin_ioctl>
ffffffffc0207df6:	f41c                	sd	a5,40(s0)
ffffffffc0207df8:	0008d517          	auipc	a0,0x8d
ffffffffc0207dfc:	a5850513          	addi	a0,a0,-1448 # ffffffffc0294850 <__wait_queue>
ffffffffc0207e00:	00043023          	sd	zero,0(s0)
ffffffffc0207e04:	0008e797          	auipc	a5,0x8e
ffffffffc0207e08:	ae07be23          	sd	zero,-1284(a5) # ffffffffc0295900 <p_wpos>
ffffffffc0207e0c:	0008e797          	auipc	a5,0x8e
ffffffffc0207e10:	ae07b623          	sd	zero,-1300(a5) # ffffffffc02958f8 <p_rpos>
ffffffffc0207e14:	ad8fc0ef          	jal	ra,ffffffffc02040ec <wait_queue_init>
ffffffffc0207e18:	4601                	li	a2,0
ffffffffc0207e1a:	85a2                	mv	a1,s0
ffffffffc0207e1c:	00006517          	auipc	a0,0x6
ffffffffc0207e20:	aa450513          	addi	a0,a0,-1372 # ffffffffc020d8c0 <dev_node_ops+0x270>
ffffffffc0207e24:	916ff0ef          	jal	ra,ffffffffc0206f3a <vfs_add_dev>
ffffffffc0207e28:	e10d                	bnez	a0,ffffffffc0207e4a <dev_init_stdin+0x98>
ffffffffc0207e2a:	60a2                	ld	ra,8(sp)
ffffffffc0207e2c:	6402                	ld	s0,0(sp)
ffffffffc0207e2e:	0141                	addi	sp,sp,16
ffffffffc0207e30:	8082                	ret
ffffffffc0207e32:	00006617          	auipc	a2,0x6
ffffffffc0207e36:	a4e60613          	addi	a2,a2,-1458 # ffffffffc020d880 <dev_node_ops+0x230>
ffffffffc0207e3a:	07500593          	li	a1,117
ffffffffc0207e3e:	00006517          	auipc	a0,0x6
ffffffffc0207e42:	a6250513          	addi	a0,a0,-1438 # ffffffffc020d8a0 <dev_node_ops+0x250>
ffffffffc0207e46:	e58f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e4a:	86aa                	mv	a3,a0
ffffffffc0207e4c:	00006617          	auipc	a2,0x6
ffffffffc0207e50:	a7c60613          	addi	a2,a2,-1412 # ffffffffc020d8c8 <dev_node_ops+0x278>
ffffffffc0207e54:	07b00593          	li	a1,123
ffffffffc0207e58:	00006517          	auipc	a0,0x6
ffffffffc0207e5c:	a4850513          	addi	a0,a0,-1464 # ffffffffc020d8a0 <dev_node_ops+0x250>
ffffffffc0207e60:	e3ef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207e64:	00005697          	auipc	a3,0x5
ffffffffc0207e68:	4c468693          	addi	a3,a3,1220 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207e6c:	00003617          	auipc	a2,0x3
ffffffffc0207e70:	9e460613          	addi	a2,a2,-1564 # ffffffffc020a850 <commands+0x210>
ffffffffc0207e74:	07700593          	li	a1,119
ffffffffc0207e78:	00006517          	auipc	a0,0x6
ffffffffc0207e7c:	a2850513          	addi	a0,a0,-1496 # ffffffffc020d8a0 <dev_node_ops+0x250>
ffffffffc0207e80:	e1ef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e84 <stdout_open>:
ffffffffc0207e84:	4785                	li	a5,1
ffffffffc0207e86:	4501                	li	a0,0
ffffffffc0207e88:	00f59363          	bne	a1,a5,ffffffffc0207e8e <stdout_open+0xa>
ffffffffc0207e8c:	8082                	ret
ffffffffc0207e8e:	5575                	li	a0,-3
ffffffffc0207e90:	8082                	ret

ffffffffc0207e92 <stdout_close>:
ffffffffc0207e92:	4501                	li	a0,0
ffffffffc0207e94:	8082                	ret

ffffffffc0207e96 <stdout_ioctl>:
ffffffffc0207e96:	5575                	li	a0,-3
ffffffffc0207e98:	8082                	ret

ffffffffc0207e9a <stdout_io>:
ffffffffc0207e9a:	ca05                	beqz	a2,ffffffffc0207eca <stdout_io+0x30>
ffffffffc0207e9c:	6d9c                	ld	a5,24(a1)
ffffffffc0207e9e:	1101                	addi	sp,sp,-32
ffffffffc0207ea0:	e822                	sd	s0,16(sp)
ffffffffc0207ea2:	e426                	sd	s1,8(sp)
ffffffffc0207ea4:	ec06                	sd	ra,24(sp)
ffffffffc0207ea6:	6180                	ld	s0,0(a1)
ffffffffc0207ea8:	84ae                	mv	s1,a1
ffffffffc0207eaa:	cb91                	beqz	a5,ffffffffc0207ebe <stdout_io+0x24>
ffffffffc0207eac:	00044503          	lbu	a0,0(s0)
ffffffffc0207eb0:	0405                	addi	s0,s0,1
ffffffffc0207eb2:	b30f80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0207eb6:	6c9c                	ld	a5,24(s1)
ffffffffc0207eb8:	17fd                	addi	a5,a5,-1
ffffffffc0207eba:	ec9c                	sd	a5,24(s1)
ffffffffc0207ebc:	fbe5                	bnez	a5,ffffffffc0207eac <stdout_io+0x12>
ffffffffc0207ebe:	60e2                	ld	ra,24(sp)
ffffffffc0207ec0:	6442                	ld	s0,16(sp)
ffffffffc0207ec2:	64a2                	ld	s1,8(sp)
ffffffffc0207ec4:	4501                	li	a0,0
ffffffffc0207ec6:	6105                	addi	sp,sp,32
ffffffffc0207ec8:	8082                	ret
ffffffffc0207eca:	5575                	li	a0,-3
ffffffffc0207ecc:	8082                	ret

ffffffffc0207ece <dev_init_stdout>:
ffffffffc0207ece:	1141                	addi	sp,sp,-16
ffffffffc0207ed0:	e406                	sd	ra,8(sp)
ffffffffc0207ed2:	9adff0ef          	jal	ra,ffffffffc020787e <dev_create_inode>
ffffffffc0207ed6:	c939                	beqz	a0,ffffffffc0207f2c <dev_init_stdout+0x5e>
ffffffffc0207ed8:	4d38                	lw	a4,88(a0)
ffffffffc0207eda:	6785                	lui	a5,0x1
ffffffffc0207edc:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207ee0:	85aa                	mv	a1,a0
ffffffffc0207ee2:	06f71e63          	bne	a4,a5,ffffffffc0207f5e <dev_init_stdout+0x90>
ffffffffc0207ee6:	4785                	li	a5,1
ffffffffc0207ee8:	e51c                	sd	a5,8(a0)
ffffffffc0207eea:	00000797          	auipc	a5,0x0
ffffffffc0207eee:	f9a78793          	addi	a5,a5,-102 # ffffffffc0207e84 <stdout_open>
ffffffffc0207ef2:	e91c                	sd	a5,16(a0)
ffffffffc0207ef4:	00000797          	auipc	a5,0x0
ffffffffc0207ef8:	f9e78793          	addi	a5,a5,-98 # ffffffffc0207e92 <stdout_close>
ffffffffc0207efc:	ed1c                	sd	a5,24(a0)
ffffffffc0207efe:	00000797          	auipc	a5,0x0
ffffffffc0207f02:	f9c78793          	addi	a5,a5,-100 # ffffffffc0207e9a <stdout_io>
ffffffffc0207f06:	f11c                	sd	a5,32(a0)
ffffffffc0207f08:	00000797          	auipc	a5,0x0
ffffffffc0207f0c:	f8e78793          	addi	a5,a5,-114 # ffffffffc0207e96 <stdout_ioctl>
ffffffffc0207f10:	00053023          	sd	zero,0(a0)
ffffffffc0207f14:	f51c                	sd	a5,40(a0)
ffffffffc0207f16:	4601                	li	a2,0
ffffffffc0207f18:	00006517          	auipc	a0,0x6
ffffffffc0207f1c:	a1050513          	addi	a0,a0,-1520 # ffffffffc020d928 <dev_node_ops+0x2d8>
ffffffffc0207f20:	81aff0ef          	jal	ra,ffffffffc0206f3a <vfs_add_dev>
ffffffffc0207f24:	e105                	bnez	a0,ffffffffc0207f44 <dev_init_stdout+0x76>
ffffffffc0207f26:	60a2                	ld	ra,8(sp)
ffffffffc0207f28:	0141                	addi	sp,sp,16
ffffffffc0207f2a:	8082                	ret
ffffffffc0207f2c:	00006617          	auipc	a2,0x6
ffffffffc0207f30:	9bc60613          	addi	a2,a2,-1604 # ffffffffc020d8e8 <dev_node_ops+0x298>
ffffffffc0207f34:	03700593          	li	a1,55
ffffffffc0207f38:	00006517          	auipc	a0,0x6
ffffffffc0207f3c:	9d050513          	addi	a0,a0,-1584 # ffffffffc020d908 <dev_node_ops+0x2b8>
ffffffffc0207f40:	d5ef80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207f44:	86aa                	mv	a3,a0
ffffffffc0207f46:	00006617          	auipc	a2,0x6
ffffffffc0207f4a:	9ea60613          	addi	a2,a2,-1558 # ffffffffc020d930 <dev_node_ops+0x2e0>
ffffffffc0207f4e:	03d00593          	li	a1,61
ffffffffc0207f52:	00006517          	auipc	a0,0x6
ffffffffc0207f56:	9b650513          	addi	a0,a0,-1610 # ffffffffc020d908 <dev_node_ops+0x2b8>
ffffffffc0207f5a:	d44f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207f5e:	00005697          	auipc	a3,0x5
ffffffffc0207f62:	3ca68693          	addi	a3,a3,970 # ffffffffc020d328 <syscalls+0xb10>
ffffffffc0207f66:	00003617          	auipc	a2,0x3
ffffffffc0207f6a:	8ea60613          	addi	a2,a2,-1814 # ffffffffc020a850 <commands+0x210>
ffffffffc0207f6e:	03900593          	li	a1,57
ffffffffc0207f72:	00006517          	auipc	a0,0x6
ffffffffc0207f76:	99650513          	addi	a0,a0,-1642 # ffffffffc020d908 <dev_node_ops+0x2b8>
ffffffffc0207f7a:	d24f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207f7e <bitmap_translate.part.0>:
ffffffffc0207f7e:	1141                	addi	sp,sp,-16
ffffffffc0207f80:	00006697          	auipc	a3,0x6
ffffffffc0207f84:	9d068693          	addi	a3,a3,-1584 # ffffffffc020d950 <dev_node_ops+0x300>
ffffffffc0207f88:	00003617          	auipc	a2,0x3
ffffffffc0207f8c:	8c860613          	addi	a2,a2,-1848 # ffffffffc020a850 <commands+0x210>
ffffffffc0207f90:	04c00593          	li	a1,76
ffffffffc0207f94:	00006517          	auipc	a0,0x6
ffffffffc0207f98:	9d450513          	addi	a0,a0,-1580 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc0207f9c:	e406                	sd	ra,8(sp)
ffffffffc0207f9e:	d00f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207fa2 <bitmap_create>:
ffffffffc0207fa2:	7139                	addi	sp,sp,-64
ffffffffc0207fa4:	fc06                	sd	ra,56(sp)
ffffffffc0207fa6:	f822                	sd	s0,48(sp)
ffffffffc0207fa8:	f426                	sd	s1,40(sp)
ffffffffc0207faa:	f04a                	sd	s2,32(sp)
ffffffffc0207fac:	ec4e                	sd	s3,24(sp)
ffffffffc0207fae:	e852                	sd	s4,16(sp)
ffffffffc0207fb0:	e456                	sd	s5,8(sp)
ffffffffc0207fb2:	c14d                	beqz	a0,ffffffffc0208054 <bitmap_create+0xb2>
ffffffffc0207fb4:	842a                	mv	s0,a0
ffffffffc0207fb6:	4541                	li	a0,16
ffffffffc0207fb8:	fd7f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207fbc:	84aa                	mv	s1,a0
ffffffffc0207fbe:	cd25                	beqz	a0,ffffffffc0208036 <bitmap_create+0x94>
ffffffffc0207fc0:	02041a13          	slli	s4,s0,0x20
ffffffffc0207fc4:	020a5a13          	srli	s4,s4,0x20
ffffffffc0207fc8:	01fa0793          	addi	a5,s4,31
ffffffffc0207fcc:	0057d993          	srli	s3,a5,0x5
ffffffffc0207fd0:	00299a93          	slli	s5,s3,0x2
ffffffffc0207fd4:	8556                	mv	a0,s5
ffffffffc0207fd6:	894e                	mv	s2,s3
ffffffffc0207fd8:	fb7f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207fdc:	c53d                	beqz	a0,ffffffffc020804a <bitmap_create+0xa8>
ffffffffc0207fde:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0207fe2:	c080                	sw	s0,0(s1)
ffffffffc0207fe4:	8656                	mv	a2,s5
ffffffffc0207fe6:	0ff00593          	li	a1,255
ffffffffc0207fea:	37e020ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0207fee:	e488                	sd	a0,8(s1)
ffffffffc0207ff0:	0996                	slli	s3,s3,0x5
ffffffffc0207ff2:	053a0263          	beq	s4,s3,ffffffffc0208036 <bitmap_create+0x94>
ffffffffc0207ff6:	fff9079b          	addiw	a5,s2,-1
ffffffffc0207ffa:	0057969b          	slliw	a3,a5,0x5
ffffffffc0207ffe:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208002:	40d4073b          	subw	a4,s0,a3
ffffffffc0208006:	0054541b          	srliw	s0,s0,0x5
ffffffffc020800a:	08f61463          	bne	a2,a5,ffffffffc0208092 <bitmap_create+0xf0>
ffffffffc020800e:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208012:	47f9                	li	a5,30
ffffffffc0208014:	04d7ef63          	bltu	a5,a3,ffffffffc0208072 <bitmap_create+0xd0>
ffffffffc0208018:	1402                	slli	s0,s0,0x20
ffffffffc020801a:	8079                	srli	s0,s0,0x1e
ffffffffc020801c:	9522                	add	a0,a0,s0
ffffffffc020801e:	411c                	lw	a5,0(a0)
ffffffffc0208020:	4585                	li	a1,1
ffffffffc0208022:	02000613          	li	a2,32
ffffffffc0208026:	00e596bb          	sllw	a3,a1,a4
ffffffffc020802a:	8fb5                	xor	a5,a5,a3
ffffffffc020802c:	2705                	addiw	a4,a4,1
ffffffffc020802e:	2781                	sext.w	a5,a5
ffffffffc0208030:	fec71be3          	bne	a4,a2,ffffffffc0208026 <bitmap_create+0x84>
ffffffffc0208034:	c11c                	sw	a5,0(a0)
ffffffffc0208036:	70e2                	ld	ra,56(sp)
ffffffffc0208038:	7442                	ld	s0,48(sp)
ffffffffc020803a:	7902                	ld	s2,32(sp)
ffffffffc020803c:	69e2                	ld	s3,24(sp)
ffffffffc020803e:	6a42                	ld	s4,16(sp)
ffffffffc0208040:	6aa2                	ld	s5,8(sp)
ffffffffc0208042:	8526                	mv	a0,s1
ffffffffc0208044:	74a2                	ld	s1,40(sp)
ffffffffc0208046:	6121                	addi	sp,sp,64
ffffffffc0208048:	8082                	ret
ffffffffc020804a:	8526                	mv	a0,s1
ffffffffc020804c:	ff3f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208050:	4481                	li	s1,0
ffffffffc0208052:	b7d5                	j	ffffffffc0208036 <bitmap_create+0x94>
ffffffffc0208054:	00006697          	auipc	a3,0x6
ffffffffc0208058:	92c68693          	addi	a3,a3,-1748 # ffffffffc020d980 <dev_node_ops+0x330>
ffffffffc020805c:	00002617          	auipc	a2,0x2
ffffffffc0208060:	7f460613          	addi	a2,a2,2036 # ffffffffc020a850 <commands+0x210>
ffffffffc0208064:	45d5                	li	a1,21
ffffffffc0208066:	00006517          	auipc	a0,0x6
ffffffffc020806a:	90250513          	addi	a0,a0,-1790 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc020806e:	c30f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208072:	00006697          	auipc	a3,0x6
ffffffffc0208076:	94e68693          	addi	a3,a3,-1714 # ffffffffc020d9c0 <dev_node_ops+0x370>
ffffffffc020807a:	00002617          	auipc	a2,0x2
ffffffffc020807e:	7d660613          	addi	a2,a2,2006 # ffffffffc020a850 <commands+0x210>
ffffffffc0208082:	02b00593          	li	a1,43
ffffffffc0208086:	00006517          	auipc	a0,0x6
ffffffffc020808a:	8e250513          	addi	a0,a0,-1822 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc020808e:	c10f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208092:	00006697          	auipc	a3,0x6
ffffffffc0208096:	91668693          	addi	a3,a3,-1770 # ffffffffc020d9a8 <dev_node_ops+0x358>
ffffffffc020809a:	00002617          	auipc	a2,0x2
ffffffffc020809e:	7b660613          	addi	a2,a2,1974 # ffffffffc020a850 <commands+0x210>
ffffffffc02080a2:	02a00593          	li	a1,42
ffffffffc02080a6:	00006517          	auipc	a0,0x6
ffffffffc02080aa:	8c250513          	addi	a0,a0,-1854 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc02080ae:	bf0f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02080b2 <bitmap_alloc>:
ffffffffc02080b2:	4150                	lw	a2,4(a0)
ffffffffc02080b4:	651c                	ld	a5,8(a0)
ffffffffc02080b6:	c231                	beqz	a2,ffffffffc02080fa <bitmap_alloc+0x48>
ffffffffc02080b8:	4701                	li	a4,0
ffffffffc02080ba:	a029                	j	ffffffffc02080c4 <bitmap_alloc+0x12>
ffffffffc02080bc:	2705                	addiw	a4,a4,1
ffffffffc02080be:	0791                	addi	a5,a5,4
ffffffffc02080c0:	02e60d63          	beq	a2,a4,ffffffffc02080fa <bitmap_alloc+0x48>
ffffffffc02080c4:	4394                	lw	a3,0(a5)
ffffffffc02080c6:	dafd                	beqz	a3,ffffffffc02080bc <bitmap_alloc+0xa>
ffffffffc02080c8:	4501                	li	a0,0
ffffffffc02080ca:	4885                	li	a7,1
ffffffffc02080cc:	8e36                	mv	t3,a3
ffffffffc02080ce:	02000313          	li	t1,32
ffffffffc02080d2:	a021                	j	ffffffffc02080da <bitmap_alloc+0x28>
ffffffffc02080d4:	2505                	addiw	a0,a0,1
ffffffffc02080d6:	02650463          	beq	a0,t1,ffffffffc02080fe <bitmap_alloc+0x4c>
ffffffffc02080da:	00a8983b          	sllw	a6,a7,a0
ffffffffc02080de:	0106f633          	and	a2,a3,a6
ffffffffc02080e2:	2601                	sext.w	a2,a2
ffffffffc02080e4:	da65                	beqz	a2,ffffffffc02080d4 <bitmap_alloc+0x22>
ffffffffc02080e6:	010e4833          	xor	a6,t3,a6
ffffffffc02080ea:	0057171b          	slliw	a4,a4,0x5
ffffffffc02080ee:	9f29                	addw	a4,a4,a0
ffffffffc02080f0:	0107a023          	sw	a6,0(a5)
ffffffffc02080f4:	c198                	sw	a4,0(a1)
ffffffffc02080f6:	4501                	li	a0,0
ffffffffc02080f8:	8082                	ret
ffffffffc02080fa:	5571                	li	a0,-4
ffffffffc02080fc:	8082                	ret
ffffffffc02080fe:	1141                	addi	sp,sp,-16
ffffffffc0208100:	00003697          	auipc	a3,0x3
ffffffffc0208104:	7d068693          	addi	a3,a3,2000 # ffffffffc020b8d0 <default_pmm_manager+0x598>
ffffffffc0208108:	00002617          	auipc	a2,0x2
ffffffffc020810c:	74860613          	addi	a2,a2,1864 # ffffffffc020a850 <commands+0x210>
ffffffffc0208110:	04300593          	li	a1,67
ffffffffc0208114:	00006517          	auipc	a0,0x6
ffffffffc0208118:	85450513          	addi	a0,a0,-1964 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc020811c:	e406                	sd	ra,8(sp)
ffffffffc020811e:	b80f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208122 <bitmap_test>:
ffffffffc0208122:	411c                	lw	a5,0(a0)
ffffffffc0208124:	00f5ff63          	bgeu	a1,a5,ffffffffc0208142 <bitmap_test+0x20>
ffffffffc0208128:	651c                	ld	a5,8(a0)
ffffffffc020812a:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020812e:	070a                	slli	a4,a4,0x2
ffffffffc0208130:	97ba                	add	a5,a5,a4
ffffffffc0208132:	4388                	lw	a0,0(a5)
ffffffffc0208134:	4785                	li	a5,1
ffffffffc0208136:	00b795bb          	sllw	a1,a5,a1
ffffffffc020813a:	8d6d                	and	a0,a0,a1
ffffffffc020813c:	1502                	slli	a0,a0,0x20
ffffffffc020813e:	9101                	srli	a0,a0,0x20
ffffffffc0208140:	8082                	ret
ffffffffc0208142:	1141                	addi	sp,sp,-16
ffffffffc0208144:	e406                	sd	ra,8(sp)
ffffffffc0208146:	e39ff0ef          	jal	ra,ffffffffc0207f7e <bitmap_translate.part.0>

ffffffffc020814a <bitmap_free>:
ffffffffc020814a:	411c                	lw	a5,0(a0)
ffffffffc020814c:	1141                	addi	sp,sp,-16
ffffffffc020814e:	e406                	sd	ra,8(sp)
ffffffffc0208150:	02f5f463          	bgeu	a1,a5,ffffffffc0208178 <bitmap_free+0x2e>
ffffffffc0208154:	651c                	ld	a5,8(a0)
ffffffffc0208156:	0055d71b          	srliw	a4,a1,0x5
ffffffffc020815a:	070a                	slli	a4,a4,0x2
ffffffffc020815c:	97ba                	add	a5,a5,a4
ffffffffc020815e:	4398                	lw	a4,0(a5)
ffffffffc0208160:	4685                	li	a3,1
ffffffffc0208162:	00b695bb          	sllw	a1,a3,a1
ffffffffc0208166:	00b776b3          	and	a3,a4,a1
ffffffffc020816a:	2681                	sext.w	a3,a3
ffffffffc020816c:	ea81                	bnez	a3,ffffffffc020817c <bitmap_free+0x32>
ffffffffc020816e:	60a2                	ld	ra,8(sp)
ffffffffc0208170:	8f4d                	or	a4,a4,a1
ffffffffc0208172:	c398                	sw	a4,0(a5)
ffffffffc0208174:	0141                	addi	sp,sp,16
ffffffffc0208176:	8082                	ret
ffffffffc0208178:	e07ff0ef          	jal	ra,ffffffffc0207f7e <bitmap_translate.part.0>
ffffffffc020817c:	00006697          	auipc	a3,0x6
ffffffffc0208180:	86c68693          	addi	a3,a3,-1940 # ffffffffc020d9e8 <dev_node_ops+0x398>
ffffffffc0208184:	00002617          	auipc	a2,0x2
ffffffffc0208188:	6cc60613          	addi	a2,a2,1740 # ffffffffc020a850 <commands+0x210>
ffffffffc020818c:	05f00593          	li	a1,95
ffffffffc0208190:	00005517          	auipc	a0,0x5
ffffffffc0208194:	7d850513          	addi	a0,a0,2008 # ffffffffc020d968 <dev_node_ops+0x318>
ffffffffc0208198:	b06f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020819c <bitmap_destroy>:
ffffffffc020819c:	1141                	addi	sp,sp,-16
ffffffffc020819e:	e022                	sd	s0,0(sp)
ffffffffc02081a0:	842a                	mv	s0,a0
ffffffffc02081a2:	6508                	ld	a0,8(a0)
ffffffffc02081a4:	e406                	sd	ra,8(sp)
ffffffffc02081a6:	e99f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02081aa:	8522                	mv	a0,s0
ffffffffc02081ac:	6402                	ld	s0,0(sp)
ffffffffc02081ae:	60a2                	ld	ra,8(sp)
ffffffffc02081b0:	0141                	addi	sp,sp,16
ffffffffc02081b2:	e8df906f          	j	ffffffffc020203e <kfree>

ffffffffc02081b6 <bitmap_getdata>:
ffffffffc02081b6:	c589                	beqz	a1,ffffffffc02081c0 <bitmap_getdata+0xa>
ffffffffc02081b8:	00456783          	lwu	a5,4(a0)
ffffffffc02081bc:	078a                	slli	a5,a5,0x2
ffffffffc02081be:	e19c                	sd	a5,0(a1)
ffffffffc02081c0:	6508                	ld	a0,8(a0)
ffffffffc02081c2:	8082                	ret

ffffffffc02081c4 <sfs_init>:
ffffffffc02081c4:	1141                	addi	sp,sp,-16
ffffffffc02081c6:	00005517          	auipc	a0,0x5
ffffffffc02081ca:	69250513          	addi	a0,a0,1682 # ffffffffc020d858 <dev_node_ops+0x208>
ffffffffc02081ce:	e406                	sd	ra,8(sp)
ffffffffc02081d0:	554000ef          	jal	ra,ffffffffc0208724 <sfs_mount>
ffffffffc02081d4:	e501                	bnez	a0,ffffffffc02081dc <sfs_init+0x18>
ffffffffc02081d6:	60a2                	ld	ra,8(sp)
ffffffffc02081d8:	0141                	addi	sp,sp,16
ffffffffc02081da:	8082                	ret
ffffffffc02081dc:	86aa                	mv	a3,a0
ffffffffc02081de:	00006617          	auipc	a2,0x6
ffffffffc02081e2:	81a60613          	addi	a2,a2,-2022 # ffffffffc020d9f8 <dev_node_ops+0x3a8>
ffffffffc02081e6:	45c1                	li	a1,16
ffffffffc02081e8:	00006517          	auipc	a0,0x6
ffffffffc02081ec:	83050513          	addi	a0,a0,-2000 # ffffffffc020da18 <dev_node_ops+0x3c8>
ffffffffc02081f0:	aaef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02081f4 <sfs_unmount>:
ffffffffc02081f4:	1141                	addi	sp,sp,-16
ffffffffc02081f6:	e406                	sd	ra,8(sp)
ffffffffc02081f8:	e022                	sd	s0,0(sp)
ffffffffc02081fa:	cd1d                	beqz	a0,ffffffffc0208238 <sfs_unmount+0x44>
ffffffffc02081fc:	0b052783          	lw	a5,176(a0)
ffffffffc0208200:	842a                	mv	s0,a0
ffffffffc0208202:	eb9d                	bnez	a5,ffffffffc0208238 <sfs_unmount+0x44>
ffffffffc0208204:	7158                	ld	a4,160(a0)
ffffffffc0208206:	09850793          	addi	a5,a0,152
ffffffffc020820a:	02f71563          	bne	a4,a5,ffffffffc0208234 <sfs_unmount+0x40>
ffffffffc020820e:	613c                	ld	a5,64(a0)
ffffffffc0208210:	e7a1                	bnez	a5,ffffffffc0208258 <sfs_unmount+0x64>
ffffffffc0208212:	7d08                	ld	a0,56(a0)
ffffffffc0208214:	f89ff0ef          	jal	ra,ffffffffc020819c <bitmap_destroy>
ffffffffc0208218:	6428                	ld	a0,72(s0)
ffffffffc020821a:	e25f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020821e:	7448                	ld	a0,168(s0)
ffffffffc0208220:	e1ff90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208224:	8522                	mv	a0,s0
ffffffffc0208226:	e19f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020822a:	4501                	li	a0,0
ffffffffc020822c:	60a2                	ld	ra,8(sp)
ffffffffc020822e:	6402                	ld	s0,0(sp)
ffffffffc0208230:	0141                	addi	sp,sp,16
ffffffffc0208232:	8082                	ret
ffffffffc0208234:	5545                	li	a0,-15
ffffffffc0208236:	bfdd                	j	ffffffffc020822c <sfs_unmount+0x38>
ffffffffc0208238:	00005697          	auipc	a3,0x5
ffffffffc020823c:	7f868693          	addi	a3,a3,2040 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208240:	00002617          	auipc	a2,0x2
ffffffffc0208244:	61060613          	addi	a2,a2,1552 # ffffffffc020a850 <commands+0x210>
ffffffffc0208248:	04100593          	li	a1,65
ffffffffc020824c:	00006517          	auipc	a0,0x6
ffffffffc0208250:	81450513          	addi	a0,a0,-2028 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208254:	a4af80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208258:	00006697          	auipc	a3,0x6
ffffffffc020825c:	82068693          	addi	a3,a3,-2016 # ffffffffc020da78 <dev_node_ops+0x428>
ffffffffc0208260:	00002617          	auipc	a2,0x2
ffffffffc0208264:	5f060613          	addi	a2,a2,1520 # ffffffffc020a850 <commands+0x210>
ffffffffc0208268:	04500593          	li	a1,69
ffffffffc020826c:	00005517          	auipc	a0,0x5
ffffffffc0208270:	7f450513          	addi	a0,a0,2036 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208274:	a2af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208278 <sfs_cleanup>:
ffffffffc0208278:	1101                	addi	sp,sp,-32
ffffffffc020827a:	ec06                	sd	ra,24(sp)
ffffffffc020827c:	e822                	sd	s0,16(sp)
ffffffffc020827e:	e426                	sd	s1,8(sp)
ffffffffc0208280:	e04a                	sd	s2,0(sp)
ffffffffc0208282:	c525                	beqz	a0,ffffffffc02082ea <sfs_cleanup+0x72>
ffffffffc0208284:	0b052783          	lw	a5,176(a0)
ffffffffc0208288:	84aa                	mv	s1,a0
ffffffffc020828a:	e3a5                	bnez	a5,ffffffffc02082ea <sfs_cleanup+0x72>
ffffffffc020828c:	4158                	lw	a4,4(a0)
ffffffffc020828e:	4514                	lw	a3,8(a0)
ffffffffc0208290:	00c50913          	addi	s2,a0,12
ffffffffc0208294:	85ca                	mv	a1,s2
ffffffffc0208296:	40d7063b          	subw	a2,a4,a3
ffffffffc020829a:	00005517          	auipc	a0,0x5
ffffffffc020829e:	7f650513          	addi	a0,a0,2038 # ffffffffc020da90 <dev_node_ops+0x440>
ffffffffc02082a2:	f05f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02082a6:	02000413          	li	s0,32
ffffffffc02082aa:	a019                	j	ffffffffc02082b0 <sfs_cleanup+0x38>
ffffffffc02082ac:	347d                	addiw	s0,s0,-1
ffffffffc02082ae:	c819                	beqz	s0,ffffffffc02082c4 <sfs_cleanup+0x4c>
ffffffffc02082b0:	7cdc                	ld	a5,184(s1)
ffffffffc02082b2:	8526                	mv	a0,s1
ffffffffc02082b4:	9782                	jalr	a5
ffffffffc02082b6:	f97d                	bnez	a0,ffffffffc02082ac <sfs_cleanup+0x34>
ffffffffc02082b8:	60e2                	ld	ra,24(sp)
ffffffffc02082ba:	6442                	ld	s0,16(sp)
ffffffffc02082bc:	64a2                	ld	s1,8(sp)
ffffffffc02082be:	6902                	ld	s2,0(sp)
ffffffffc02082c0:	6105                	addi	sp,sp,32
ffffffffc02082c2:	8082                	ret
ffffffffc02082c4:	6442                	ld	s0,16(sp)
ffffffffc02082c6:	60e2                	ld	ra,24(sp)
ffffffffc02082c8:	64a2                	ld	s1,8(sp)
ffffffffc02082ca:	86ca                	mv	a3,s2
ffffffffc02082cc:	6902                	ld	s2,0(sp)
ffffffffc02082ce:	872a                	mv	a4,a0
ffffffffc02082d0:	00005617          	auipc	a2,0x5
ffffffffc02082d4:	7e060613          	addi	a2,a2,2016 # ffffffffc020dab0 <dev_node_ops+0x460>
ffffffffc02082d8:	05f00593          	li	a1,95
ffffffffc02082dc:	00005517          	auipc	a0,0x5
ffffffffc02082e0:	78450513          	addi	a0,a0,1924 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc02082e4:	6105                	addi	sp,sp,32
ffffffffc02082e6:	a20f806f          	j	ffffffffc0200506 <__warn>
ffffffffc02082ea:	00005697          	auipc	a3,0x5
ffffffffc02082ee:	74668693          	addi	a3,a3,1862 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc02082f2:	00002617          	auipc	a2,0x2
ffffffffc02082f6:	55e60613          	addi	a2,a2,1374 # ffffffffc020a850 <commands+0x210>
ffffffffc02082fa:	05400593          	li	a1,84
ffffffffc02082fe:	00005517          	auipc	a0,0x5
ffffffffc0208302:	76250513          	addi	a0,a0,1890 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208306:	998f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020830a <sfs_sync>:
ffffffffc020830a:	7179                	addi	sp,sp,-48
ffffffffc020830c:	f406                	sd	ra,40(sp)
ffffffffc020830e:	f022                	sd	s0,32(sp)
ffffffffc0208310:	ec26                	sd	s1,24(sp)
ffffffffc0208312:	e84a                	sd	s2,16(sp)
ffffffffc0208314:	e44e                	sd	s3,8(sp)
ffffffffc0208316:	e052                	sd	s4,0(sp)
ffffffffc0208318:	cd4d                	beqz	a0,ffffffffc02083d2 <sfs_sync+0xc8>
ffffffffc020831a:	0b052783          	lw	a5,176(a0)
ffffffffc020831e:	8a2a                	mv	s4,a0
ffffffffc0208320:	ebcd                	bnez	a5,ffffffffc02083d2 <sfs_sync+0xc8>
ffffffffc0208322:	2f3010ef          	jal	ra,ffffffffc0209e14 <lock_sfs_fs>
ffffffffc0208326:	0a0a3403          	ld	s0,160(s4)
ffffffffc020832a:	098a0913          	addi	s2,s4,152
ffffffffc020832e:	02890763          	beq	s2,s0,ffffffffc020835c <sfs_sync+0x52>
ffffffffc0208332:	00004997          	auipc	s3,0x4
ffffffffc0208336:	e3e98993          	addi	s3,s3,-450 # ffffffffc020c170 <default_pmm_manager+0xe38>
ffffffffc020833a:	7c1c                	ld	a5,56(s0)
ffffffffc020833c:	fc840493          	addi	s1,s0,-56
ffffffffc0208340:	cbb5                	beqz	a5,ffffffffc02083b4 <sfs_sync+0xaa>
ffffffffc0208342:	7b9c                	ld	a5,48(a5)
ffffffffc0208344:	cba5                	beqz	a5,ffffffffc02083b4 <sfs_sync+0xaa>
ffffffffc0208346:	85ce                	mv	a1,s3
ffffffffc0208348:	8526                	mv	a0,s1
ffffffffc020834a:	e28fe0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc020834e:	7c1c                	ld	a5,56(s0)
ffffffffc0208350:	8526                	mv	a0,s1
ffffffffc0208352:	7b9c                	ld	a5,48(a5)
ffffffffc0208354:	9782                	jalr	a5
ffffffffc0208356:	6400                	ld	s0,8(s0)
ffffffffc0208358:	fe8911e3          	bne	s2,s0,ffffffffc020833a <sfs_sync+0x30>
ffffffffc020835c:	8552                	mv	a0,s4
ffffffffc020835e:	2c7010ef          	jal	ra,ffffffffc0209e24 <unlock_sfs_fs>
ffffffffc0208362:	040a3783          	ld	a5,64(s4)
ffffffffc0208366:	4501                	li	a0,0
ffffffffc0208368:	eb89                	bnez	a5,ffffffffc020837a <sfs_sync+0x70>
ffffffffc020836a:	70a2                	ld	ra,40(sp)
ffffffffc020836c:	7402                	ld	s0,32(sp)
ffffffffc020836e:	64e2                	ld	s1,24(sp)
ffffffffc0208370:	6942                	ld	s2,16(sp)
ffffffffc0208372:	69a2                	ld	s3,8(sp)
ffffffffc0208374:	6a02                	ld	s4,0(sp)
ffffffffc0208376:	6145                	addi	sp,sp,48
ffffffffc0208378:	8082                	ret
ffffffffc020837a:	040a3023          	sd	zero,64(s4)
ffffffffc020837e:	8552                	mv	a0,s4
ffffffffc0208380:	179010ef          	jal	ra,ffffffffc0209cf8 <sfs_sync_super>
ffffffffc0208384:	cd01                	beqz	a0,ffffffffc020839c <sfs_sync+0x92>
ffffffffc0208386:	70a2                	ld	ra,40(sp)
ffffffffc0208388:	7402                	ld	s0,32(sp)
ffffffffc020838a:	4785                	li	a5,1
ffffffffc020838c:	04fa3023          	sd	a5,64(s4)
ffffffffc0208390:	64e2                	ld	s1,24(sp)
ffffffffc0208392:	6942                	ld	s2,16(sp)
ffffffffc0208394:	69a2                	ld	s3,8(sp)
ffffffffc0208396:	6a02                	ld	s4,0(sp)
ffffffffc0208398:	6145                	addi	sp,sp,48
ffffffffc020839a:	8082                	ret
ffffffffc020839c:	8552                	mv	a0,s4
ffffffffc020839e:	1a1010ef          	jal	ra,ffffffffc0209d3e <sfs_sync_freemap>
ffffffffc02083a2:	f175                	bnez	a0,ffffffffc0208386 <sfs_sync+0x7c>
ffffffffc02083a4:	70a2                	ld	ra,40(sp)
ffffffffc02083a6:	7402                	ld	s0,32(sp)
ffffffffc02083a8:	64e2                	ld	s1,24(sp)
ffffffffc02083aa:	6942                	ld	s2,16(sp)
ffffffffc02083ac:	69a2                	ld	s3,8(sp)
ffffffffc02083ae:	6a02                	ld	s4,0(sp)
ffffffffc02083b0:	6145                	addi	sp,sp,48
ffffffffc02083b2:	8082                	ret
ffffffffc02083b4:	00004697          	auipc	a3,0x4
ffffffffc02083b8:	d6c68693          	addi	a3,a3,-660 # ffffffffc020c120 <default_pmm_manager+0xde8>
ffffffffc02083bc:	00002617          	auipc	a2,0x2
ffffffffc02083c0:	49460613          	addi	a2,a2,1172 # ffffffffc020a850 <commands+0x210>
ffffffffc02083c4:	45ed                	li	a1,27
ffffffffc02083c6:	00005517          	auipc	a0,0x5
ffffffffc02083ca:	69a50513          	addi	a0,a0,1690 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc02083ce:	8d0f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02083d2:	00005697          	auipc	a3,0x5
ffffffffc02083d6:	65e68693          	addi	a3,a3,1630 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc02083da:	00002617          	auipc	a2,0x2
ffffffffc02083de:	47660613          	addi	a2,a2,1142 # ffffffffc020a850 <commands+0x210>
ffffffffc02083e2:	45d5                	li	a1,21
ffffffffc02083e4:	00005517          	auipc	a0,0x5
ffffffffc02083e8:	67c50513          	addi	a0,a0,1660 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc02083ec:	8b2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02083f0 <sfs_get_root>:
ffffffffc02083f0:	1101                	addi	sp,sp,-32
ffffffffc02083f2:	ec06                	sd	ra,24(sp)
ffffffffc02083f4:	cd09                	beqz	a0,ffffffffc020840e <sfs_get_root+0x1e>
ffffffffc02083f6:	0b052783          	lw	a5,176(a0)
ffffffffc02083fa:	eb91                	bnez	a5,ffffffffc020840e <sfs_get_root+0x1e>
ffffffffc02083fc:	4605                	li	a2,1
ffffffffc02083fe:	002c                	addi	a1,sp,8
ffffffffc0208400:	1ea010ef          	jal	ra,ffffffffc02095ea <sfs_load_inode>
ffffffffc0208404:	e50d                	bnez	a0,ffffffffc020842e <sfs_get_root+0x3e>
ffffffffc0208406:	60e2                	ld	ra,24(sp)
ffffffffc0208408:	6522                	ld	a0,8(sp)
ffffffffc020840a:	6105                	addi	sp,sp,32
ffffffffc020840c:	8082                	ret
ffffffffc020840e:	00005697          	auipc	a3,0x5
ffffffffc0208412:	62268693          	addi	a3,a3,1570 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208416:	00002617          	auipc	a2,0x2
ffffffffc020841a:	43a60613          	addi	a2,a2,1082 # ffffffffc020a850 <commands+0x210>
ffffffffc020841e:	03600593          	li	a1,54
ffffffffc0208422:	00005517          	auipc	a0,0x5
ffffffffc0208426:	63e50513          	addi	a0,a0,1598 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc020842a:	874f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020842e:	86aa                	mv	a3,a0
ffffffffc0208430:	00005617          	auipc	a2,0x5
ffffffffc0208434:	6a060613          	addi	a2,a2,1696 # ffffffffc020dad0 <dev_node_ops+0x480>
ffffffffc0208438:	03700593          	li	a1,55
ffffffffc020843c:	00005517          	auipc	a0,0x5
ffffffffc0208440:	62450513          	addi	a0,a0,1572 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208444:	85af80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208448 <sfs_do_mount>:
ffffffffc0208448:	6518                	ld	a4,8(a0)
ffffffffc020844a:	7171                	addi	sp,sp,-176
ffffffffc020844c:	f506                	sd	ra,168(sp)
ffffffffc020844e:	f122                	sd	s0,160(sp)
ffffffffc0208450:	ed26                	sd	s1,152(sp)
ffffffffc0208452:	e94a                	sd	s2,144(sp)
ffffffffc0208454:	e54e                	sd	s3,136(sp)
ffffffffc0208456:	e152                	sd	s4,128(sp)
ffffffffc0208458:	fcd6                	sd	s5,120(sp)
ffffffffc020845a:	f8da                	sd	s6,112(sp)
ffffffffc020845c:	f4de                	sd	s7,104(sp)
ffffffffc020845e:	f0e2                	sd	s8,96(sp)
ffffffffc0208460:	ece6                	sd	s9,88(sp)
ffffffffc0208462:	e8ea                	sd	s10,80(sp)
ffffffffc0208464:	e4ee                	sd	s11,72(sp)
ffffffffc0208466:	6785                	lui	a5,0x1
ffffffffc0208468:	24f71663          	bne	a4,a5,ffffffffc02086b4 <sfs_do_mount+0x26c>
ffffffffc020846c:	892a                	mv	s2,a0
ffffffffc020846e:	4501                	li	a0,0
ffffffffc0208470:	8aae                	mv	s5,a1
ffffffffc0208472:	f00fe0ef          	jal	ra,ffffffffc0206b72 <__alloc_fs>
ffffffffc0208476:	842a                	mv	s0,a0
ffffffffc0208478:	24050463          	beqz	a0,ffffffffc02086c0 <sfs_do_mount+0x278>
ffffffffc020847c:	0b052b03          	lw	s6,176(a0)
ffffffffc0208480:	260b1263          	bnez	s6,ffffffffc02086e4 <sfs_do_mount+0x29c>
ffffffffc0208484:	03253823          	sd	s2,48(a0)
ffffffffc0208488:	6505                	lui	a0,0x1
ffffffffc020848a:	b05f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020848e:	e428                	sd	a0,72(s0)
ffffffffc0208490:	84aa                	mv	s1,a0
ffffffffc0208492:	16050363          	beqz	a0,ffffffffc02085f8 <sfs_do_mount+0x1b0>
ffffffffc0208496:	85aa                	mv	a1,a0
ffffffffc0208498:	4681                	li	a3,0
ffffffffc020849a:	6605                	lui	a2,0x1
ffffffffc020849c:	1008                	addi	a0,sp,32
ffffffffc020849e:	a9bfc0ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc02084a2:	02093783          	ld	a5,32(s2)
ffffffffc02084a6:	85aa                	mv	a1,a0
ffffffffc02084a8:	4601                	li	a2,0
ffffffffc02084aa:	854a                	mv	a0,s2
ffffffffc02084ac:	9782                	jalr	a5
ffffffffc02084ae:	8a2a                	mv	s4,a0
ffffffffc02084b0:	10051e63          	bnez	a0,ffffffffc02085cc <sfs_do_mount+0x184>
ffffffffc02084b4:	408c                	lw	a1,0(s1)
ffffffffc02084b6:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc02084ba:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc02084be:	14c59863          	bne	a1,a2,ffffffffc020860e <sfs_do_mount+0x1c6>
ffffffffc02084c2:	40dc                	lw	a5,4(s1)
ffffffffc02084c4:	00093603          	ld	a2,0(s2)
ffffffffc02084c8:	02079713          	slli	a4,a5,0x20
ffffffffc02084cc:	9301                	srli	a4,a4,0x20
ffffffffc02084ce:	12e66763          	bltu	a2,a4,ffffffffc02085fc <sfs_do_mount+0x1b4>
ffffffffc02084d2:	020485a3          	sb	zero,43(s1)
ffffffffc02084d6:	0084af03          	lw	t5,8(s1)
ffffffffc02084da:	00c4ae83          	lw	t4,12(s1)
ffffffffc02084de:	0104ae03          	lw	t3,16(s1)
ffffffffc02084e2:	0144a303          	lw	t1,20(s1)
ffffffffc02084e6:	0184a883          	lw	a7,24(s1)
ffffffffc02084ea:	01c4a803          	lw	a6,28(s1)
ffffffffc02084ee:	5090                	lw	a2,32(s1)
ffffffffc02084f0:	50d4                	lw	a3,36(s1)
ffffffffc02084f2:	5498                	lw	a4,40(s1)
ffffffffc02084f4:	6511                	lui	a0,0x4
ffffffffc02084f6:	c00c                	sw	a1,0(s0)
ffffffffc02084f8:	c05c                	sw	a5,4(s0)
ffffffffc02084fa:	01e42423          	sw	t5,8(s0)
ffffffffc02084fe:	01d42623          	sw	t4,12(s0)
ffffffffc0208502:	01c42823          	sw	t3,16(s0)
ffffffffc0208506:	00642a23          	sw	t1,20(s0)
ffffffffc020850a:	01142c23          	sw	a7,24(s0)
ffffffffc020850e:	01042e23          	sw	a6,28(s0)
ffffffffc0208512:	d010                	sw	a2,32(s0)
ffffffffc0208514:	d054                	sw	a3,36(s0)
ffffffffc0208516:	d418                	sw	a4,40(s0)
ffffffffc0208518:	a77f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020851c:	f448                	sd	a0,168(s0)
ffffffffc020851e:	8c2a                	mv	s8,a0
ffffffffc0208520:	18050c63          	beqz	a0,ffffffffc02086b8 <sfs_do_mount+0x270>
ffffffffc0208524:	6711                	lui	a4,0x4
ffffffffc0208526:	87aa                	mv	a5,a0
ffffffffc0208528:	972a                	add	a4,a4,a0
ffffffffc020852a:	e79c                	sd	a5,8(a5)
ffffffffc020852c:	e39c                	sd	a5,0(a5)
ffffffffc020852e:	07c1                	addi	a5,a5,16
ffffffffc0208530:	fee79de3          	bne	a5,a4,ffffffffc020852a <sfs_do_mount+0xe2>
ffffffffc0208534:	0044eb83          	lwu	s7,4(s1)
ffffffffc0208538:	67a1                	lui	a5,0x8
ffffffffc020853a:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc020853e:	9bce                	add	s7,s7,s3
ffffffffc0208540:	77e1                	lui	a5,0xffff8
ffffffffc0208542:	00fbfbb3          	and	s7,s7,a5
ffffffffc0208546:	2b81                	sext.w	s7,s7
ffffffffc0208548:	855e                	mv	a0,s7
ffffffffc020854a:	a59ff0ef          	jal	ra,ffffffffc0207fa2 <bitmap_create>
ffffffffc020854e:	fc08                	sd	a0,56(s0)
ffffffffc0208550:	8d2a                	mv	s10,a0
ffffffffc0208552:	14050f63          	beqz	a0,ffffffffc02086b0 <sfs_do_mount+0x268>
ffffffffc0208556:	0044e783          	lwu	a5,4(s1)
ffffffffc020855a:	082c                	addi	a1,sp,24
ffffffffc020855c:	97ce                	add	a5,a5,s3
ffffffffc020855e:	00f7d713          	srli	a4,a5,0xf
ffffffffc0208562:	e43a                	sd	a4,8(sp)
ffffffffc0208564:	40f7d993          	srai	s3,a5,0xf
ffffffffc0208568:	c4fff0ef          	jal	ra,ffffffffc02081b6 <bitmap_getdata>
ffffffffc020856c:	14050c63          	beqz	a0,ffffffffc02086c4 <sfs_do_mount+0x27c>
ffffffffc0208570:	00c9979b          	slliw	a5,s3,0xc
ffffffffc0208574:	66e2                	ld	a3,24(sp)
ffffffffc0208576:	1782                	slli	a5,a5,0x20
ffffffffc0208578:	9381                	srli	a5,a5,0x20
ffffffffc020857a:	14d79563          	bne	a5,a3,ffffffffc02086c4 <sfs_do_mount+0x27c>
ffffffffc020857e:	6722                	ld	a4,8(sp)
ffffffffc0208580:	6d89                	lui	s11,0x2
ffffffffc0208582:	89aa                	mv	s3,a0
ffffffffc0208584:	00c71c93          	slli	s9,a4,0xc
ffffffffc0208588:	9caa                	add	s9,s9,a0
ffffffffc020858a:	40ad8dbb          	subw	s11,s11,a0
ffffffffc020858e:	e711                	bnez	a4,ffffffffc020859a <sfs_do_mount+0x152>
ffffffffc0208590:	a079                	j	ffffffffc020861e <sfs_do_mount+0x1d6>
ffffffffc0208592:	6785                	lui	a5,0x1
ffffffffc0208594:	99be                	add	s3,s3,a5
ffffffffc0208596:	093c8463          	beq	s9,s3,ffffffffc020861e <sfs_do_mount+0x1d6>
ffffffffc020859a:	013d86bb          	addw	a3,s11,s3
ffffffffc020859e:	1682                	slli	a3,a3,0x20
ffffffffc02085a0:	6605                	lui	a2,0x1
ffffffffc02085a2:	85ce                	mv	a1,s3
ffffffffc02085a4:	9281                	srli	a3,a3,0x20
ffffffffc02085a6:	1008                	addi	a0,sp,32
ffffffffc02085a8:	991fc0ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc02085ac:	02093783          	ld	a5,32(s2)
ffffffffc02085b0:	85aa                	mv	a1,a0
ffffffffc02085b2:	4601                	li	a2,0
ffffffffc02085b4:	854a                	mv	a0,s2
ffffffffc02085b6:	9782                	jalr	a5
ffffffffc02085b8:	dd69                	beqz	a0,ffffffffc0208592 <sfs_do_mount+0x14a>
ffffffffc02085ba:	e42a                	sd	a0,8(sp)
ffffffffc02085bc:	856a                	mv	a0,s10
ffffffffc02085be:	bdfff0ef          	jal	ra,ffffffffc020819c <bitmap_destroy>
ffffffffc02085c2:	67a2                	ld	a5,8(sp)
ffffffffc02085c4:	8a3e                	mv	s4,a5
ffffffffc02085c6:	8562                	mv	a0,s8
ffffffffc02085c8:	a77f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02085cc:	8526                	mv	a0,s1
ffffffffc02085ce:	a71f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02085d2:	8522                	mv	a0,s0
ffffffffc02085d4:	a6bf90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02085d8:	70aa                	ld	ra,168(sp)
ffffffffc02085da:	740a                	ld	s0,160(sp)
ffffffffc02085dc:	64ea                	ld	s1,152(sp)
ffffffffc02085de:	694a                	ld	s2,144(sp)
ffffffffc02085e0:	69aa                	ld	s3,136(sp)
ffffffffc02085e2:	7ae6                	ld	s5,120(sp)
ffffffffc02085e4:	7b46                	ld	s6,112(sp)
ffffffffc02085e6:	7ba6                	ld	s7,104(sp)
ffffffffc02085e8:	7c06                	ld	s8,96(sp)
ffffffffc02085ea:	6ce6                	ld	s9,88(sp)
ffffffffc02085ec:	6d46                	ld	s10,80(sp)
ffffffffc02085ee:	6da6                	ld	s11,72(sp)
ffffffffc02085f0:	8552                	mv	a0,s4
ffffffffc02085f2:	6a0a                	ld	s4,128(sp)
ffffffffc02085f4:	614d                	addi	sp,sp,176
ffffffffc02085f6:	8082                	ret
ffffffffc02085f8:	5a71                	li	s4,-4
ffffffffc02085fa:	bfe1                	j	ffffffffc02085d2 <sfs_do_mount+0x18a>
ffffffffc02085fc:	85be                	mv	a1,a5
ffffffffc02085fe:	00005517          	auipc	a0,0x5
ffffffffc0208602:	52a50513          	addi	a0,a0,1322 # ffffffffc020db28 <dev_node_ops+0x4d8>
ffffffffc0208606:	ba1f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020860a:	5a75                	li	s4,-3
ffffffffc020860c:	b7c1                	j	ffffffffc02085cc <sfs_do_mount+0x184>
ffffffffc020860e:	00005517          	auipc	a0,0x5
ffffffffc0208612:	4e250513          	addi	a0,a0,1250 # ffffffffc020daf0 <dev_node_ops+0x4a0>
ffffffffc0208616:	b91f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020861a:	5a75                	li	s4,-3
ffffffffc020861c:	bf45                	j	ffffffffc02085cc <sfs_do_mount+0x184>
ffffffffc020861e:	00442903          	lw	s2,4(s0)
ffffffffc0208622:	4481                	li	s1,0
ffffffffc0208624:	080b8c63          	beqz	s7,ffffffffc02086bc <sfs_do_mount+0x274>
ffffffffc0208628:	85a6                	mv	a1,s1
ffffffffc020862a:	856a                	mv	a0,s10
ffffffffc020862c:	af7ff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0208630:	c111                	beqz	a0,ffffffffc0208634 <sfs_do_mount+0x1ec>
ffffffffc0208632:	2b05                	addiw	s6,s6,1
ffffffffc0208634:	2485                	addiw	s1,s1,1
ffffffffc0208636:	fe9b99e3          	bne	s7,s1,ffffffffc0208628 <sfs_do_mount+0x1e0>
ffffffffc020863a:	441c                	lw	a5,8(s0)
ffffffffc020863c:	0d679463          	bne	a5,s6,ffffffffc0208704 <sfs_do_mount+0x2bc>
ffffffffc0208640:	4585                	li	a1,1
ffffffffc0208642:	05040513          	addi	a0,s0,80
ffffffffc0208646:	04043023          	sd	zero,64(s0)
ffffffffc020864a:	a67fb0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc020864e:	4585                	li	a1,1
ffffffffc0208650:	06840513          	addi	a0,s0,104
ffffffffc0208654:	a5dfb0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0208658:	4585                	li	a1,1
ffffffffc020865a:	08040513          	addi	a0,s0,128
ffffffffc020865e:	a53fb0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc0208662:	09840793          	addi	a5,s0,152
ffffffffc0208666:	f05c                	sd	a5,160(s0)
ffffffffc0208668:	ec5c                	sd	a5,152(s0)
ffffffffc020866a:	874a                	mv	a4,s2
ffffffffc020866c:	86da                	mv	a3,s6
ffffffffc020866e:	4169063b          	subw	a2,s2,s6
ffffffffc0208672:	00c40593          	addi	a1,s0,12
ffffffffc0208676:	00005517          	auipc	a0,0x5
ffffffffc020867a:	54250513          	addi	a0,a0,1346 # ffffffffc020dbb8 <dev_node_ops+0x568>
ffffffffc020867e:	b29f70ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0208682:	00000797          	auipc	a5,0x0
ffffffffc0208686:	c8878793          	addi	a5,a5,-888 # ffffffffc020830a <sfs_sync>
ffffffffc020868a:	fc5c                	sd	a5,184(s0)
ffffffffc020868c:	00000797          	auipc	a5,0x0
ffffffffc0208690:	d6478793          	addi	a5,a5,-668 # ffffffffc02083f0 <sfs_get_root>
ffffffffc0208694:	e07c                	sd	a5,192(s0)
ffffffffc0208696:	00000797          	auipc	a5,0x0
ffffffffc020869a:	b5e78793          	addi	a5,a5,-1186 # ffffffffc02081f4 <sfs_unmount>
ffffffffc020869e:	e47c                	sd	a5,200(s0)
ffffffffc02086a0:	00000797          	auipc	a5,0x0
ffffffffc02086a4:	bd878793          	addi	a5,a5,-1064 # ffffffffc0208278 <sfs_cleanup>
ffffffffc02086a8:	e87c                	sd	a5,208(s0)
ffffffffc02086aa:	008ab023          	sd	s0,0(s5)
ffffffffc02086ae:	b72d                	j	ffffffffc02085d8 <sfs_do_mount+0x190>
ffffffffc02086b0:	5a71                	li	s4,-4
ffffffffc02086b2:	bf11                	j	ffffffffc02085c6 <sfs_do_mount+0x17e>
ffffffffc02086b4:	5a49                	li	s4,-14
ffffffffc02086b6:	b70d                	j	ffffffffc02085d8 <sfs_do_mount+0x190>
ffffffffc02086b8:	5a71                	li	s4,-4
ffffffffc02086ba:	bf09                	j	ffffffffc02085cc <sfs_do_mount+0x184>
ffffffffc02086bc:	4b01                	li	s6,0
ffffffffc02086be:	bfb5                	j	ffffffffc020863a <sfs_do_mount+0x1f2>
ffffffffc02086c0:	5a71                	li	s4,-4
ffffffffc02086c2:	bf19                	j	ffffffffc02085d8 <sfs_do_mount+0x190>
ffffffffc02086c4:	00005697          	auipc	a3,0x5
ffffffffc02086c8:	49468693          	addi	a3,a3,1172 # ffffffffc020db58 <dev_node_ops+0x508>
ffffffffc02086cc:	00002617          	auipc	a2,0x2
ffffffffc02086d0:	18460613          	addi	a2,a2,388 # ffffffffc020a850 <commands+0x210>
ffffffffc02086d4:	08300593          	li	a1,131
ffffffffc02086d8:	00005517          	auipc	a0,0x5
ffffffffc02086dc:	38850513          	addi	a0,a0,904 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc02086e0:	dbff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02086e4:	00005697          	auipc	a3,0x5
ffffffffc02086e8:	34c68693          	addi	a3,a3,844 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc02086ec:	00002617          	auipc	a2,0x2
ffffffffc02086f0:	16460613          	addi	a2,a2,356 # ffffffffc020a850 <commands+0x210>
ffffffffc02086f4:	0a300593          	li	a1,163
ffffffffc02086f8:	00005517          	auipc	a0,0x5
ffffffffc02086fc:	36850513          	addi	a0,a0,872 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208700:	d9ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208704:	00005697          	auipc	a3,0x5
ffffffffc0208708:	48468693          	addi	a3,a3,1156 # ffffffffc020db88 <dev_node_ops+0x538>
ffffffffc020870c:	00002617          	auipc	a2,0x2
ffffffffc0208710:	14460613          	addi	a2,a2,324 # ffffffffc020a850 <commands+0x210>
ffffffffc0208714:	0e000593          	li	a1,224
ffffffffc0208718:	00005517          	auipc	a0,0x5
ffffffffc020871c:	34850513          	addi	a0,a0,840 # ffffffffc020da60 <dev_node_ops+0x410>
ffffffffc0208720:	d7ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208724 <sfs_mount>:
ffffffffc0208724:	00000597          	auipc	a1,0x0
ffffffffc0208728:	d2458593          	addi	a1,a1,-732 # ffffffffc0208448 <sfs_do_mount>
ffffffffc020872c:	817fe06f          	j	ffffffffc0206f42 <vfs_mount>

ffffffffc0208730 <sfs_opendir>:
ffffffffc0208730:	0235f593          	andi	a1,a1,35
ffffffffc0208734:	4501                	li	a0,0
ffffffffc0208736:	e191                	bnez	a1,ffffffffc020873a <sfs_opendir+0xa>
ffffffffc0208738:	8082                	ret
ffffffffc020873a:	553d                	li	a0,-17
ffffffffc020873c:	8082                	ret

ffffffffc020873e <sfs_openfile>:
ffffffffc020873e:	4501                	li	a0,0
ffffffffc0208740:	8082                	ret

ffffffffc0208742 <sfs_gettype>:
ffffffffc0208742:	1141                	addi	sp,sp,-16
ffffffffc0208744:	e406                	sd	ra,8(sp)
ffffffffc0208746:	c939                	beqz	a0,ffffffffc020879c <sfs_gettype+0x5a>
ffffffffc0208748:	4d34                	lw	a3,88(a0)
ffffffffc020874a:	6785                	lui	a5,0x1
ffffffffc020874c:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208750:	04e69663          	bne	a3,a4,ffffffffc020879c <sfs_gettype+0x5a>
ffffffffc0208754:	6114                	ld	a3,0(a0)
ffffffffc0208756:	4709                	li	a4,2
ffffffffc0208758:	0046d683          	lhu	a3,4(a3)
ffffffffc020875c:	02e68a63          	beq	a3,a4,ffffffffc0208790 <sfs_gettype+0x4e>
ffffffffc0208760:	470d                	li	a4,3
ffffffffc0208762:	02e68163          	beq	a3,a4,ffffffffc0208784 <sfs_gettype+0x42>
ffffffffc0208766:	4705                	li	a4,1
ffffffffc0208768:	00e68f63          	beq	a3,a4,ffffffffc0208786 <sfs_gettype+0x44>
ffffffffc020876c:	00005617          	auipc	a2,0x5
ffffffffc0208770:	4bc60613          	addi	a2,a2,1212 # ffffffffc020dc28 <dev_node_ops+0x5d8>
ffffffffc0208774:	36500593          	li	a1,869
ffffffffc0208778:	00005517          	auipc	a0,0x5
ffffffffc020877c:	49850513          	addi	a0,a0,1176 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208780:	d1ff70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208784:	678d                	lui	a5,0x3
ffffffffc0208786:	60a2                	ld	ra,8(sp)
ffffffffc0208788:	c19c                	sw	a5,0(a1)
ffffffffc020878a:	4501                	li	a0,0
ffffffffc020878c:	0141                	addi	sp,sp,16
ffffffffc020878e:	8082                	ret
ffffffffc0208790:	60a2                	ld	ra,8(sp)
ffffffffc0208792:	6789                	lui	a5,0x2
ffffffffc0208794:	c19c                	sw	a5,0(a1)
ffffffffc0208796:	4501                	li	a0,0
ffffffffc0208798:	0141                	addi	sp,sp,16
ffffffffc020879a:	8082                	ret
ffffffffc020879c:	00005697          	auipc	a3,0x5
ffffffffc02087a0:	43c68693          	addi	a3,a3,1084 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc02087a4:	00002617          	auipc	a2,0x2
ffffffffc02087a8:	0ac60613          	addi	a2,a2,172 # ffffffffc020a850 <commands+0x210>
ffffffffc02087ac:	35900593          	li	a1,857
ffffffffc02087b0:	00005517          	auipc	a0,0x5
ffffffffc02087b4:	46050513          	addi	a0,a0,1120 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02087b8:	ce7f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087bc <sfs_fsync>:
ffffffffc02087bc:	7179                	addi	sp,sp,-48
ffffffffc02087be:	ec26                	sd	s1,24(sp)
ffffffffc02087c0:	7524                	ld	s1,104(a0)
ffffffffc02087c2:	f406                	sd	ra,40(sp)
ffffffffc02087c4:	f022                	sd	s0,32(sp)
ffffffffc02087c6:	e84a                	sd	s2,16(sp)
ffffffffc02087c8:	e44e                	sd	s3,8(sp)
ffffffffc02087ca:	c4bd                	beqz	s1,ffffffffc0208838 <sfs_fsync+0x7c>
ffffffffc02087cc:	0b04a783          	lw	a5,176(s1)
ffffffffc02087d0:	e7a5                	bnez	a5,ffffffffc0208838 <sfs_fsync+0x7c>
ffffffffc02087d2:	4d38                	lw	a4,88(a0)
ffffffffc02087d4:	6785                	lui	a5,0x1
ffffffffc02087d6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02087da:	842a                	mv	s0,a0
ffffffffc02087dc:	06f71e63          	bne	a4,a5,ffffffffc0208858 <sfs_fsync+0x9c>
ffffffffc02087e0:	691c                	ld	a5,16(a0)
ffffffffc02087e2:	4901                	li	s2,0
ffffffffc02087e4:	eb89                	bnez	a5,ffffffffc02087f6 <sfs_fsync+0x3a>
ffffffffc02087e6:	70a2                	ld	ra,40(sp)
ffffffffc02087e8:	7402                	ld	s0,32(sp)
ffffffffc02087ea:	64e2                	ld	s1,24(sp)
ffffffffc02087ec:	69a2                	ld	s3,8(sp)
ffffffffc02087ee:	854a                	mv	a0,s2
ffffffffc02087f0:	6942                	ld	s2,16(sp)
ffffffffc02087f2:	6145                	addi	sp,sp,48
ffffffffc02087f4:	8082                	ret
ffffffffc02087f6:	02050993          	addi	s3,a0,32
ffffffffc02087fa:	854e                	mv	a0,s3
ffffffffc02087fc:	8bffb0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0208800:	681c                	ld	a5,16(s0)
ffffffffc0208802:	ef81                	bnez	a5,ffffffffc020881a <sfs_fsync+0x5e>
ffffffffc0208804:	854e                	mv	a0,s3
ffffffffc0208806:	8b1fb0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc020880a:	70a2                	ld	ra,40(sp)
ffffffffc020880c:	7402                	ld	s0,32(sp)
ffffffffc020880e:	64e2                	ld	s1,24(sp)
ffffffffc0208810:	69a2                	ld	s3,8(sp)
ffffffffc0208812:	854a                	mv	a0,s2
ffffffffc0208814:	6942                	ld	s2,16(sp)
ffffffffc0208816:	6145                	addi	sp,sp,48
ffffffffc0208818:	8082                	ret
ffffffffc020881a:	4414                	lw	a3,8(s0)
ffffffffc020881c:	600c                	ld	a1,0(s0)
ffffffffc020881e:	00043823          	sd	zero,16(s0)
ffffffffc0208822:	4701                	li	a4,0
ffffffffc0208824:	04000613          	li	a2,64
ffffffffc0208828:	8526                	mv	a0,s1
ffffffffc020882a:	43a010ef          	jal	ra,ffffffffc0209c64 <sfs_wbuf>
ffffffffc020882e:	892a                	mv	s2,a0
ffffffffc0208830:	d971                	beqz	a0,ffffffffc0208804 <sfs_fsync+0x48>
ffffffffc0208832:	4785                	li	a5,1
ffffffffc0208834:	e81c                	sd	a5,16(s0)
ffffffffc0208836:	b7f9                	j	ffffffffc0208804 <sfs_fsync+0x48>
ffffffffc0208838:	00005697          	auipc	a3,0x5
ffffffffc020883c:	1f868693          	addi	a3,a3,504 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208840:	00002617          	auipc	a2,0x2
ffffffffc0208844:	01060613          	addi	a2,a2,16 # ffffffffc020a850 <commands+0x210>
ffffffffc0208848:	29d00593          	li	a1,669
ffffffffc020884c:	00005517          	auipc	a0,0x5
ffffffffc0208850:	3c450513          	addi	a0,a0,964 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208854:	c4bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208858:	00005697          	auipc	a3,0x5
ffffffffc020885c:	38068693          	addi	a3,a3,896 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0208860:	00002617          	auipc	a2,0x2
ffffffffc0208864:	ff060613          	addi	a2,a2,-16 # ffffffffc020a850 <commands+0x210>
ffffffffc0208868:	29e00593          	li	a1,670
ffffffffc020886c:	00005517          	auipc	a0,0x5
ffffffffc0208870:	3a450513          	addi	a0,a0,932 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208874:	c2bf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208878 <sfs_fstat>:
ffffffffc0208878:	1101                	addi	sp,sp,-32
ffffffffc020887a:	e426                	sd	s1,8(sp)
ffffffffc020887c:	84ae                	mv	s1,a1
ffffffffc020887e:	e822                	sd	s0,16(sp)
ffffffffc0208880:	02000613          	li	a2,32
ffffffffc0208884:	842a                	mv	s0,a0
ffffffffc0208886:	4581                	li	a1,0
ffffffffc0208888:	8526                	mv	a0,s1
ffffffffc020888a:	ec06                	sd	ra,24(sp)
ffffffffc020888c:	2dd010ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0208890:	c439                	beqz	s0,ffffffffc02088de <sfs_fstat+0x66>
ffffffffc0208892:	783c                	ld	a5,112(s0)
ffffffffc0208894:	c7a9                	beqz	a5,ffffffffc02088de <sfs_fstat+0x66>
ffffffffc0208896:	6bbc                	ld	a5,80(a5)
ffffffffc0208898:	c3b9                	beqz	a5,ffffffffc02088de <sfs_fstat+0x66>
ffffffffc020889a:	00005597          	auipc	a1,0x5
ffffffffc020889e:	d2e58593          	addi	a1,a1,-722 # ffffffffc020d5c8 <syscalls+0xdb0>
ffffffffc02088a2:	8522                	mv	a0,s0
ffffffffc02088a4:	8cefe0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02088a8:	783c                	ld	a5,112(s0)
ffffffffc02088aa:	85a6                	mv	a1,s1
ffffffffc02088ac:	8522                	mv	a0,s0
ffffffffc02088ae:	6bbc                	ld	a5,80(a5)
ffffffffc02088b0:	9782                	jalr	a5
ffffffffc02088b2:	e10d                	bnez	a0,ffffffffc02088d4 <sfs_fstat+0x5c>
ffffffffc02088b4:	4c38                	lw	a4,88(s0)
ffffffffc02088b6:	6785                	lui	a5,0x1
ffffffffc02088b8:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02088bc:	04f71163          	bne	a4,a5,ffffffffc02088fe <sfs_fstat+0x86>
ffffffffc02088c0:	601c                	ld	a5,0(s0)
ffffffffc02088c2:	0067d683          	lhu	a3,6(a5)
ffffffffc02088c6:	0087e703          	lwu	a4,8(a5)
ffffffffc02088ca:	0007e783          	lwu	a5,0(a5)
ffffffffc02088ce:	e494                	sd	a3,8(s1)
ffffffffc02088d0:	e898                	sd	a4,16(s1)
ffffffffc02088d2:	ec9c                	sd	a5,24(s1)
ffffffffc02088d4:	60e2                	ld	ra,24(sp)
ffffffffc02088d6:	6442                	ld	s0,16(sp)
ffffffffc02088d8:	64a2                	ld	s1,8(sp)
ffffffffc02088da:	6105                	addi	sp,sp,32
ffffffffc02088dc:	8082                	ret
ffffffffc02088de:	00005697          	auipc	a3,0x5
ffffffffc02088e2:	c8268693          	addi	a3,a3,-894 # ffffffffc020d560 <syscalls+0xd48>
ffffffffc02088e6:	00002617          	auipc	a2,0x2
ffffffffc02088ea:	f6a60613          	addi	a2,a2,-150 # ffffffffc020a850 <commands+0x210>
ffffffffc02088ee:	28e00593          	li	a1,654
ffffffffc02088f2:	00005517          	auipc	a0,0x5
ffffffffc02088f6:	31e50513          	addi	a0,a0,798 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02088fa:	ba5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02088fe:	00005697          	auipc	a3,0x5
ffffffffc0208902:	2da68693          	addi	a3,a3,730 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0208906:	00002617          	auipc	a2,0x2
ffffffffc020890a:	f4a60613          	addi	a2,a2,-182 # ffffffffc020a850 <commands+0x210>
ffffffffc020890e:	29100593          	li	a1,657
ffffffffc0208912:	00005517          	auipc	a0,0x5
ffffffffc0208916:	2fe50513          	addi	a0,a0,766 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020891a:	b85f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020891e <sfs_tryseek>:
ffffffffc020891e:	080007b7          	lui	a5,0x8000
ffffffffc0208922:	04f5fd63          	bgeu	a1,a5,ffffffffc020897c <sfs_tryseek+0x5e>
ffffffffc0208926:	1101                	addi	sp,sp,-32
ffffffffc0208928:	e822                	sd	s0,16(sp)
ffffffffc020892a:	ec06                	sd	ra,24(sp)
ffffffffc020892c:	e426                	sd	s1,8(sp)
ffffffffc020892e:	842a                	mv	s0,a0
ffffffffc0208930:	c921                	beqz	a0,ffffffffc0208980 <sfs_tryseek+0x62>
ffffffffc0208932:	4d38                	lw	a4,88(a0)
ffffffffc0208934:	6785                	lui	a5,0x1
ffffffffc0208936:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020893a:	04f71363          	bne	a4,a5,ffffffffc0208980 <sfs_tryseek+0x62>
ffffffffc020893e:	611c                	ld	a5,0(a0)
ffffffffc0208940:	84ae                	mv	s1,a1
ffffffffc0208942:	0007e783          	lwu	a5,0(a5)
ffffffffc0208946:	02b7d563          	bge	a5,a1,ffffffffc0208970 <sfs_tryseek+0x52>
ffffffffc020894a:	793c                	ld	a5,112(a0)
ffffffffc020894c:	cbb1                	beqz	a5,ffffffffc02089a0 <sfs_tryseek+0x82>
ffffffffc020894e:	73bc                	ld	a5,96(a5)
ffffffffc0208950:	cba1                	beqz	a5,ffffffffc02089a0 <sfs_tryseek+0x82>
ffffffffc0208952:	00005597          	auipc	a1,0x5
ffffffffc0208956:	b6658593          	addi	a1,a1,-1178 # ffffffffc020d4b8 <syscalls+0xca0>
ffffffffc020895a:	818fe0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc020895e:	783c                	ld	a5,112(s0)
ffffffffc0208960:	8522                	mv	a0,s0
ffffffffc0208962:	6442                	ld	s0,16(sp)
ffffffffc0208964:	60e2                	ld	ra,24(sp)
ffffffffc0208966:	73bc                	ld	a5,96(a5)
ffffffffc0208968:	85a6                	mv	a1,s1
ffffffffc020896a:	64a2                	ld	s1,8(sp)
ffffffffc020896c:	6105                	addi	sp,sp,32
ffffffffc020896e:	8782                	jr	a5
ffffffffc0208970:	60e2                	ld	ra,24(sp)
ffffffffc0208972:	6442                	ld	s0,16(sp)
ffffffffc0208974:	64a2                	ld	s1,8(sp)
ffffffffc0208976:	4501                	li	a0,0
ffffffffc0208978:	6105                	addi	sp,sp,32
ffffffffc020897a:	8082                	ret
ffffffffc020897c:	5575                	li	a0,-3
ffffffffc020897e:	8082                	ret
ffffffffc0208980:	00005697          	auipc	a3,0x5
ffffffffc0208984:	25868693          	addi	a3,a3,600 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0208988:	00002617          	auipc	a2,0x2
ffffffffc020898c:	ec860613          	addi	a2,a2,-312 # ffffffffc020a850 <commands+0x210>
ffffffffc0208990:	37000593          	li	a1,880
ffffffffc0208994:	00005517          	auipc	a0,0x5
ffffffffc0208998:	27c50513          	addi	a0,a0,636 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020899c:	b03f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089a0:	00005697          	auipc	a3,0x5
ffffffffc02089a4:	ac068693          	addi	a3,a3,-1344 # ffffffffc020d460 <syscalls+0xc48>
ffffffffc02089a8:	00002617          	auipc	a2,0x2
ffffffffc02089ac:	ea860613          	addi	a2,a2,-344 # ffffffffc020a850 <commands+0x210>
ffffffffc02089b0:	37200593          	li	a1,882
ffffffffc02089b4:	00005517          	auipc	a0,0x5
ffffffffc02089b8:	25c50513          	addi	a0,a0,604 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02089bc:	ae3f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02089c0 <sfs_close>:
ffffffffc02089c0:	1141                	addi	sp,sp,-16
ffffffffc02089c2:	e406                	sd	ra,8(sp)
ffffffffc02089c4:	e022                	sd	s0,0(sp)
ffffffffc02089c6:	c11d                	beqz	a0,ffffffffc02089ec <sfs_close+0x2c>
ffffffffc02089c8:	793c                	ld	a5,112(a0)
ffffffffc02089ca:	842a                	mv	s0,a0
ffffffffc02089cc:	c385                	beqz	a5,ffffffffc02089ec <sfs_close+0x2c>
ffffffffc02089ce:	7b9c                	ld	a5,48(a5)
ffffffffc02089d0:	cf91                	beqz	a5,ffffffffc02089ec <sfs_close+0x2c>
ffffffffc02089d2:	00003597          	auipc	a1,0x3
ffffffffc02089d6:	79e58593          	addi	a1,a1,1950 # ffffffffc020c170 <default_pmm_manager+0xe38>
ffffffffc02089da:	f99fd0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc02089de:	783c                	ld	a5,112(s0)
ffffffffc02089e0:	8522                	mv	a0,s0
ffffffffc02089e2:	6402                	ld	s0,0(sp)
ffffffffc02089e4:	60a2                	ld	ra,8(sp)
ffffffffc02089e6:	7b9c                	ld	a5,48(a5)
ffffffffc02089e8:	0141                	addi	sp,sp,16
ffffffffc02089ea:	8782                	jr	a5
ffffffffc02089ec:	00003697          	auipc	a3,0x3
ffffffffc02089f0:	73468693          	addi	a3,a3,1844 # ffffffffc020c120 <default_pmm_manager+0xde8>
ffffffffc02089f4:	00002617          	auipc	a2,0x2
ffffffffc02089f8:	e5c60613          	addi	a2,a2,-420 # ffffffffc020a850 <commands+0x210>
ffffffffc02089fc:	21c00593          	li	a1,540
ffffffffc0208a00:	00005517          	auipc	a0,0x5
ffffffffc0208a04:	21050513          	addi	a0,a0,528 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208a08:	a97f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a0c <sfs_io.part.0>:
ffffffffc0208a0c:	1141                	addi	sp,sp,-16
ffffffffc0208a0e:	00005697          	auipc	a3,0x5
ffffffffc0208a12:	1ca68693          	addi	a3,a3,458 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0208a16:	00002617          	auipc	a2,0x2
ffffffffc0208a1a:	e3a60613          	addi	a2,a2,-454 # ffffffffc020a850 <commands+0x210>
ffffffffc0208a1e:	26d00593          	li	a1,621
ffffffffc0208a22:	00005517          	auipc	a0,0x5
ffffffffc0208a26:	1ee50513          	addi	a0,a0,494 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208a2a:	e406                	sd	ra,8(sp)
ffffffffc0208a2c:	a73f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a30 <sfs_read>:
ffffffffc0208a30:	753c                	ld	a5,104(a0)
ffffffffc0208a32:	1101                	addi	sp,sp,-32
ffffffffc0208a34:	ec06                	sd	ra,24(sp)
ffffffffc0208a36:	e822                	sd	s0,16(sp)
ffffffffc0208a38:	e426                	sd	s1,8(sp)
ffffffffc0208a3a:	e04a                	sd	s2,0(sp)
ffffffffc0208a3c:	cba5                	beqz	a5,ffffffffc0208aac <sfs_read+0x7c>
ffffffffc0208a3e:	0b07a783          	lw	a5,176(a5)
ffffffffc0208a42:	e7ad                	bnez	a5,ffffffffc0208aac <sfs_read+0x7c>
ffffffffc0208a44:	4d38                	lw	a4,88(a0)
ffffffffc0208a46:	6785                	lui	a5,0x1
ffffffffc0208a48:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208a4c:	842a                	mv	s0,a0
ffffffffc0208a4e:	08f71f63          	bne	a4,a5,ffffffffc0208aec <sfs_read+0xbc>
ffffffffc0208a52:	02050913          	addi	s2,a0,32
ffffffffc0208a56:	854a                	mv	a0,s2
ffffffffc0208a58:	84ae                	mv	s1,a1
ffffffffc0208a5a:	e60fb0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0208a5e:	6014                	ld	a3,0(s0)
ffffffffc0208a60:	4609                	li	a2,2
ffffffffc0208a62:	6c98                	ld	a4,24(s1)
ffffffffc0208a64:	0046d583          	lhu	a1,4(a3)
ffffffffc0208a68:	649c                	ld	a5,8(s1)
ffffffffc0208a6a:	06c58163          	beq	a1,a2,ffffffffc0208acc <sfs_read+0x9c>
ffffffffc0208a6e:	08000637          	lui	a2,0x8000
ffffffffc0208a72:	973e                	add	a4,a4,a5
ffffffffc0208a74:	02c7fa63          	bgeu	a5,a2,ffffffffc0208aa8 <sfs_read+0x78>
ffffffffc0208a78:	02f74863          	blt	a4,a5,ffffffffc0208aa8 <sfs_read+0x78>
ffffffffc0208a7c:	4481                	li	s1,0
ffffffffc0208a7e:	00e78b63          	beq	a5,a4,ffffffffc0208a94 <sfs_read+0x64>
ffffffffc0208a82:	0006e703          	lwu	a4,0(a3)
ffffffffc0208a86:	00e7d763          	bge	a5,a4,ffffffffc0208a94 <sfs_read+0x64>
ffffffffc0208a8a:	00f77563          	bgeu	a4,a5,ffffffffc0208a94 <sfs_read+0x64>
ffffffffc0208a8e:	c29c                	sw	a5,0(a3)
ffffffffc0208a90:	4785                	li	a5,1
ffffffffc0208a92:	e81c                	sd	a5,16(s0)
ffffffffc0208a94:	854a                	mv	a0,s2
ffffffffc0208a96:	e20fb0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0208a9a:	60e2                	ld	ra,24(sp)
ffffffffc0208a9c:	6442                	ld	s0,16(sp)
ffffffffc0208a9e:	6902                	ld	s2,0(sp)
ffffffffc0208aa0:	8526                	mv	a0,s1
ffffffffc0208aa2:	64a2                	ld	s1,8(sp)
ffffffffc0208aa4:	6105                	addi	sp,sp,32
ffffffffc0208aa6:	8082                	ret
ffffffffc0208aa8:	54f5                	li	s1,-3
ffffffffc0208aaa:	b7ed                	j	ffffffffc0208a94 <sfs_read+0x64>
ffffffffc0208aac:	00005697          	auipc	a3,0x5
ffffffffc0208ab0:	f8468693          	addi	a3,a3,-124 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208ab4:	00002617          	auipc	a2,0x2
ffffffffc0208ab8:	d9c60613          	addi	a2,a2,-612 # ffffffffc020a850 <commands+0x210>
ffffffffc0208abc:	26c00593          	li	a1,620
ffffffffc0208ac0:	00005517          	auipc	a0,0x5
ffffffffc0208ac4:	15050513          	addi	a0,a0,336 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208ac8:	9d7f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208acc:	00005697          	auipc	a3,0x5
ffffffffc0208ad0:	17468693          	addi	a3,a3,372 # ffffffffc020dc40 <dev_node_ops+0x5f0>
ffffffffc0208ad4:	00002617          	auipc	a2,0x2
ffffffffc0208ad8:	d7c60613          	addi	a2,a2,-644 # ffffffffc020a850 <commands+0x210>
ffffffffc0208adc:	22b00593          	li	a1,555
ffffffffc0208ae0:	00005517          	auipc	a0,0x5
ffffffffc0208ae4:	13050513          	addi	a0,a0,304 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208ae8:	9b7f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208aec:	f21ff0ef          	jal	ra,ffffffffc0208a0c <sfs_io.part.0>

ffffffffc0208af0 <sfs_write>:
ffffffffc0208af0:	753c                	ld	a5,104(a0)
ffffffffc0208af2:	1101                	addi	sp,sp,-32
ffffffffc0208af4:	ec06                	sd	ra,24(sp)
ffffffffc0208af6:	e822                	sd	s0,16(sp)
ffffffffc0208af8:	e426                	sd	s1,8(sp)
ffffffffc0208afa:	e04a                	sd	s2,0(sp)
ffffffffc0208afc:	c7b5                	beqz	a5,ffffffffc0208b68 <sfs_write+0x78>
ffffffffc0208afe:	0b07a783          	lw	a5,176(a5)
ffffffffc0208b02:	e3bd                	bnez	a5,ffffffffc0208b68 <sfs_write+0x78>
ffffffffc0208b04:	4d38                	lw	a4,88(a0)
ffffffffc0208b06:	6785                	lui	a5,0x1
ffffffffc0208b08:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208b0c:	842a                	mv	s0,a0
ffffffffc0208b0e:	08f71d63          	bne	a4,a5,ffffffffc0208ba8 <sfs_write+0xb8>
ffffffffc0208b12:	02050913          	addi	s2,a0,32
ffffffffc0208b16:	854a                	mv	a0,s2
ffffffffc0208b18:	84ae                	mv	s1,a1
ffffffffc0208b1a:	da0fb0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0208b1e:	6014                	ld	a3,0(s0)
ffffffffc0208b20:	4609                	li	a2,2
ffffffffc0208b22:	6c98                	ld	a4,24(s1)
ffffffffc0208b24:	0046d583          	lhu	a1,4(a3)
ffffffffc0208b28:	649c                	ld	a5,8(s1)
ffffffffc0208b2a:	04c58f63          	beq	a1,a2,ffffffffc0208b88 <sfs_write+0x98>
ffffffffc0208b2e:	08000637          	lui	a2,0x8000
ffffffffc0208b32:	973e                	add	a4,a4,a5
ffffffffc0208b34:	02c7f863          	bgeu	a5,a2,ffffffffc0208b64 <sfs_write+0x74>
ffffffffc0208b38:	02f74663          	blt	a4,a5,ffffffffc0208b64 <sfs_write+0x74>
ffffffffc0208b3c:	4481                	li	s1,0
ffffffffc0208b3e:	00e78963          	beq	a5,a4,ffffffffc0208b50 <sfs_write+0x60>
ffffffffc0208b42:	0006e703          	lwu	a4,0(a3)
ffffffffc0208b46:	00f77563          	bgeu	a4,a5,ffffffffc0208b50 <sfs_write+0x60>
ffffffffc0208b4a:	c29c                	sw	a5,0(a3)
ffffffffc0208b4c:	4785                	li	a5,1
ffffffffc0208b4e:	e81c                	sd	a5,16(s0)
ffffffffc0208b50:	854a                	mv	a0,s2
ffffffffc0208b52:	d64fb0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0208b56:	60e2                	ld	ra,24(sp)
ffffffffc0208b58:	6442                	ld	s0,16(sp)
ffffffffc0208b5a:	6902                	ld	s2,0(sp)
ffffffffc0208b5c:	8526                	mv	a0,s1
ffffffffc0208b5e:	64a2                	ld	s1,8(sp)
ffffffffc0208b60:	6105                	addi	sp,sp,32
ffffffffc0208b62:	8082                	ret
ffffffffc0208b64:	54f5                	li	s1,-3
ffffffffc0208b66:	b7ed                	j	ffffffffc0208b50 <sfs_write+0x60>
ffffffffc0208b68:	00005697          	auipc	a3,0x5
ffffffffc0208b6c:	ec868693          	addi	a3,a3,-312 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208b70:	00002617          	auipc	a2,0x2
ffffffffc0208b74:	ce060613          	addi	a2,a2,-800 # ffffffffc020a850 <commands+0x210>
ffffffffc0208b78:	26c00593          	li	a1,620
ffffffffc0208b7c:	00005517          	auipc	a0,0x5
ffffffffc0208b80:	09450513          	addi	a0,a0,148 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208b84:	91bf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b88:	00005697          	auipc	a3,0x5
ffffffffc0208b8c:	0b868693          	addi	a3,a3,184 # ffffffffc020dc40 <dev_node_ops+0x5f0>
ffffffffc0208b90:	00002617          	auipc	a2,0x2
ffffffffc0208b94:	cc060613          	addi	a2,a2,-832 # ffffffffc020a850 <commands+0x210>
ffffffffc0208b98:	22b00593          	li	a1,555
ffffffffc0208b9c:	00005517          	auipc	a0,0x5
ffffffffc0208ba0:	07450513          	addi	a0,a0,116 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208ba4:	8fbf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208ba8:	e65ff0ef          	jal	ra,ffffffffc0208a0c <sfs_io.part.0>

ffffffffc0208bac <sfs_block_free>:
ffffffffc0208bac:	1101                	addi	sp,sp,-32
ffffffffc0208bae:	e426                	sd	s1,8(sp)
ffffffffc0208bb0:	ec06                	sd	ra,24(sp)
ffffffffc0208bb2:	e822                	sd	s0,16(sp)
ffffffffc0208bb4:	4154                	lw	a3,4(a0)
ffffffffc0208bb6:	84ae                	mv	s1,a1
ffffffffc0208bb8:	c595                	beqz	a1,ffffffffc0208be4 <sfs_block_free+0x38>
ffffffffc0208bba:	02d5f563          	bgeu	a1,a3,ffffffffc0208be4 <sfs_block_free+0x38>
ffffffffc0208bbe:	842a                	mv	s0,a0
ffffffffc0208bc0:	7d08                	ld	a0,56(a0)
ffffffffc0208bc2:	d60ff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0208bc6:	ed05                	bnez	a0,ffffffffc0208bfe <sfs_block_free+0x52>
ffffffffc0208bc8:	7c08                	ld	a0,56(s0)
ffffffffc0208bca:	85a6                	mv	a1,s1
ffffffffc0208bcc:	d7eff0ef          	jal	ra,ffffffffc020814a <bitmap_free>
ffffffffc0208bd0:	441c                	lw	a5,8(s0)
ffffffffc0208bd2:	4705                	li	a4,1
ffffffffc0208bd4:	60e2                	ld	ra,24(sp)
ffffffffc0208bd6:	2785                	addiw	a5,a5,1
ffffffffc0208bd8:	e038                	sd	a4,64(s0)
ffffffffc0208bda:	c41c                	sw	a5,8(s0)
ffffffffc0208bdc:	6442                	ld	s0,16(sp)
ffffffffc0208bde:	64a2                	ld	s1,8(sp)
ffffffffc0208be0:	6105                	addi	sp,sp,32
ffffffffc0208be2:	8082                	ret
ffffffffc0208be4:	8726                	mv	a4,s1
ffffffffc0208be6:	00005617          	auipc	a2,0x5
ffffffffc0208bea:	07a60613          	addi	a2,a2,122 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc0208bee:	05300593          	li	a1,83
ffffffffc0208bf2:	00005517          	auipc	a0,0x5
ffffffffc0208bf6:	01e50513          	addi	a0,a0,30 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208bfa:	8a5f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208bfe:	00005697          	auipc	a3,0x5
ffffffffc0208c02:	09a68693          	addi	a3,a3,154 # ffffffffc020dc98 <dev_node_ops+0x648>
ffffffffc0208c06:	00002617          	auipc	a2,0x2
ffffffffc0208c0a:	c4a60613          	addi	a2,a2,-950 # ffffffffc020a850 <commands+0x210>
ffffffffc0208c0e:	06a00593          	li	a1,106
ffffffffc0208c12:	00005517          	auipc	a0,0x5
ffffffffc0208c16:	ffe50513          	addi	a0,a0,-2 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208c1a:	885f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208c1e <sfs_reclaim>:
ffffffffc0208c1e:	1101                	addi	sp,sp,-32
ffffffffc0208c20:	e426                	sd	s1,8(sp)
ffffffffc0208c22:	7524                	ld	s1,104(a0)
ffffffffc0208c24:	ec06                	sd	ra,24(sp)
ffffffffc0208c26:	e822                	sd	s0,16(sp)
ffffffffc0208c28:	e04a                	sd	s2,0(sp)
ffffffffc0208c2a:	0e048a63          	beqz	s1,ffffffffc0208d1e <sfs_reclaim+0x100>
ffffffffc0208c2e:	0b04a783          	lw	a5,176(s1)
ffffffffc0208c32:	0e079663          	bnez	a5,ffffffffc0208d1e <sfs_reclaim+0x100>
ffffffffc0208c36:	4d38                	lw	a4,88(a0)
ffffffffc0208c38:	6785                	lui	a5,0x1
ffffffffc0208c3a:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0208c3e:	842a                	mv	s0,a0
ffffffffc0208c40:	10f71f63          	bne	a4,a5,ffffffffc0208d5e <sfs_reclaim+0x140>
ffffffffc0208c44:	8526                	mv	a0,s1
ffffffffc0208c46:	1ce010ef          	jal	ra,ffffffffc0209e14 <lock_sfs_fs>
ffffffffc0208c4a:	4c1c                	lw	a5,24(s0)
ffffffffc0208c4c:	0ef05963          	blez	a5,ffffffffc0208d3e <sfs_reclaim+0x120>
ffffffffc0208c50:	fff7871b          	addiw	a4,a5,-1
ffffffffc0208c54:	cc18                	sw	a4,24(s0)
ffffffffc0208c56:	eb59                	bnez	a4,ffffffffc0208cec <sfs_reclaim+0xce>
ffffffffc0208c58:	05c42903          	lw	s2,92(s0)
ffffffffc0208c5c:	08091863          	bnez	s2,ffffffffc0208cec <sfs_reclaim+0xce>
ffffffffc0208c60:	601c                	ld	a5,0(s0)
ffffffffc0208c62:	0067d783          	lhu	a5,6(a5)
ffffffffc0208c66:	e785                	bnez	a5,ffffffffc0208c8e <sfs_reclaim+0x70>
ffffffffc0208c68:	783c                	ld	a5,112(s0)
ffffffffc0208c6a:	10078a63          	beqz	a5,ffffffffc0208d7e <sfs_reclaim+0x160>
ffffffffc0208c6e:	73bc                	ld	a5,96(a5)
ffffffffc0208c70:	10078763          	beqz	a5,ffffffffc0208d7e <sfs_reclaim+0x160>
ffffffffc0208c74:	00005597          	auipc	a1,0x5
ffffffffc0208c78:	84458593          	addi	a1,a1,-1980 # ffffffffc020d4b8 <syscalls+0xca0>
ffffffffc0208c7c:	8522                	mv	a0,s0
ffffffffc0208c7e:	cf5fd0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0208c82:	783c                	ld	a5,112(s0)
ffffffffc0208c84:	4581                	li	a1,0
ffffffffc0208c86:	8522                	mv	a0,s0
ffffffffc0208c88:	73bc                	ld	a5,96(a5)
ffffffffc0208c8a:	9782                	jalr	a5
ffffffffc0208c8c:	e559                	bnez	a0,ffffffffc0208d1a <sfs_reclaim+0xfc>
ffffffffc0208c8e:	681c                	ld	a5,16(s0)
ffffffffc0208c90:	c39d                	beqz	a5,ffffffffc0208cb6 <sfs_reclaim+0x98>
ffffffffc0208c92:	783c                	ld	a5,112(s0)
ffffffffc0208c94:	10078563          	beqz	a5,ffffffffc0208d9e <sfs_reclaim+0x180>
ffffffffc0208c98:	7b9c                	ld	a5,48(a5)
ffffffffc0208c9a:	10078263          	beqz	a5,ffffffffc0208d9e <sfs_reclaim+0x180>
ffffffffc0208c9e:	8522                	mv	a0,s0
ffffffffc0208ca0:	00003597          	auipc	a1,0x3
ffffffffc0208ca4:	4d058593          	addi	a1,a1,1232 # ffffffffc020c170 <default_pmm_manager+0xe38>
ffffffffc0208ca8:	ccbfd0ef          	jal	ra,ffffffffc0206972 <inode_check>
ffffffffc0208cac:	783c                	ld	a5,112(s0)
ffffffffc0208cae:	8522                	mv	a0,s0
ffffffffc0208cb0:	7b9c                	ld	a5,48(a5)
ffffffffc0208cb2:	9782                	jalr	a5
ffffffffc0208cb4:	e13d                	bnez	a0,ffffffffc0208d1a <sfs_reclaim+0xfc>
ffffffffc0208cb6:	7c18                	ld	a4,56(s0)
ffffffffc0208cb8:	603c                	ld	a5,64(s0)
ffffffffc0208cba:	8526                	mv	a0,s1
ffffffffc0208cbc:	e71c                	sd	a5,8(a4)
ffffffffc0208cbe:	e398                	sd	a4,0(a5)
ffffffffc0208cc0:	6438                	ld	a4,72(s0)
ffffffffc0208cc2:	683c                	ld	a5,80(s0)
ffffffffc0208cc4:	e71c                	sd	a5,8(a4)
ffffffffc0208cc6:	e398                	sd	a4,0(a5)
ffffffffc0208cc8:	15c010ef          	jal	ra,ffffffffc0209e24 <unlock_sfs_fs>
ffffffffc0208ccc:	6008                	ld	a0,0(s0)
ffffffffc0208cce:	00655783          	lhu	a5,6(a0)
ffffffffc0208cd2:	cb85                	beqz	a5,ffffffffc0208d02 <sfs_reclaim+0xe4>
ffffffffc0208cd4:	b6af90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208cd8:	8522                	mv	a0,s0
ffffffffc0208cda:	c2dfd0ef          	jal	ra,ffffffffc0206906 <inode_kill>
ffffffffc0208cde:	60e2                	ld	ra,24(sp)
ffffffffc0208ce0:	6442                	ld	s0,16(sp)
ffffffffc0208ce2:	64a2                	ld	s1,8(sp)
ffffffffc0208ce4:	854a                	mv	a0,s2
ffffffffc0208ce6:	6902                	ld	s2,0(sp)
ffffffffc0208ce8:	6105                	addi	sp,sp,32
ffffffffc0208cea:	8082                	ret
ffffffffc0208cec:	5945                	li	s2,-15
ffffffffc0208cee:	8526                	mv	a0,s1
ffffffffc0208cf0:	134010ef          	jal	ra,ffffffffc0209e24 <unlock_sfs_fs>
ffffffffc0208cf4:	60e2                	ld	ra,24(sp)
ffffffffc0208cf6:	6442                	ld	s0,16(sp)
ffffffffc0208cf8:	64a2                	ld	s1,8(sp)
ffffffffc0208cfa:	854a                	mv	a0,s2
ffffffffc0208cfc:	6902                	ld	s2,0(sp)
ffffffffc0208cfe:	6105                	addi	sp,sp,32
ffffffffc0208d00:	8082                	ret
ffffffffc0208d02:	440c                	lw	a1,8(s0)
ffffffffc0208d04:	8526                	mv	a0,s1
ffffffffc0208d06:	ea7ff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc0208d0a:	6008                	ld	a0,0(s0)
ffffffffc0208d0c:	5d4c                	lw	a1,60(a0)
ffffffffc0208d0e:	d1f9                	beqz	a1,ffffffffc0208cd4 <sfs_reclaim+0xb6>
ffffffffc0208d10:	8526                	mv	a0,s1
ffffffffc0208d12:	e9bff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc0208d16:	6008                	ld	a0,0(s0)
ffffffffc0208d18:	bf75                	j	ffffffffc0208cd4 <sfs_reclaim+0xb6>
ffffffffc0208d1a:	892a                	mv	s2,a0
ffffffffc0208d1c:	bfc9                	j	ffffffffc0208cee <sfs_reclaim+0xd0>
ffffffffc0208d1e:	00005697          	auipc	a3,0x5
ffffffffc0208d22:	d1268693          	addi	a3,a3,-750 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0208d26:	00002617          	auipc	a2,0x2
ffffffffc0208d2a:	b2a60613          	addi	a2,a2,-1238 # ffffffffc020a850 <commands+0x210>
ffffffffc0208d2e:	32e00593          	li	a1,814
ffffffffc0208d32:	00005517          	auipc	a0,0x5
ffffffffc0208d36:	ede50513          	addi	a0,a0,-290 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208d3a:	f64f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d3e:	00005697          	auipc	a3,0x5
ffffffffc0208d42:	f7a68693          	addi	a3,a3,-134 # ffffffffc020dcb8 <dev_node_ops+0x668>
ffffffffc0208d46:	00002617          	auipc	a2,0x2
ffffffffc0208d4a:	b0a60613          	addi	a2,a2,-1270 # ffffffffc020a850 <commands+0x210>
ffffffffc0208d4e:	33400593          	li	a1,820
ffffffffc0208d52:	00005517          	auipc	a0,0x5
ffffffffc0208d56:	ebe50513          	addi	a0,a0,-322 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208d5a:	f44f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d5e:	00005697          	auipc	a3,0x5
ffffffffc0208d62:	e7a68693          	addi	a3,a3,-390 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0208d66:	00002617          	auipc	a2,0x2
ffffffffc0208d6a:	aea60613          	addi	a2,a2,-1302 # ffffffffc020a850 <commands+0x210>
ffffffffc0208d6e:	32f00593          	li	a1,815
ffffffffc0208d72:	00005517          	auipc	a0,0x5
ffffffffc0208d76:	e9e50513          	addi	a0,a0,-354 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208d7a:	f24f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d7e:	00004697          	auipc	a3,0x4
ffffffffc0208d82:	6e268693          	addi	a3,a3,1762 # ffffffffc020d460 <syscalls+0xc48>
ffffffffc0208d86:	00002617          	auipc	a2,0x2
ffffffffc0208d8a:	aca60613          	addi	a2,a2,-1334 # ffffffffc020a850 <commands+0x210>
ffffffffc0208d8e:	33900593          	li	a1,825
ffffffffc0208d92:	00005517          	auipc	a0,0x5
ffffffffc0208d96:	e7e50513          	addi	a0,a0,-386 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208d9a:	f04f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208d9e:	00003697          	auipc	a3,0x3
ffffffffc0208da2:	38268693          	addi	a3,a3,898 # ffffffffc020c120 <default_pmm_manager+0xde8>
ffffffffc0208da6:	00002617          	auipc	a2,0x2
ffffffffc0208daa:	aaa60613          	addi	a2,a2,-1366 # ffffffffc020a850 <commands+0x210>
ffffffffc0208dae:	33e00593          	li	a1,830
ffffffffc0208db2:	00005517          	auipc	a0,0x5
ffffffffc0208db6:	e5e50513          	addi	a0,a0,-418 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208dba:	ee4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208dbe <sfs_block_alloc>:
ffffffffc0208dbe:	1101                	addi	sp,sp,-32
ffffffffc0208dc0:	e822                	sd	s0,16(sp)
ffffffffc0208dc2:	842a                	mv	s0,a0
ffffffffc0208dc4:	7d08                	ld	a0,56(a0)
ffffffffc0208dc6:	e426                	sd	s1,8(sp)
ffffffffc0208dc8:	ec06                	sd	ra,24(sp)
ffffffffc0208dca:	84ae                	mv	s1,a1
ffffffffc0208dcc:	ae6ff0ef          	jal	ra,ffffffffc02080b2 <bitmap_alloc>
ffffffffc0208dd0:	e90d                	bnez	a0,ffffffffc0208e02 <sfs_block_alloc+0x44>
ffffffffc0208dd2:	441c                	lw	a5,8(s0)
ffffffffc0208dd4:	cbad                	beqz	a5,ffffffffc0208e46 <sfs_block_alloc+0x88>
ffffffffc0208dd6:	37fd                	addiw	a5,a5,-1
ffffffffc0208dd8:	c41c                	sw	a5,8(s0)
ffffffffc0208dda:	408c                	lw	a1,0(s1)
ffffffffc0208ddc:	4785                	li	a5,1
ffffffffc0208dde:	e03c                	sd	a5,64(s0)
ffffffffc0208de0:	4054                	lw	a3,4(s0)
ffffffffc0208de2:	c58d                	beqz	a1,ffffffffc0208e0c <sfs_block_alloc+0x4e>
ffffffffc0208de4:	02d5f463          	bgeu	a1,a3,ffffffffc0208e0c <sfs_block_alloc+0x4e>
ffffffffc0208de8:	7c08                	ld	a0,56(s0)
ffffffffc0208dea:	b38ff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0208dee:	ed05                	bnez	a0,ffffffffc0208e26 <sfs_block_alloc+0x68>
ffffffffc0208df0:	8522                	mv	a0,s0
ffffffffc0208df2:	6442                	ld	s0,16(sp)
ffffffffc0208df4:	408c                	lw	a1,0(s1)
ffffffffc0208df6:	60e2                	ld	ra,24(sp)
ffffffffc0208df8:	64a2                	ld	s1,8(sp)
ffffffffc0208dfa:	4605                	li	a2,1
ffffffffc0208dfc:	6105                	addi	sp,sp,32
ffffffffc0208dfe:	7b70006f          	j	ffffffffc0209db4 <sfs_clear_block>
ffffffffc0208e02:	60e2                	ld	ra,24(sp)
ffffffffc0208e04:	6442                	ld	s0,16(sp)
ffffffffc0208e06:	64a2                	ld	s1,8(sp)
ffffffffc0208e08:	6105                	addi	sp,sp,32
ffffffffc0208e0a:	8082                	ret
ffffffffc0208e0c:	872e                	mv	a4,a1
ffffffffc0208e0e:	00005617          	auipc	a2,0x5
ffffffffc0208e12:	e5260613          	addi	a2,a2,-430 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc0208e16:	05300593          	li	a1,83
ffffffffc0208e1a:	00005517          	auipc	a0,0x5
ffffffffc0208e1e:	df650513          	addi	a0,a0,-522 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208e22:	e7cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e26:	00005697          	auipc	a3,0x5
ffffffffc0208e2a:	eca68693          	addi	a3,a3,-310 # ffffffffc020dcf0 <dev_node_ops+0x6a0>
ffffffffc0208e2e:	00002617          	auipc	a2,0x2
ffffffffc0208e32:	a2260613          	addi	a2,a2,-1502 # ffffffffc020a850 <commands+0x210>
ffffffffc0208e36:	06100593          	li	a1,97
ffffffffc0208e3a:	00005517          	auipc	a0,0x5
ffffffffc0208e3e:	dd650513          	addi	a0,a0,-554 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208e42:	e5cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e46:	00005697          	auipc	a3,0x5
ffffffffc0208e4a:	e8a68693          	addi	a3,a3,-374 # ffffffffc020dcd0 <dev_node_ops+0x680>
ffffffffc0208e4e:	00002617          	auipc	a2,0x2
ffffffffc0208e52:	a0260613          	addi	a2,a2,-1534 # ffffffffc020a850 <commands+0x210>
ffffffffc0208e56:	05f00593          	li	a1,95
ffffffffc0208e5a:	00005517          	auipc	a0,0x5
ffffffffc0208e5e:	db650513          	addi	a0,a0,-586 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208e62:	e3cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e66 <sfs_bmap_load_nolock>:
ffffffffc0208e66:	7159                	addi	sp,sp,-112
ffffffffc0208e68:	f85a                	sd	s6,48(sp)
ffffffffc0208e6a:	0005bb03          	ld	s6,0(a1)
ffffffffc0208e6e:	f45e                	sd	s7,40(sp)
ffffffffc0208e70:	f486                	sd	ra,104(sp)
ffffffffc0208e72:	008b2b83          	lw	s7,8(s6)
ffffffffc0208e76:	f0a2                	sd	s0,96(sp)
ffffffffc0208e78:	eca6                	sd	s1,88(sp)
ffffffffc0208e7a:	e8ca                	sd	s2,80(sp)
ffffffffc0208e7c:	e4ce                	sd	s3,72(sp)
ffffffffc0208e7e:	e0d2                	sd	s4,64(sp)
ffffffffc0208e80:	fc56                	sd	s5,56(sp)
ffffffffc0208e82:	f062                	sd	s8,32(sp)
ffffffffc0208e84:	ec66                	sd	s9,24(sp)
ffffffffc0208e86:	18cbe363          	bltu	s7,a2,ffffffffc020900c <sfs_bmap_load_nolock+0x1a6>
ffffffffc0208e8a:	47ad                	li	a5,11
ffffffffc0208e8c:	8aae                	mv	s5,a1
ffffffffc0208e8e:	8432                	mv	s0,a2
ffffffffc0208e90:	84aa                	mv	s1,a0
ffffffffc0208e92:	89b6                	mv	s3,a3
ffffffffc0208e94:	04c7f563          	bgeu	a5,a2,ffffffffc0208ede <sfs_bmap_load_nolock+0x78>
ffffffffc0208e98:	ff46071b          	addiw	a4,a2,-12
ffffffffc0208e9c:	0007069b          	sext.w	a3,a4
ffffffffc0208ea0:	3ff00793          	li	a5,1023
ffffffffc0208ea4:	1ad7e163          	bltu	a5,a3,ffffffffc0209046 <sfs_bmap_load_nolock+0x1e0>
ffffffffc0208ea8:	03cb2a03          	lw	s4,60(s6)
ffffffffc0208eac:	02071793          	slli	a5,a4,0x20
ffffffffc0208eb0:	c602                	sw	zero,12(sp)
ffffffffc0208eb2:	c452                	sw	s4,8(sp)
ffffffffc0208eb4:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0208eb8:	0e0a1e63          	bnez	s4,ffffffffc0208fb4 <sfs_bmap_load_nolock+0x14e>
ffffffffc0208ebc:	0acb8663          	beq	s7,a2,ffffffffc0208f68 <sfs_bmap_load_nolock+0x102>
ffffffffc0208ec0:	4a01                	li	s4,0
ffffffffc0208ec2:	40d4                	lw	a3,4(s1)
ffffffffc0208ec4:	8752                	mv	a4,s4
ffffffffc0208ec6:	00005617          	auipc	a2,0x5
ffffffffc0208eca:	d9a60613          	addi	a2,a2,-614 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc0208ece:	05300593          	li	a1,83
ffffffffc0208ed2:	00005517          	auipc	a0,0x5
ffffffffc0208ed6:	d3e50513          	addi	a0,a0,-706 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0208eda:	dc4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208ede:	02061793          	slli	a5,a2,0x20
ffffffffc0208ee2:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0208ee6:	9a5a                	add	s4,s4,s6
ffffffffc0208ee8:	00ca2583          	lw	a1,12(s4)
ffffffffc0208eec:	c22e                	sw	a1,4(sp)
ffffffffc0208eee:	ed99                	bnez	a1,ffffffffc0208f0c <sfs_bmap_load_nolock+0xa6>
ffffffffc0208ef0:	fccb98e3          	bne	s7,a2,ffffffffc0208ec0 <sfs_bmap_load_nolock+0x5a>
ffffffffc0208ef4:	004c                	addi	a1,sp,4
ffffffffc0208ef6:	ec9ff0ef          	jal	ra,ffffffffc0208dbe <sfs_block_alloc>
ffffffffc0208efa:	892a                	mv	s2,a0
ffffffffc0208efc:	e921                	bnez	a0,ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208efe:	4592                	lw	a1,4(sp)
ffffffffc0208f00:	4705                	li	a4,1
ffffffffc0208f02:	00ba2623          	sw	a1,12(s4)
ffffffffc0208f06:	00eab823          	sd	a4,16(s5)
ffffffffc0208f0a:	d9dd                	beqz	a1,ffffffffc0208ec0 <sfs_bmap_load_nolock+0x5a>
ffffffffc0208f0c:	40d4                	lw	a3,4(s1)
ffffffffc0208f0e:	10d5ff63          	bgeu	a1,a3,ffffffffc020902c <sfs_bmap_load_nolock+0x1c6>
ffffffffc0208f12:	7c88                	ld	a0,56(s1)
ffffffffc0208f14:	a0eff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0208f18:	18051363          	bnez	a0,ffffffffc020909e <sfs_bmap_load_nolock+0x238>
ffffffffc0208f1c:	4a12                	lw	s4,4(sp)
ffffffffc0208f1e:	fa0a02e3          	beqz	s4,ffffffffc0208ec2 <sfs_bmap_load_nolock+0x5c>
ffffffffc0208f22:	40dc                	lw	a5,4(s1)
ffffffffc0208f24:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0208ec2 <sfs_bmap_load_nolock+0x5c>
ffffffffc0208f28:	7c88                	ld	a0,56(s1)
ffffffffc0208f2a:	85d2                	mv	a1,s4
ffffffffc0208f2c:	9f6ff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0208f30:	12051763          	bnez	a0,ffffffffc020905e <sfs_bmap_load_nolock+0x1f8>
ffffffffc0208f34:	008b9763          	bne	s7,s0,ffffffffc0208f42 <sfs_bmap_load_nolock+0xdc>
ffffffffc0208f38:	008b2783          	lw	a5,8(s6)
ffffffffc0208f3c:	2785                	addiw	a5,a5,1
ffffffffc0208f3e:	00fb2423          	sw	a5,8(s6)
ffffffffc0208f42:	4901                	li	s2,0
ffffffffc0208f44:	00098463          	beqz	s3,ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208f48:	0149a023          	sw	s4,0(s3)
ffffffffc0208f4c:	70a6                	ld	ra,104(sp)
ffffffffc0208f4e:	7406                	ld	s0,96(sp)
ffffffffc0208f50:	64e6                	ld	s1,88(sp)
ffffffffc0208f52:	69a6                	ld	s3,72(sp)
ffffffffc0208f54:	6a06                	ld	s4,64(sp)
ffffffffc0208f56:	7ae2                	ld	s5,56(sp)
ffffffffc0208f58:	7b42                	ld	s6,48(sp)
ffffffffc0208f5a:	7ba2                	ld	s7,40(sp)
ffffffffc0208f5c:	7c02                	ld	s8,32(sp)
ffffffffc0208f5e:	6ce2                	ld	s9,24(sp)
ffffffffc0208f60:	854a                	mv	a0,s2
ffffffffc0208f62:	6946                	ld	s2,80(sp)
ffffffffc0208f64:	6165                	addi	sp,sp,112
ffffffffc0208f66:	8082                	ret
ffffffffc0208f68:	002c                	addi	a1,sp,8
ffffffffc0208f6a:	e55ff0ef          	jal	ra,ffffffffc0208dbe <sfs_block_alloc>
ffffffffc0208f6e:	892a                	mv	s2,a0
ffffffffc0208f70:	00c10c93          	addi	s9,sp,12
ffffffffc0208f74:	fd61                	bnez	a0,ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208f76:	85e6                	mv	a1,s9
ffffffffc0208f78:	8526                	mv	a0,s1
ffffffffc0208f7a:	e45ff0ef          	jal	ra,ffffffffc0208dbe <sfs_block_alloc>
ffffffffc0208f7e:	892a                	mv	s2,a0
ffffffffc0208f80:	e925                	bnez	a0,ffffffffc0208ff0 <sfs_bmap_load_nolock+0x18a>
ffffffffc0208f82:	46a2                	lw	a3,8(sp)
ffffffffc0208f84:	85e6                	mv	a1,s9
ffffffffc0208f86:	8762                	mv	a4,s8
ffffffffc0208f88:	4611                	li	a2,4
ffffffffc0208f8a:	8526                	mv	a0,s1
ffffffffc0208f8c:	4d9000ef          	jal	ra,ffffffffc0209c64 <sfs_wbuf>
ffffffffc0208f90:	45b2                	lw	a1,12(sp)
ffffffffc0208f92:	892a                	mv	s2,a0
ffffffffc0208f94:	e939                	bnez	a0,ffffffffc0208fea <sfs_bmap_load_nolock+0x184>
ffffffffc0208f96:	03cb2683          	lw	a3,60(s6)
ffffffffc0208f9a:	4722                	lw	a4,8(sp)
ffffffffc0208f9c:	c22e                	sw	a1,4(sp)
ffffffffc0208f9e:	f6d706e3          	beq	a4,a3,ffffffffc0208f0a <sfs_bmap_load_nolock+0xa4>
ffffffffc0208fa2:	eef1                	bnez	a3,ffffffffc020907e <sfs_bmap_load_nolock+0x218>
ffffffffc0208fa4:	02eb2e23          	sw	a4,60(s6)
ffffffffc0208fa8:	4705                	li	a4,1
ffffffffc0208faa:	00eab823          	sd	a4,16(s5)
ffffffffc0208fae:	f00589e3          	beqz	a1,ffffffffc0208ec0 <sfs_bmap_load_nolock+0x5a>
ffffffffc0208fb2:	bfa9                	j	ffffffffc0208f0c <sfs_bmap_load_nolock+0xa6>
ffffffffc0208fb4:	00c10c93          	addi	s9,sp,12
ffffffffc0208fb8:	8762                	mv	a4,s8
ffffffffc0208fba:	86d2                	mv	a3,s4
ffffffffc0208fbc:	4611                	li	a2,4
ffffffffc0208fbe:	85e6                	mv	a1,s9
ffffffffc0208fc0:	425000ef          	jal	ra,ffffffffc0209be4 <sfs_rbuf>
ffffffffc0208fc4:	892a                	mv	s2,a0
ffffffffc0208fc6:	f159                	bnez	a0,ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208fc8:	45b2                	lw	a1,12(sp)
ffffffffc0208fca:	e995                	bnez	a1,ffffffffc0208ffe <sfs_bmap_load_nolock+0x198>
ffffffffc0208fcc:	fa8b85e3          	beq	s7,s0,ffffffffc0208f76 <sfs_bmap_load_nolock+0x110>
ffffffffc0208fd0:	03cb2703          	lw	a4,60(s6)
ffffffffc0208fd4:	47a2                	lw	a5,8(sp)
ffffffffc0208fd6:	c202                	sw	zero,4(sp)
ffffffffc0208fd8:	eee784e3          	beq	a5,a4,ffffffffc0208ec0 <sfs_bmap_load_nolock+0x5a>
ffffffffc0208fdc:	e34d                	bnez	a4,ffffffffc020907e <sfs_bmap_load_nolock+0x218>
ffffffffc0208fde:	02fb2e23          	sw	a5,60(s6)
ffffffffc0208fe2:	4785                	li	a5,1
ffffffffc0208fe4:	00fab823          	sd	a5,16(s5)
ffffffffc0208fe8:	bde1                	j	ffffffffc0208ec0 <sfs_bmap_load_nolock+0x5a>
ffffffffc0208fea:	8526                	mv	a0,s1
ffffffffc0208fec:	bc1ff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc0208ff0:	45a2                	lw	a1,8(sp)
ffffffffc0208ff2:	f4ba0de3          	beq	s4,a1,ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208ff6:	8526                	mv	a0,s1
ffffffffc0208ff8:	bb5ff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc0208ffc:	bf81                	j	ffffffffc0208f4c <sfs_bmap_load_nolock+0xe6>
ffffffffc0208ffe:	03cb2683          	lw	a3,60(s6)
ffffffffc0209002:	4722                	lw	a4,8(sp)
ffffffffc0209004:	c22e                	sw	a1,4(sp)
ffffffffc0209006:	f8e69ee3          	bne	a3,a4,ffffffffc0208fa2 <sfs_bmap_load_nolock+0x13c>
ffffffffc020900a:	b709                	j	ffffffffc0208f0c <sfs_bmap_load_nolock+0xa6>
ffffffffc020900c:	00005697          	auipc	a3,0x5
ffffffffc0209010:	d0c68693          	addi	a3,a3,-756 # ffffffffc020dd18 <dev_node_ops+0x6c8>
ffffffffc0209014:	00002617          	auipc	a2,0x2
ffffffffc0209018:	83c60613          	addi	a2,a2,-1988 # ffffffffc020a850 <commands+0x210>
ffffffffc020901c:	16400593          	li	a1,356
ffffffffc0209020:	00005517          	auipc	a0,0x5
ffffffffc0209024:	bf050513          	addi	a0,a0,-1040 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209028:	c76f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020902c:	872e                	mv	a4,a1
ffffffffc020902e:	00005617          	auipc	a2,0x5
ffffffffc0209032:	c3260613          	addi	a2,a2,-974 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc0209036:	05300593          	li	a1,83
ffffffffc020903a:	00005517          	auipc	a0,0x5
ffffffffc020903e:	bd650513          	addi	a0,a0,-1066 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209042:	c5cf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209046:	00005617          	auipc	a2,0x5
ffffffffc020904a:	d0260613          	addi	a2,a2,-766 # ffffffffc020dd48 <dev_node_ops+0x6f8>
ffffffffc020904e:	11e00593          	li	a1,286
ffffffffc0209052:	00005517          	auipc	a0,0x5
ffffffffc0209056:	bbe50513          	addi	a0,a0,-1090 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020905a:	c44f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020905e:	00005697          	auipc	a3,0x5
ffffffffc0209062:	c3a68693          	addi	a3,a3,-966 # ffffffffc020dc98 <dev_node_ops+0x648>
ffffffffc0209066:	00001617          	auipc	a2,0x1
ffffffffc020906a:	7ea60613          	addi	a2,a2,2026 # ffffffffc020a850 <commands+0x210>
ffffffffc020906e:	16b00593          	li	a1,363
ffffffffc0209072:	00005517          	auipc	a0,0x5
ffffffffc0209076:	b9e50513          	addi	a0,a0,-1122 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020907a:	c24f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020907e:	00005697          	auipc	a3,0x5
ffffffffc0209082:	cb268693          	addi	a3,a3,-846 # ffffffffc020dd30 <dev_node_ops+0x6e0>
ffffffffc0209086:	00001617          	auipc	a2,0x1
ffffffffc020908a:	7ca60613          	addi	a2,a2,1994 # ffffffffc020a850 <commands+0x210>
ffffffffc020908e:	11800593          	li	a1,280
ffffffffc0209092:	00005517          	auipc	a0,0x5
ffffffffc0209096:	b7e50513          	addi	a0,a0,-1154 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020909a:	c04f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020909e:	00005697          	auipc	a3,0x5
ffffffffc02090a2:	cda68693          	addi	a3,a3,-806 # ffffffffc020dd78 <dev_node_ops+0x728>
ffffffffc02090a6:	00001617          	auipc	a2,0x1
ffffffffc02090aa:	7aa60613          	addi	a2,a2,1962 # ffffffffc020a850 <commands+0x210>
ffffffffc02090ae:	12100593          	li	a1,289
ffffffffc02090b2:	00005517          	auipc	a0,0x5
ffffffffc02090b6:	b5e50513          	addi	a0,a0,-1186 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02090ba:	be4f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090be <sfs_dirent_read_nolock>:
ffffffffc02090be:	6198                	ld	a4,0(a1)
ffffffffc02090c0:	7179                	addi	sp,sp,-48
ffffffffc02090c2:	f406                	sd	ra,40(sp)
ffffffffc02090c4:	00475883          	lhu	a7,4(a4) # 4004 <_binary_bin_swap_img_size-0x3cfc>
ffffffffc02090c8:	f022                	sd	s0,32(sp)
ffffffffc02090ca:	ec26                	sd	s1,24(sp)
ffffffffc02090cc:	4809                	li	a6,2
ffffffffc02090ce:	05089b63          	bne	a7,a6,ffffffffc0209124 <sfs_dirent_read_nolock+0x66>
ffffffffc02090d2:	4718                	lw	a4,8(a4)
ffffffffc02090d4:	87b2                	mv	a5,a2
ffffffffc02090d6:	2601                	sext.w	a2,a2
ffffffffc02090d8:	04e7f663          	bgeu	a5,a4,ffffffffc0209124 <sfs_dirent_read_nolock+0x66>
ffffffffc02090dc:	84b6                	mv	s1,a3
ffffffffc02090de:	0074                	addi	a3,sp,12
ffffffffc02090e0:	842a                	mv	s0,a0
ffffffffc02090e2:	d85ff0ef          	jal	ra,ffffffffc0208e66 <sfs_bmap_load_nolock>
ffffffffc02090e6:	c511                	beqz	a0,ffffffffc02090f2 <sfs_dirent_read_nolock+0x34>
ffffffffc02090e8:	70a2                	ld	ra,40(sp)
ffffffffc02090ea:	7402                	ld	s0,32(sp)
ffffffffc02090ec:	64e2                	ld	s1,24(sp)
ffffffffc02090ee:	6145                	addi	sp,sp,48
ffffffffc02090f0:	8082                	ret
ffffffffc02090f2:	45b2                	lw	a1,12(sp)
ffffffffc02090f4:	4054                	lw	a3,4(s0)
ffffffffc02090f6:	c5b9                	beqz	a1,ffffffffc0209144 <sfs_dirent_read_nolock+0x86>
ffffffffc02090f8:	04d5f663          	bgeu	a1,a3,ffffffffc0209144 <sfs_dirent_read_nolock+0x86>
ffffffffc02090fc:	7c08                	ld	a0,56(s0)
ffffffffc02090fe:	824ff0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0209102:	ed31                	bnez	a0,ffffffffc020915e <sfs_dirent_read_nolock+0xa0>
ffffffffc0209104:	46b2                	lw	a3,12(sp)
ffffffffc0209106:	4701                	li	a4,0
ffffffffc0209108:	10400613          	li	a2,260
ffffffffc020910c:	85a6                	mv	a1,s1
ffffffffc020910e:	8522                	mv	a0,s0
ffffffffc0209110:	2d5000ef          	jal	ra,ffffffffc0209be4 <sfs_rbuf>
ffffffffc0209114:	f971                	bnez	a0,ffffffffc02090e8 <sfs_dirent_read_nolock+0x2a>
ffffffffc0209116:	100481a3          	sb	zero,259(s1)
ffffffffc020911a:	70a2                	ld	ra,40(sp)
ffffffffc020911c:	7402                	ld	s0,32(sp)
ffffffffc020911e:	64e2                	ld	s1,24(sp)
ffffffffc0209120:	6145                	addi	sp,sp,48
ffffffffc0209122:	8082                	ret
ffffffffc0209124:	00005697          	auipc	a3,0x5
ffffffffc0209128:	c7c68693          	addi	a3,a3,-900 # ffffffffc020dda0 <dev_node_ops+0x750>
ffffffffc020912c:	00001617          	auipc	a2,0x1
ffffffffc0209130:	72460613          	addi	a2,a2,1828 # ffffffffc020a850 <commands+0x210>
ffffffffc0209134:	18e00593          	li	a1,398
ffffffffc0209138:	00005517          	auipc	a0,0x5
ffffffffc020913c:	ad850513          	addi	a0,a0,-1320 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209140:	b5ef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209144:	872e                	mv	a4,a1
ffffffffc0209146:	00005617          	auipc	a2,0x5
ffffffffc020914a:	b1a60613          	addi	a2,a2,-1254 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc020914e:	05300593          	li	a1,83
ffffffffc0209152:	00005517          	auipc	a0,0x5
ffffffffc0209156:	abe50513          	addi	a0,a0,-1346 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020915a:	b44f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020915e:	00005697          	auipc	a3,0x5
ffffffffc0209162:	b3a68693          	addi	a3,a3,-1222 # ffffffffc020dc98 <dev_node_ops+0x648>
ffffffffc0209166:	00001617          	auipc	a2,0x1
ffffffffc020916a:	6ea60613          	addi	a2,a2,1770 # ffffffffc020a850 <commands+0x210>
ffffffffc020916e:	19500593          	li	a1,405
ffffffffc0209172:	00005517          	auipc	a0,0x5
ffffffffc0209176:	a9e50513          	addi	a0,a0,-1378 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020917a:	b24f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020917e <sfs_getdirentry>:
ffffffffc020917e:	715d                	addi	sp,sp,-80
ffffffffc0209180:	ec56                	sd	s5,24(sp)
ffffffffc0209182:	8aaa                	mv	s5,a0
ffffffffc0209184:	10400513          	li	a0,260
ffffffffc0209188:	e85a                	sd	s6,16(sp)
ffffffffc020918a:	e486                	sd	ra,72(sp)
ffffffffc020918c:	e0a2                	sd	s0,64(sp)
ffffffffc020918e:	fc26                	sd	s1,56(sp)
ffffffffc0209190:	f84a                	sd	s2,48(sp)
ffffffffc0209192:	f44e                	sd	s3,40(sp)
ffffffffc0209194:	f052                	sd	s4,32(sp)
ffffffffc0209196:	e45e                	sd	s7,8(sp)
ffffffffc0209198:	e062                	sd	s8,0(sp)
ffffffffc020919a:	8b2e                	mv	s6,a1
ffffffffc020919c:	df3f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02091a0:	cd61                	beqz	a0,ffffffffc0209278 <sfs_getdirentry+0xfa>
ffffffffc02091a2:	068abb83          	ld	s7,104(s5)
ffffffffc02091a6:	0c0b8b63          	beqz	s7,ffffffffc020927c <sfs_getdirentry+0xfe>
ffffffffc02091aa:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc02091ae:	e7f9                	bnez	a5,ffffffffc020927c <sfs_getdirentry+0xfe>
ffffffffc02091b0:	058aa703          	lw	a4,88(s5)
ffffffffc02091b4:	6785                	lui	a5,0x1
ffffffffc02091b6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02091ba:	0ef71163          	bne	a4,a5,ffffffffc020929c <sfs_getdirentry+0x11e>
ffffffffc02091be:	008b3983          	ld	s3,8(s6)
ffffffffc02091c2:	892a                	mv	s2,a0
ffffffffc02091c4:	0a09c163          	bltz	s3,ffffffffc0209266 <sfs_getdirentry+0xe8>
ffffffffc02091c8:	0ff9f793          	zext.b	a5,s3
ffffffffc02091cc:	efc9                	bnez	a5,ffffffffc0209266 <sfs_getdirentry+0xe8>
ffffffffc02091ce:	000ab783          	ld	a5,0(s5)
ffffffffc02091d2:	0089d993          	srli	s3,s3,0x8
ffffffffc02091d6:	2981                	sext.w	s3,s3
ffffffffc02091d8:	479c                	lw	a5,8(a5)
ffffffffc02091da:	0937eb63          	bltu	a5,s3,ffffffffc0209270 <sfs_getdirentry+0xf2>
ffffffffc02091de:	020a8c13          	addi	s8,s5,32
ffffffffc02091e2:	8562                	mv	a0,s8
ffffffffc02091e4:	ed7fa0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc02091e8:	000ab783          	ld	a5,0(s5)
ffffffffc02091ec:	0087aa03          	lw	s4,8(a5)
ffffffffc02091f0:	07405663          	blez	s4,ffffffffc020925c <sfs_getdirentry+0xde>
ffffffffc02091f4:	4481                	li	s1,0
ffffffffc02091f6:	a811                	j	ffffffffc020920a <sfs_getdirentry+0x8c>
ffffffffc02091f8:	00092783          	lw	a5,0(s2)
ffffffffc02091fc:	c781                	beqz	a5,ffffffffc0209204 <sfs_getdirentry+0x86>
ffffffffc02091fe:	02098263          	beqz	s3,ffffffffc0209222 <sfs_getdirentry+0xa4>
ffffffffc0209202:	39fd                	addiw	s3,s3,-1
ffffffffc0209204:	2485                	addiw	s1,s1,1
ffffffffc0209206:	049a0b63          	beq	s4,s1,ffffffffc020925c <sfs_getdirentry+0xde>
ffffffffc020920a:	86ca                	mv	a3,s2
ffffffffc020920c:	8626                	mv	a2,s1
ffffffffc020920e:	85d6                	mv	a1,s5
ffffffffc0209210:	855e                	mv	a0,s7
ffffffffc0209212:	eadff0ef          	jal	ra,ffffffffc02090be <sfs_dirent_read_nolock>
ffffffffc0209216:	842a                	mv	s0,a0
ffffffffc0209218:	d165                	beqz	a0,ffffffffc02091f8 <sfs_getdirentry+0x7a>
ffffffffc020921a:	8562                	mv	a0,s8
ffffffffc020921c:	e9bfa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0209220:	a831                	j	ffffffffc020923c <sfs_getdirentry+0xbe>
ffffffffc0209222:	8562                	mv	a0,s8
ffffffffc0209224:	e93fa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0209228:	4701                	li	a4,0
ffffffffc020922a:	4685                	li	a3,1
ffffffffc020922c:	10000613          	li	a2,256
ffffffffc0209230:	00490593          	addi	a1,s2,4
ffffffffc0209234:	855a                	mv	a0,s6
ffffffffc0209236:	d0dfb0ef          	jal	ra,ffffffffc0204f42 <iobuf_move>
ffffffffc020923a:	842a                	mv	s0,a0
ffffffffc020923c:	854a                	mv	a0,s2
ffffffffc020923e:	e01f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209242:	60a6                	ld	ra,72(sp)
ffffffffc0209244:	8522                	mv	a0,s0
ffffffffc0209246:	6406                	ld	s0,64(sp)
ffffffffc0209248:	74e2                	ld	s1,56(sp)
ffffffffc020924a:	7942                	ld	s2,48(sp)
ffffffffc020924c:	79a2                	ld	s3,40(sp)
ffffffffc020924e:	7a02                	ld	s4,32(sp)
ffffffffc0209250:	6ae2                	ld	s5,24(sp)
ffffffffc0209252:	6b42                	ld	s6,16(sp)
ffffffffc0209254:	6ba2                	ld	s7,8(sp)
ffffffffc0209256:	6c02                	ld	s8,0(sp)
ffffffffc0209258:	6161                	addi	sp,sp,80
ffffffffc020925a:	8082                	ret
ffffffffc020925c:	8562                	mv	a0,s8
ffffffffc020925e:	5441                	li	s0,-16
ffffffffc0209260:	e57fa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0209264:	bfe1                	j	ffffffffc020923c <sfs_getdirentry+0xbe>
ffffffffc0209266:	854a                	mv	a0,s2
ffffffffc0209268:	dd7f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020926c:	5475                	li	s0,-3
ffffffffc020926e:	bfd1                	j	ffffffffc0209242 <sfs_getdirentry+0xc4>
ffffffffc0209270:	dcff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209274:	5441                	li	s0,-16
ffffffffc0209276:	b7f1                	j	ffffffffc0209242 <sfs_getdirentry+0xc4>
ffffffffc0209278:	5471                	li	s0,-4
ffffffffc020927a:	b7e1                	j	ffffffffc0209242 <sfs_getdirentry+0xc4>
ffffffffc020927c:	00004697          	auipc	a3,0x4
ffffffffc0209280:	7b468693          	addi	a3,a3,1972 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0209284:	00001617          	auipc	a2,0x1
ffffffffc0209288:	5cc60613          	addi	a2,a2,1484 # ffffffffc020a850 <commands+0x210>
ffffffffc020928c:	31000593          	li	a1,784
ffffffffc0209290:	00005517          	auipc	a0,0x5
ffffffffc0209294:	98050513          	addi	a0,a0,-1664 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209298:	a06f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020929c:	00005697          	auipc	a3,0x5
ffffffffc02092a0:	93c68693          	addi	a3,a3,-1732 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc02092a4:	00001617          	auipc	a2,0x1
ffffffffc02092a8:	5ac60613          	addi	a2,a2,1452 # ffffffffc020a850 <commands+0x210>
ffffffffc02092ac:	31100593          	li	a1,785
ffffffffc02092b0:	00005517          	auipc	a0,0x5
ffffffffc02092b4:	96050513          	addi	a0,a0,-1696 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02092b8:	9e6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02092bc <sfs_dirent_search_nolock.constprop.0>:
ffffffffc02092bc:	715d                	addi	sp,sp,-80
ffffffffc02092be:	f052                	sd	s4,32(sp)
ffffffffc02092c0:	8a2a                	mv	s4,a0
ffffffffc02092c2:	8532                	mv	a0,a2
ffffffffc02092c4:	f44e                	sd	s3,40(sp)
ffffffffc02092c6:	e85a                	sd	s6,16(sp)
ffffffffc02092c8:	e45e                	sd	s7,8(sp)
ffffffffc02092ca:	e486                	sd	ra,72(sp)
ffffffffc02092cc:	e0a2                	sd	s0,64(sp)
ffffffffc02092ce:	fc26                	sd	s1,56(sp)
ffffffffc02092d0:	f84a                	sd	s2,48(sp)
ffffffffc02092d2:	ec56                	sd	s5,24(sp)
ffffffffc02092d4:	e062                	sd	s8,0(sp)
ffffffffc02092d6:	8b32                	mv	s6,a2
ffffffffc02092d8:	89ae                	mv	s3,a1
ffffffffc02092da:	8bb6                	mv	s7,a3
ffffffffc02092dc:	7eb000ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc02092e0:	0ff00793          	li	a5,255
ffffffffc02092e4:	06a7ef63          	bltu	a5,a0,ffffffffc0209362 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc02092e8:	10400513          	li	a0,260
ffffffffc02092ec:	ca3f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02092f0:	892a                	mv	s2,a0
ffffffffc02092f2:	c535                	beqz	a0,ffffffffc020935e <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc02092f4:	0009b783          	ld	a5,0(s3)
ffffffffc02092f8:	0087aa83          	lw	s5,8(a5)
ffffffffc02092fc:	05505a63          	blez	s5,ffffffffc0209350 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc0209300:	4481                	li	s1,0
ffffffffc0209302:	00450c13          	addi	s8,a0,4
ffffffffc0209306:	a829                	j	ffffffffc0209320 <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc0209308:	00092783          	lw	a5,0(s2)
ffffffffc020930c:	c799                	beqz	a5,ffffffffc020931a <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020930e:	85e2                	mv	a1,s8
ffffffffc0209310:	855a                	mv	a0,s6
ffffffffc0209312:	7fd000ef          	jal	ra,ffffffffc020a30e <strcmp>
ffffffffc0209316:	842a                	mv	s0,a0
ffffffffc0209318:	cd15                	beqz	a0,ffffffffc0209354 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020931a:	2485                	addiw	s1,s1,1
ffffffffc020931c:	029a8a63          	beq	s5,s1,ffffffffc0209350 <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc0209320:	86ca                	mv	a3,s2
ffffffffc0209322:	8626                	mv	a2,s1
ffffffffc0209324:	85ce                	mv	a1,s3
ffffffffc0209326:	8552                	mv	a0,s4
ffffffffc0209328:	d97ff0ef          	jal	ra,ffffffffc02090be <sfs_dirent_read_nolock>
ffffffffc020932c:	842a                	mv	s0,a0
ffffffffc020932e:	dd69                	beqz	a0,ffffffffc0209308 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc0209330:	854a                	mv	a0,s2
ffffffffc0209332:	d0df80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209336:	60a6                	ld	ra,72(sp)
ffffffffc0209338:	8522                	mv	a0,s0
ffffffffc020933a:	6406                	ld	s0,64(sp)
ffffffffc020933c:	74e2                	ld	s1,56(sp)
ffffffffc020933e:	7942                	ld	s2,48(sp)
ffffffffc0209340:	79a2                	ld	s3,40(sp)
ffffffffc0209342:	7a02                	ld	s4,32(sp)
ffffffffc0209344:	6ae2                	ld	s5,24(sp)
ffffffffc0209346:	6b42                	ld	s6,16(sp)
ffffffffc0209348:	6ba2                	ld	s7,8(sp)
ffffffffc020934a:	6c02                	ld	s8,0(sp)
ffffffffc020934c:	6161                	addi	sp,sp,80
ffffffffc020934e:	8082                	ret
ffffffffc0209350:	5441                	li	s0,-16
ffffffffc0209352:	bff9                	j	ffffffffc0209330 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc0209354:	00092783          	lw	a5,0(s2)
ffffffffc0209358:	00fba023          	sw	a5,0(s7)
ffffffffc020935c:	bfd1                	j	ffffffffc0209330 <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020935e:	5471                	li	s0,-4
ffffffffc0209360:	bfd9                	j	ffffffffc0209336 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc0209362:	00005697          	auipc	a3,0x5
ffffffffc0209366:	a8e68693          	addi	a3,a3,-1394 # ffffffffc020ddf0 <dev_node_ops+0x7a0>
ffffffffc020936a:	00001617          	auipc	a2,0x1
ffffffffc020936e:	4e660613          	addi	a2,a2,1254 # ffffffffc020a850 <commands+0x210>
ffffffffc0209372:	1ba00593          	li	a1,442
ffffffffc0209376:	00005517          	auipc	a0,0x5
ffffffffc020937a:	89a50513          	addi	a0,a0,-1894 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020937e:	920f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209382 <sfs_truncfile>:
ffffffffc0209382:	7175                	addi	sp,sp,-144
ffffffffc0209384:	e506                	sd	ra,136(sp)
ffffffffc0209386:	e122                	sd	s0,128(sp)
ffffffffc0209388:	fca6                	sd	s1,120(sp)
ffffffffc020938a:	f8ca                	sd	s2,112(sp)
ffffffffc020938c:	f4ce                	sd	s3,104(sp)
ffffffffc020938e:	f0d2                	sd	s4,96(sp)
ffffffffc0209390:	ecd6                	sd	s5,88(sp)
ffffffffc0209392:	e8da                	sd	s6,80(sp)
ffffffffc0209394:	e4de                	sd	s7,72(sp)
ffffffffc0209396:	e0e2                	sd	s8,64(sp)
ffffffffc0209398:	fc66                	sd	s9,56(sp)
ffffffffc020939a:	f86a                	sd	s10,48(sp)
ffffffffc020939c:	f46e                	sd	s11,40(sp)
ffffffffc020939e:	080007b7          	lui	a5,0x8000
ffffffffc02093a2:	16b7e463          	bltu	a5,a1,ffffffffc020950a <sfs_truncfile+0x188>
ffffffffc02093a6:	06853c83          	ld	s9,104(a0)
ffffffffc02093aa:	89aa                	mv	s3,a0
ffffffffc02093ac:	160c8163          	beqz	s9,ffffffffc020950e <sfs_truncfile+0x18c>
ffffffffc02093b0:	0b0ca783          	lw	a5,176(s9) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc02093b4:	14079d63          	bnez	a5,ffffffffc020950e <sfs_truncfile+0x18c>
ffffffffc02093b8:	4d38                	lw	a4,88(a0)
ffffffffc02093ba:	6405                	lui	s0,0x1
ffffffffc02093bc:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02093c0:	16f71763          	bne	a4,a5,ffffffffc020952e <sfs_truncfile+0x1ac>
ffffffffc02093c4:	00053a83          	ld	s5,0(a0)
ffffffffc02093c8:	147d                	addi	s0,s0,-1
ffffffffc02093ca:	942e                	add	s0,s0,a1
ffffffffc02093cc:	000ae783          	lwu	a5,0(s5)
ffffffffc02093d0:	8031                	srli	s0,s0,0xc
ffffffffc02093d2:	8a2e                	mv	s4,a1
ffffffffc02093d4:	2401                	sext.w	s0,s0
ffffffffc02093d6:	02b79763          	bne	a5,a1,ffffffffc0209404 <sfs_truncfile+0x82>
ffffffffc02093da:	008aa783          	lw	a5,8(s5)
ffffffffc02093de:	4901                	li	s2,0
ffffffffc02093e0:	18879763          	bne	a5,s0,ffffffffc020956e <sfs_truncfile+0x1ec>
ffffffffc02093e4:	60aa                	ld	ra,136(sp)
ffffffffc02093e6:	640a                	ld	s0,128(sp)
ffffffffc02093e8:	74e6                	ld	s1,120(sp)
ffffffffc02093ea:	79a6                	ld	s3,104(sp)
ffffffffc02093ec:	7a06                	ld	s4,96(sp)
ffffffffc02093ee:	6ae6                	ld	s5,88(sp)
ffffffffc02093f0:	6b46                	ld	s6,80(sp)
ffffffffc02093f2:	6ba6                	ld	s7,72(sp)
ffffffffc02093f4:	6c06                	ld	s8,64(sp)
ffffffffc02093f6:	7ce2                	ld	s9,56(sp)
ffffffffc02093f8:	7d42                	ld	s10,48(sp)
ffffffffc02093fa:	7da2                	ld	s11,40(sp)
ffffffffc02093fc:	854a                	mv	a0,s2
ffffffffc02093fe:	7946                	ld	s2,112(sp)
ffffffffc0209400:	6149                	addi	sp,sp,144
ffffffffc0209402:	8082                	ret
ffffffffc0209404:	02050b13          	addi	s6,a0,32
ffffffffc0209408:	855a                	mv	a0,s6
ffffffffc020940a:	cb1fa0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020940e:	008aa483          	lw	s1,8(s5)
ffffffffc0209412:	0a84e663          	bltu	s1,s0,ffffffffc02094be <sfs_truncfile+0x13c>
ffffffffc0209416:	0c947163          	bgeu	s0,s1,ffffffffc02094d8 <sfs_truncfile+0x156>
ffffffffc020941a:	4dad                	li	s11,11
ffffffffc020941c:	4b85                	li	s7,1
ffffffffc020941e:	a09d                	j	ffffffffc0209484 <sfs_truncfile+0x102>
ffffffffc0209420:	ff37091b          	addiw	s2,a4,-13
ffffffffc0209424:	0009079b          	sext.w	a5,s2
ffffffffc0209428:	3ff00713          	li	a4,1023
ffffffffc020942c:	04f76563          	bltu	a4,a5,ffffffffc0209476 <sfs_truncfile+0xf4>
ffffffffc0209430:	03cd2c03          	lw	s8,60(s10)
ffffffffc0209434:	040c0163          	beqz	s8,ffffffffc0209476 <sfs_truncfile+0xf4>
ffffffffc0209438:	004ca783          	lw	a5,4(s9)
ffffffffc020943c:	18fc7963          	bgeu	s8,a5,ffffffffc02095ce <sfs_truncfile+0x24c>
ffffffffc0209440:	038cb503          	ld	a0,56(s9)
ffffffffc0209444:	85e2                	mv	a1,s8
ffffffffc0209446:	cddfe0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc020944a:	16051263          	bnez	a0,ffffffffc02095ae <sfs_truncfile+0x22c>
ffffffffc020944e:	02091793          	slli	a5,s2,0x20
ffffffffc0209452:	01e7d713          	srli	a4,a5,0x1e
ffffffffc0209456:	86e2                	mv	a3,s8
ffffffffc0209458:	4611                	li	a2,4
ffffffffc020945a:	082c                	addi	a1,sp,24
ffffffffc020945c:	8566                	mv	a0,s9
ffffffffc020945e:	e43a                	sd	a4,8(sp)
ffffffffc0209460:	ce02                	sw	zero,28(sp)
ffffffffc0209462:	782000ef          	jal	ra,ffffffffc0209be4 <sfs_rbuf>
ffffffffc0209466:	892a                	mv	s2,a0
ffffffffc0209468:	e141                	bnez	a0,ffffffffc02094e8 <sfs_truncfile+0x166>
ffffffffc020946a:	47e2                	lw	a5,24(sp)
ffffffffc020946c:	6722                	ld	a4,8(sp)
ffffffffc020946e:	e3c9                	bnez	a5,ffffffffc02094f0 <sfs_truncfile+0x16e>
ffffffffc0209470:	008d2603          	lw	a2,8(s10)
ffffffffc0209474:	367d                	addiw	a2,a2,-1
ffffffffc0209476:	00cd2423          	sw	a2,8(s10)
ffffffffc020947a:	0179b823          	sd	s7,16(s3)
ffffffffc020947e:	34fd                	addiw	s1,s1,-1
ffffffffc0209480:	04940a63          	beq	s0,s1,ffffffffc02094d4 <sfs_truncfile+0x152>
ffffffffc0209484:	0009bd03          	ld	s10,0(s3)
ffffffffc0209488:	008d2703          	lw	a4,8(s10)
ffffffffc020948c:	c369                	beqz	a4,ffffffffc020954e <sfs_truncfile+0x1cc>
ffffffffc020948e:	fff7079b          	addiw	a5,a4,-1
ffffffffc0209492:	0007861b          	sext.w	a2,a5
ffffffffc0209496:	f8cde5e3          	bltu	s11,a2,ffffffffc0209420 <sfs_truncfile+0x9e>
ffffffffc020949a:	02079713          	slli	a4,a5,0x20
ffffffffc020949e:	01e75793          	srli	a5,a4,0x1e
ffffffffc02094a2:	00fd0933          	add	s2,s10,a5
ffffffffc02094a6:	00c92583          	lw	a1,12(s2)
ffffffffc02094aa:	d5f1                	beqz	a1,ffffffffc0209476 <sfs_truncfile+0xf4>
ffffffffc02094ac:	8566                	mv	a0,s9
ffffffffc02094ae:	efeff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc02094b2:	00092623          	sw	zero,12(s2)
ffffffffc02094b6:	008d2603          	lw	a2,8(s10)
ffffffffc02094ba:	367d                	addiw	a2,a2,-1
ffffffffc02094bc:	bf6d                	j	ffffffffc0209476 <sfs_truncfile+0xf4>
ffffffffc02094be:	4681                	li	a3,0
ffffffffc02094c0:	8626                	mv	a2,s1
ffffffffc02094c2:	85ce                	mv	a1,s3
ffffffffc02094c4:	8566                	mv	a0,s9
ffffffffc02094c6:	9a1ff0ef          	jal	ra,ffffffffc0208e66 <sfs_bmap_load_nolock>
ffffffffc02094ca:	892a                	mv	s2,a0
ffffffffc02094cc:	ed11                	bnez	a0,ffffffffc02094e8 <sfs_truncfile+0x166>
ffffffffc02094ce:	2485                	addiw	s1,s1,1
ffffffffc02094d0:	fe9417e3          	bne	s0,s1,ffffffffc02094be <sfs_truncfile+0x13c>
ffffffffc02094d4:	008aa483          	lw	s1,8(s5)
ffffffffc02094d8:	0a941b63          	bne	s0,s1,ffffffffc020958e <sfs_truncfile+0x20c>
ffffffffc02094dc:	014aa023          	sw	s4,0(s5)
ffffffffc02094e0:	4785                	li	a5,1
ffffffffc02094e2:	00f9b823          	sd	a5,16(s3)
ffffffffc02094e6:	4901                	li	s2,0
ffffffffc02094e8:	855a                	mv	a0,s6
ffffffffc02094ea:	bcdfa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02094ee:	bddd                	j	ffffffffc02093e4 <sfs_truncfile+0x62>
ffffffffc02094f0:	86e2                	mv	a3,s8
ffffffffc02094f2:	4611                	li	a2,4
ffffffffc02094f4:	086c                	addi	a1,sp,28
ffffffffc02094f6:	8566                	mv	a0,s9
ffffffffc02094f8:	76c000ef          	jal	ra,ffffffffc0209c64 <sfs_wbuf>
ffffffffc02094fc:	892a                	mv	s2,a0
ffffffffc02094fe:	f56d                	bnez	a0,ffffffffc02094e8 <sfs_truncfile+0x166>
ffffffffc0209500:	45e2                	lw	a1,24(sp)
ffffffffc0209502:	8566                	mv	a0,s9
ffffffffc0209504:	ea8ff0ef          	jal	ra,ffffffffc0208bac <sfs_block_free>
ffffffffc0209508:	b7a5                	j	ffffffffc0209470 <sfs_truncfile+0xee>
ffffffffc020950a:	5975                	li	s2,-3
ffffffffc020950c:	bde1                	j	ffffffffc02093e4 <sfs_truncfile+0x62>
ffffffffc020950e:	00004697          	auipc	a3,0x4
ffffffffc0209512:	52268693          	addi	a3,a3,1314 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0209516:	00001617          	auipc	a2,0x1
ffffffffc020951a:	33a60613          	addi	a2,a2,826 # ffffffffc020a850 <commands+0x210>
ffffffffc020951e:	37f00593          	li	a1,895
ffffffffc0209522:	00004517          	auipc	a0,0x4
ffffffffc0209526:	6ee50513          	addi	a0,a0,1774 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020952a:	f75f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020952e:	00004697          	auipc	a3,0x4
ffffffffc0209532:	6aa68693          	addi	a3,a3,1706 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0209536:	00001617          	auipc	a2,0x1
ffffffffc020953a:	31a60613          	addi	a2,a2,794 # ffffffffc020a850 <commands+0x210>
ffffffffc020953e:	38000593          	li	a1,896
ffffffffc0209542:	00004517          	auipc	a0,0x4
ffffffffc0209546:	6ce50513          	addi	a0,a0,1742 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020954a:	f55f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020954e:	00005697          	auipc	a3,0x5
ffffffffc0209552:	8e268693          	addi	a3,a3,-1822 # ffffffffc020de30 <dev_node_ops+0x7e0>
ffffffffc0209556:	00001617          	auipc	a2,0x1
ffffffffc020955a:	2fa60613          	addi	a2,a2,762 # ffffffffc020a850 <commands+0x210>
ffffffffc020955e:	17b00593          	li	a1,379
ffffffffc0209562:	00004517          	auipc	a0,0x4
ffffffffc0209566:	6ae50513          	addi	a0,a0,1710 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020956a:	f35f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020956e:	00005697          	auipc	a3,0x5
ffffffffc0209572:	8aa68693          	addi	a3,a3,-1878 # ffffffffc020de18 <dev_node_ops+0x7c8>
ffffffffc0209576:	00001617          	auipc	a2,0x1
ffffffffc020957a:	2da60613          	addi	a2,a2,730 # ffffffffc020a850 <commands+0x210>
ffffffffc020957e:	38700593          	li	a1,903
ffffffffc0209582:	00004517          	auipc	a0,0x4
ffffffffc0209586:	68e50513          	addi	a0,a0,1678 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020958a:	f15f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020958e:	00005697          	auipc	a3,0x5
ffffffffc0209592:	8f268693          	addi	a3,a3,-1806 # ffffffffc020de80 <dev_node_ops+0x830>
ffffffffc0209596:	00001617          	auipc	a2,0x1
ffffffffc020959a:	2ba60613          	addi	a2,a2,698 # ffffffffc020a850 <commands+0x210>
ffffffffc020959e:	3a000593          	li	a1,928
ffffffffc02095a2:	00004517          	auipc	a0,0x4
ffffffffc02095a6:	66e50513          	addi	a0,a0,1646 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02095aa:	ef5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095ae:	00005697          	auipc	a3,0x5
ffffffffc02095b2:	89a68693          	addi	a3,a3,-1894 # ffffffffc020de48 <dev_node_ops+0x7f8>
ffffffffc02095b6:	00001617          	auipc	a2,0x1
ffffffffc02095ba:	29a60613          	addi	a2,a2,666 # ffffffffc020a850 <commands+0x210>
ffffffffc02095be:	12b00593          	li	a1,299
ffffffffc02095c2:	00004517          	auipc	a0,0x4
ffffffffc02095c6:	64e50513          	addi	a0,a0,1614 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02095ca:	ed5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02095ce:	8762                	mv	a4,s8
ffffffffc02095d0:	86be                	mv	a3,a5
ffffffffc02095d2:	00004617          	auipc	a2,0x4
ffffffffc02095d6:	68e60613          	addi	a2,a2,1678 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc02095da:	05300593          	li	a1,83
ffffffffc02095de:	00004517          	auipc	a0,0x4
ffffffffc02095e2:	63250513          	addi	a0,a0,1586 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02095e6:	eb9f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02095ea <sfs_load_inode>:
ffffffffc02095ea:	7139                	addi	sp,sp,-64
ffffffffc02095ec:	fc06                	sd	ra,56(sp)
ffffffffc02095ee:	f822                	sd	s0,48(sp)
ffffffffc02095f0:	f426                	sd	s1,40(sp)
ffffffffc02095f2:	f04a                	sd	s2,32(sp)
ffffffffc02095f4:	84b2                	mv	s1,a2
ffffffffc02095f6:	892a                	mv	s2,a0
ffffffffc02095f8:	ec4e                	sd	s3,24(sp)
ffffffffc02095fa:	e852                	sd	s4,16(sp)
ffffffffc02095fc:	89ae                	mv	s3,a1
ffffffffc02095fe:	e456                	sd	s5,8(sp)
ffffffffc0209600:	015000ef          	jal	ra,ffffffffc0209e14 <lock_sfs_fs>
ffffffffc0209604:	45a9                	li	a1,10
ffffffffc0209606:	8526                	mv	a0,s1
ffffffffc0209608:	0a893403          	ld	s0,168(s2)
ffffffffc020960c:	029000ef          	jal	ra,ffffffffc0209e34 <hash32>
ffffffffc0209610:	02051793          	slli	a5,a0,0x20
ffffffffc0209614:	01c7d713          	srli	a4,a5,0x1c
ffffffffc0209618:	9722                	add	a4,a4,s0
ffffffffc020961a:	843a                	mv	s0,a4
ffffffffc020961c:	a029                	j	ffffffffc0209626 <sfs_load_inode+0x3c>
ffffffffc020961e:	fc042783          	lw	a5,-64(s0)
ffffffffc0209622:	10978863          	beq	a5,s1,ffffffffc0209732 <sfs_load_inode+0x148>
ffffffffc0209626:	6400                	ld	s0,8(s0)
ffffffffc0209628:	fe871be3          	bne	a4,s0,ffffffffc020961e <sfs_load_inode+0x34>
ffffffffc020962c:	04000513          	li	a0,64
ffffffffc0209630:	95ff80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209634:	8aaa                	mv	s5,a0
ffffffffc0209636:	16050563          	beqz	a0,ffffffffc02097a0 <sfs_load_inode+0x1b6>
ffffffffc020963a:	00492683          	lw	a3,4(s2)
ffffffffc020963e:	18048363          	beqz	s1,ffffffffc02097c4 <sfs_load_inode+0x1da>
ffffffffc0209642:	18d4f163          	bgeu	s1,a3,ffffffffc02097c4 <sfs_load_inode+0x1da>
ffffffffc0209646:	03893503          	ld	a0,56(s2)
ffffffffc020964a:	85a6                	mv	a1,s1
ffffffffc020964c:	ad7fe0ef          	jal	ra,ffffffffc0208122 <bitmap_test>
ffffffffc0209650:	18051763          	bnez	a0,ffffffffc02097de <sfs_load_inode+0x1f4>
ffffffffc0209654:	4701                	li	a4,0
ffffffffc0209656:	86a6                	mv	a3,s1
ffffffffc0209658:	04000613          	li	a2,64
ffffffffc020965c:	85d6                	mv	a1,s5
ffffffffc020965e:	854a                	mv	a0,s2
ffffffffc0209660:	584000ef          	jal	ra,ffffffffc0209be4 <sfs_rbuf>
ffffffffc0209664:	842a                	mv	s0,a0
ffffffffc0209666:	0e051563          	bnez	a0,ffffffffc0209750 <sfs_load_inode+0x166>
ffffffffc020966a:	006ad783          	lhu	a5,6(s5)
ffffffffc020966e:	12078b63          	beqz	a5,ffffffffc02097a4 <sfs_load_inode+0x1ba>
ffffffffc0209672:	6405                	lui	s0,0x1
ffffffffc0209674:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209678:	a64fd0ef          	jal	ra,ffffffffc02068dc <__alloc_inode>
ffffffffc020967c:	8a2a                	mv	s4,a0
ffffffffc020967e:	c961                	beqz	a0,ffffffffc020974e <sfs_load_inode+0x164>
ffffffffc0209680:	004ad683          	lhu	a3,4(s5)
ffffffffc0209684:	4785                	li	a5,1
ffffffffc0209686:	0cf69c63          	bne	a3,a5,ffffffffc020975e <sfs_load_inode+0x174>
ffffffffc020968a:	864a                	mv	a2,s2
ffffffffc020968c:	00005597          	auipc	a1,0x5
ffffffffc0209690:	90458593          	addi	a1,a1,-1788 # ffffffffc020df90 <sfs_node_fileops>
ffffffffc0209694:	a64fd0ef          	jal	ra,ffffffffc02068f8 <inode_init>
ffffffffc0209698:	058a2783          	lw	a5,88(s4)
ffffffffc020969c:	23540413          	addi	s0,s0,565
ffffffffc02096a0:	0e879063          	bne	a5,s0,ffffffffc0209780 <sfs_load_inode+0x196>
ffffffffc02096a4:	4785                	li	a5,1
ffffffffc02096a6:	00fa2c23          	sw	a5,24(s4)
ffffffffc02096aa:	015a3023          	sd	s5,0(s4)
ffffffffc02096ae:	009a2423          	sw	s1,8(s4)
ffffffffc02096b2:	000a3823          	sd	zero,16(s4)
ffffffffc02096b6:	4585                	li	a1,1
ffffffffc02096b8:	020a0513          	addi	a0,s4,32
ffffffffc02096bc:	9f5fa0ef          	jal	ra,ffffffffc02040b0 <sem_init>
ffffffffc02096c0:	058a2703          	lw	a4,88(s4)
ffffffffc02096c4:	6785                	lui	a5,0x1
ffffffffc02096c6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02096ca:	14f71663          	bne	a4,a5,ffffffffc0209816 <sfs_load_inode+0x22c>
ffffffffc02096ce:	0a093703          	ld	a4,160(s2)
ffffffffc02096d2:	038a0793          	addi	a5,s4,56
ffffffffc02096d6:	008a2503          	lw	a0,8(s4)
ffffffffc02096da:	e31c                	sd	a5,0(a4)
ffffffffc02096dc:	0af93023          	sd	a5,160(s2)
ffffffffc02096e0:	09890793          	addi	a5,s2,152
ffffffffc02096e4:	0a893403          	ld	s0,168(s2)
ffffffffc02096e8:	45a9                	li	a1,10
ffffffffc02096ea:	04ea3023          	sd	a4,64(s4)
ffffffffc02096ee:	02fa3c23          	sd	a5,56(s4)
ffffffffc02096f2:	742000ef          	jal	ra,ffffffffc0209e34 <hash32>
ffffffffc02096f6:	02051713          	slli	a4,a0,0x20
ffffffffc02096fa:	01c75793          	srli	a5,a4,0x1c
ffffffffc02096fe:	97a2                	add	a5,a5,s0
ffffffffc0209700:	6798                	ld	a4,8(a5)
ffffffffc0209702:	048a0693          	addi	a3,s4,72
ffffffffc0209706:	e314                	sd	a3,0(a4)
ffffffffc0209708:	e794                	sd	a3,8(a5)
ffffffffc020970a:	04ea3823          	sd	a4,80(s4)
ffffffffc020970e:	04fa3423          	sd	a5,72(s4)
ffffffffc0209712:	854a                	mv	a0,s2
ffffffffc0209714:	710000ef          	jal	ra,ffffffffc0209e24 <unlock_sfs_fs>
ffffffffc0209718:	4401                	li	s0,0
ffffffffc020971a:	0149b023          	sd	s4,0(s3)
ffffffffc020971e:	70e2                	ld	ra,56(sp)
ffffffffc0209720:	8522                	mv	a0,s0
ffffffffc0209722:	7442                	ld	s0,48(sp)
ffffffffc0209724:	74a2                	ld	s1,40(sp)
ffffffffc0209726:	7902                	ld	s2,32(sp)
ffffffffc0209728:	69e2                	ld	s3,24(sp)
ffffffffc020972a:	6a42                	ld	s4,16(sp)
ffffffffc020972c:	6aa2                	ld	s5,8(sp)
ffffffffc020972e:	6121                	addi	sp,sp,64
ffffffffc0209730:	8082                	ret
ffffffffc0209732:	fb840a13          	addi	s4,s0,-72
ffffffffc0209736:	8552                	mv	a0,s4
ffffffffc0209738:	a22fd0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc020973c:	4785                	li	a5,1
ffffffffc020973e:	fcf51ae3          	bne	a0,a5,ffffffffc0209712 <sfs_load_inode+0x128>
ffffffffc0209742:	fd042783          	lw	a5,-48(s0)
ffffffffc0209746:	2785                	addiw	a5,a5,1
ffffffffc0209748:	fcf42823          	sw	a5,-48(s0)
ffffffffc020974c:	b7d9                	j	ffffffffc0209712 <sfs_load_inode+0x128>
ffffffffc020974e:	5471                	li	s0,-4
ffffffffc0209750:	8556                	mv	a0,s5
ffffffffc0209752:	8edf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209756:	854a                	mv	a0,s2
ffffffffc0209758:	6cc000ef          	jal	ra,ffffffffc0209e24 <unlock_sfs_fs>
ffffffffc020975c:	b7c9                	j	ffffffffc020971e <sfs_load_inode+0x134>
ffffffffc020975e:	4789                	li	a5,2
ffffffffc0209760:	08f69f63          	bne	a3,a5,ffffffffc02097fe <sfs_load_inode+0x214>
ffffffffc0209764:	864a                	mv	a2,s2
ffffffffc0209766:	00004597          	auipc	a1,0x4
ffffffffc020976a:	7aa58593          	addi	a1,a1,1962 # ffffffffc020df10 <sfs_node_dirops>
ffffffffc020976e:	98afd0ef          	jal	ra,ffffffffc02068f8 <inode_init>
ffffffffc0209772:	058a2703          	lw	a4,88(s4)
ffffffffc0209776:	6785                	lui	a5,0x1
ffffffffc0209778:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020977c:	f2f704e3          	beq	a4,a5,ffffffffc02096a4 <sfs_load_inode+0xba>
ffffffffc0209780:	00004697          	auipc	a3,0x4
ffffffffc0209784:	45868693          	addi	a3,a3,1112 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0209788:	00001617          	auipc	a2,0x1
ffffffffc020978c:	0c860613          	addi	a2,a2,200 # ffffffffc020a850 <commands+0x210>
ffffffffc0209790:	07700593          	li	a1,119
ffffffffc0209794:	00004517          	auipc	a0,0x4
ffffffffc0209798:	47c50513          	addi	a0,a0,1148 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020979c:	d03f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097a0:	5471                	li	s0,-4
ffffffffc02097a2:	bf55                	j	ffffffffc0209756 <sfs_load_inode+0x16c>
ffffffffc02097a4:	00004697          	auipc	a3,0x4
ffffffffc02097a8:	6f468693          	addi	a3,a3,1780 # ffffffffc020de98 <dev_node_ops+0x848>
ffffffffc02097ac:	00001617          	auipc	a2,0x1
ffffffffc02097b0:	0a460613          	addi	a2,a2,164 # ffffffffc020a850 <commands+0x210>
ffffffffc02097b4:	0ad00593          	li	a1,173
ffffffffc02097b8:	00004517          	auipc	a0,0x4
ffffffffc02097bc:	45850513          	addi	a0,a0,1112 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02097c0:	cdff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097c4:	8726                	mv	a4,s1
ffffffffc02097c6:	00004617          	auipc	a2,0x4
ffffffffc02097ca:	49a60613          	addi	a2,a2,1178 # ffffffffc020dc60 <dev_node_ops+0x610>
ffffffffc02097ce:	05300593          	li	a1,83
ffffffffc02097d2:	00004517          	auipc	a0,0x4
ffffffffc02097d6:	43e50513          	addi	a0,a0,1086 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02097da:	cc5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097de:	00004697          	auipc	a3,0x4
ffffffffc02097e2:	4ba68693          	addi	a3,a3,1210 # ffffffffc020dc98 <dev_node_ops+0x648>
ffffffffc02097e6:	00001617          	auipc	a2,0x1
ffffffffc02097ea:	06a60613          	addi	a2,a2,106 # ffffffffc020a850 <commands+0x210>
ffffffffc02097ee:	0a800593          	li	a1,168
ffffffffc02097f2:	00004517          	auipc	a0,0x4
ffffffffc02097f6:	41e50513          	addi	a0,a0,1054 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02097fa:	ca5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02097fe:	00004617          	auipc	a2,0x4
ffffffffc0209802:	42a60613          	addi	a2,a2,1066 # ffffffffc020dc28 <dev_node_ops+0x5d8>
ffffffffc0209806:	02e00593          	li	a1,46
ffffffffc020980a:	00004517          	auipc	a0,0x4
ffffffffc020980e:	40650513          	addi	a0,a0,1030 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209812:	c8df60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209816:	00004697          	auipc	a3,0x4
ffffffffc020981a:	3c268693          	addi	a3,a3,962 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc020981e:	00001617          	auipc	a2,0x1
ffffffffc0209822:	03260613          	addi	a2,a2,50 # ffffffffc020a850 <commands+0x210>
ffffffffc0209826:	0b100593          	li	a1,177
ffffffffc020982a:	00004517          	auipc	a0,0x4
ffffffffc020982e:	3e650513          	addi	a0,a0,998 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209832:	c6df60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209836 <sfs_lookup>:
ffffffffc0209836:	7139                	addi	sp,sp,-64
ffffffffc0209838:	ec4e                	sd	s3,24(sp)
ffffffffc020983a:	06853983          	ld	s3,104(a0)
ffffffffc020983e:	fc06                	sd	ra,56(sp)
ffffffffc0209840:	f822                	sd	s0,48(sp)
ffffffffc0209842:	f426                	sd	s1,40(sp)
ffffffffc0209844:	f04a                	sd	s2,32(sp)
ffffffffc0209846:	e852                	sd	s4,16(sp)
ffffffffc0209848:	0a098c63          	beqz	s3,ffffffffc0209900 <sfs_lookup+0xca>
ffffffffc020984c:	0b09a783          	lw	a5,176(s3)
ffffffffc0209850:	ebc5                	bnez	a5,ffffffffc0209900 <sfs_lookup+0xca>
ffffffffc0209852:	0005c783          	lbu	a5,0(a1)
ffffffffc0209856:	84ae                	mv	s1,a1
ffffffffc0209858:	c7c1                	beqz	a5,ffffffffc02098e0 <sfs_lookup+0xaa>
ffffffffc020985a:	02f00713          	li	a4,47
ffffffffc020985e:	08e78163          	beq	a5,a4,ffffffffc02098e0 <sfs_lookup+0xaa>
ffffffffc0209862:	842a                	mv	s0,a0
ffffffffc0209864:	8a32                	mv	s4,a2
ffffffffc0209866:	8f4fd0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc020986a:	4c38                	lw	a4,88(s0)
ffffffffc020986c:	6785                	lui	a5,0x1
ffffffffc020986e:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209872:	0af71763          	bne	a4,a5,ffffffffc0209920 <sfs_lookup+0xea>
ffffffffc0209876:	6018                	ld	a4,0(s0)
ffffffffc0209878:	4789                	li	a5,2
ffffffffc020987a:	00475703          	lhu	a4,4(a4)
ffffffffc020987e:	04f71c63          	bne	a4,a5,ffffffffc02098d6 <sfs_lookup+0xa0>
ffffffffc0209882:	02040913          	addi	s2,s0,32
ffffffffc0209886:	854a                	mv	a0,s2
ffffffffc0209888:	833fa0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc020988c:	8626                	mv	a2,s1
ffffffffc020988e:	0054                	addi	a3,sp,4
ffffffffc0209890:	85a2                	mv	a1,s0
ffffffffc0209892:	854e                	mv	a0,s3
ffffffffc0209894:	a29ff0ef          	jal	ra,ffffffffc02092bc <sfs_dirent_search_nolock.constprop.0>
ffffffffc0209898:	84aa                	mv	s1,a0
ffffffffc020989a:	854a                	mv	a0,s2
ffffffffc020989c:	81bfa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02098a0:	cc89                	beqz	s1,ffffffffc02098ba <sfs_lookup+0x84>
ffffffffc02098a2:	8522                	mv	a0,s0
ffffffffc02098a4:	984fd0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02098a8:	70e2                	ld	ra,56(sp)
ffffffffc02098aa:	7442                	ld	s0,48(sp)
ffffffffc02098ac:	7902                	ld	s2,32(sp)
ffffffffc02098ae:	69e2                	ld	s3,24(sp)
ffffffffc02098b0:	6a42                	ld	s4,16(sp)
ffffffffc02098b2:	8526                	mv	a0,s1
ffffffffc02098b4:	74a2                	ld	s1,40(sp)
ffffffffc02098b6:	6121                	addi	sp,sp,64
ffffffffc02098b8:	8082                	ret
ffffffffc02098ba:	4612                	lw	a2,4(sp)
ffffffffc02098bc:	002c                	addi	a1,sp,8
ffffffffc02098be:	854e                	mv	a0,s3
ffffffffc02098c0:	d2bff0ef          	jal	ra,ffffffffc02095ea <sfs_load_inode>
ffffffffc02098c4:	84aa                	mv	s1,a0
ffffffffc02098c6:	8522                	mv	a0,s0
ffffffffc02098c8:	960fd0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02098cc:	fcf1                	bnez	s1,ffffffffc02098a8 <sfs_lookup+0x72>
ffffffffc02098ce:	67a2                	ld	a5,8(sp)
ffffffffc02098d0:	00fa3023          	sd	a5,0(s4)
ffffffffc02098d4:	bfd1                	j	ffffffffc02098a8 <sfs_lookup+0x72>
ffffffffc02098d6:	8522                	mv	a0,s0
ffffffffc02098d8:	950fd0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02098dc:	54b9                	li	s1,-18
ffffffffc02098de:	b7e9                	j	ffffffffc02098a8 <sfs_lookup+0x72>
ffffffffc02098e0:	00004697          	auipc	a3,0x4
ffffffffc02098e4:	5d068693          	addi	a3,a3,1488 # ffffffffc020deb0 <dev_node_ops+0x860>
ffffffffc02098e8:	00001617          	auipc	a2,0x1
ffffffffc02098ec:	f6860613          	addi	a2,a2,-152 # ffffffffc020a850 <commands+0x210>
ffffffffc02098f0:	3b100593          	li	a1,945
ffffffffc02098f4:	00004517          	auipc	a0,0x4
ffffffffc02098f8:	31c50513          	addi	a0,a0,796 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc02098fc:	ba3f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209900:	00004697          	auipc	a3,0x4
ffffffffc0209904:	13068693          	addi	a3,a3,304 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0209908:	00001617          	auipc	a2,0x1
ffffffffc020990c:	f4860613          	addi	a2,a2,-184 # ffffffffc020a850 <commands+0x210>
ffffffffc0209910:	3b000593          	li	a1,944
ffffffffc0209914:	00004517          	auipc	a0,0x4
ffffffffc0209918:	2fc50513          	addi	a0,a0,764 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020991c:	b83f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209920:	00004697          	auipc	a3,0x4
ffffffffc0209924:	2b868693          	addi	a3,a3,696 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0209928:	00001617          	auipc	a2,0x1
ffffffffc020992c:	f2860613          	addi	a2,a2,-216 # ffffffffc020a850 <commands+0x210>
ffffffffc0209930:	3b300593          	li	a1,947
ffffffffc0209934:	00004517          	auipc	a0,0x4
ffffffffc0209938:	2dc50513          	addi	a0,a0,732 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc020993c:	b63f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209940 <sfs_namefile>:
ffffffffc0209940:	6d98                	ld	a4,24(a1)
ffffffffc0209942:	7175                	addi	sp,sp,-144
ffffffffc0209944:	e506                	sd	ra,136(sp)
ffffffffc0209946:	e122                	sd	s0,128(sp)
ffffffffc0209948:	fca6                	sd	s1,120(sp)
ffffffffc020994a:	f8ca                	sd	s2,112(sp)
ffffffffc020994c:	f4ce                	sd	s3,104(sp)
ffffffffc020994e:	f0d2                	sd	s4,96(sp)
ffffffffc0209950:	ecd6                	sd	s5,88(sp)
ffffffffc0209952:	e8da                	sd	s6,80(sp)
ffffffffc0209954:	e4de                	sd	s7,72(sp)
ffffffffc0209956:	e0e2                	sd	s8,64(sp)
ffffffffc0209958:	fc66                	sd	s9,56(sp)
ffffffffc020995a:	f86a                	sd	s10,48(sp)
ffffffffc020995c:	f46e                	sd	s11,40(sp)
ffffffffc020995e:	e42e                	sd	a1,8(sp)
ffffffffc0209960:	4789                	li	a5,2
ffffffffc0209962:	1ae7f363          	bgeu	a5,a4,ffffffffc0209b08 <sfs_namefile+0x1c8>
ffffffffc0209966:	89aa                	mv	s3,a0
ffffffffc0209968:	10400513          	li	a0,260
ffffffffc020996c:	e22f80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209970:	842a                	mv	s0,a0
ffffffffc0209972:	18050b63          	beqz	a0,ffffffffc0209b08 <sfs_namefile+0x1c8>
ffffffffc0209976:	0689b483          	ld	s1,104(s3)
ffffffffc020997a:	1e048963          	beqz	s1,ffffffffc0209b6c <sfs_namefile+0x22c>
ffffffffc020997e:	0b04a783          	lw	a5,176(s1)
ffffffffc0209982:	1e079563          	bnez	a5,ffffffffc0209b6c <sfs_namefile+0x22c>
ffffffffc0209986:	0589ac83          	lw	s9,88(s3)
ffffffffc020998a:	6785                	lui	a5,0x1
ffffffffc020998c:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209990:	1afc9e63          	bne	s9,a5,ffffffffc0209b4c <sfs_namefile+0x20c>
ffffffffc0209994:	6722                	ld	a4,8(sp)
ffffffffc0209996:	854e                	mv	a0,s3
ffffffffc0209998:	8ace                	mv	s5,s3
ffffffffc020999a:	6f1c                	ld	a5,24(a4)
ffffffffc020999c:	00073b03          	ld	s6,0(a4)
ffffffffc02099a0:	02098a13          	addi	s4,s3,32
ffffffffc02099a4:	ffe78b93          	addi	s7,a5,-2
ffffffffc02099a8:	9b3e                	add	s6,s6,a5
ffffffffc02099aa:	00004d17          	auipc	s10,0x4
ffffffffc02099ae:	526d0d13          	addi	s10,s10,1318 # ffffffffc020ded0 <dev_node_ops+0x880>
ffffffffc02099b2:	fa9fc0ef          	jal	ra,ffffffffc020695a <inode_ref_inc>
ffffffffc02099b6:	00440c13          	addi	s8,s0,4
ffffffffc02099ba:	e066                	sd	s9,0(sp)
ffffffffc02099bc:	8552                	mv	a0,s4
ffffffffc02099be:	efcfa0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc02099c2:	0854                	addi	a3,sp,20
ffffffffc02099c4:	866a                	mv	a2,s10
ffffffffc02099c6:	85d6                	mv	a1,s5
ffffffffc02099c8:	8526                	mv	a0,s1
ffffffffc02099ca:	8f3ff0ef          	jal	ra,ffffffffc02092bc <sfs_dirent_search_nolock.constprop.0>
ffffffffc02099ce:	8daa                	mv	s11,a0
ffffffffc02099d0:	8552                	mv	a0,s4
ffffffffc02099d2:	ee4fa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc02099d6:	020d8863          	beqz	s11,ffffffffc0209a06 <sfs_namefile+0xc6>
ffffffffc02099da:	854e                	mv	a0,s3
ffffffffc02099dc:	84cfd0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc02099e0:	8522                	mv	a0,s0
ffffffffc02099e2:	e5cf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02099e6:	60aa                	ld	ra,136(sp)
ffffffffc02099e8:	640a                	ld	s0,128(sp)
ffffffffc02099ea:	74e6                	ld	s1,120(sp)
ffffffffc02099ec:	7946                	ld	s2,112(sp)
ffffffffc02099ee:	79a6                	ld	s3,104(sp)
ffffffffc02099f0:	7a06                	ld	s4,96(sp)
ffffffffc02099f2:	6ae6                	ld	s5,88(sp)
ffffffffc02099f4:	6b46                	ld	s6,80(sp)
ffffffffc02099f6:	6ba6                	ld	s7,72(sp)
ffffffffc02099f8:	6c06                	ld	s8,64(sp)
ffffffffc02099fa:	7ce2                	ld	s9,56(sp)
ffffffffc02099fc:	7d42                	ld	s10,48(sp)
ffffffffc02099fe:	856e                	mv	a0,s11
ffffffffc0209a00:	7da2                	ld	s11,40(sp)
ffffffffc0209a02:	6149                	addi	sp,sp,144
ffffffffc0209a04:	8082                	ret
ffffffffc0209a06:	4652                	lw	a2,20(sp)
ffffffffc0209a08:	082c                	addi	a1,sp,24
ffffffffc0209a0a:	8526                	mv	a0,s1
ffffffffc0209a0c:	bdfff0ef          	jal	ra,ffffffffc02095ea <sfs_load_inode>
ffffffffc0209a10:	8daa                	mv	s11,a0
ffffffffc0209a12:	f561                	bnez	a0,ffffffffc02099da <sfs_namefile+0x9a>
ffffffffc0209a14:	854e                	mv	a0,s3
ffffffffc0209a16:	008aa903          	lw	s2,8(s5)
ffffffffc0209a1a:	80efd0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0209a1e:	6ce2                	ld	s9,24(sp)
ffffffffc0209a20:	0b3c8463          	beq	s9,s3,ffffffffc0209ac8 <sfs_namefile+0x188>
ffffffffc0209a24:	100c8463          	beqz	s9,ffffffffc0209b2c <sfs_namefile+0x1ec>
ffffffffc0209a28:	058ca703          	lw	a4,88(s9)
ffffffffc0209a2c:	6782                	ld	a5,0(sp)
ffffffffc0209a2e:	0ef71f63          	bne	a4,a5,ffffffffc0209b2c <sfs_namefile+0x1ec>
ffffffffc0209a32:	008ca703          	lw	a4,8(s9)
ffffffffc0209a36:	8ae6                	mv	s5,s9
ffffffffc0209a38:	0d270a63          	beq	a4,s2,ffffffffc0209b0c <sfs_namefile+0x1cc>
ffffffffc0209a3c:	000cb703          	ld	a4,0(s9)
ffffffffc0209a40:	4789                	li	a5,2
ffffffffc0209a42:	00475703          	lhu	a4,4(a4)
ffffffffc0209a46:	0cf71363          	bne	a4,a5,ffffffffc0209b0c <sfs_namefile+0x1cc>
ffffffffc0209a4a:	020c8a13          	addi	s4,s9,32
ffffffffc0209a4e:	8552                	mv	a0,s4
ffffffffc0209a50:	e6afa0ef          	jal	ra,ffffffffc02040ba <down>
ffffffffc0209a54:	000cb703          	ld	a4,0(s9)
ffffffffc0209a58:	00872983          	lw	s3,8(a4)
ffffffffc0209a5c:	01304963          	bgtz	s3,ffffffffc0209a6e <sfs_namefile+0x12e>
ffffffffc0209a60:	a899                	j	ffffffffc0209ab6 <sfs_namefile+0x176>
ffffffffc0209a62:	4018                	lw	a4,0(s0)
ffffffffc0209a64:	01270e63          	beq	a4,s2,ffffffffc0209a80 <sfs_namefile+0x140>
ffffffffc0209a68:	2d85                	addiw	s11,s11,1
ffffffffc0209a6a:	05b98663          	beq	s3,s11,ffffffffc0209ab6 <sfs_namefile+0x176>
ffffffffc0209a6e:	86a2                	mv	a3,s0
ffffffffc0209a70:	866e                	mv	a2,s11
ffffffffc0209a72:	85e6                	mv	a1,s9
ffffffffc0209a74:	8526                	mv	a0,s1
ffffffffc0209a76:	e48ff0ef          	jal	ra,ffffffffc02090be <sfs_dirent_read_nolock>
ffffffffc0209a7a:	872a                	mv	a4,a0
ffffffffc0209a7c:	d17d                	beqz	a0,ffffffffc0209a62 <sfs_namefile+0x122>
ffffffffc0209a7e:	a82d                	j	ffffffffc0209ab8 <sfs_namefile+0x178>
ffffffffc0209a80:	8552                	mv	a0,s4
ffffffffc0209a82:	e34fa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0209a86:	8562                	mv	a0,s8
ffffffffc0209a88:	03f000ef          	jal	ra,ffffffffc020a2c6 <strlen>
ffffffffc0209a8c:	00150793          	addi	a5,a0,1
ffffffffc0209a90:	862a                	mv	a2,a0
ffffffffc0209a92:	06fbe863          	bltu	s7,a5,ffffffffc0209b02 <sfs_namefile+0x1c2>
ffffffffc0209a96:	fff64913          	not	s2,a2
ffffffffc0209a9a:	995a                	add	s2,s2,s6
ffffffffc0209a9c:	85e2                	mv	a1,s8
ffffffffc0209a9e:	854a                	mv	a0,s2
ffffffffc0209aa0:	40fb8bb3          	sub	s7,s7,a5
ffffffffc0209aa4:	117000ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0209aa8:	02f00793          	li	a5,47
ffffffffc0209aac:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc0209ab0:	89e6                	mv	s3,s9
ffffffffc0209ab2:	8b4a                	mv	s6,s2
ffffffffc0209ab4:	b721                	j	ffffffffc02099bc <sfs_namefile+0x7c>
ffffffffc0209ab6:	5741                	li	a4,-16
ffffffffc0209ab8:	8552                	mv	a0,s4
ffffffffc0209aba:	e03a                	sd	a4,0(sp)
ffffffffc0209abc:	dfafa0ef          	jal	ra,ffffffffc02040b6 <up>
ffffffffc0209ac0:	6702                	ld	a4,0(sp)
ffffffffc0209ac2:	89e6                	mv	s3,s9
ffffffffc0209ac4:	8dba                	mv	s11,a4
ffffffffc0209ac6:	bf11                	j	ffffffffc02099da <sfs_namefile+0x9a>
ffffffffc0209ac8:	854e                	mv	a0,s3
ffffffffc0209aca:	f5ffc0ef          	jal	ra,ffffffffc0206a28 <inode_ref_dec>
ffffffffc0209ace:	64a2                	ld	s1,8(sp)
ffffffffc0209ad0:	85da                	mv	a1,s6
ffffffffc0209ad2:	6c98                	ld	a4,24(s1)
ffffffffc0209ad4:	6088                	ld	a0,0(s1)
ffffffffc0209ad6:	1779                	addi	a4,a4,-2
ffffffffc0209ad8:	41770bb3          	sub	s7,a4,s7
ffffffffc0209adc:	865e                	mv	a2,s7
ffffffffc0209ade:	0505                	addi	a0,a0,1
ffffffffc0209ae0:	09b000ef          	jal	ra,ffffffffc020a37a <memmove>
ffffffffc0209ae4:	02f00713          	li	a4,47
ffffffffc0209ae8:	fee50fa3          	sb	a4,-1(a0)
ffffffffc0209aec:	955e                	add	a0,a0,s7
ffffffffc0209aee:	00050023          	sb	zero,0(a0)
ffffffffc0209af2:	85de                	mv	a1,s7
ffffffffc0209af4:	8526                	mv	a0,s1
ffffffffc0209af6:	cb8fb0ef          	jal	ra,ffffffffc0204fae <iobuf_skip>
ffffffffc0209afa:	8522                	mv	a0,s0
ffffffffc0209afc:	d42f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209b00:	b5dd                	j	ffffffffc02099e6 <sfs_namefile+0xa6>
ffffffffc0209b02:	89e6                	mv	s3,s9
ffffffffc0209b04:	5df1                	li	s11,-4
ffffffffc0209b06:	bdd1                	j	ffffffffc02099da <sfs_namefile+0x9a>
ffffffffc0209b08:	5df1                	li	s11,-4
ffffffffc0209b0a:	bdf1                	j	ffffffffc02099e6 <sfs_namefile+0xa6>
ffffffffc0209b0c:	00004697          	auipc	a3,0x4
ffffffffc0209b10:	3cc68693          	addi	a3,a3,972 # ffffffffc020ded8 <dev_node_ops+0x888>
ffffffffc0209b14:	00001617          	auipc	a2,0x1
ffffffffc0209b18:	d3c60613          	addi	a2,a2,-708 # ffffffffc020a850 <commands+0x210>
ffffffffc0209b1c:	2cf00593          	li	a1,719
ffffffffc0209b20:	00004517          	auipc	a0,0x4
ffffffffc0209b24:	0f050513          	addi	a0,a0,240 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209b28:	977f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b2c:	00004697          	auipc	a3,0x4
ffffffffc0209b30:	0ac68693          	addi	a3,a3,172 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0209b34:	00001617          	auipc	a2,0x1
ffffffffc0209b38:	d1c60613          	addi	a2,a2,-740 # ffffffffc020a850 <commands+0x210>
ffffffffc0209b3c:	2ce00593          	li	a1,718
ffffffffc0209b40:	00004517          	auipc	a0,0x4
ffffffffc0209b44:	0d050513          	addi	a0,a0,208 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209b48:	957f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b4c:	00004697          	auipc	a3,0x4
ffffffffc0209b50:	08c68693          	addi	a3,a3,140 # ffffffffc020dbd8 <dev_node_ops+0x588>
ffffffffc0209b54:	00001617          	auipc	a2,0x1
ffffffffc0209b58:	cfc60613          	addi	a2,a2,-772 # ffffffffc020a850 <commands+0x210>
ffffffffc0209b5c:	2bb00593          	li	a1,699
ffffffffc0209b60:	00004517          	auipc	a0,0x4
ffffffffc0209b64:	0b050513          	addi	a0,a0,176 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209b68:	937f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b6c:	00004697          	auipc	a3,0x4
ffffffffc0209b70:	ec468693          	addi	a3,a3,-316 # ffffffffc020da30 <dev_node_ops+0x3e0>
ffffffffc0209b74:	00001617          	auipc	a2,0x1
ffffffffc0209b78:	cdc60613          	addi	a2,a2,-804 # ffffffffc020a850 <commands+0x210>
ffffffffc0209b7c:	2ba00593          	li	a1,698
ffffffffc0209b80:	00004517          	auipc	a0,0x4
ffffffffc0209b84:	09050513          	addi	a0,a0,144 # ffffffffc020dc10 <dev_node_ops+0x5c0>
ffffffffc0209b88:	917f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209b8c <sfs_rwblock_nolock>:
ffffffffc0209b8c:	7139                	addi	sp,sp,-64
ffffffffc0209b8e:	f822                	sd	s0,48(sp)
ffffffffc0209b90:	f426                	sd	s1,40(sp)
ffffffffc0209b92:	fc06                	sd	ra,56(sp)
ffffffffc0209b94:	842a                	mv	s0,a0
ffffffffc0209b96:	84b6                	mv	s1,a3
ffffffffc0209b98:	e211                	bnez	a2,ffffffffc0209b9c <sfs_rwblock_nolock+0x10>
ffffffffc0209b9a:	e715                	bnez	a4,ffffffffc0209bc6 <sfs_rwblock_nolock+0x3a>
ffffffffc0209b9c:	405c                	lw	a5,4(s0)
ffffffffc0209b9e:	02f67463          	bgeu	a2,a5,ffffffffc0209bc6 <sfs_rwblock_nolock+0x3a>
ffffffffc0209ba2:	00c6169b          	slliw	a3,a2,0xc
ffffffffc0209ba6:	1682                	slli	a3,a3,0x20
ffffffffc0209ba8:	6605                	lui	a2,0x1
ffffffffc0209baa:	9281                	srli	a3,a3,0x20
ffffffffc0209bac:	850a                	mv	a0,sp
ffffffffc0209bae:	b8afb0ef          	jal	ra,ffffffffc0204f38 <iobuf_init>
ffffffffc0209bb2:	85aa                	mv	a1,a0
ffffffffc0209bb4:	7808                	ld	a0,48(s0)
ffffffffc0209bb6:	8626                	mv	a2,s1
ffffffffc0209bb8:	7118                	ld	a4,32(a0)
ffffffffc0209bba:	9702                	jalr	a4
ffffffffc0209bbc:	70e2                	ld	ra,56(sp)
ffffffffc0209bbe:	7442                	ld	s0,48(sp)
ffffffffc0209bc0:	74a2                	ld	s1,40(sp)
ffffffffc0209bc2:	6121                	addi	sp,sp,64
ffffffffc0209bc4:	8082                	ret
ffffffffc0209bc6:	00004697          	auipc	a3,0x4
ffffffffc0209bca:	44a68693          	addi	a3,a3,1098 # ffffffffc020e010 <sfs_node_fileops+0x80>
ffffffffc0209bce:	00001617          	auipc	a2,0x1
ffffffffc0209bd2:	c8260613          	addi	a2,a2,-894 # ffffffffc020a850 <commands+0x210>
ffffffffc0209bd6:	45d5                	li	a1,21
ffffffffc0209bd8:	00004517          	auipc	a0,0x4
ffffffffc0209bdc:	47050513          	addi	a0,a0,1136 # ffffffffc020e048 <sfs_node_fileops+0xb8>
ffffffffc0209be0:	8bff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209be4 <sfs_rbuf>:
ffffffffc0209be4:	7179                	addi	sp,sp,-48
ffffffffc0209be6:	f406                	sd	ra,40(sp)
ffffffffc0209be8:	f022                	sd	s0,32(sp)
ffffffffc0209bea:	ec26                	sd	s1,24(sp)
ffffffffc0209bec:	e84a                	sd	s2,16(sp)
ffffffffc0209bee:	e44e                	sd	s3,8(sp)
ffffffffc0209bf0:	e052                	sd	s4,0(sp)
ffffffffc0209bf2:	6785                	lui	a5,0x1
ffffffffc0209bf4:	04f77863          	bgeu	a4,a5,ffffffffc0209c44 <sfs_rbuf+0x60>
ffffffffc0209bf8:	84ba                	mv	s1,a4
ffffffffc0209bfa:	9732                	add	a4,a4,a2
ffffffffc0209bfc:	89b2                	mv	s3,a2
ffffffffc0209bfe:	04e7e363          	bltu	a5,a4,ffffffffc0209c44 <sfs_rbuf+0x60>
ffffffffc0209c02:	8936                	mv	s2,a3
ffffffffc0209c04:	842a                	mv	s0,a0
ffffffffc0209c06:	8a2e                	mv	s4,a1
ffffffffc0209c08:	214000ef          	jal	ra,ffffffffc0209e1c <lock_sfs_io>
ffffffffc0209c0c:	642c                	ld	a1,72(s0)
ffffffffc0209c0e:	864a                	mv	a2,s2
ffffffffc0209c10:	4705                	li	a4,1
ffffffffc0209c12:	4681                	li	a3,0
ffffffffc0209c14:	8522                	mv	a0,s0
ffffffffc0209c16:	f77ff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209c1a:	892a                	mv	s2,a0
ffffffffc0209c1c:	cd09                	beqz	a0,ffffffffc0209c36 <sfs_rbuf+0x52>
ffffffffc0209c1e:	8522                	mv	a0,s0
ffffffffc0209c20:	20c000ef          	jal	ra,ffffffffc0209e2c <unlock_sfs_io>
ffffffffc0209c24:	70a2                	ld	ra,40(sp)
ffffffffc0209c26:	7402                	ld	s0,32(sp)
ffffffffc0209c28:	64e2                	ld	s1,24(sp)
ffffffffc0209c2a:	69a2                	ld	s3,8(sp)
ffffffffc0209c2c:	6a02                	ld	s4,0(sp)
ffffffffc0209c2e:	854a                	mv	a0,s2
ffffffffc0209c30:	6942                	ld	s2,16(sp)
ffffffffc0209c32:	6145                	addi	sp,sp,48
ffffffffc0209c34:	8082                	ret
ffffffffc0209c36:	642c                	ld	a1,72(s0)
ffffffffc0209c38:	864e                	mv	a2,s3
ffffffffc0209c3a:	8552                	mv	a0,s4
ffffffffc0209c3c:	95a6                	add	a1,a1,s1
ffffffffc0209c3e:	77c000ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0209c42:	bff1                	j	ffffffffc0209c1e <sfs_rbuf+0x3a>
ffffffffc0209c44:	00004697          	auipc	a3,0x4
ffffffffc0209c48:	41c68693          	addi	a3,a3,1052 # ffffffffc020e060 <sfs_node_fileops+0xd0>
ffffffffc0209c4c:	00001617          	auipc	a2,0x1
ffffffffc0209c50:	c0460613          	addi	a2,a2,-1020 # ffffffffc020a850 <commands+0x210>
ffffffffc0209c54:	05500593          	li	a1,85
ffffffffc0209c58:	00004517          	auipc	a0,0x4
ffffffffc0209c5c:	3f050513          	addi	a0,a0,1008 # ffffffffc020e048 <sfs_node_fileops+0xb8>
ffffffffc0209c60:	83ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c64 <sfs_wbuf>:
ffffffffc0209c64:	7139                	addi	sp,sp,-64
ffffffffc0209c66:	fc06                	sd	ra,56(sp)
ffffffffc0209c68:	f822                	sd	s0,48(sp)
ffffffffc0209c6a:	f426                	sd	s1,40(sp)
ffffffffc0209c6c:	f04a                	sd	s2,32(sp)
ffffffffc0209c6e:	ec4e                	sd	s3,24(sp)
ffffffffc0209c70:	e852                	sd	s4,16(sp)
ffffffffc0209c72:	e456                	sd	s5,8(sp)
ffffffffc0209c74:	6785                	lui	a5,0x1
ffffffffc0209c76:	06f77163          	bgeu	a4,a5,ffffffffc0209cd8 <sfs_wbuf+0x74>
ffffffffc0209c7a:	893a                	mv	s2,a4
ffffffffc0209c7c:	9732                	add	a4,a4,a2
ffffffffc0209c7e:	8a32                	mv	s4,a2
ffffffffc0209c80:	04e7ec63          	bltu	a5,a4,ffffffffc0209cd8 <sfs_wbuf+0x74>
ffffffffc0209c84:	842a                	mv	s0,a0
ffffffffc0209c86:	89b6                	mv	s3,a3
ffffffffc0209c88:	8aae                	mv	s5,a1
ffffffffc0209c8a:	192000ef          	jal	ra,ffffffffc0209e1c <lock_sfs_io>
ffffffffc0209c8e:	642c                	ld	a1,72(s0)
ffffffffc0209c90:	4705                	li	a4,1
ffffffffc0209c92:	4681                	li	a3,0
ffffffffc0209c94:	864e                	mv	a2,s3
ffffffffc0209c96:	8522                	mv	a0,s0
ffffffffc0209c98:	ef5ff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209c9c:	84aa                	mv	s1,a0
ffffffffc0209c9e:	cd11                	beqz	a0,ffffffffc0209cba <sfs_wbuf+0x56>
ffffffffc0209ca0:	8522                	mv	a0,s0
ffffffffc0209ca2:	18a000ef          	jal	ra,ffffffffc0209e2c <unlock_sfs_io>
ffffffffc0209ca6:	70e2                	ld	ra,56(sp)
ffffffffc0209ca8:	7442                	ld	s0,48(sp)
ffffffffc0209caa:	7902                	ld	s2,32(sp)
ffffffffc0209cac:	69e2                	ld	s3,24(sp)
ffffffffc0209cae:	6a42                	ld	s4,16(sp)
ffffffffc0209cb0:	6aa2                	ld	s5,8(sp)
ffffffffc0209cb2:	8526                	mv	a0,s1
ffffffffc0209cb4:	74a2                	ld	s1,40(sp)
ffffffffc0209cb6:	6121                	addi	sp,sp,64
ffffffffc0209cb8:	8082                	ret
ffffffffc0209cba:	6428                	ld	a0,72(s0)
ffffffffc0209cbc:	8652                	mv	a2,s4
ffffffffc0209cbe:	85d6                	mv	a1,s5
ffffffffc0209cc0:	954a                	add	a0,a0,s2
ffffffffc0209cc2:	6f8000ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0209cc6:	642c                	ld	a1,72(s0)
ffffffffc0209cc8:	4705                	li	a4,1
ffffffffc0209cca:	4685                	li	a3,1
ffffffffc0209ccc:	864e                	mv	a2,s3
ffffffffc0209cce:	8522                	mv	a0,s0
ffffffffc0209cd0:	ebdff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209cd4:	84aa                	mv	s1,a0
ffffffffc0209cd6:	b7e9                	j	ffffffffc0209ca0 <sfs_wbuf+0x3c>
ffffffffc0209cd8:	00004697          	auipc	a3,0x4
ffffffffc0209cdc:	38868693          	addi	a3,a3,904 # ffffffffc020e060 <sfs_node_fileops+0xd0>
ffffffffc0209ce0:	00001617          	auipc	a2,0x1
ffffffffc0209ce4:	b7060613          	addi	a2,a2,-1168 # ffffffffc020a850 <commands+0x210>
ffffffffc0209ce8:	06b00593          	li	a1,107
ffffffffc0209cec:	00004517          	auipc	a0,0x4
ffffffffc0209cf0:	35c50513          	addi	a0,a0,860 # ffffffffc020e048 <sfs_node_fileops+0xb8>
ffffffffc0209cf4:	faaf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209cf8 <sfs_sync_super>:
ffffffffc0209cf8:	1101                	addi	sp,sp,-32
ffffffffc0209cfa:	ec06                	sd	ra,24(sp)
ffffffffc0209cfc:	e822                	sd	s0,16(sp)
ffffffffc0209cfe:	e426                	sd	s1,8(sp)
ffffffffc0209d00:	842a                	mv	s0,a0
ffffffffc0209d02:	11a000ef          	jal	ra,ffffffffc0209e1c <lock_sfs_io>
ffffffffc0209d06:	6428                	ld	a0,72(s0)
ffffffffc0209d08:	6605                	lui	a2,0x1
ffffffffc0209d0a:	4581                	li	a1,0
ffffffffc0209d0c:	65c000ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0209d10:	6428                	ld	a0,72(s0)
ffffffffc0209d12:	85a2                	mv	a1,s0
ffffffffc0209d14:	02c00613          	li	a2,44
ffffffffc0209d18:	6a2000ef          	jal	ra,ffffffffc020a3ba <memcpy>
ffffffffc0209d1c:	642c                	ld	a1,72(s0)
ffffffffc0209d1e:	4701                	li	a4,0
ffffffffc0209d20:	4685                	li	a3,1
ffffffffc0209d22:	4601                	li	a2,0
ffffffffc0209d24:	8522                	mv	a0,s0
ffffffffc0209d26:	e67ff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209d2a:	84aa                	mv	s1,a0
ffffffffc0209d2c:	8522                	mv	a0,s0
ffffffffc0209d2e:	0fe000ef          	jal	ra,ffffffffc0209e2c <unlock_sfs_io>
ffffffffc0209d32:	60e2                	ld	ra,24(sp)
ffffffffc0209d34:	6442                	ld	s0,16(sp)
ffffffffc0209d36:	8526                	mv	a0,s1
ffffffffc0209d38:	64a2                	ld	s1,8(sp)
ffffffffc0209d3a:	6105                	addi	sp,sp,32
ffffffffc0209d3c:	8082                	ret

ffffffffc0209d3e <sfs_sync_freemap>:
ffffffffc0209d3e:	7139                	addi	sp,sp,-64
ffffffffc0209d40:	ec4e                	sd	s3,24(sp)
ffffffffc0209d42:	e852                	sd	s4,16(sp)
ffffffffc0209d44:	00456983          	lwu	s3,4(a0)
ffffffffc0209d48:	8a2a                	mv	s4,a0
ffffffffc0209d4a:	7d08                	ld	a0,56(a0)
ffffffffc0209d4c:	67a1                	lui	a5,0x8
ffffffffc0209d4e:	17fd                	addi	a5,a5,-1
ffffffffc0209d50:	4581                	li	a1,0
ffffffffc0209d52:	f822                	sd	s0,48(sp)
ffffffffc0209d54:	fc06                	sd	ra,56(sp)
ffffffffc0209d56:	f426                	sd	s1,40(sp)
ffffffffc0209d58:	f04a                	sd	s2,32(sp)
ffffffffc0209d5a:	e456                	sd	s5,8(sp)
ffffffffc0209d5c:	99be                	add	s3,s3,a5
ffffffffc0209d5e:	c58fe0ef          	jal	ra,ffffffffc02081b6 <bitmap_getdata>
ffffffffc0209d62:	00f9d993          	srli	s3,s3,0xf
ffffffffc0209d66:	842a                	mv	s0,a0
ffffffffc0209d68:	8552                	mv	a0,s4
ffffffffc0209d6a:	0b2000ef          	jal	ra,ffffffffc0209e1c <lock_sfs_io>
ffffffffc0209d6e:	04098163          	beqz	s3,ffffffffc0209db0 <sfs_sync_freemap+0x72>
ffffffffc0209d72:	09b2                	slli	s3,s3,0xc
ffffffffc0209d74:	99a2                	add	s3,s3,s0
ffffffffc0209d76:	4909                	li	s2,2
ffffffffc0209d78:	6a85                	lui	s5,0x1
ffffffffc0209d7a:	a021                	j	ffffffffc0209d82 <sfs_sync_freemap+0x44>
ffffffffc0209d7c:	2905                	addiw	s2,s2,1
ffffffffc0209d7e:	02898963          	beq	s3,s0,ffffffffc0209db0 <sfs_sync_freemap+0x72>
ffffffffc0209d82:	85a2                	mv	a1,s0
ffffffffc0209d84:	864a                	mv	a2,s2
ffffffffc0209d86:	4705                	li	a4,1
ffffffffc0209d88:	4685                	li	a3,1
ffffffffc0209d8a:	8552                	mv	a0,s4
ffffffffc0209d8c:	e01ff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209d90:	84aa                	mv	s1,a0
ffffffffc0209d92:	9456                	add	s0,s0,s5
ffffffffc0209d94:	d565                	beqz	a0,ffffffffc0209d7c <sfs_sync_freemap+0x3e>
ffffffffc0209d96:	8552                	mv	a0,s4
ffffffffc0209d98:	094000ef          	jal	ra,ffffffffc0209e2c <unlock_sfs_io>
ffffffffc0209d9c:	70e2                	ld	ra,56(sp)
ffffffffc0209d9e:	7442                	ld	s0,48(sp)
ffffffffc0209da0:	7902                	ld	s2,32(sp)
ffffffffc0209da2:	69e2                	ld	s3,24(sp)
ffffffffc0209da4:	6a42                	ld	s4,16(sp)
ffffffffc0209da6:	6aa2                	ld	s5,8(sp)
ffffffffc0209da8:	8526                	mv	a0,s1
ffffffffc0209daa:	74a2                	ld	s1,40(sp)
ffffffffc0209dac:	6121                	addi	sp,sp,64
ffffffffc0209dae:	8082                	ret
ffffffffc0209db0:	4481                	li	s1,0
ffffffffc0209db2:	b7d5                	j	ffffffffc0209d96 <sfs_sync_freemap+0x58>

ffffffffc0209db4 <sfs_clear_block>:
ffffffffc0209db4:	7179                	addi	sp,sp,-48
ffffffffc0209db6:	f022                	sd	s0,32(sp)
ffffffffc0209db8:	e84a                	sd	s2,16(sp)
ffffffffc0209dba:	e44e                	sd	s3,8(sp)
ffffffffc0209dbc:	f406                	sd	ra,40(sp)
ffffffffc0209dbe:	89b2                	mv	s3,a2
ffffffffc0209dc0:	ec26                	sd	s1,24(sp)
ffffffffc0209dc2:	892a                	mv	s2,a0
ffffffffc0209dc4:	842e                	mv	s0,a1
ffffffffc0209dc6:	056000ef          	jal	ra,ffffffffc0209e1c <lock_sfs_io>
ffffffffc0209dca:	04893503          	ld	a0,72(s2)
ffffffffc0209dce:	6605                	lui	a2,0x1
ffffffffc0209dd0:	4581                	li	a1,0
ffffffffc0209dd2:	596000ef          	jal	ra,ffffffffc020a368 <memset>
ffffffffc0209dd6:	02098d63          	beqz	s3,ffffffffc0209e10 <sfs_clear_block+0x5c>
ffffffffc0209dda:	013409bb          	addw	s3,s0,s3
ffffffffc0209dde:	a019                	j	ffffffffc0209de4 <sfs_clear_block+0x30>
ffffffffc0209de0:	02898863          	beq	s3,s0,ffffffffc0209e10 <sfs_clear_block+0x5c>
ffffffffc0209de4:	04893583          	ld	a1,72(s2)
ffffffffc0209de8:	8622                	mv	a2,s0
ffffffffc0209dea:	4705                	li	a4,1
ffffffffc0209dec:	4685                	li	a3,1
ffffffffc0209dee:	854a                	mv	a0,s2
ffffffffc0209df0:	d9dff0ef          	jal	ra,ffffffffc0209b8c <sfs_rwblock_nolock>
ffffffffc0209df4:	84aa                	mv	s1,a0
ffffffffc0209df6:	2405                	addiw	s0,s0,1
ffffffffc0209df8:	d565                	beqz	a0,ffffffffc0209de0 <sfs_clear_block+0x2c>
ffffffffc0209dfa:	854a                	mv	a0,s2
ffffffffc0209dfc:	030000ef          	jal	ra,ffffffffc0209e2c <unlock_sfs_io>
ffffffffc0209e00:	70a2                	ld	ra,40(sp)
ffffffffc0209e02:	7402                	ld	s0,32(sp)
ffffffffc0209e04:	6942                	ld	s2,16(sp)
ffffffffc0209e06:	69a2                	ld	s3,8(sp)
ffffffffc0209e08:	8526                	mv	a0,s1
ffffffffc0209e0a:	64e2                	ld	s1,24(sp)
ffffffffc0209e0c:	6145                	addi	sp,sp,48
ffffffffc0209e0e:	8082                	ret
ffffffffc0209e10:	4481                	li	s1,0
ffffffffc0209e12:	b7e5                	j	ffffffffc0209dfa <sfs_clear_block+0x46>

ffffffffc0209e14 <lock_sfs_fs>:
ffffffffc0209e14:	05050513          	addi	a0,a0,80
ffffffffc0209e18:	aa2fa06f          	j	ffffffffc02040ba <down>

ffffffffc0209e1c <lock_sfs_io>:
ffffffffc0209e1c:	06850513          	addi	a0,a0,104
ffffffffc0209e20:	a9afa06f          	j	ffffffffc02040ba <down>

ffffffffc0209e24 <unlock_sfs_fs>:
ffffffffc0209e24:	05050513          	addi	a0,a0,80
ffffffffc0209e28:	a8efa06f          	j	ffffffffc02040b6 <up>

ffffffffc0209e2c <unlock_sfs_io>:
ffffffffc0209e2c:	06850513          	addi	a0,a0,104
ffffffffc0209e30:	a86fa06f          	j	ffffffffc02040b6 <up>

ffffffffc0209e34 <hash32>:
ffffffffc0209e34:	9e3707b7          	lui	a5,0x9e370
ffffffffc0209e38:	2785                	addiw	a5,a5,1
ffffffffc0209e3a:	02a7853b          	mulw	a0,a5,a0
ffffffffc0209e3e:	02000793          	li	a5,32
ffffffffc0209e42:	9f8d                	subw	a5,a5,a1
ffffffffc0209e44:	00f5553b          	srlw	a0,a0,a5
ffffffffc0209e48:	8082                	ret

ffffffffc0209e4a <printnum>:
ffffffffc0209e4a:	02071893          	slli	a7,a4,0x20
ffffffffc0209e4e:	7139                	addi	sp,sp,-64
ffffffffc0209e50:	0208d893          	srli	a7,a7,0x20
ffffffffc0209e54:	e456                	sd	s5,8(sp)
ffffffffc0209e56:	0316fab3          	remu	s5,a3,a7
ffffffffc0209e5a:	f822                	sd	s0,48(sp)
ffffffffc0209e5c:	f426                	sd	s1,40(sp)
ffffffffc0209e5e:	f04a                	sd	s2,32(sp)
ffffffffc0209e60:	ec4e                	sd	s3,24(sp)
ffffffffc0209e62:	fc06                	sd	ra,56(sp)
ffffffffc0209e64:	e852                	sd	s4,16(sp)
ffffffffc0209e66:	84aa                	mv	s1,a0
ffffffffc0209e68:	89ae                	mv	s3,a1
ffffffffc0209e6a:	8932                	mv	s2,a2
ffffffffc0209e6c:	fff7841b          	addiw	s0,a5,-1
ffffffffc0209e70:	2a81                	sext.w	s5,s5
ffffffffc0209e72:	0516f163          	bgeu	a3,a7,ffffffffc0209eb4 <printnum+0x6a>
ffffffffc0209e76:	8a42                	mv	s4,a6
ffffffffc0209e78:	00805863          	blez	s0,ffffffffc0209e88 <printnum+0x3e>
ffffffffc0209e7c:	347d                	addiw	s0,s0,-1
ffffffffc0209e7e:	864e                	mv	a2,s3
ffffffffc0209e80:	85ca                	mv	a1,s2
ffffffffc0209e82:	8552                	mv	a0,s4
ffffffffc0209e84:	9482                	jalr	s1
ffffffffc0209e86:	f87d                	bnez	s0,ffffffffc0209e7c <printnum+0x32>
ffffffffc0209e88:	1a82                	slli	s5,s5,0x20
ffffffffc0209e8a:	00004797          	auipc	a5,0x4
ffffffffc0209e8e:	21e78793          	addi	a5,a5,542 # ffffffffc020e0a8 <sfs_node_fileops+0x118>
ffffffffc0209e92:	020ada93          	srli	s5,s5,0x20
ffffffffc0209e96:	9abe                	add	s5,s5,a5
ffffffffc0209e98:	7442                	ld	s0,48(sp)
ffffffffc0209e9a:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0209e9e:	70e2                	ld	ra,56(sp)
ffffffffc0209ea0:	6a42                	ld	s4,16(sp)
ffffffffc0209ea2:	6aa2                	ld	s5,8(sp)
ffffffffc0209ea4:	864e                	mv	a2,s3
ffffffffc0209ea6:	85ca                	mv	a1,s2
ffffffffc0209ea8:	69e2                	ld	s3,24(sp)
ffffffffc0209eaa:	7902                	ld	s2,32(sp)
ffffffffc0209eac:	87a6                	mv	a5,s1
ffffffffc0209eae:	74a2                	ld	s1,40(sp)
ffffffffc0209eb0:	6121                	addi	sp,sp,64
ffffffffc0209eb2:	8782                	jr	a5
ffffffffc0209eb4:	0316d6b3          	divu	a3,a3,a7
ffffffffc0209eb8:	87a2                	mv	a5,s0
ffffffffc0209eba:	f91ff0ef          	jal	ra,ffffffffc0209e4a <printnum>
ffffffffc0209ebe:	b7e9                	j	ffffffffc0209e88 <printnum+0x3e>

ffffffffc0209ec0 <sprintputch>:
ffffffffc0209ec0:	499c                	lw	a5,16(a1)
ffffffffc0209ec2:	6198                	ld	a4,0(a1)
ffffffffc0209ec4:	6594                	ld	a3,8(a1)
ffffffffc0209ec6:	2785                	addiw	a5,a5,1
ffffffffc0209ec8:	c99c                	sw	a5,16(a1)
ffffffffc0209eca:	00d77763          	bgeu	a4,a3,ffffffffc0209ed8 <sprintputch+0x18>
ffffffffc0209ece:	00170793          	addi	a5,a4,1
ffffffffc0209ed2:	e19c                	sd	a5,0(a1)
ffffffffc0209ed4:	00a70023          	sb	a0,0(a4)
ffffffffc0209ed8:	8082                	ret

ffffffffc0209eda <vprintfmt>:
ffffffffc0209eda:	7119                	addi	sp,sp,-128
ffffffffc0209edc:	f4a6                	sd	s1,104(sp)
ffffffffc0209ede:	f0ca                	sd	s2,96(sp)
ffffffffc0209ee0:	ecce                	sd	s3,88(sp)
ffffffffc0209ee2:	e8d2                	sd	s4,80(sp)
ffffffffc0209ee4:	e4d6                	sd	s5,72(sp)
ffffffffc0209ee6:	e0da                	sd	s6,64(sp)
ffffffffc0209ee8:	fc5e                	sd	s7,56(sp)
ffffffffc0209eea:	ec6e                	sd	s11,24(sp)
ffffffffc0209eec:	fc86                	sd	ra,120(sp)
ffffffffc0209eee:	f8a2                	sd	s0,112(sp)
ffffffffc0209ef0:	f862                	sd	s8,48(sp)
ffffffffc0209ef2:	f466                	sd	s9,40(sp)
ffffffffc0209ef4:	f06a                	sd	s10,32(sp)
ffffffffc0209ef6:	89aa                	mv	s3,a0
ffffffffc0209ef8:	892e                	mv	s2,a1
ffffffffc0209efa:	84b2                	mv	s1,a2
ffffffffc0209efc:	8db6                	mv	s11,a3
ffffffffc0209efe:	8aba                	mv	s5,a4
ffffffffc0209f00:	02500a13          	li	s4,37
ffffffffc0209f04:	5bfd                	li	s7,-1
ffffffffc0209f06:	00004b17          	auipc	s6,0x4
ffffffffc0209f0a:	1ceb0b13          	addi	s6,s6,462 # ffffffffc020e0d4 <sfs_node_fileops+0x144>
ffffffffc0209f0e:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc0209f12:	001d8413          	addi	s0,s11,1
ffffffffc0209f16:	01450b63          	beq	a0,s4,ffffffffc0209f2c <vprintfmt+0x52>
ffffffffc0209f1a:	c129                	beqz	a0,ffffffffc0209f5c <vprintfmt+0x82>
ffffffffc0209f1c:	864a                	mv	a2,s2
ffffffffc0209f1e:	85a6                	mv	a1,s1
ffffffffc0209f20:	0405                	addi	s0,s0,1
ffffffffc0209f22:	9982                	jalr	s3
ffffffffc0209f24:	fff44503          	lbu	a0,-1(s0)
ffffffffc0209f28:	ff4519e3          	bne	a0,s4,ffffffffc0209f1a <vprintfmt+0x40>
ffffffffc0209f2c:	00044583          	lbu	a1,0(s0)
ffffffffc0209f30:	02000813          	li	a6,32
ffffffffc0209f34:	4d01                	li	s10,0
ffffffffc0209f36:	4301                	li	t1,0
ffffffffc0209f38:	5cfd                	li	s9,-1
ffffffffc0209f3a:	5c7d                	li	s8,-1
ffffffffc0209f3c:	05500513          	li	a0,85
ffffffffc0209f40:	48a5                	li	a7,9
ffffffffc0209f42:	fdd5861b          	addiw	a2,a1,-35
ffffffffc0209f46:	0ff67613          	zext.b	a2,a2
ffffffffc0209f4a:	00140d93          	addi	s11,s0,1
ffffffffc0209f4e:	04c56263          	bltu	a0,a2,ffffffffc0209f92 <vprintfmt+0xb8>
ffffffffc0209f52:	060a                	slli	a2,a2,0x2
ffffffffc0209f54:	965a                	add	a2,a2,s6
ffffffffc0209f56:	4214                	lw	a3,0(a2)
ffffffffc0209f58:	96da                	add	a3,a3,s6
ffffffffc0209f5a:	8682                	jr	a3
ffffffffc0209f5c:	70e6                	ld	ra,120(sp)
ffffffffc0209f5e:	7446                	ld	s0,112(sp)
ffffffffc0209f60:	74a6                	ld	s1,104(sp)
ffffffffc0209f62:	7906                	ld	s2,96(sp)
ffffffffc0209f64:	69e6                	ld	s3,88(sp)
ffffffffc0209f66:	6a46                	ld	s4,80(sp)
ffffffffc0209f68:	6aa6                	ld	s5,72(sp)
ffffffffc0209f6a:	6b06                	ld	s6,64(sp)
ffffffffc0209f6c:	7be2                	ld	s7,56(sp)
ffffffffc0209f6e:	7c42                	ld	s8,48(sp)
ffffffffc0209f70:	7ca2                	ld	s9,40(sp)
ffffffffc0209f72:	7d02                	ld	s10,32(sp)
ffffffffc0209f74:	6de2                	ld	s11,24(sp)
ffffffffc0209f76:	6109                	addi	sp,sp,128
ffffffffc0209f78:	8082                	ret
ffffffffc0209f7a:	882e                	mv	a6,a1
ffffffffc0209f7c:	00144583          	lbu	a1,1(s0)
ffffffffc0209f80:	846e                	mv	s0,s11
ffffffffc0209f82:	00140d93          	addi	s11,s0,1
ffffffffc0209f86:	fdd5861b          	addiw	a2,a1,-35
ffffffffc0209f8a:	0ff67613          	zext.b	a2,a2
ffffffffc0209f8e:	fcc572e3          	bgeu	a0,a2,ffffffffc0209f52 <vprintfmt+0x78>
ffffffffc0209f92:	864a                	mv	a2,s2
ffffffffc0209f94:	85a6                	mv	a1,s1
ffffffffc0209f96:	02500513          	li	a0,37
ffffffffc0209f9a:	9982                	jalr	s3
ffffffffc0209f9c:	fff44783          	lbu	a5,-1(s0)
ffffffffc0209fa0:	8da2                	mv	s11,s0
ffffffffc0209fa2:	f74786e3          	beq	a5,s4,ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc0209fa6:	ffedc783          	lbu	a5,-2(s11)
ffffffffc0209faa:	1dfd                	addi	s11,s11,-1
ffffffffc0209fac:	ff479de3          	bne	a5,s4,ffffffffc0209fa6 <vprintfmt+0xcc>
ffffffffc0209fb0:	bfb9                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc0209fb2:	fd058c9b          	addiw	s9,a1,-48
ffffffffc0209fb6:	00144583          	lbu	a1,1(s0)
ffffffffc0209fba:	846e                	mv	s0,s11
ffffffffc0209fbc:	fd05869b          	addiw	a3,a1,-48
ffffffffc0209fc0:	0005861b          	sext.w	a2,a1
ffffffffc0209fc4:	02d8e463          	bltu	a7,a3,ffffffffc0209fec <vprintfmt+0x112>
ffffffffc0209fc8:	00144583          	lbu	a1,1(s0)
ffffffffc0209fcc:	002c969b          	slliw	a3,s9,0x2
ffffffffc0209fd0:	0196873b          	addw	a4,a3,s9
ffffffffc0209fd4:	0017171b          	slliw	a4,a4,0x1
ffffffffc0209fd8:	9f31                	addw	a4,a4,a2
ffffffffc0209fda:	fd05869b          	addiw	a3,a1,-48
ffffffffc0209fde:	0405                	addi	s0,s0,1
ffffffffc0209fe0:	fd070c9b          	addiw	s9,a4,-48
ffffffffc0209fe4:	0005861b          	sext.w	a2,a1
ffffffffc0209fe8:	fed8f0e3          	bgeu	a7,a3,ffffffffc0209fc8 <vprintfmt+0xee>
ffffffffc0209fec:	f40c5be3          	bgez	s8,ffffffffc0209f42 <vprintfmt+0x68>
ffffffffc0209ff0:	8c66                	mv	s8,s9
ffffffffc0209ff2:	5cfd                	li	s9,-1
ffffffffc0209ff4:	b7b9                	j	ffffffffc0209f42 <vprintfmt+0x68>
ffffffffc0209ff6:	fffc4693          	not	a3,s8
ffffffffc0209ffa:	96fd                	srai	a3,a3,0x3f
ffffffffc0209ffc:	00dc77b3          	and	a5,s8,a3
ffffffffc020a000:	00144583          	lbu	a1,1(s0)
ffffffffc020a004:	00078c1b          	sext.w	s8,a5
ffffffffc020a008:	846e                	mv	s0,s11
ffffffffc020a00a:	bf25                	j	ffffffffc0209f42 <vprintfmt+0x68>
ffffffffc020a00c:	000aac83          	lw	s9,0(s5)
ffffffffc020a010:	00144583          	lbu	a1,1(s0)
ffffffffc020a014:	0aa1                	addi	s5,s5,8
ffffffffc020a016:	846e                	mv	s0,s11
ffffffffc020a018:	bfd1                	j	ffffffffc0209fec <vprintfmt+0x112>
ffffffffc020a01a:	4705                	li	a4,1
ffffffffc020a01c:	008a8613          	addi	a2,s5,8
ffffffffc020a020:	00674463          	blt	a4,t1,ffffffffc020a028 <vprintfmt+0x14e>
ffffffffc020a024:	1c030c63          	beqz	t1,ffffffffc020a1fc <vprintfmt+0x322>
ffffffffc020a028:	000ab683          	ld	a3,0(s5)
ffffffffc020a02c:	4741                	li	a4,16
ffffffffc020a02e:	8ab2                	mv	s5,a2
ffffffffc020a030:	2801                	sext.w	a6,a6
ffffffffc020a032:	87e2                	mv	a5,s8
ffffffffc020a034:	8626                	mv	a2,s1
ffffffffc020a036:	85ca                	mv	a1,s2
ffffffffc020a038:	854e                	mv	a0,s3
ffffffffc020a03a:	e11ff0ef          	jal	ra,ffffffffc0209e4a <printnum>
ffffffffc020a03e:	bdc1                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a040:	000aa503          	lw	a0,0(s5)
ffffffffc020a044:	864a                	mv	a2,s2
ffffffffc020a046:	85a6                	mv	a1,s1
ffffffffc020a048:	0aa1                	addi	s5,s5,8
ffffffffc020a04a:	9982                	jalr	s3
ffffffffc020a04c:	b5c9                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a04e:	4705                	li	a4,1
ffffffffc020a050:	008a8613          	addi	a2,s5,8
ffffffffc020a054:	00674463          	blt	a4,t1,ffffffffc020a05c <vprintfmt+0x182>
ffffffffc020a058:	18030d63          	beqz	t1,ffffffffc020a1f2 <vprintfmt+0x318>
ffffffffc020a05c:	000ab683          	ld	a3,0(s5)
ffffffffc020a060:	4729                	li	a4,10
ffffffffc020a062:	8ab2                	mv	s5,a2
ffffffffc020a064:	b7f1                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a066:	00144583          	lbu	a1,1(s0)
ffffffffc020a06a:	4d05                	li	s10,1
ffffffffc020a06c:	846e                	mv	s0,s11
ffffffffc020a06e:	bdd1                	j	ffffffffc0209f42 <vprintfmt+0x68>
ffffffffc020a070:	864a                	mv	a2,s2
ffffffffc020a072:	85a6                	mv	a1,s1
ffffffffc020a074:	02500513          	li	a0,37
ffffffffc020a078:	9982                	jalr	s3
ffffffffc020a07a:	bd51                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a07c:	00144583          	lbu	a1,1(s0)
ffffffffc020a080:	2305                	addiw	t1,t1,1
ffffffffc020a082:	846e                	mv	s0,s11
ffffffffc020a084:	bd7d                	j	ffffffffc0209f42 <vprintfmt+0x68>
ffffffffc020a086:	4705                	li	a4,1
ffffffffc020a088:	008a8613          	addi	a2,s5,8
ffffffffc020a08c:	00674463          	blt	a4,t1,ffffffffc020a094 <vprintfmt+0x1ba>
ffffffffc020a090:	14030c63          	beqz	t1,ffffffffc020a1e8 <vprintfmt+0x30e>
ffffffffc020a094:	000ab683          	ld	a3,0(s5)
ffffffffc020a098:	4721                	li	a4,8
ffffffffc020a09a:	8ab2                	mv	s5,a2
ffffffffc020a09c:	bf51                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a09e:	03000513          	li	a0,48
ffffffffc020a0a2:	864a                	mv	a2,s2
ffffffffc020a0a4:	85a6                	mv	a1,s1
ffffffffc020a0a6:	e042                	sd	a6,0(sp)
ffffffffc020a0a8:	9982                	jalr	s3
ffffffffc020a0aa:	864a                	mv	a2,s2
ffffffffc020a0ac:	85a6                	mv	a1,s1
ffffffffc020a0ae:	07800513          	li	a0,120
ffffffffc020a0b2:	9982                	jalr	s3
ffffffffc020a0b4:	0aa1                	addi	s5,s5,8
ffffffffc020a0b6:	6802                	ld	a6,0(sp)
ffffffffc020a0b8:	4741                	li	a4,16
ffffffffc020a0ba:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020a0be:	bf8d                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a0c0:	000ab403          	ld	s0,0(s5)
ffffffffc020a0c4:	008a8793          	addi	a5,s5,8
ffffffffc020a0c8:	e03e                	sd	a5,0(sp)
ffffffffc020a0ca:	14040c63          	beqz	s0,ffffffffc020a222 <vprintfmt+0x348>
ffffffffc020a0ce:	11805063          	blez	s8,ffffffffc020a1ce <vprintfmt+0x2f4>
ffffffffc020a0d2:	02d00693          	li	a3,45
ffffffffc020a0d6:	0cd81963          	bne	a6,a3,ffffffffc020a1a8 <vprintfmt+0x2ce>
ffffffffc020a0da:	00044683          	lbu	a3,0(s0)
ffffffffc020a0de:	0006851b          	sext.w	a0,a3
ffffffffc020a0e2:	ce8d                	beqz	a3,ffffffffc020a11c <vprintfmt+0x242>
ffffffffc020a0e4:	00140a93          	addi	s5,s0,1
ffffffffc020a0e8:	05e00413          	li	s0,94
ffffffffc020a0ec:	000cc563          	bltz	s9,ffffffffc020a0f6 <vprintfmt+0x21c>
ffffffffc020a0f0:	3cfd                	addiw	s9,s9,-1
ffffffffc020a0f2:	037c8363          	beq	s9,s7,ffffffffc020a118 <vprintfmt+0x23e>
ffffffffc020a0f6:	864a                	mv	a2,s2
ffffffffc020a0f8:	85a6                	mv	a1,s1
ffffffffc020a0fa:	100d0663          	beqz	s10,ffffffffc020a206 <vprintfmt+0x32c>
ffffffffc020a0fe:	3681                	addiw	a3,a3,-32
ffffffffc020a100:	10d47363          	bgeu	s0,a3,ffffffffc020a206 <vprintfmt+0x32c>
ffffffffc020a104:	03f00513          	li	a0,63
ffffffffc020a108:	9982                	jalr	s3
ffffffffc020a10a:	000ac683          	lbu	a3,0(s5)
ffffffffc020a10e:	3c7d                	addiw	s8,s8,-1
ffffffffc020a110:	0a85                	addi	s5,s5,1
ffffffffc020a112:	0006851b          	sext.w	a0,a3
ffffffffc020a116:	faf9                	bnez	a3,ffffffffc020a0ec <vprintfmt+0x212>
ffffffffc020a118:	01805a63          	blez	s8,ffffffffc020a12c <vprintfmt+0x252>
ffffffffc020a11c:	3c7d                	addiw	s8,s8,-1
ffffffffc020a11e:	864a                	mv	a2,s2
ffffffffc020a120:	85a6                	mv	a1,s1
ffffffffc020a122:	02000513          	li	a0,32
ffffffffc020a126:	9982                	jalr	s3
ffffffffc020a128:	fe0c1ae3          	bnez	s8,ffffffffc020a11c <vprintfmt+0x242>
ffffffffc020a12c:	6a82                	ld	s5,0(sp)
ffffffffc020a12e:	b3c5                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a130:	4705                	li	a4,1
ffffffffc020a132:	008a8d13          	addi	s10,s5,8
ffffffffc020a136:	00674463          	blt	a4,t1,ffffffffc020a13e <vprintfmt+0x264>
ffffffffc020a13a:	0a030463          	beqz	t1,ffffffffc020a1e2 <vprintfmt+0x308>
ffffffffc020a13e:	000ab403          	ld	s0,0(s5)
ffffffffc020a142:	0c044463          	bltz	s0,ffffffffc020a20a <vprintfmt+0x330>
ffffffffc020a146:	86a2                	mv	a3,s0
ffffffffc020a148:	8aea                	mv	s5,s10
ffffffffc020a14a:	4729                	li	a4,10
ffffffffc020a14c:	b5d5                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a14e:	000aa783          	lw	a5,0(s5)
ffffffffc020a152:	46e1                	li	a3,24
ffffffffc020a154:	0aa1                	addi	s5,s5,8
ffffffffc020a156:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020a15a:	8fb9                	xor	a5,a5,a4
ffffffffc020a15c:	40e7873b          	subw	a4,a5,a4
ffffffffc020a160:	02e6c663          	blt	a3,a4,ffffffffc020a18c <vprintfmt+0x2b2>
ffffffffc020a164:	00371793          	slli	a5,a4,0x3
ffffffffc020a168:	00004697          	auipc	a3,0x4
ffffffffc020a16c:	2a068693          	addi	a3,a3,672 # ffffffffc020e408 <error_string>
ffffffffc020a170:	97b6                	add	a5,a5,a3
ffffffffc020a172:	639c                	ld	a5,0(a5)
ffffffffc020a174:	cf81                	beqz	a5,ffffffffc020a18c <vprintfmt+0x2b2>
ffffffffc020a176:	873e                	mv	a4,a5
ffffffffc020a178:	00000697          	auipc	a3,0x0
ffffffffc020a17c:	28868693          	addi	a3,a3,648 # ffffffffc020a400 <etext+0x2e>
ffffffffc020a180:	8626                	mv	a2,s1
ffffffffc020a182:	85ca                	mv	a1,s2
ffffffffc020a184:	854e                	mv	a0,s3
ffffffffc020a186:	0d4000ef          	jal	ra,ffffffffc020a25a <printfmt>
ffffffffc020a18a:	b351                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a18c:	00004697          	auipc	a3,0x4
ffffffffc020a190:	f3c68693          	addi	a3,a3,-196 # ffffffffc020e0c8 <sfs_node_fileops+0x138>
ffffffffc020a194:	8626                	mv	a2,s1
ffffffffc020a196:	85ca                	mv	a1,s2
ffffffffc020a198:	854e                	mv	a0,s3
ffffffffc020a19a:	0c0000ef          	jal	ra,ffffffffc020a25a <printfmt>
ffffffffc020a19e:	bb85                	j	ffffffffc0209f0e <vprintfmt+0x34>
ffffffffc020a1a0:	00004417          	auipc	s0,0x4
ffffffffc020a1a4:	f2040413          	addi	s0,s0,-224 # ffffffffc020e0c0 <sfs_node_fileops+0x130>
ffffffffc020a1a8:	85e6                	mv	a1,s9
ffffffffc020a1aa:	8522                	mv	a0,s0
ffffffffc020a1ac:	e442                	sd	a6,8(sp)
ffffffffc020a1ae:	132000ef          	jal	ra,ffffffffc020a2e0 <strnlen>
ffffffffc020a1b2:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020a1b6:	01805c63          	blez	s8,ffffffffc020a1ce <vprintfmt+0x2f4>
ffffffffc020a1ba:	6822                	ld	a6,8(sp)
ffffffffc020a1bc:	00080a9b          	sext.w	s5,a6
ffffffffc020a1c0:	3c7d                	addiw	s8,s8,-1
ffffffffc020a1c2:	864a                	mv	a2,s2
ffffffffc020a1c4:	85a6                	mv	a1,s1
ffffffffc020a1c6:	8556                	mv	a0,s5
ffffffffc020a1c8:	9982                	jalr	s3
ffffffffc020a1ca:	fe0c1be3          	bnez	s8,ffffffffc020a1c0 <vprintfmt+0x2e6>
ffffffffc020a1ce:	00044683          	lbu	a3,0(s0)
ffffffffc020a1d2:	00140a93          	addi	s5,s0,1
ffffffffc020a1d6:	0006851b          	sext.w	a0,a3
ffffffffc020a1da:	daa9                	beqz	a3,ffffffffc020a12c <vprintfmt+0x252>
ffffffffc020a1dc:	05e00413          	li	s0,94
ffffffffc020a1e0:	b731                	j	ffffffffc020a0ec <vprintfmt+0x212>
ffffffffc020a1e2:	000aa403          	lw	s0,0(s5)
ffffffffc020a1e6:	bfb1                	j	ffffffffc020a142 <vprintfmt+0x268>
ffffffffc020a1e8:	000ae683          	lwu	a3,0(s5)
ffffffffc020a1ec:	4721                	li	a4,8
ffffffffc020a1ee:	8ab2                	mv	s5,a2
ffffffffc020a1f0:	b581                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a1f2:	000ae683          	lwu	a3,0(s5)
ffffffffc020a1f6:	4729                	li	a4,10
ffffffffc020a1f8:	8ab2                	mv	s5,a2
ffffffffc020a1fa:	bd1d                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a1fc:	000ae683          	lwu	a3,0(s5)
ffffffffc020a200:	4741                	li	a4,16
ffffffffc020a202:	8ab2                	mv	s5,a2
ffffffffc020a204:	b535                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a206:	9982                	jalr	s3
ffffffffc020a208:	b709                	j	ffffffffc020a10a <vprintfmt+0x230>
ffffffffc020a20a:	864a                	mv	a2,s2
ffffffffc020a20c:	85a6                	mv	a1,s1
ffffffffc020a20e:	02d00513          	li	a0,45
ffffffffc020a212:	e042                	sd	a6,0(sp)
ffffffffc020a214:	9982                	jalr	s3
ffffffffc020a216:	6802                	ld	a6,0(sp)
ffffffffc020a218:	8aea                	mv	s5,s10
ffffffffc020a21a:	408006b3          	neg	a3,s0
ffffffffc020a21e:	4729                	li	a4,10
ffffffffc020a220:	bd01                	j	ffffffffc020a030 <vprintfmt+0x156>
ffffffffc020a222:	03805163          	blez	s8,ffffffffc020a244 <vprintfmt+0x36a>
ffffffffc020a226:	02d00693          	li	a3,45
ffffffffc020a22a:	f6d81be3          	bne	a6,a3,ffffffffc020a1a0 <vprintfmt+0x2c6>
ffffffffc020a22e:	00004417          	auipc	s0,0x4
ffffffffc020a232:	e9240413          	addi	s0,s0,-366 # ffffffffc020e0c0 <sfs_node_fileops+0x130>
ffffffffc020a236:	02800693          	li	a3,40
ffffffffc020a23a:	02800513          	li	a0,40
ffffffffc020a23e:	00140a93          	addi	s5,s0,1
ffffffffc020a242:	b55d                	j	ffffffffc020a0e8 <vprintfmt+0x20e>
ffffffffc020a244:	00004a97          	auipc	s5,0x4
ffffffffc020a248:	e7da8a93          	addi	s5,s5,-387 # ffffffffc020e0c1 <sfs_node_fileops+0x131>
ffffffffc020a24c:	02800513          	li	a0,40
ffffffffc020a250:	02800693          	li	a3,40
ffffffffc020a254:	05e00413          	li	s0,94
ffffffffc020a258:	bd51                	j	ffffffffc020a0ec <vprintfmt+0x212>

ffffffffc020a25a <printfmt>:
ffffffffc020a25a:	7139                	addi	sp,sp,-64
ffffffffc020a25c:	02010313          	addi	t1,sp,32
ffffffffc020a260:	f03a                	sd	a4,32(sp)
ffffffffc020a262:	871a                	mv	a4,t1
ffffffffc020a264:	ec06                	sd	ra,24(sp)
ffffffffc020a266:	f43e                	sd	a5,40(sp)
ffffffffc020a268:	f842                	sd	a6,48(sp)
ffffffffc020a26a:	fc46                	sd	a7,56(sp)
ffffffffc020a26c:	e41a                	sd	t1,8(sp)
ffffffffc020a26e:	c6dff0ef          	jal	ra,ffffffffc0209eda <vprintfmt>
ffffffffc020a272:	60e2                	ld	ra,24(sp)
ffffffffc020a274:	6121                	addi	sp,sp,64
ffffffffc020a276:	8082                	ret

ffffffffc020a278 <snprintf>:
ffffffffc020a278:	711d                	addi	sp,sp,-96
ffffffffc020a27a:	15fd                	addi	a1,a1,-1
ffffffffc020a27c:	03810313          	addi	t1,sp,56
ffffffffc020a280:	95aa                	add	a1,a1,a0
ffffffffc020a282:	f406                	sd	ra,40(sp)
ffffffffc020a284:	fc36                	sd	a3,56(sp)
ffffffffc020a286:	e0ba                	sd	a4,64(sp)
ffffffffc020a288:	e4be                	sd	a5,72(sp)
ffffffffc020a28a:	e8c2                	sd	a6,80(sp)
ffffffffc020a28c:	ecc6                	sd	a7,88(sp)
ffffffffc020a28e:	e01a                	sd	t1,0(sp)
ffffffffc020a290:	e42a                	sd	a0,8(sp)
ffffffffc020a292:	e82e                	sd	a1,16(sp)
ffffffffc020a294:	cc02                	sw	zero,24(sp)
ffffffffc020a296:	c515                	beqz	a0,ffffffffc020a2c2 <snprintf+0x4a>
ffffffffc020a298:	02a5e563          	bltu	a1,a0,ffffffffc020a2c2 <snprintf+0x4a>
ffffffffc020a29c:	75dd                	lui	a1,0xffff7
ffffffffc020a29e:	86b2                	mv	a3,a2
ffffffffc020a2a0:	00000517          	auipc	a0,0x0
ffffffffc020a2a4:	c2050513          	addi	a0,a0,-992 # ffffffffc0209ec0 <sprintputch>
ffffffffc020a2a8:	871a                	mv	a4,t1
ffffffffc020a2aa:	0030                	addi	a2,sp,8
ffffffffc020a2ac:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd611d1>
ffffffffc020a2b0:	c2bff0ef          	jal	ra,ffffffffc0209eda <vprintfmt>
ffffffffc020a2b4:	67a2                	ld	a5,8(sp)
ffffffffc020a2b6:	00078023          	sb	zero,0(a5)
ffffffffc020a2ba:	4562                	lw	a0,24(sp)
ffffffffc020a2bc:	70a2                	ld	ra,40(sp)
ffffffffc020a2be:	6125                	addi	sp,sp,96
ffffffffc020a2c0:	8082                	ret
ffffffffc020a2c2:	5575                	li	a0,-3
ffffffffc020a2c4:	bfe5                	j	ffffffffc020a2bc <snprintf+0x44>

ffffffffc020a2c6 <strlen>:
ffffffffc020a2c6:	00054783          	lbu	a5,0(a0)
ffffffffc020a2ca:	872a                	mv	a4,a0
ffffffffc020a2cc:	4501                	li	a0,0
ffffffffc020a2ce:	cb81                	beqz	a5,ffffffffc020a2de <strlen+0x18>
ffffffffc020a2d0:	0505                	addi	a0,a0,1
ffffffffc020a2d2:	00a707b3          	add	a5,a4,a0
ffffffffc020a2d6:	0007c783          	lbu	a5,0(a5)
ffffffffc020a2da:	fbfd                	bnez	a5,ffffffffc020a2d0 <strlen+0xa>
ffffffffc020a2dc:	8082                	ret
ffffffffc020a2de:	8082                	ret

ffffffffc020a2e0 <strnlen>:
ffffffffc020a2e0:	4781                	li	a5,0
ffffffffc020a2e2:	e589                	bnez	a1,ffffffffc020a2ec <strnlen+0xc>
ffffffffc020a2e4:	a811                	j	ffffffffc020a2f8 <strnlen+0x18>
ffffffffc020a2e6:	0785                	addi	a5,a5,1
ffffffffc020a2e8:	00f58863          	beq	a1,a5,ffffffffc020a2f8 <strnlen+0x18>
ffffffffc020a2ec:	00f50733          	add	a4,a0,a5
ffffffffc020a2f0:	00074703          	lbu	a4,0(a4)
ffffffffc020a2f4:	fb6d                	bnez	a4,ffffffffc020a2e6 <strnlen+0x6>
ffffffffc020a2f6:	85be                	mv	a1,a5
ffffffffc020a2f8:	852e                	mv	a0,a1
ffffffffc020a2fa:	8082                	ret

ffffffffc020a2fc <strcpy>:
ffffffffc020a2fc:	87aa                	mv	a5,a0
ffffffffc020a2fe:	0005c703          	lbu	a4,0(a1)
ffffffffc020a302:	0785                	addi	a5,a5,1
ffffffffc020a304:	0585                	addi	a1,a1,1
ffffffffc020a306:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020a30a:	fb75                	bnez	a4,ffffffffc020a2fe <strcpy+0x2>
ffffffffc020a30c:	8082                	ret

ffffffffc020a30e <strcmp>:
ffffffffc020a30e:	00054783          	lbu	a5,0(a0)
ffffffffc020a312:	0005c703          	lbu	a4,0(a1)
ffffffffc020a316:	cb89                	beqz	a5,ffffffffc020a328 <strcmp+0x1a>
ffffffffc020a318:	0505                	addi	a0,a0,1
ffffffffc020a31a:	0585                	addi	a1,a1,1
ffffffffc020a31c:	fee789e3          	beq	a5,a4,ffffffffc020a30e <strcmp>
ffffffffc020a320:	0007851b          	sext.w	a0,a5
ffffffffc020a324:	9d19                	subw	a0,a0,a4
ffffffffc020a326:	8082                	ret
ffffffffc020a328:	4501                	li	a0,0
ffffffffc020a32a:	bfed                	j	ffffffffc020a324 <strcmp+0x16>

ffffffffc020a32c <strncmp>:
ffffffffc020a32c:	c20d                	beqz	a2,ffffffffc020a34e <strncmp+0x22>
ffffffffc020a32e:	962e                	add	a2,a2,a1
ffffffffc020a330:	a031                	j	ffffffffc020a33c <strncmp+0x10>
ffffffffc020a332:	0505                	addi	a0,a0,1
ffffffffc020a334:	00e79a63          	bne	a5,a4,ffffffffc020a348 <strncmp+0x1c>
ffffffffc020a338:	00b60b63          	beq	a2,a1,ffffffffc020a34e <strncmp+0x22>
ffffffffc020a33c:	00054783          	lbu	a5,0(a0)
ffffffffc020a340:	0585                	addi	a1,a1,1
ffffffffc020a342:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020a346:	f7f5                	bnez	a5,ffffffffc020a332 <strncmp+0x6>
ffffffffc020a348:	40e7853b          	subw	a0,a5,a4
ffffffffc020a34c:	8082                	ret
ffffffffc020a34e:	4501                	li	a0,0
ffffffffc020a350:	8082                	ret

ffffffffc020a352 <strchr>:
ffffffffc020a352:	00054783          	lbu	a5,0(a0)
ffffffffc020a356:	c799                	beqz	a5,ffffffffc020a364 <strchr+0x12>
ffffffffc020a358:	00f58763          	beq	a1,a5,ffffffffc020a366 <strchr+0x14>
ffffffffc020a35c:	00154783          	lbu	a5,1(a0)
ffffffffc020a360:	0505                	addi	a0,a0,1
ffffffffc020a362:	fbfd                	bnez	a5,ffffffffc020a358 <strchr+0x6>
ffffffffc020a364:	4501                	li	a0,0
ffffffffc020a366:	8082                	ret

ffffffffc020a368 <memset>:
ffffffffc020a368:	ca01                	beqz	a2,ffffffffc020a378 <memset+0x10>
ffffffffc020a36a:	962a                	add	a2,a2,a0
ffffffffc020a36c:	87aa                	mv	a5,a0
ffffffffc020a36e:	0785                	addi	a5,a5,1
ffffffffc020a370:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020a374:	fec79de3          	bne	a5,a2,ffffffffc020a36e <memset+0x6>
ffffffffc020a378:	8082                	ret

ffffffffc020a37a <memmove>:
ffffffffc020a37a:	02a5f263          	bgeu	a1,a0,ffffffffc020a39e <memmove+0x24>
ffffffffc020a37e:	00c587b3          	add	a5,a1,a2
ffffffffc020a382:	00f57e63          	bgeu	a0,a5,ffffffffc020a39e <memmove+0x24>
ffffffffc020a386:	00c50733          	add	a4,a0,a2
ffffffffc020a38a:	c615                	beqz	a2,ffffffffc020a3b6 <memmove+0x3c>
ffffffffc020a38c:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020a390:	17fd                	addi	a5,a5,-1
ffffffffc020a392:	177d                	addi	a4,a4,-1
ffffffffc020a394:	00d70023          	sb	a3,0(a4)
ffffffffc020a398:	fef59ae3          	bne	a1,a5,ffffffffc020a38c <memmove+0x12>
ffffffffc020a39c:	8082                	ret
ffffffffc020a39e:	00c586b3          	add	a3,a1,a2
ffffffffc020a3a2:	87aa                	mv	a5,a0
ffffffffc020a3a4:	ca11                	beqz	a2,ffffffffc020a3b8 <memmove+0x3e>
ffffffffc020a3a6:	0005c703          	lbu	a4,0(a1)
ffffffffc020a3aa:	0585                	addi	a1,a1,1
ffffffffc020a3ac:	0785                	addi	a5,a5,1
ffffffffc020a3ae:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020a3b2:	fed59ae3          	bne	a1,a3,ffffffffc020a3a6 <memmove+0x2c>
ffffffffc020a3b6:	8082                	ret
ffffffffc020a3b8:	8082                	ret

ffffffffc020a3ba <memcpy>:
ffffffffc020a3ba:	ca19                	beqz	a2,ffffffffc020a3d0 <memcpy+0x16>
ffffffffc020a3bc:	962e                	add	a2,a2,a1
ffffffffc020a3be:	87aa                	mv	a5,a0
ffffffffc020a3c0:	0005c703          	lbu	a4,0(a1)
ffffffffc020a3c4:	0585                	addi	a1,a1,1
ffffffffc020a3c6:	0785                	addi	a5,a5,1
ffffffffc020a3c8:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020a3cc:	fec59ae3          	bne	a1,a2,ffffffffc020a3c0 <memcpy+0x6>
ffffffffc020a3d0:	8082                	ret
