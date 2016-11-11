# Student: Luke Walsh	    Date: 7 November 2016
# Description:	Reads the integers 4, -4, 64679, and -64679, and loads
#		them into registers $s0 to $s3 respectively, and then
#		performs the following operations.

	.data
	newline:	.asciiz	"\n"
	space:	.asciiz " "
	.globl main
	.text
main:
	addi $s0, 4		# filling in the variables
	addi $s1, -4
	li $s2, 64679
	li $s3, -64679

	move $a0, $s0
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall

	addi $a0, $s1, 0		# print the second number (-4)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall


	addi $a0, $s2, 0		# print the third number (64679)
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall

	addi $a0, $s3, 0		# print the fourth number (-64679)
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	add $a0, $s2, $s3		# pring the addition of $s2 and $s3
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	ori $a0, $s3, 4		# print the "or" between 4 and $s3
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	sll $a0, $s3, 1		# print a shift $s3 one bit left
	li $v0, 1
	syscall
	la $a0, newline
	li $v0, 4
	syscall

	li $v0, 10
	syscall
