	.file	"password_safe.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	2
.LC0:
	.string	"\nAccess granted. The ID requested is 3528712754."
	.text
	.align	2
	.globl	secret_function
	.type	secret_function, @function
secret_function:
	addi	sp,sp,-16
	sw	ra,12(sp)
	sw	s0,8(sp)
	addi	s0,sp,16
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	puts
	nop
	lw	ra,12(sp)
	lw	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	secret_function, .-secret_function
	.section	.rodata
	.align	2
.LC1:
	.string	"Input the password: "
	.align	2
.LC2:
	.string	"\nIncorrect password. Try again."
	.text
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	li	a5,1936941056
	addi	a5,a5,368
	sw	a5,-28(s0)
	li	a5,858927104
	addi	a5,a5,292
	sw	a5,-24(s0)
	sb	zero,-20(s0)
	li	a5,1936941056
	addi	a5,a5,368
	sw	a5,-40(s0)
	li	a5,858927104
	addi	a5,a5,292
	sw	a5,-36(s0)
	sb	zero,-32(s0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	printf
	addi	a4,s0,-28
	addi	a5,s0,-40
	mv	a1,a4
	mv	a0,a5
	call	strcmp
	mv	a5,a0
	beq	a5,zero,.L3
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	puts
	j	.L4
.L3:
	call	secret_function
.L4:
	li	a5,0
	mv	a0,a5
	lw	ra,44(sp)
	lw	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 14.2.0"
	.section	.note.GNU-stack,"",@progbits
