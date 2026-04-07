	.arch armv8-a+crc
	.file	"opts.c"
// GNU C17 (Debian 14.2.0-19) version 14.2.0 (aarch64-linux-gnu)
//	compiled by GNU C version 14.2.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.27-GMP

// warning: MPFR header version 4.2.1 differs from library version 4.2.2.
// GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
// options passed: -mcpu=cortex-a72 -mlittle-endian -mabi=lp64 -g -ggdb -O3 -fasynchronous-unwind-tables
	.text
.Ltext0:
	.file 0 "/home/alex/ECE785/Speed/Scalar/compiler" "opts.c"
	.align	2
	.p2align 4,,15
	.global	init
	.type	init, %function
init:
.LVL0:
.LFB22:
	.file 1 "opts.c"
	.loc 1 15 25 view -0
	.cfi_startproc
	.loc 1 16 3 view .LVU1
.LBB8:
	.loc 1 16 8 view .LVU2
	.loc 1 16 18 discriminator 1 view .LVU3
.LBE8:
// opts.c:15: void init(int mask_val) {
	.loc 1 15 25 is_stmt 0 view .LVU4
	adrp	x1, .LC0	// tmp122,
	movi	v29.4s, 0x4	//
	adrp	x2, b	// tmp118,
	adrp	x3, a	// tmp119,
	dup	v31.4s, w0	//, tmp120
.LBB9:
// opts.c:18:     b[n] = n;
	.loc 1 18 10 view .LVU5
	add	x0, x2, :lo12:b	// tmp115, tmp118,
.LVL1:
	.loc 1 18 10 view .LVU6
