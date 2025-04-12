	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
.LC2:
	.string	"Plaintext message:"
	.align	2
.LC3:
	.string	"%02x %02x %02x %02x "
	.align	2
.LC4:
	.string	"Ciphered message:"
	.align	2
.LC5:
	.string	"Original message (after inv cipher):"
	.section	.text.startup,"ax",@progbits
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-96
	sw	s5,68(sp)
	lui	a1,%hi(.LANCHOR0)
	addi	s5,sp,32
	sw	s0,88(sp)
	li	a2,32
	addi	s0,a1,%lo(.LANCHOR0)
	mv	a0,s5
	addi	a1,a1,%lo(.LANCHOR0)
	sw	ra,92(sp)
	sw	s1,84(sp)
	sw	s2,80(sp)
	sw	s3,76(sp)
	sw	s4,72(sp)
	call	memcpy
	li	a2,16
	addi	a1,s0,32
	mv	a0,sp
	call	memcpy
	li	a0,32
	call	aes_init
	mv	a1,a0
	mv	s2,a0
	mv	a0,s5
	call	aes_key_expansion
	lui	a0,%hi(.LC2)
	addi	a0,a0,%lo(.LC2)
	call	puts
	mv	s0,sp
	addi	s3,sp,16
	mv	s1,sp
	lui	s4,%hi(.LC3)
.L2:
	lbu	a4,3(s1)
	lbu	a3,2(s1)
	lbu	a2,1(s1)
	lbu	a1,0(s1)
	addi	a0,s4,%lo(.LC3)
	addi	s1,s1,4
	call	printf
	bne	s3,s1,.L2
	li	a0,10
	call	putchar
	mv	a2,s2
	mv	a1,s3
	mv	a0,sp
	call	aes_cipher
	lui	a0,%hi(.LC4)
	addi	a0,a0,%lo(.LC4)
	call	puts
	mv	s1,s3
.L3:
	lbu	a4,3(s1)
	lbu	a3,2(s1)
	lbu	a2,1(s1)
	lbu	a1,0(s1)
	addi	a0,s4,%lo(.LC3)
	addi	s1,s1,4
	call	printf
	bne	s5,s1,.L3
	li	a0,10
	call	putchar
	mv	a0,s3
	mv	a2,s2
	mv	a1,sp
	call	aes_inv_cipher
	lui	a0,%hi(.LC5)
	addi	a0,a0,%lo(.LC5)
	call	puts
.L4:
	lbu	a4,3(s0)
	lbu	a3,2(s0)
	lbu	a2,1(s0)
	lbu	a1,0(s0)
	addi	a0,s4,%lo(.LC3)
	addi	s0,s0,4
	call	printf
	bne	s3,s0,.L4
	li	a0,10
	call	putchar
	mv	a0,s2
	call	free
	lw	ra,92(sp)
	lw	s0,88(sp)
	lw	s1,84(sp)
	lw	s2,80(sp)
	lw	s3,76(sp)
	lw	s4,72(sp)
	lw	s5,68(sp)
	li	a0,0
	addi	sp,sp,96
	jr	ra
	.size	main, .-main
	.section	.rodata
	.align	2
	.set	.LANCHOR0,. + 0
.LC0:
	.string	""
	.ascii	"\001\002\003\004\005\006\007\b\t\n\013\f\r\016\017\020\021\022"
	.ascii	"\023\024\025\026\027\030\031\032\033\034\035\036\037"
.LC1:
	.string	""
	.ascii	"\021\"3DUfw\210\231\252\273\314\335\356\377"
	.ident	"GCC: (gc891d8dc23e) 13.2.0"
