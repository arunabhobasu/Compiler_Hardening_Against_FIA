	.file	"aes.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	gadd
	.type	gadd, @function
gadd:
	xor	a0,a0,a1
	ret
	.size	gadd, .-gadd
	.align	2
	.globl	gsub
	.type	gsub, @function
gsub:
	xor	a0,a0,a1
	ret
	.size	gsub, .-gsub
	.align	2
	.globl	coef_add
	.type	coef_add, @function
coef_add:
	lbu	a4,0(a1)
	lbu	a5,0(a0)
	xor	a5,a5,a4
	sb	a5,0(a2)
	lbu	a4,1(a1)
	lbu	a5,1(a0)
	xor	a5,a5,a4
	sb	a5,1(a2)
	lbu	a4,2(a1)
	lbu	a5,2(a0)
	xor	a5,a5,a4
	sb	a5,2(a2)
	lbu	a5,3(a0)
	lbu	a4,3(a1)
	xor	a5,a5,a4
	sb	a5,3(a2)
	ret
	.size	coef_add, .-coef_add
	.align	2
	.globl	coef_mult
	.type	coef_mult, @function
coef_mult:
	lbu	a4,0(a0)
	lbu	a3,0(a1)
	lui	a5,%hi(gmult_aes)
	addi	a5,a5,%lo(gmult_aes)
	slli	a4,a4,8
	add	a4,a5,a4
	add	a4,a4,a3
	lbu	a3,3(a0)
	lbu	a6,1(a1)
	lbu	a4,0(a4)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,2(a1)
	xor	a4,a4,a3
	lbu	a3,2(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,3(a1)
	xor	a4,a4,a3
	lbu	a3,1(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	xor	a4,a4,a3
	sb	a4,0(a2)
	lbu	a4,1(a0)
	lbu	a3,0(a1)
	lbu	a6,1(a1)
	slli	a4,a4,8
	add	a4,a5,a4
	add	a4,a4,a3
	lbu	a3,0(a0)
	lbu	a4,0(a4)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,2(a1)
	xor	a4,a4,a3
	lbu	a3,3(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,3(a1)
	xor	a4,a4,a3
	lbu	a3,2(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	xor	a4,a4,a3
	sb	a4,1(a2)
	lbu	a4,2(a0)
	lbu	a3,0(a1)
	lbu	a6,1(a1)
	slli	a4,a4,8
	add	a4,a5,a4
	add	a4,a4,a3
	lbu	a3,1(a0)
	lbu	a4,0(a4)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	xor	a4,a4,a3
	lbu	a3,0(a0)
	lbu	a6,2(a1)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,3(a1)
	xor	a4,a4,a3
	lbu	a3,3(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	xor	a4,a4,a3
	sb	a4,2(a2)
	lbu	a4,3(a0)
	lbu	a3,0(a1)
	lbu	a6,1(a1)
	slli	a4,a4,8
	add	a4,a5,a4
	add	a4,a4,a3
	lbu	a3,2(a0)
	lbu	a4,0(a4)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	lbu	a6,2(a1)
	lbu	a1,3(a1)
	xor	a4,a4,a3
	lbu	a3,1(a0)
	slli	a3,a3,8
	add	a3,a5,a3
	add	a3,a3,a6
	lbu	a3,0(a3)
	xor	a4,a4,a3
	lbu	a3,0(a0)
	slli	a3,a3,8
	add	a5,a5,a3
	add	a5,a5,a1
	lbu	a5,0(a5)
	xor	a5,a4,a5
	sb	a5,3(a2)
	ret
	.size	coef_mult, .-coef_mult
	.align	2
	.globl	Rcon
	.type	Rcon, @function
Rcon:
	li	a5,1
	lui	a3,%hi(R)
	bne	a0,a5,.L6
	sb	a0,%lo(R)(a3)
.L7:
	addi	a0,a3,%lo(R)
	ret
.L6:
	bleu	a0,a5,.L7
	li	a5,2
	sb	a5,%lo(R)(a3)
	lui	a2,%hi(gmult_aes)
	addi	a5,a0,-1
	andi	a5,a5,0xff
	li	a1,0
	li	a4,2
	li	a0,1
	addi	a2,a2,%lo(gmult_aes)
.L9:
	bne	a5,a0,.L10
	beq	a1,zero,.L7
	sb	a4,%lo(R)(a3)
	j	.L7
.L10:
	slli	a4,a4,8
	add	a4,a2,a4
	addi	a5,a5,-1
	lbu	a4,2(a4)
	andi	a5,a5,0xff
	li	a1,1
	j	.L9
	.size	Rcon, .-Rcon
	.globl	__mulsi3
	.align	2
	.globl	add_round_key
	.type	add_round_key, @function
add_round_key:
	addi	sp,sp,-32
	sw	s0,24(sp)
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	sw	ra,28(sp)
	sw	s1,20(sp)
	mv	s2,a0
	mv	s3,a1
	mv	s4,a2
	li	s0,0
	lui	s5,%hi(Nb)
.L16:
	lw	a1,%lo(Nb)(s5)
	blt	s0,a1,.L17
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	addi	sp,sp,32
	jr	ra
.L17:
	mv	a0,s4
	call	__mulsi3
	add	a0,a0,s0
	slli	a0,a0,2
	add	s1,s2,s0
	add	a0,s3,a0
	lbu	a4,0(s1)
	lbu	a5,0(a0)
	mv	a0,s4
	xor	a5,a5,a4
	sb	a5,0(s1)
	lw	a1,%lo(Nb)(s5)
	add	s1,a1,s0
	call	__mulsi3
	add	a0,a0,s0
	slli	a0,a0,2
	add	s1,s2,s1
	add	a0,s3,a0
	lbu	a4,0(s1)
	lbu	a5,1(a0)
	mv	a0,s4
	xor	a5,a5,a4
	sb	a5,0(s1)
	lw	a1,%lo(Nb)(s5)
	slli	s1,a1,1
	call	__mulsi3
	add	a0,a0,s0
	add	s1,s1,s0
	slli	a0,a0,2
	add	s1,s2,s1
	add	a0,s3,a0
	lbu	a4,0(s1)
	lbu	a5,2(a0)
	mv	a0,s4
	xor	a5,a5,a4
	sb	a5,0(s1)
	lw	a1,%lo(Nb)(s5)
	slli	s1,a1,1
	add	s1,s1,a1
	call	__mulsi3
	add	a5,a0,s0
	add	s1,s1,s0
	slli	a5,a5,2
	add	s1,s2,s1
	add	a5,s3,a5
	lbu	a5,3(a5)
	lbu	a4,0(s1)
	addi	s0,s0,1
	andi	s0,s0,0xff
	xor	a5,a5,a4
	sb	a5,0(s1)
	j	.L16
	.size	add_round_key, .-add_round_key
	.align	2
	.globl	mix_columns
	.type	mix_columns, @function
mix_columns:
	li	a5,50397184
	addi	sp,sp,-48
	addi	a5,a5,258
	sw	s0,40(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	ra,44(sp)
	sw	s1,36(sp)
	sw	s5,20(sp)
	mv	s2,a0
	sw	a5,4(sp)
	li	s0,0
	lui	s3,%hi(Nb)
	li	s4,4
.L20:
	lw	a3,%lo(Nb)(s3)
	blt	s0,a3,.L23
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	addi	sp,sp,48
	jr	ra
.L23:
	add	a4,s2,s0
	li	a5,0
	mv	s5,a4
.L21:
	lbu	a1,0(a4)
	addi	a2,sp,8
	add	a2,a2,a5
	sb	a1,0(a2)
	addi	a5,a5,1
	add	a4,a4,a3
	bne	a5,s4,.L21
	addi	a2,sp,12
	addi	a1,sp,8
	addi	a0,sp,4
	call	coef_mult
	li	s1,0
.L22:
	lw	a1,%lo(Nb)(s3)
	mv	a0,s1
	call	__mulsi3
	addi	a5,sp,12
	add	a5,a5,s1
	lbu	a5,0(a5)
	add	a0,s5,a0
	addi	s1,s1,1
	sb	a5,0(a0)
	bne	s1,s4,.L22
	addi	s0,s0,1
	andi	s0,s0,0xff
	j	.L20
	.size	mix_columns, .-mix_columns
	.align	2
	.globl	inv_mix_columns
	.type	inv_mix_columns, @function
inv_mix_columns:
	li	a5,185405440
	addi	sp,sp,-48
	addi	a5,a5,-1778
	sw	s0,40(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	ra,44(sp)
	sw	s1,36(sp)
	sw	s5,20(sp)
	mv	s2,a0
	sw	a5,4(sp)
	li	s0,0
	lui	s3,%hi(Nb)
	li	s4,4
.L28:
	lw	a3,%lo(Nb)(s3)
	blt	s0,a3,.L31
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	addi	sp,sp,48
	jr	ra
.L31:
	add	a4,s2,s0
	li	a5,0
	mv	s5,a4
.L29:
	lbu	a1,0(a4)
	addi	a2,sp,8
	add	a2,a2,a5
	sb	a1,0(a2)
	addi	a5,a5,1
	add	a4,a4,a3
	bne	a5,s4,.L29
	addi	a2,sp,12
	addi	a1,sp,8
	addi	a0,sp,4
	call	coef_mult
	li	s1,0
.L30:
	lw	a1,%lo(Nb)(s3)
	mv	a0,s1
	call	__mulsi3
	addi	a5,sp,12
	add	a5,a5,s1
	lbu	a5,0(a5)
	add	a0,s5,a0
	addi	s1,s1,1
	sb	a5,0(a0)
	bne	s1,s4,.L30
	addi	s0,s0,1
	andi	s0,s0,0xff
	j	.L28
	.size	inv_mix_columns, .-inv_mix_columns
	.align	2
	.globl	shift_rows
	.type	shift_rows, @function
shift_rows:
	addi	sp,sp,-48
	sw	s1,36(sp)
	sw	s3,28(sp)
	sw	s5,20(sp)
	sw	s7,12(sp)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s2,32(sp)
	sw	s4,24(sp)
	sw	s6,16(sp)
	sw	s8,8(sp)
	mv	s3,a0
	li	s1,1
	lui	s5,%hi(Nb)
	li	s7,4
.L36:
	li	s2,0
	addi	s4,s1,1
	andi	s6,s1,0xff
.L39:
	lw	a1,%lo(Nb)(s5)
	mv	a0,s1
	li	s0,1
	call	__mulsi3
	add	a0,s3,a0
	lbu	s8,0(a0)
.L37:
	lw	a1,%lo(Nb)(s5)
	blt	s0,a1,.L38
	mv	a0,s4
	call	__mulsi3
	add	a0,s3,a0
	addi	s2,s2,1
	sb	s8,-1(a0)
	andi	s2,s2,0xff
	bne	s2,s6,.L39
	beq	s4,s7,.L35
	mv	s1,s4
	j	.L36
.L38:
	mv	a0,s1
	call	__mulsi3
	add	a5,a0,s0
	add	a5,s3,a5
	lbu	a4,0(a5)
	addi	s0,s0,1
	andi	s0,s0,0xff
	sb	a4,-1(a5)
	j	.L37
.L35:
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s6,16(sp)
	lw	s7,12(sp)
	lw	s8,8(sp)
	addi	sp,sp,48
	jr	ra
	.size	shift_rows, .-shift_rows
	.align	2
	.globl	inv_shift_rows
	.type	inv_shift_rows, @function
inv_shift_rows:
	addi	sp,sp,-48
	sw	s2,32(sp)
	sw	s4,24(sp)
	sw	s6,16(sp)
	sw	s7,12(sp)
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s3,28(sp)
	sw	s5,20(sp)
	sw	s8,8(sp)
	mv	s6,a0
	li	s7,1
	lui	s2,%hi(Nb)
	li	s4,4
.L44:
	li	s5,0
	addi	s1,s7,1
	andi	s3,s7,0xff
.L47:
	lw	s0,%lo(Nb)(s2)
	mv	a0,s1
	mv	a1,s0
	call	__mulsi3
	add	a0,s6,a0
	lbu	s8,-1(a0)
	addi	s0,s0,-1
	andi	s0,s0,0xff
.L45:
	lw	a1,%lo(Nb)(s2)
	mv	a0,s7
	call	__mulsi3
	bne	s0,zero,.L46
	add	a5,s6,a0
	addi	s5,s5,1
	sb	s8,0(a5)
	andi	s5,s5,0xff
	bne	s5,s3,.L47
	beq	s1,s4,.L43
	mv	s7,s1
	j	.L44
.L46:
	add	a5,s0,a0
	add	a5,s6,a5
	lbu	a4,-1(a5)
	addi	s0,s0,-1
	sb	a4,0(a5)
	j	.L45
.L43:
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s6,16(sp)
	lw	s7,12(sp)
	lw	s8,8(sp)
	addi	sp,sp,48
	jr	ra
	.size	inv_shift_rows, .-inv_shift_rows
	.align	2
	.globl	sub_bytes
	.type	sub_bytes, @function
sub_bytes:
	addi	sp,sp,-32
	sw	s3,12(sp)
	lui	s3,%hi(.LANCHOR0)
	sw	s1,20(sp)
	sw	s2,16(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	sw	ra,28(sp)
	sw	s0,24(sp)
	mv	s2,a0
	li	s1,0
	lui	s4,%hi(Nb)
	addi	s3,s3,%lo(.LANCHOR0)
	li	s5,4
.L52:
	li	s0,0
	j	.L55
.L53:
	mv	a0,s1
	call	__mulsi3
	add	a5,a0,s0
	add	a5,s2,a5
	lbu	a4,0(a5)
	addi	s0,s0,1
	andi	s0,s0,0xff
	add	a4,s3,a4
	lbu	a4,0(a4)
	sb	a4,0(a5)
.L55:
	lw	a1,%lo(Nb)(s4)
	blt	s0,a1,.L53
	addi	s1,s1,1
	bne	s1,s5,.L52
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	addi	sp,sp,32
	jr	ra
	.size	sub_bytes, .-sub_bytes
	.align	2
	.globl	inv_sub_bytes
	.type	inv_sub_bytes, @function
inv_sub_bytes:
	addi	sp,sp,-32
	sw	s3,12(sp)
	lui	s3,%hi(.LANCHOR0)
	sw	s1,20(sp)
	sw	s2,16(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	sw	ra,28(sp)
	sw	s0,24(sp)
	mv	s2,a0
	li	s1,0
	lui	s4,%hi(Nb)
	addi	s3,s3,%lo(.LANCHOR0)
	li	s5,4
.L58:
	li	s0,0
	j	.L61
.L59:
	mv	a0,s1
	call	__mulsi3
	add	a5,a0,s0
	add	a5,s2,a5
	lbu	a4,0(a5)
	addi	s0,s0,1
	andi	s0,s0,0xff
	add	a4,s3,a4
	lbu	a4,256(a4)
	sb	a4,0(a5)
.L61:
	lw	a1,%lo(Nb)(s4)
	blt	s0,a1,.L59
	addi	s1,s1,1
	bne	s1,s5,.L58
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	addi	sp,sp,32
	jr	ra
	.size	inv_sub_bytes, .-inv_sub_bytes
	.align	2
	.globl	sub_word
	.type	sub_word, @function
sub_word:
	lui	a4,%hi(.LANCHOR0)
	addi	a3,a0,4
	addi	a4,a4,%lo(.LANCHOR0)
.L64:
	lbu	a5,0(a0)
	addi	a0,a0,1
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-1(a0)
	bne	a0,a3,.L64
	ret
	.size	sub_word, .-sub_word
	.align	2
	.globl	rot_word
	.type	rot_word, @function
rot_word:
	lbu	a4,1(a0)
	lbu	a5,0(a0)
	sb	a4,0(a0)
	lbu	a4,2(a0)
	sb	a4,1(a0)
	lbu	a4,3(a0)
	sb	a5,3(a0)
	sb	a4,2(a0)
	ret
	.size	rot_word, .-rot_word
	.globl	__modsi3
	.globl	__divsi3
	.align	2
	.globl	aes_key_expansion
	.type	aes_key_expansion, @function
aes_key_expansion:
	addi	sp,sp,-64
	lui	a5,%hi(Nr)
	sw	s1,52(sp)
	mv	s1,a0
	lw	a0,%lo(Nr)(a5)
	lui	a5,%hi(Nb)
	sw	s2,48(sp)
	mv	s2,a1
	lw	a1,%lo(Nb)(a5)
	addi	a0,a0,1
	sw	s3,44(sp)
	sw	s6,32(sp)
	sw	ra,60(sp)
	sw	s0,56(sp)
	sw	s4,40(sp)
	sw	s5,36(sp)
	sw	s7,28(sp)
	call	__mulsi3
	andi	s3,a0,0xff
	li	a4,0
	lui	s6,%hi(Nk)
.L68:
	lw	s0,%lo(Nk)(s6)
	blt	a4,s0,.L69
	andi	s0,s0,255
	slli	s1,s0,2
	add	s1,s2,s1
	li	s4,6
	li	s5,4
.L70:
	andi	a5,s0,0xff
	bgtu	s3,a5,.L73
	lw	ra,60(sp)
	lw	s0,56(sp)
	lw	s1,52(sp)
	lw	s2,48(sp)
	lw	s3,44(sp)
	lw	s4,40(sp)
	lw	s5,36(sp)
	lw	s6,32(sp)
	lw	s7,28(sp)
	addi	sp,sp,64
	jr	ra
.L69:
	slli	a5,a4,2
	add	a3,s1,a5
	lbu	a2,0(a3)
	add	a3,s2,a5
	addi	a4,a4,1
	sb	a2,0(a3)
	addi	a3,a5,1
	add	a2,s1,a3
	lbu	a2,0(a2)
	add	a3,s2,a3
	andi	a4,a4,0xff
	sb	a2,0(a3)
	addi	a3,a5,2
	add	a2,s1,a3
	lbu	a2,0(a2)
	add	a3,s2,a3
	addi	a5,a5,3
	sb	a2,0(a3)
	add	a3,s1,a5
	lbu	a3,0(a3)
	add	a5,s2,a5
	sb	a3,0(a5)
	j	.L68
.L73:
	lbu	a5,-4(s1)
	lw	s7,%lo(Nk)(s6)
	mv	a0,s0
	sb	a5,12(sp)
	lbu	a5,-3(s1)
	mv	a1,s7
	sb	a5,13(sp)
	lbu	a5,-2(s1)
	sb	a5,14(sp)
	lbu	a5,-1(s1)
	sb	a5,15(sp)
	call	__modsi3
	bne	a0,zero,.L71
	addi	a0,sp,12
	call	rot_word
	addi	a0,sp,12
	call	sub_word
	mv	a1,s7
	mv	a0,s0
	call	__divsi3
	andi	a0,a0,0xff
	call	Rcon
	addi	a2,sp,12
	mv	a1,a0
	mv	a0,a2
	call	coef_add
.L72:
	lw	a5,%lo(Nk)(s6)
	lbu	a4,12(sp)
	addi	s1,s1,4
	sub	a5,s0,a5
	slli	a5,a5,2
	add	a5,s2,a5
	lbu	a5,0(a5)
	xor	a5,a5,a4
	sb	a5,-4(s1)
	lw	a5,%lo(Nk)(s6)
	lbu	a4,13(sp)
	sub	a5,s0,a5
	slli	a5,a5,2
	add	a5,s2,a5
	lbu	a5,1(a5)
	xor	a5,a5,a4
	sb	a5,-3(s1)
	lw	a5,%lo(Nk)(s6)
	lbu	a4,14(sp)
	sub	a5,s0,a5
	slli	a5,a5,2
	add	a5,s2,a5
	lbu	a5,2(a5)
	xor	a5,a5,a4
	sb	a5,-2(s1)
	lw	a5,%lo(Nk)(s6)
	lbu	a4,15(sp)
	sub	a5,s0,a5
	slli	a5,a5,2
	add	a5,s2,a5
	lbu	a5,3(a5)
	addi	s0,s0,1
	xor	a5,a5,a4
	sb	a5,-1(s1)
	j	.L70
.L71:
	ble	s7,s4,.L72
	bne	a0,s5,.L72
	addi	a0,sp,12
	call	sub_word
	j	.L72
	.size	aes_key_expansion, .-aes_key_expansion
	.align	2
	.globl	aes_init
	.type	aes_init, @function
aes_init:
	addi	sp,sp,-16
	sw	ra,12(sp)
	li	a5,24
	beq	a0,a5,.L77
	li	a5,32
	beq	a0,a5,.L78
	li	a5,4
	li	a0,10
.L76:
	lui	a4,%hi(Nk)
	sw	a5,%lo(Nk)(a4)
	lui	a5,%hi(Nr)
	sw	a0,%lo(Nr)(a5)
	lui	a5,%hi(Nb)
	lw	a1,%lo(Nb)(a5)
	addi	a0,a0,1
	call	__mulsi3
	lw	ra,12(sp)
	slli	a0,a0,2
	addi	sp,sp,16
	tail	malloc
.L77:
	li	a5,6
	li	a0,12
	j	.L76
.L78:
	li	a5,8
	li	a0,14
	j	.L76
	.size	aes_init, .-aes_init
	.align	2
	.globl	aes_cipher
	.type	aes_cipher, @function
aes_cipher:
	addi	sp,sp,-48
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s3,28(sp)
	sw	s5,20(sp)
	sw	s6,16(sp)
	sw	ra,44(sp)
	sw	s2,32(sp)
	sw	s4,24(sp)
	sw	s7,12(sp)
	addi	s0,sp,48
	lui	s6,%hi(Nb)
	mv	s5,a1
	lw	a1,%lo(Nb)(s6)
	mv	s3,a2
	li	a3,0
	slli	a5,a1,2
	addi	a5,a5,15
	andi	a5,a5,-16
	sub	sp,sp,a5
	mv	s1,sp
	li	a2,0
	li	a7,4
.L81:
	li	a5,0
	add	a6,s1,a2
	j	.L84
.L82:
	slli	a4,a5,2
	add	a4,a0,a4
	add	a4,a4,a3
	lbu	a4,0(a4)
	add	t1,a6,a5
	addi	a5,a5,1
	sb	a4,0(t1)
	andi	a5,a5,0xff
.L84:
	bgt	a1,a5,.L82
	addi	a3,a3,1
	add	a2,a2,a1
	bne	a3,a7,.L81
	li	a2,0
	mv	a1,s3
	mv	a0,s1
	call	add_round_key
	li	s2,1
	lui	s7,%hi(Nr)
.L85:
	lw	s4,%lo(Nr)(s7)
	mv	a0,s1
	blt	s2,s4,.L86
	call	sub_bytes
	mv	a0,s1
	call	shift_rows
	mv	a1,s3
	andi	a2,s4,0xff
	mv	a0,s1
	call	add_round_key
	li	s3,0
	li	s7,4
.L87:
	li	s2,0
	j	.L90
.L86:
	call	sub_bytes
	mv	a0,s1
	call	shift_rows
	mv	a0,s1
	call	mix_columns
	mv	a2,s2
	mv	a1,s3
	mv	a0,s1
	addi	s2,s2,1
	call	add_round_key
	andi	s2,s2,0xff
	j	.L85
.L88:
	mv	a0,s3
	call	__mulsi3
	add	a5,s1,s2
	add	a5,a5,a0
	slli	s4,s2,2
	lbu	a5,0(a5)
	add	s4,s5,s4
	add	s4,s4,s3
	addi	s2,s2,1
	sb	a5,0(s4)
	andi	s2,s2,0xff
.L90:
	lw	a1,%lo(Nb)(s6)
	blt	s2,a1,.L88
	addi	s3,s3,1
	bne	s3,s7,.L87
	addi	sp,s0,-48
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s6,16(sp)
	lw	s7,12(sp)
	addi	sp,sp,48
	jr	ra
	.size	aes_cipher, .-aes_cipher
	.align	2
	.globl	aes_inv_cipher
	.type	aes_inv_cipher, @function
aes_inv_cipher:
	addi	sp,sp,-48
	sw	s0,40(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	s5,20(sp)
	sw	ra,44(sp)
	sw	s1,36(sp)
	sw	s6,16(sp)
	sw	s7,12(sp)
	addi	s0,sp,48
	lui	s4,%hi(Nb)
	mv	s3,a1
	lw	a1,%lo(Nb)(s4)
	mv	s5,a2
	li	a3,0
	slli	a5,a1,2
	addi	a5,a5,15
	andi	a5,a5,-16
	sub	sp,sp,a5
	mv	s2,sp
	li	a2,0
	li	a7,4
.L93:
	li	a5,0
	add	a6,s2,a2
	j	.L96
.L94:
	slli	a4,a5,2
	add	a4,a0,a4
	add	a4,a4,a3
	lbu	a4,0(a4)
	add	t1,a6,a5
	addi	a5,a5,1
	sb	a4,0(t1)
	andi	a5,a5,0xff
.L96:
	bgt	a1,a5,.L94
	addi	a3,a3,1
	add	a2,a2,a1
	bne	a3,a7,.L93
	lui	a5,%hi(Nr)
	lbu	s1,%lo(Nr)(a5)
	mv	a1,s5
	mv	a0,s2
	mv	a2,s1
	call	add_round_key
.L104:
	addi	s1,s1,-1
	andi	s1,s1,0xff
	mv	a0,s2
	bne	s1,zero,.L98
	call	inv_shift_rows
	mv	a0,s2
	call	inv_sub_bytes
	mv	a1,s5
	li	a2,0
	mv	a0,s2
	call	add_round_key
	li	s5,0
	li	s7,4
.L99:
	li	s1,0
	j	.L102
.L98:
	call	inv_shift_rows
	mv	a0,s2
	call	inv_sub_bytes
	mv	a0,s2
	mv	a2,s1
	mv	a1,s5
	call	add_round_key
	mv	a0,s2
	call	inv_mix_columns
	j	.L104
.L100:
	mv	a0,s5
	call	__mulsi3
	add	a5,s2,s1
	add	a5,a5,a0
	slli	s6,s1,2
	lbu	a5,0(a5)
	add	s6,s3,s6
	add	s6,s6,s5
	addi	s1,s1,1
	sb	a5,0(s6)
	andi	s1,s1,0xff
.L102:
	lw	a1,%lo(Nb)(s4)
	blt	s1,a1,.L100
	addi	s5,s5,1
	bne	s5,s7,.L99
	addi	sp,s0,-48
	lw	ra,44(sp)
	lw	s0,40(sp)
	lw	s1,36(sp)
	lw	s2,32(sp)
	lw	s3,28(sp)
	lw	s4,24(sp)
	lw	s5,20(sp)
	lw	s6,16(sp)
	lw	s7,12(sp)
	addi	sp,sp,48
	jr	ra
	.size	aes_inv_cipher, .-aes_inv_cipher
	.globl	R
	.globl	Nr
	.globl	Nk
	.globl	Nb
	.globl	K
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
	.type	s_box, @object
	.size	s_box, 256
s_box:
	.string	"c|w{\362ko\3050\001g+\376\327\253v\312\202\311}\372YG\360\255\324\242\257\234\244r\300\267\375\223&6?\367\3144\245\345\361q\3301\025\004\307#\303\030\226\005\232\007\022\200\342\353'\262u\t\203,\032\033nZ\240R;\326\263)\343/\204S\321"
	.ascii	"\355 \374\261[j\313\2769JLX\317\320\357\252\373CM3\205E\371\002"
	.ascii	"\177P<\237\250Q\243@\217\222\2358\365\274\266\332!\020\377\363"
	.ascii	"\322\315\f\023\354_\227D\027\304\247~=d]\031s`\201O\334\"*\220"
	.ascii	"\210F\356\270\024\336^\013\333\3402:\nI\006$\\\302\323\254b\221"
	.ascii	"\225\344y\347\3107m\215\325N\251lV\364\352ez\256\b\272x%.\034"
	.ascii	"\246\264\306\350\335t\037K\275\213\212p>\265fH\003\366\016a5"
	.ascii	"W\271\206\301\035\236\341\370\230\021i\331\216\224\233\036\207"
	.ascii	"\351\316U(\337\214\241\211\r\277\346BhA\231-\017\260T\273\026"
	.type	inv_s_box, @object
	.size	inv_s_box, 256
inv_s_box:
	.string	"R\tj\32506\2458\277@\243\236\201\363\327\373|\3439\202\233/\377\2074\216CD\304\336\351\313T{\2242\246\302#=\356L\225\013B\372\303N\b.\241f(\331$\262v[\242Im\213\321%r\370\366d\206h\230\026\324\244\\\314]e\266\222lpHP\375\355\271\332^\025FW\247\215\235\204\220\330\253"
	.ascii	"\214\274\323\n\367\344X\005\270\263E\006\320,\036\217\312?\017"
	.ascii	"\002\301\257\275\003\001\023\212k:\221\021AOg\334\352\227\362"
	.ascii	"\317\316\360\264\346s\226\254t\"\347\2555\205\342\3717\350\034"
	.ascii	"u\337nG\361\032q\035)\305\211o\267b\016\252\030\276\033\374V"
	.ascii	">K\306\322y \232\333\300\376x\315Z\364\037\335\2503\210\007\307"
	.ascii	"1\261\022\020Y'\200\354_`Q\177\251\031\265J\r-\345z\237\223\311"
	.ascii	"\234\357\240\340;M\256*\365\260\310\353\273<\203S\231a\027+\004"
	.ascii	"~\272w\326&\341i\024cU!\f}"
	.section	.sbss,"aw",@nobits
	.align	2
	.type	Nr, @object
	.size	Nr, 4
Nr:
	.zero	4
	.type	Nk, @object
	.size	Nk, 4
Nk:
	.zero	4
	.type	K, @object
	.size	K, 4
K:
	.zero	4
	.section	.sdata,"aw"
	.align	2
	.type	R, @object
	.size	R, 4
R:
	.string	"\002"
	.string	""
	.string	""
	.type	Nb, @object
	.size	Nb, 4
Nb:
	.word	4
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