.LBE9:
// opts.c:15: void init(int mask_val) {
	.loc 1 15 25 view .LVU7
	ldr	q30, [x1, #:lo12:.LC0]	//,
.LBB10:
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 10 view .LVU8
	add	x3, x3, :lo12:a	// tmp111, tmp119,
.LBE10:
// opts.c:15: void init(int mask_val) {
	.loc 1 15 25 view .LVU9
	mov	x1, 0	// ivtmp.21,
	mov	x2, 40000	// tmp117,
.LVL2:
	.p2align 3,,7
.L2:
	.loc 1 15 25 view .LVU10
	mov	v28.16b, v30.16b	//,
	add	v30.4s, v30.4s, v29.4s	//,,
.LBB11:
	.loc 1 17 5 is_stmt 1 view .LVU11
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 14 is_stmt 0 view .LVU12
	and	v27.16b, v28.16b, v31.16b	//,,
// opts.c:18:     b[n] = n;
	.loc 1 18 10 view .LVU13
	str	q28, [x0, x1]	//, MEM <vector(4) int> [(int *)&b + ivtmp.21_3 * 1]
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 10 view .LVU14
	str	q27, [x3, x1]	//, MEM <vector(4) int> [(int *)&a + ivtmp.21_3 * 1]
	.loc 1 18 5 is_stmt 1 view .LVU15
	.loc 1 16 32 discriminator 3 view .LVU16
	.loc 1 16 18 discriminator 1 view .LVU17
	add	x1, x1, 16	// ivtmp.21, ivtmp.21,
	cmp	x1, x2	// ivtmp.21, tmp117
	bne	.L2		//,
.LBE11:
// opts.c:20: }
	.loc 1 20 1 is_stmt 0 view .LVU18
	ret	
	.cfi_endproc
.LFE22:
	.size	init, .-init
	.align	2
	.p2align 4,,15
	.global	do_test1
	.type	do_test1, %function
do_test1:
.LFB23:
	.loc 1 22 20 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 23 3 view .LVU20
.LVL3:
	.loc 1 24 3 view .LVU21
.LBB12:
	.loc 1 24 8 view .LVU22
	.loc 1 24 29 discriminator 1 view .LVU23
	adrp	x5, b	// tmp115,
	adrp	x4, a	// tmp116,
.LBE12:
// opts.c:22: int do_test1(void) {
	.loc 1 22 20 is_stmt 0 view .LVU24
	mov	x1, 0	// ivtmp.43,
// opts.c:23:   int sum=0;
	.loc 1 23 7 view .LVU25
	mov	w0, 0	// <retval>,
.LBB13:
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU26
	add	x5, x5, :lo12:b	// tmp105, tmp115,
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 10 view .LVU27
	add	x4, x4, :lo12:a	// tmp109, tmp116,
// opts.c:24:   for (int n=ARRAY_SIZE-1; n!=0; n--) {
	.loc 1 24 29 discriminator 1 view .LVU28
	mov	x6, -39996	// tmp113,
.LVL4:
	.p2align 3,,7
.L8:
	.loc 1 25 5 is_stmt 1 view .LVU29
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 10 is_stmt 0 view .LVU30
	add	x3, x1, x4	// tmp108, ivtmp.43, tmp109
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU31
	add	x2, x1, x5	// tmp104, ivtmp.43, tmp105
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 10 view .LVU32
	add	x3, x3, 32768	// tmp111, tmp108,
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU33
	add	x2, x2, 32768	// tmp107, tmp104,
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 8 view .LVU34
	ldr	w3, [x3, 7228]	//, MEM[(int *)&a + 39996B + ivtmp.43_12 * 1]
// opts.c:24:   for (int n=ARRAY_SIZE-1; n!=0; n--) {
	.loc 1 24 29 discriminator 1 view .LVU35
	sub	x1, x1, #4	// ivtmp.43, ivtmp.43,
.LVL5:
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU36
	ldr	w2, [x2, 7228]	//, MEM[(int *)&b + 39996B + ivtmp.43_12 * 1]
// opts.c:26:       sum += b[n];
	.loc 1 26 11 view .LVU37
	cmp	w3, 0	// MEM[(int *)&a + 39996B + ivtmp.43_12 * 1],
	add	w3, w0, w2	// tmp118, <retval>, pretmp_20
	sub	w0, w0, w2	// tmp117, <retval>, pretmp_20
.LVL6:
	.loc 1 26 11 view .LVU38
	csel	w0, w0, w3, eq	// <retval>, tmp117, tmp118,
.LVL7:
	.loc 1 24 35 is_stmt 1 discriminator 2 view .LVU39
	.loc 1 24 29 discriminator 1 view .LVU40
	cmp	x1, x6	// ivtmp.43, tmp113
	bne	.L8		//,
.LBE13:
	.loc 1 30 3 view .LVU41
// opts.c:31: }
	.loc 1 31 1 is_stmt 0 view .LVU42
	ret	
	.cfi_endproc
.LFE23:
	.size	do_test1, .-do_test1
	.align	2
	.p2align 4,,15
	.global	do_test2
	.type	do_test2, %function
do_test2:
.LFB24:
	.loc 1 33 21 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 34 3 view .LVU44
.LBB14:
	.loc 1 34 8 view .LVU45
.LVL8:
	.loc 1 34 29 discriminator 1 view .LVU46
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 is_stmt 0 view .LVU47
	adrp	x0, .LC1	// tmp164,
	adrp	x9, a	// tmp158,
	adrp	x10, b	// tmp159,
	adrp	x8, c	// tmp160,
	ldr	q27, [x0, #:lo12:.LC1]	//,
	add	x4, x9, :lo12:a	// tmp111, tmp158,
.LBE14:
// opts.c:33: void do_test2(void) {
	.loc 1 33 21 view .LVU48
	mov	x0, 0	// ivtmp.70,
.LBB15:
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 view .LVU49
	add	x5, x10, :lo12:b	// tmp119, tmp159,
	add	x7, x8, :lo12:c	// tmp130, tmp160,
	mov	x6, -39984	// tmp139,
.LVL9:
	.p2align 3,,7
.L11:
	.loc 1 35 5 is_stmt 1 view .LVU50
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 is_stmt 0 view .LVU51
	add	x3, x0, x4	// tmp110, ivtmp.70, tmp111
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 view .LVU52
	add	x2, x0, x5	// tmp118, ivtmp.70, tmp119
	add	x1, x0, x7	// tmp129, ivtmp.70, tmp130
	sub	x0, x0, #16	// ivtmp.70, ivtmp.70,
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 view .LVU53
	ldr	q28, [x3, 39984]	//, MEM <vector(4) int> [(int *)&a + 39984B + ivtmp.70_9 * 1]
	cmp	x0, x6	// ivtmp.70, tmp139
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 view .LVU54
	ldr	q30, [x2, 39984]	//, MEM <vector(4) int> [(int *)&b + 39984B + ivtmp.70_9 * 1]
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 view .LVU55
	mov	v29.16b, v28.16b	//,
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 view .LVU56
	mov	v31.16b, v30.16b	//,
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 view .LVU57
	tbl	v28.16b, {v28.16b - v29.16b}, v27.16b	//,,
	.loc 1 38 7 is_stmt 1 view .LVU58
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 is_stmt 0 view .LVU59
	tbl	v30.16b, {v30.16b - v31.16b}, v27.16b	//,,
	cmeq	v29.4s, v28.4s, #0	//,
	bsl	v29.16b, v30.16b, v28.16b	//,,
	mov	v30.16b, v29.16b	//,
	tbl	v29.16b, {v29.16b - v30.16b}, v27.16b	//,,
	str	q29, [x1, 39984]	//, MEM <vector(4) int> [(int *)&c + 39984B + ivtmp.70_9 * 1]
	.loc 1 34 35 is_stmt 1 discriminator 2 view .LVU60
	.loc 1 34 29 discriminator 1 view .LVU61
	bne	.L11		//,
.LVL10:
	.loc 1 35 5 view .LVU62
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 is_stmt 0 view .LVU63
	ldr	w1, [x4, 12]	//, a[3]
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 8 view .LVU64
	cbnz	w1, .L12	// _1,
	.loc 1 38 7 is_stmt 1 view .LVU65
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 is_stmt 0 view .LVU66
	ldr	w1, [x5, 12]	//, b[3]
.L12:
	add	x0, x8, :lo12:c	// tmp144, tmp160,
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 view .LVU67
	add	x2, x9, :lo12:a	// tmp146, tmp158,
	ldr	w2, [x2, 8]	//, a[2]
	str	w1, [x0, 12]	// _1, c[3]
	.loc 1 34 35 is_stmt 1 discriminator 2 view .LVU68
.LVL11:
	.loc 1 34 29 discriminator 1 view .LVU69
	.loc 1 35 5 view .LVU70
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 8 is_stmt 0 view .LVU71
	cbnz	w2, .L13	// cstore_21,
	.loc 1 38 7 is_stmt 1 view .LVU72
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 is_stmt 0 view .LVU73
	add	x0, x10, :lo12:b	// tmp148, tmp159,
	ldr	w2, [x0, 8]	//, b[2]
.L13:
	add	x0, x8, :lo12:c	// tmp150, tmp160,
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 10 view .LVU74
	add	x9, x9, :lo12:a	// tmp152, tmp158,
	ldr	w1, [x9, 4]	//, a[1]
	str	w2, [x0, 8]	// cstore_21, c[2]
	.loc 1 34 35 is_stmt 1 discriminator 2 view .LVU75
.LVL12:
	.loc 1 34 29 discriminator 1 view .LVU76
	.loc 1 35 5 view .LVU77
// opts.c:35:     if (a[n] != 0)
	.loc 1 35 8 is_stmt 0 view .LVU78
	cbnz	w1, .L15	// _28,
	.loc 1 38 7 is_stmt 1 view .LVU79
// opts.c:38:       c[n] = b[n];
	.loc 1 38 15 is_stmt 0 view .LVU80
	add	x10, x10, :lo12:b	// tmp156, tmp159,
	ldr	w1, [x10, 4]	//, b[1]
.L15:
	add	x8, x8, :lo12:c	// tmp154, tmp160,
	str	w1, [x8, 4]	// _28, c[1]
	.loc 1 34 35 is_stmt 1 discriminator 2 view .LVU81
.LVL13:
	.loc 1 34 29 discriminator 1 view .LVU82
.LBE15:
// opts.c:40: }
	.loc 1 40 1 is_stmt 0 view .LVU83
	ret	
	.cfi_endproc
.LFE24:
	.size	do_test2, .-do_test2
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC2:
	.string	"%u"
	.align	3
.LC3:
	.string	"Assuming clock of %.1f GHz\n"
	.align	3
.LC4:
	.string	"%d elements in array, %d tests, mask length is %d bits\n"
	.align	3
.LC5:
	.string	"Mask 0x%x leads to a[n]==0 every %u entries]\n"
	.align	3
.LC6:
	.string	"Cycles per array element: minimum %6.3f,    average %6.3f\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,15
	.global	main
	.type	main, %function
main:
.LVL14:
.LFB25:
	.loc 1 42 36 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 43 3 view .LVU85
	.loc 1 44 3 view .LVU86
	.loc 1 45 3 view .LVU87
	.loc 1 46 3 view .LVU88
// opts.c:47:   unsigned int mask=1, mask_len=1;
	.loc 1 47 24 is_stmt 0 view .LVU89
	mov	w2, 1	// tmp140,
// opts.c:42: int main (int argc, char * argv[]) {
	.loc 1 42 36 view .LVU90
	stp	x29, x30, [sp, -176]!	//,,,
	.cfi_def_cfa_offset 176
	.cfi_offset 29, -176
	.cfi_offset 30, -168
	mov	x29, sp	//,
// opts.c:49:   if (argc == 2) {
	.loc 1 49 6 view .LVU91
	cmp	w0, 2	// tmp211,
// opts.c:42: int main (int argc, char * argv[]) {
	.loc 1 42 36 view .LVU92
	stp	x19, x20, [sp, 16]	//,,
	stp	x21, x22, [sp, 32]	//,,
	stp	x23, x24, [sp, 48]	//,,
	stp	x25, x26, [sp, 64]	//,,
	stp	x27, x28, [sp, 80]	//,,
	stp	d13, d14, [sp, 96]	//,,
	str	d15, [sp, 112]	//,
	.cfi_offset 19, -160
	.cfi_offset 20, -152
	.cfi_offset 21, -144
	.cfi_offset 22, -136
	.cfi_offset 23, -128
	.cfi_offset 24, -120
	.cfi_offset 25, -112
	.cfi_offset 26, -104
	.cfi_offset 27, -96
	.cfi_offset 28, -88
	.cfi_offset 77, -80
	.cfi_offset 78, -72
	.cfi_offset 79, -64
// opts.c:46:   volatile int ss=0;
	.loc 1 46 16 view .LVU93
	str	wzr, [sp, 136]	//, ss
	.loc 1 47 3 is_stmt 1 view .LVU94
.LVL15:
// opts.c:47:   unsigned int mask=1, mask_len=1;
	.loc 1 47 24 is_stmt 0 view .LVU95
	str	w2, [sp, 140]	// tmp140, mask_len
	.loc 1 49 3 is_stmt 1 view .LVU96
// opts.c:49:   if (argc == 2) {
	.loc 1 49 6 is_stmt 0 view .LVU97
	beq	.L31		//,
.LVL16:
.L19:
	.loc 1 53 3 is_stmt 1 view .LVU98
	adrp	x0, .LC3	// tmp145,
	fmov	d0, 1.5e+0	//,
// opts.c:55:   mask = (1<<mask_len) - 1;
	.loc 1 55 12 is_stmt 0 view .LVU99
	mov	w22, 1	// tmp151,
// opts.c:53:   printf("Assuming clock of %.1f GHz\n", CLOCK_FREQ_GHZ);
	.loc 1 53 3 view .LVU100
	add	x0, x0, :lo12:.LC3	//, tmp145,
	adrp	x28, a	// tmp199,
	bl	printf		//
.LVL17:
	.loc 1 54 3 is_stmt 1 view .LVU101
	mov	w2, 10000	//,
	adrp	x0, .LC4	// tmp148,
	ldr	w3, [sp, 140]	//, mask_len
	mov	w1, w2	//,
	add	x0, x0, :lo12:.LC4	//, tmp148,
	bl	printf		//
.LVL18:
	.loc 1 55 3 view .LVU102
// opts.c:78:     printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	.loc 1 78 5 is_stmt 0 view .LVU103
	mov	x2, 236961935654912	// tmp213,
	mov	x1, 149533581377536	// tmp214,
// opts.c:55:   mask = (1<<mask_len) - 1;
	.loc 1 55 12 view .LVU104
	ldr	w0, [sp, 140]	//, mask_len
// opts.c:78:     printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	.loc 1 78 5 view .LVU105
	movk	x2, 0x4197, lsl 48	// tmp213,,
	movk	x1, 0x40c3, lsl 48	// tmp214,,
	adrp	x27, b	// tmp201,
// opts.c:64:       diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	.loc 1 64 26 view .LVU106
	mov	x21, 51712	// tmp180,
	movk	x21, 0x3b9a, lsl 16	// tmp180,,
// opts.c:78:     printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	.loc 1 78 5 view .LVU107
	fmov	d13, x2	// tmp209, tmp213
	add	x24, sp, 144	// tmp202,,
	fmov	d14, x1	// tmp210, tmp214
	add	x23, sp, 160	// tmp200,,
.LBB16:
.LBB17:
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 10 view .LVU108
	add	x28, x28, :lo12:a	// tmp157, tmp199,
.LBE17:
.LBE16:
// opts.c:55:   mask = (1<<mask_len) - 1;
	.loc 1 55 12 view .LVU109
	lsl	w22, w22, w0	// _4, tmp151, mask_len
.LBB22:
.LBB18:
// opts.c:18:     b[n] = n;
	.loc 1 18 10 view .LVU110
	add	x27, x27, :lo12:b	// tmp161, tmp201,
	adrp	x26, .LC5	// tmp203,
	adrp	x25, .LC6	// tmp204,
.LBE18:
.LBE22:
// opts.c:55:   mask = (1<<mask_len) - 1;
	.loc 1 55 24 view .LVU111
	sub	w22, w22, #1	// mask, _4,
.LVL19:
.L25:
	.loc 1 56 3 is_stmt 1 view .LVU112
	.loc 1 57 5 view .LVU113
.LBB23:
.LBI16:
	.loc 1 15 6 view .LVU114
	.loc 1 16 3 view .LVU115
.LBB19:
	.loc 1 16 8 view .LVU116
	.loc 1 16 18 discriminator 1 view .LVU117
	dup	v27.4s, w22	// vect_cst__117, mask
.LBE19:
.LBE23:
// opts.c:57:     init(mask);
	.loc 1 57 5 is_stmt 0 view .LVU118
	adrp	x0, .LC0	// tmp216,
	mov	x1, 40000	// tmp163,
	movi	v28.4s, 0x4	// tmp155
	ldr	q31, [x0, #:lo12:.LC0]	// vect_vec_iv_.89,
	mov	x0, 0	// ivtmp.117,
.LVL20:
.L20:
	.loc 1 57 5 view .LVU119
	mov	v30.16b, v31.16b	// vect_vec_iv_.89, vect_vec_iv_.89
	add	v31.4s, v31.4s, v28.4s	// vect_vec_iv_.89, vect_vec_iv_.89, tmp155
.LBB24:
.LBB20:
	.loc 1 17 5 is_stmt 1 view .LVU120
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 14 is_stmt 0 view .LVU121
	and	v29.16b, v27.16b, v30.16b	// vect__52.90_118, vect_cst__117, vect_vec_iv_.89
// opts.c:18:     b[n] = n;
	.loc 1 18 10 view .LVU122
	str	q30, [x27, x0]	// vect_vec_iv_.89, MEM <vector(4) int> [(int *)&b + ivtmp.117_54 * 1]
// opts.c:17:     a[n] = n & mask_val;
	.loc 1 17 10 view .LVU123
	str	q29, [x28, x0]	// vect__52.90_118, MEM <vector(4) int> [(int *)&a + ivtmp.117_54 * 1]
	.loc 1 18 5 is_stmt 1 view .LVU124
	.loc 1 16 32 discriminator 3 view .LVU125
	.loc 1 16 18 discriminator 1 view .LVU126
	add	x0, x0, 16	// ivtmp.117, ivtmp.117,
	cmp	x0, x1	// ivtmp.117, tmp163
	bne	.L20		//,
.LBE20:
.LBE24:
// opts.c:58:     total = 0;
	.loc 1 58 11 is_stmt 0 view .LVU127
	movi	v15.2d, #0	// total
// opts.c:59:     min = 1234567890;
	.loc 1 59 9 view .LVU128
	mov	x19, 722	// min,
	movk	x19, 0x4996, lsl 16	// min,,
.LBB25:
.LBB21:
	mov	w20, 10000	// ivtmp_71,
.LVL21:
.L24:
	.loc 1 59 9 view .LVU129
.LBE21:
.LBE25:
	.loc 1 61 7 is_stmt 1 view .LVU130
	mov	x1, x24	//, tmp202
	mov	w0, 3	//,
	bl	clock_gettime		//
.LVL22:
	.loc 1 62 7 view .LVU131
.LBB26:
.LBI26:
	.loc 1 22 5 view .LVU132
.LBB27:
	.loc 1 23 3 view .LVU133
	.loc 1 24 3 view .LVU134
.LBB28:
	.loc 1 24 8 view .LVU135
	.loc 1 24 29 discriminator 1 view .LVU136
.LBE28:
.LBE27:
.LBE26:
// opts.c:61:       clock_gettime(CLOCK_THREAD_CPUTIME_ID, &start);
	.loc 1 61 7 is_stmt 0 view .LVU137
	mov	x0, 0	// ivtmp.107,
.LBB31:
.LBB30:
// opts.c:23:   int sum=0;
	.loc 1 23 7 view .LVU138
	mov	w2, 0	// sum,
.LBB29:
// opts.c:24:   for (int n=ARRAY_SIZE-1; n!=0; n--) {
	.loc 1 24 29 discriminator 1 view .LVU139
	mov	x4, -39996	// tmp174,
.LVL23:
	.p2align 3,,7
.L23:
	.loc 1 25 5 is_stmt 1 view .LVU140
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 10 is_stmt 0 view .LVU141
	add	x3, x0, x28	// tmp169, ivtmp.107, tmp157
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU142
	add	x1, x0, x27	// tmp165, ivtmp.107, tmp161
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 10 view .LVU143
	add	x3, x3, 32768	// tmp172, tmp169,
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU144
	add	x1, x1, 32768	// tmp168, tmp165,
// opts.c:25:     if (a[n] != 0)
	.loc 1 25 8 view .LVU145
	ldr	w3, [x3, 7228]	//, MEM[(int *)&a + 39996B + ivtmp.107_24 * 1]
// opts.c:24:   for (int n=ARRAY_SIZE-1; n!=0; n--) {
	.loc 1 24 29 discriminator 1 view .LVU146
	sub	x0, x0, #4	// ivtmp.107, ivtmp.107,
.LVL24:
// opts.c:26:       sum += b[n];
	.loc 1 26 15 view .LVU147
	ldr	w1, [x1, 7228]	//, MEM[(int *)&b + 39996B + ivtmp.107_24 * 1]
// opts.c:28:       sum -= b[n];
	.loc 1 28 11 view .LVU148
	cmp	w3, 0	// MEM[(int *)&a + 39996B + ivtmp.107_24 * 1],
	sub	w3, w2, w1	// tmp206, sum, pretmp_127
	add	w2, w2, w1	// tmp205, sum, pretmp_127
.LVL25:
	.loc 1 28 11 view .LVU149
	csel	w2, w2, w3, ne	// sum, tmp205, tmp206,
.LVL26:
	.loc 1 24 35 is_stmt 1 discriminator 2 view .LVU150
	.loc 1 24 29 discriminator 1 view .LVU151
	cmp	x0, x4	// ivtmp.107, tmp174
	bne	.L23		//,
.LBE29:
	.loc 1 30 3 view .LVU152
.LVL27:
	.loc 1 30 3 is_stmt 0 view .LVU153
.LBE30:
.LBE31:
// opts.c:62:       ss += do_test1();
	.loc 1 62 10 discriminator 1 view .LVU154
	ldr	w3, [sp, 136]	//, ss
// opts.c:63:       clock_gettime(CLOCK_THREAD_CPUTIME_ID, &end);
	.loc 1 63 7 view .LVU155
	mov	x1, x23	//, tmp200
	mov	w0, 3	//,
// opts.c:62:       ss += do_test1();
	.loc 1 62 10 discriminator 1 view .LVU156
	add	w2, w3, w2	// _98, ss.3_97, sum
	str	w2, [sp, 136]	// _98, ss
	.loc 1 63 7 is_stmt 1 view .LVU157
	bl	clock_gettime		//
.LVL28:
	.loc 1 64 7 view .LVU158
// opts.c:65: 	end.tv_nsec - start.tv_nsec;
	.loc 1 65 14 is_stmt 0 view .LVU159
	ldp	x3, x1, [sp, 144]	// start.tv_sec, start.tv_nsec,
// opts.c:64:       diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	.loc 1 64 57 view .LVU160
	ldp	x0, x2, [sp, 160]	// end.tv_sec, end.tv_nsec,
// opts.c:64:       diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	.loc 1 64 40 view .LVU161
	sub	x0, x0, x3	// _103, end.tv_sec, start.tv_sec
// opts.c:64:       diff = (1000000000 * (end.tv_sec - start.tv_sec)) +
	.loc 1 64 57 view .LVU162
	madd	x0, x0, x21, x2	// _106, _103, tmp180, end.tv_nsec
// opts.c:65: 	end.tv_nsec - start.tv_nsec;
	.loc 1 65 14 view .LVU163
	sub	x0, x0, x1	// diff, _106, start.tv_nsec
.LVL29:
	.loc 1 66 7 is_stmt 1 view .LVU164
// opts.c:67:       if (diff < min)
	.loc 1 67 10 is_stmt 0 view .LVU165
	cmp	x19, x0	// min, diff
	csel	x19, x19, x0, ls	// min, min, diff,
.LVL30:
// opts.c:66:       total += diff;
	.loc 1 66 13 view .LVU166
	fmov	d31, x0	// diff, diff
// opts.c:60:     for (n=0; n<N_TESTS; n++) {
	.loc 1 60 16 discriminator 1 view .LVU167
	subs	w20, w20, #1	// ivtmp_71, ivtmp_71,
// opts.c:66:       total += diff;
	.loc 1 66 13 view .LVU168
	add	d15, d15, d31	// total, total, diff
.LVL31:
	.loc 1 67 7 is_stmt 1 view .LVU169
	.loc 1 60 27 discriminator 2 view .LVU170
	.loc 1 60 16 discriminator 1 view .LVU171
	bne	.L24		//,
	.loc 1 70 5 view .LVU172
	add	w2, w22, 1	//, mask,
	mov	w1, w22	//, mask
	add	x0, x26, :lo12:.LC5	//, tmp203,
.LVL32:
// opts.c:80:     mask >>= 1;
	.loc 1 80 10 is_stmt 0 view .LVU173
	lsr	w22, w22, 1	// mask, mask,
.LVL33:
// opts.c:70:     printf("Mask 0x%x leads to a[n]==0 every %u entries]\n", mask, mask+1);
	.loc 1 70 5 view .LVU174
	bl	printf		//
.LVL34:
	.loc 1 78 5 is_stmt 1 view .LVU175
// opts.c:79: 	   CLOCK_FREQ_GHZ*min/(ARRAY_SIZE), CLOCK_FREQ_GHZ*total/(N_TESTS*ARRAY_SIZE));
	.loc 1 79 52 is_stmt 0 view .LVU176
	ucvtf	d15, d15	// _21, total
.LVL35:
// opts.c:79: 	   CLOCK_FREQ_GHZ*min/(ARRAY_SIZE), CLOCK_FREQ_GHZ*total/(N_TESTS*ARRAY_SIZE));
	.loc 1 79 19 view .LVU177
	ucvtf	d0, x19	// _18, min
// opts.c:78:     printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	.loc 1 78 5 view .LVU178
	add	x0, x25, :lo12:.LC6	//, tmp204,
// opts.c:79: 	   CLOCK_FREQ_GHZ*min/(ARRAY_SIZE), CLOCK_FREQ_GHZ*total/(N_TESTS*ARRAY_SIZE));
	.loc 1 79 52 view .LVU179
	fmov	d31, 1.5e+0	// tmp189,
	fmul	d1, d15, d31	// _22, _21, tmp189
// opts.c:79: 	   CLOCK_FREQ_GHZ*min/(ARRAY_SIZE), CLOCK_FREQ_GHZ*total/(N_TESTS*ARRAY_SIZE));
	.loc 1 79 19 view .LVU180
	fmul	d0, d0, d31	// _19, _18, tmp189
// opts.c:78:     printf("Cycles per array element: minimum %6.3f,    average %6.3f\n",
	.loc 1 78 5 view .LVU181
	fdiv	d1, d1, d13	//, _22, tmp209
	fdiv	d0, d0, d14	//, _19, tmp210
	bl	printf		//
.LVL36:
	.loc 1 80 5 is_stmt 1 view .LVU182
	.loc 1 81 17 view .LVU183
	cbnz	w22, .L25	// mask,
	.loc 1 83 3 view .LVU184
	mov	w0, 0	//,
	bl	exit		//
.LVL37:
.L31:
	.loc 1 50 5 view .LVU185
	mov	x0, x1	// argv, tmp212
.LVL38:
	.loc 1 50 5 is_stmt 0 view .LVU186
	adrp	x1, .LC2	// tmp143,
.LVL39:
	.loc 1 50 5 view .LVU187
	ldr	x0, [x0, 8]	//, MEM[(char * *)argv_35(D) + 8B]
.LVL40:
	.loc 1 50 5 view .LVU188
	add	x2, sp, 140	//,,
	add	x1, x1, :lo12:.LC2	//, tmp143,
	bl	__isoc99_sscanf		//
.LVL41:
	b	.L19		//
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.global	c
	.global	b
	.global	a
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC0:
	.word	0
	.word	1
	.word	2
	.word	3
	.align	4
.LC1:
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.bss
	.align	4
	.type	c, %object
	.size	c, 40000
c:
	.zero	40000
	.type	b, %object
	.size	b, 40000
b:
	.zero	40000
	.type	a, %object
	.size	a, 40000
a:
	.zero	40000
	.text
.Letext0:
	.file 2 "/usr/include/aarch64-linux-gnu/bits/types.h"
	.file 3 "/usr/include/aarch64-linux-gnu/bits/types/clockid_t.h"
	.file 4 "/usr/include/aarch64-linux-gnu/bits/types/struct_timespec.h"
	.file 5 "/usr/include/stdlib.h"
	.file 6 "/usr/include/time.h"
	.file 7 "/usr/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x543
	.2byte	0x5
	.byte	0x1
	.byte	0x8
	.4byte	.Ldebug_abbrev0
	.uleb128 0x17
	.4byte	.LASF32
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.LLRL22
	.8byte	0
	.4byte	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x4
	.4byte	.LASF2
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF3
	.uleb128 0x18
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x19
	.4byte	0x38
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF4
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF5
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.4byte	.LASF6
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.4byte	.LASF7
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.4byte	.LASF8
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x6
	.4byte	.LASF10
	.byte	0x2
	.byte	0xa0
	.byte	0x1a
	.4byte	0x67
	.uleb128 0x6
	.4byte	.LASF11
	.byte	0x2
	.byte	0xa9
	.byte	0x1d
	.4byte	0x38
	.uleb128 0x6
	.4byte	.LASF12
	.byte	0x2
	.byte	0xc5
	.byte	0x21
	.4byte	0x67
	.uleb128 0x7
	.4byte	0x97
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.4byte	.LASF13
	.uleb128 0x1a
	.4byte	0x97
	.uleb128 0x7
	.4byte	0x9e
	.uleb128 0x2
	.byte	0x4
	.byte	0x4
	.4byte	.LASF14
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.4byte	.LASF15
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.4byte	.LASF16
	.uleb128 0x6
	.4byte	.LASF17
	.byte	0x3
	.byte	0x7
	.byte	0x15
	.4byte	0x7a
	.uleb128 0x1b
	.4byte	.LASF33
	.byte	0x10
	.byte	0x4
	.byte	0xb
	.byte	0x8
	.4byte	0xef
	.uleb128 0xd
	.4byte	.LASF18
	.byte	0x10
	.byte	0xc
	.4byte	0x6e
	.byte	0
	.uleb128 0xd
	.4byte	.LASF19
	.byte	0x15
	.byte	0x15
	.4byte	0x86
	.byte	0x8
	.byte	0
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.4byte	.LASF20
	.uleb128 0x1c
	.4byte	0x38
	.4byte	0x107
	.uleb128 0x1d
	.4byte	0x31
	.2byte	0x270f
	.byte	0
	.uleb128 0x9
	.string	"a"
	.byte	0x5
	.4byte	0xf6
	.uleb128 0x9
	.byte	0x3
	.8byte	a
	.uleb128 0x9
	.string	"b"
	.byte	0x15
	.4byte	0xf6
	.uleb128 0x9
	.byte	0x3
	.8byte	b
	.uleb128 0x9
	.string	"c"
	.byte	0x25
	.4byte	0xf6
	.uleb128 0x9
	.byte	0x3
	.8byte	c
	.uleb128 0x1e
	.4byte	.LASF21
	.byte	0x5
	.2byte	0x2f4
	.byte	0xd
	.4byte	0x150
	.uleb128 0x4
	.4byte	0x38
	.byte	0
	.uleb128 0xe
	.4byte	.LASF22
	.byte	0x6
	.2byte	0x120
	.4byte	0x38
	.4byte	0x16b
	.uleb128 0x4
	.4byte	0xbd
	.uleb128 0x4
	.4byte	0x16b
	.byte	0
	.uleb128 0x7
	.4byte	0xc9
	.uleb128 0xe
	.4byte	.LASF23
	.byte	0x7
	.2byte	0x16b
	.4byte	0x38
	.4byte	0x187
	.uleb128 0x4
	.4byte	0xa3
	.uleb128 0xf
	.byte	0
	.uleb128 0x1f
	.4byte	.LASF34
	.byte	0x7
	.2byte	0x1d4
	.byte	0xc
	.4byte	.LASF35
	.4byte	0x38
	.4byte	0x1a8
	.uleb128 0x4
	.4byte	0xa3
	.uleb128 0x4
	.4byte	0xa3
	.uleb128 0xf
	.byte	0
	.uleb128 0x20
	.4byte	.LASF36
	.byte	0x1
	.byte	0x2a
	.byte	0x5
	.4byte	0x38
	.8byte	.LFB25
	.8byte	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x442
	.uleb128 0x10
	.4byte	.LASF24
	.byte	0xf
	.4byte	0x38
	.4byte	.LLST8
	.4byte	.LVUS8
	.uleb128 0x10
	.4byte	.LASF25
	.byte	0x1c
	.4byte	0x442
	.4byte	.LLST9
	.4byte	.LVUS9
	.uleb128 0x11
	.4byte	.LASF26
	.byte	0x2b
	.byte	0x13
	.4byte	0xc9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x12
	.string	"end"
	.byte	0x2b
	.byte	0x1a
	.4byte	0xc9
	.uleb128 0x2
	.byte	0x91
	.sleb128 -16
	.uleb128 0xa
	.4byte	.LASF27
	.byte	0x2c
	.byte	0x11
	.4byte	0x31
	.4byte	.LLST10
	.4byte	.LVUS10
	.uleb128 0xa
	.4byte	.LASF28
	.byte	0x2c
	.byte	0x17
	.4byte	0x31
	.4byte	.LLST11
	.4byte	.LVUS11
	.uleb128 0xb
	.string	"min"
	.byte	0x2c
	.byte	0x20
	.4byte	0x31
	.4byte	.LLST12
	.4byte	.LVUS12
	.uleb128 0xb
	.string	"n"
	.byte	0x2d
	.byte	0x7
	.4byte	0x38
	.4byte	.LLST13
	.4byte	.LVUS13
	.uleb128 0x12
	.string	"ss"
	.byte	0x2e
	.byte	0x10
	.4byte	0x3f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0xa
	.4byte	.LASF29
	.byte	0x2f
	.byte	0x10
	.4byte	0x52
	.4byte	.LLST14
	.4byte	.LVUS14
	.uleb128 0x11
	.4byte	.LASF30
	.byte	0x2f
	.byte	0x18
	.4byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x13
	.4byte	0x4a5
	.8byte	.LBI16
	.byte	.LVU114
	.4byte	.LLRL15
	.byte	0x39
	.byte	0x5
	.4byte	0x2bf
	.uleb128 0x14
	.4byte	0x4b2
	.4byte	.LLST16
	.4byte	.LVUS16
	.uleb128 0x8
	.4byte	0x4be
	.4byte	.LLRL15
	.uleb128 0x5
	.4byte	0x4bf
	.4byte	.LLST17
	.4byte	.LVUS17
	.byte	0
	.byte	0
	.uleb128 0x13
	.4byte	0x47d
	.8byte	.LBI26
	.byte	.LVU132
	.4byte	.LLRL18
	.byte	0x3e
	.byte	0xd
	.4byte	0x302
	.uleb128 0x15
	.4byte	.LLRL18
	.uleb128 0x5
	.4byte	0x48e
	.4byte	.LLST19
	.4byte	.LVUS19
	.uleb128 0x8
	.4byte	0x499
	.4byte	.LLRL20
	.uleb128 0x5
	.4byte	0x49a
	.4byte	.LLST21
	.4byte	.LVUS21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x3
	.8byte	.LVL17
	.4byte	0x170
	.4byte	0x331
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC3
	.uleb128 0x1
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x40
	.uleb128 0xb
	.byte	0xa4
	.uleb128 0x2a
	.byte	0x8
	.4byte	0
	.4byte	0x3ff80000
	.byte	0
	.uleb128 0x3
	.8byte	.LVL18
	.4byte	0x170
	.4byte	0x35e
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC4
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x3
	.byte	0xa
	.2byte	0x2710
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x3
	.byte	0xa
	.2byte	0x2710
	.byte	0
	.uleb128 0x3
	.8byte	.LVL22
	.4byte	0x150
	.4byte	0x37b
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x88
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.8byte	.LVL28
	.4byte	0x150
	.4byte	0x398
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1
	.byte	0x33
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x87
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.8byte	.LVL34
	.4byte	0x170
	.4byte	0x3b7
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC5
	.byte	0
	.uleb128 0x3
	.8byte	.LVL36
	.4byte	0x170
	.4byte	0x409
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC6
	.uleb128 0x1
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x40
	.uleb128 0x16
	.byte	0x83
	.sleb128 0
	.byte	0xa8
	.uleb128 0x31
	.byte	0xa8
	.uleb128 0x2a
	.byte	0xa4
	.uleb128 0x2a
	.byte	0x8
	.4byte	0
	.4byte	0x3ff80000
	.byte	0x1e
	.byte	0xa5
	.uleb128 0x4e
	.uleb128 0x2a
	.byte	0x1b
	.uleb128 0x1
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x41
	.uleb128 0x13
	.byte	0xa5
	.uleb128 0x4f
	.uleb128 0x2a
	.byte	0xa4
	.uleb128 0x2a
	.byte	0x8
	.4byte	0
	.4byte	0x3ff80000
	.byte	0x1e
	.byte	0xa5
	.uleb128 0x4d
	.uleb128 0x2a
	.byte	0x1b
	.byte	0
	.uleb128 0x3
	.8byte	.LVL37
	.4byte	0x13d
	.4byte	0x420
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x50
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x21
	.8byte	.LVL41
	.4byte	0x187
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC2
	.uleb128 0x1
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.byte	0
	.byte	0
	.uleb128 0x7
	.4byte	0x92
	.uleb128 0x22
	.4byte	.LASF37
	.byte	0x1
	.byte	0x21
	.byte	0x6
	.8byte	.LFB24
	.8byte	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x47d
	.uleb128 0x15
	.4byte	.LLRL6
	.uleb128 0xb
	.string	"n"
	.byte	0x22
	.byte	0xc
	.4byte	0x38
	.4byte	.LLST7
	.4byte	.LVUS7
	.byte	0
	.byte	0
	.uleb128 0x23
	.4byte	.LASF31
	.byte	0x1
	.byte	0x16
	.byte	0x5
	.4byte	0x38
	.byte	0x1
	.4byte	0x4a5
	.uleb128 0xc
	.string	"sum"
	.byte	0x17
	.byte	0x7
	.4byte	0x38
	.uleb128 0x16
	.uleb128 0xc
	.string	"n"
	.byte	0x18
	.byte	0xc
	.4byte	0x38
	.byte	0
	.byte	0
	.uleb128 0x24
	.4byte	.LASF38
	.byte	0x1
	.byte	0xf
	.byte	0x6
	.byte	0x1
	.4byte	0x4ca
	.uleb128 0x25
	.4byte	.LASF39
	.byte	0x1
	.byte	0xf
	.byte	0xf
	.4byte	0x38
	.uleb128 0x16
	.uleb128 0xc
	.string	"n"
	.byte	0x10
	.byte	0xc
	.4byte	0x38
	.byte	0
	.byte	0
	.uleb128 0x26
	.4byte	0x4a5
	.8byte	.LFB22
	.8byte	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x50a
	.uleb128 0x14
	.4byte	0x4b2
	.4byte	.LLST0
	.4byte	.LVUS0
	.uleb128 0x8
	.4byte	0x4be
	.4byte	.LLRL1
	.uleb128 0x5
	.4byte	0x4bf
	.4byte	.LLST2
	.4byte	.LVUS2
	.byte	0
	.byte	0
	.uleb128 0x27
	.4byte	0x47d
	.8byte	.LFB23
	.8byte	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x5
	.4byte	0x48e
	.4byte	.LLST3
	.4byte	.LVUS3
	.uleb128 0x8
	.4byte	0x499
	.4byte	.LLRL4
	.uleb128 0x5
	.4byte	0x49a
	.4byte	.LLST5
	.4byte	.LVUS5
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x34
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 13
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 4
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 42
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x2138
	.uleb128 0xb
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x58
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xb
	.byte	0x1
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x8
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LVUS8:
	.uleb128 0
	.uleb128 .LVU98
	.uleb128 .LVU98
	.uleb128 .LVU185
	.uleb128 .LVU185
	.uleb128 .LVU186
	.uleb128 .LVU186
	.uleb128 0
.LLST8:
	.byte	0x6
	.8byte	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL16-.LVL14
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL16-.LVL14
	.uleb128 .LVL37-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL37-.LVL14
	.uleb128 .LVL38-.LVL14
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL38-.LVL14
	.uleb128 .LFE25-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS9:
	.uleb128 0
	.uleb128 .LVU98
	.uleb128 .LVU98
	.uleb128 .LVU185
	.uleb128 .LVU185
	.uleb128 .LVU187
	.uleb128 .LVU187
	.uleb128 .LVU188
	.uleb128 .LVU188
	.uleb128 0
.LLST9:
	.byte	0x6
	.8byte	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL16-.LVL14
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL16-.LVL14
	.uleb128 .LVL37-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL37-.LVL14
	.uleb128 .LVL39-.LVL14
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL39-.LVL14
	.uleb128 .LVL40-.LVL14
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL40-.LVL14
	.uleb128 .LFE25-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS10:
	.uleb128 .LVU164
	.uleb128 .LVU173
	.uleb128 .LVU173
	.uleb128 .LVU175
.LLST10:
	.byte	0x6
	.8byte	.LVL29
	.byte	0x4
	.uleb128 .LVL29-.LVL29
	.uleb128 .LVL32-.LVL29
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL32-.LVL29
	.uleb128 .LVL34-1-.LVL29
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x5f
	.byte	0
.LVUS11:
	.uleb128 .LVU87
	.uleb128 .LVU112
	.uleb128 .LVU129
	.uleb128 .LVU177
	.uleb128 .LVU185
	.uleb128 0
.LLST11:
	.byte	0x6
	.8byte	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL19-.LVL14
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.LVL14
	.uleb128 .LVL35-.LVL14
	.uleb128 0x2
	.byte	0x90
	.uleb128 0x4f
	.byte	0x4
	.uleb128 .LVL37-.LVL14
	.uleb128 .LFE25-.LVL14
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS12:
	.uleb128 .LVU87
	.uleb128 .LVU112
	.uleb128 .LVU129
	.uleb128 .LVU166
	.uleb128 .LVU170
	.uleb128 .LVU185
	.uleb128 .LVU185
	.uleb128 0
.LLST12:
	.byte	0x6
	.8byte	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL19-.LVL14
	.uleb128 0x6
	.byte	0xc
	.4byte	0x499602d2
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.LVL14
	.uleb128 .LVL30-.LVL14
	.uleb128 0x1
	.byte	0x63
	.byte	0x4
	.uleb128 .LVL31-.LVL14
	.uleb128 .LVL37-.LVL14
	.uleb128 0x1
	.byte	0x63
	.byte	0x4
	.uleb128 .LVL37-.LVL14
	.uleb128 .LFE25-.LVL14
	.uleb128 0x6
	.byte	0xc
	.4byte	0x499602d2
	.byte	0x9f
	.byte	0
.LVUS13:
	.uleb128 .LVU88
	.uleb128 .LVU112
	.uleb128 .LVU185
	.uleb128 0
.LLST13:
	.byte	0x6
	.8byte	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL19-.LVL14
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL37-.LVL14
	.uleb128 .LFE25-.LVL14
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS14:
	.uleb128 .LVU95
	.uleb128 .LVU112
	.uleb128 .LVU112
	.uleb128 .LVU174
	.uleb128 .LVU174
	.uleb128 .LVU175
	.uleb128 .LVU183
	.uleb128 .LVU185
	.uleb128 .LVU185
	.uleb128 0
.LLST14:
	.byte	0x6
	.8byte	.LVL15
	.byte	0x4
	.uleb128 .LVL15-.LVL15
	.uleb128 .LVL19-.LVL15
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.LVL15
	.uleb128 .LVL33-.LVL15
	.uleb128 0x1
	.byte	0x66
	.byte	0x4
	.uleb128 .LVL33-.LVL15
	.uleb128 .LVL34-1-.LVL15
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL36-.LVL15
	.uleb128 .LVL37-.LVL15
	.uleb128 0x1
	.byte	0x66
	.byte	0x4
	.uleb128 .LVL37-.LVL15
	.uleb128 .LFE25-.LVL15
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0
.LVUS16:
	.uleb128 .LVU114
	.uleb128 .LVU129
.LLST16:
	.byte	0x8
	.8byte	.LVL19
	.uleb128 .LVL21-.LVL19
	.uleb128 0x1
	.byte	0x66
	.byte	0
.LVUS17:
	.uleb128 .LVU117
	.uleb128 .LVU119
.LLST17:
	.byte	0x8
	.8byte	.LVL19
	.uleb128 .LVL20-.LVL19
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS19:
	.uleb128 .LVU134
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU149
	.uleb128 .LVU150
	.uleb128 .LVU153
.LLST19:
	.byte	0x6
	.8byte	.LVL22
	.byte	0x4
	.uleb128 .LVL22-.LVL22
	.uleb128 .LVL23-.LVL22
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.LVL22
	.uleb128 .LVL25-.LVL22
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL26-.LVL22
	.uleb128 .LVL27-.LVL22
	.uleb128 0x1
	.byte	0x52
	.byte	0
.LVUS21:
	.uleb128 .LVU136
	.uleb128 .LVU140
	.uleb128 .LVU140
	.uleb128 .LVU147
	.uleb128 .LVU147
	.uleb128 .LVU151
.LLST21:
	.byte	0x6
	.8byte	.LVL22
	.byte	0x4
	.uleb128 .LVL22-.LVL22
	.uleb128 .LVL23-.LVL22
	.uleb128 0x4
	.byte	0xa
	.2byte	0x270f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL23-.LVL22
	.uleb128 .LVL24-.LVL22
	.uleb128 0x8
	.byte	0x70
	.sleb128 0
	.byte	0x32
	.byte	0x25
	.byte	0x23
	.uleb128 0x270f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL24-.LVL22
	.uleb128 .LVL26-.LVL22
	.uleb128 0x8
	.byte	0x70
	.sleb128 4
	.byte	0x32
	.byte	0x25
	.byte	0x23
	.uleb128 0x270f
	.byte	0x9f
	.byte	0
.LVUS7:
	.uleb128 .LVU46
	.uleb128 .LVU50
	.uleb128 .LVU62
	.uleb128 .LVU69
	.uleb128 .LVU69
	.uleb128 .LVU76
	.uleb128 .LVU76
	.uleb128 .LVU82
	.uleb128 .LVU82
	.uleb128 0
.LLST7:
	.byte	0x6
	.8byte	.LVL8
	.byte	0x4
	.uleb128 .LVL8-.LVL8
	.uleb128 .LVL9-.LVL8
	.uleb128 0x4
	.byte	0xa
	.2byte	0x270f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL10-.LVL8
	.uleb128 .LVL11-.LVL8
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.LVL8
	.uleb128 .LVL12-.LVL8
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL12-.LVL8
	.uleb128 .LVL13-.LVL8
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.LVL8
	.uleb128 .LFE24-.LVL8
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 0
.LLST0:
	.byte	0x6
	.8byte	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL1-.LVL0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL1-.LVL0
	.uleb128 .LFE22-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x50
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 .LVU3
	.uleb128 .LVU10
.LLST2:
	.byte	0x8
	.8byte	.LVL0
	.uleb128 .LVL2-.LVL0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 .LVU21
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 .LVU38
	.uleb128 .LVU39
	.uleb128 0
.LLST3:
	.byte	0x6
	.8byte	.LVL3
	.byte	0x4
	.uleb128 .LVL3-.LVL3
	.uleb128 .LVL4-.LVL3
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL4-.LVL3
	.uleb128 .LVL6-.LVL3
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL7-.LVL3
	.uleb128 .LFE23-.LVL3
	.uleb128 0x1
	.byte	0x50
	.byte	0
.LVUS5:
	.uleb128 .LVU23
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 .LVU36
	.uleb128 .LVU36
	.uleb128 .LVU40
.LLST5:
	.byte	0x6
	.8byte	.LVL3
	.byte	0x4
	.uleb128 .LVL3-.LVL3
	.uleb128 .LVL4-.LVL3
	.uleb128 0x4
	.byte	0xa
	.2byte	0x270f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL4-.LVL3
	.uleb128 .LVL5-.LVL3
	.uleb128 0x8
	.byte	0x71
	.sleb128 0
	.byte	0x32
	.byte	0x25
	.byte	0x23
	.uleb128 0x270f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL5-.LVL3
	.uleb128 .LVL7-.LVL3
	.uleb128 0x8
	.byte	0x71
	.sleb128 4
	.byte	0x32
	.byte	0x25
	.byte	0x23
	.uleb128 0x270f
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x3c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	.LFB25
	.8byte	.LFE25-.LFB25
	.8byte	0
	.8byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x8
	.byte	0
	.4byte	0
.LLRL1:
	.byte	0x5
	.8byte	.LBB8
	.byte	0x4
	.uleb128 .LBB8-.LBB8
	.uleb128 .LBE8-.LBB8
	.byte	0x4
	.uleb128 .LBB9-.LBB8
	.uleb128 .LBE9-.LBB8
	.byte	0x4
	.uleb128 .LBB10-.LBB8
	.uleb128 .LBE10-.LBB8
	.byte	0x4
	.uleb128 .LBB11-.LBB8
	.uleb128 .LBE11-.LBB8
	.byte	0
.LLRL4:
	.byte	0x5
	.8byte	.LBB12
	.byte	0x4
	.uleb128 .LBB12-.LBB12
	.uleb128 .LBE12-.LBB12
	.byte	0x4
	.uleb128 .LBB13-.LBB12
	.uleb128 .LBE13-.LBB12
	.byte	0
.LLRL6:
	.byte	0x5
	.8byte	.LBB14
	.byte	0x4
	.uleb128 .LBB14-.LBB14
	.uleb128 .LBE14-.LBB14
	.byte	0x4
	.uleb128 .LBB15-.LBB14
	.uleb128 .LBE15-.LBB14
	.byte	0
.LLRL15:
	.byte	0x5
	.8byte	.LBB16
	.byte	0x4
	.uleb128 .LBB16-.LBB16
	.uleb128 .LBE16-.LBB16
	.byte	0x4
	.uleb128 .LBB22-.LBB16
	.uleb128 .LBE22-.LBB16
	.byte	0x4
	.uleb128 .LBB23-.LBB16
	.uleb128 .LBE23-.LBB16
	.byte	0x4
	.uleb128 .LBB24-.LBB16
	.uleb128 .LBE24-.LBB16
	.byte	0x4
	.uleb128 .LBB25-.LBB16
	.uleb128 .LBE25-.LBB16
	.byte	0
.LLRL18:
	.byte	0x5
	.8byte	.LBB26
	.byte	0x4
	.uleb128 .LBB26-.LBB26
	.uleb128 .LBE26-.LBB26
	.byte	0x4
	.uleb128 .LBB31-.LBB26
	.uleb128 .LBE31-.LBB26
	.byte	0
.LLRL20:
	.byte	0x5
	.8byte	.LBB28
	.byte	0x4
	.uleb128 .LBB28-.LBB28
	.uleb128 .LBE28-.LBB28
	.byte	0x4
	.uleb128 .LBB29-.LBB28
	.uleb128 .LBE29-.LBB28
	.byte	0
.LLRL22:
	.byte	0x7
	.8byte	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.8byte	.LFB25
	.uleb128 .LFE25-.LFB25
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF34:
	.string	"sscanf"
.LASF21:
	.string	"exit"
.LASF14:
	.string	"float"
.LASF26:
	.string	"start"
.LASF19:
	.string	"tv_nsec"
.LASF38:
	.string	"init"
.LASF32:
	.string	"GNU C17 14.2.0 -mcpu=cortex-a72 -mlittle-endian -mabi=lp64 -g -ggdb -O3 -fasynchronous-unwind-tables"
.LASF4:
	.string	"unsigned char"
.LASF3:
	.string	"long unsigned int"
.LASF5:
	.string	"short unsigned int"
.LASF10:
	.string	"__time_t"
.LASF2:
	.string	"double"
.LASF36:
	.string	"main"
.LASF6:
	.string	"unsigned int"
.LASF20:
	.string	"long long unsigned int"
.LASF30:
	.string	"mask_len"
.LASF31:
	.string	"do_test1"
.LASF37:
	.string	"do_test2"
.LASF22:
	.string	"clock_gettime"
.LASF24:
	.string	"argc"
.LASF27:
	.string	"diff"
.LASF18:
	.string	"tv_sec"
.LASF16:
	.string	"long long int"
.LASF33:
	.string	"timespec"
.LASF29:
	.string	"mask"
.LASF23:
	.string	"printf"
.LASF8:
	.string	"short int"
.LASF15:
	.string	"__unknown__"
.LASF25:
	.string	"argv"
.LASF28:
	.string	"total"
.LASF9:
	.string	"long int"
.LASF13:
	.string	"char"
.LASF35:
	.string	"__isoc99_sscanf"
.LASF7:
	.string	"signed char"
.LASF17:
	.string	"clockid_t"
.LASF11:
	.string	"__clockid_t"
.LASF12:
	.string	"__syscall_slong_t"
.LASF39:
	.string	"mask_val"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/alex/ECE785/Speed/Scalar/compiler"
.LASF0:
	.string	"opts.c"
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
