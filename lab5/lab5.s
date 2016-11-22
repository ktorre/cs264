# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 5

	.data
records: .space	480 # ( 40 char ) + ( 4 int ) + ( 4 int )
name:	.asciiz	"Name: "
age:	.asciiz "Age: "
salary:	.asciiz	"Salary: "
newLine:	.asciiz	"\n"

	.globl main
	.text
main:
	la $t0, records
	li $t1, 3 
	
	loop:
		la $a0, name
		li $v0, 4
		syscall
		move $a0, $t0
		li $a1, 40
		li $v0, 8
		syscall
		
		la $a0, age
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 40( $t0 )
		
		la $a0, salary
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 44( $t0 )
		
		addi $t0, $t0, 48
		addi $t1, $t1, -1
		bgtz $t1, loop

	la $t0, records
	li $t1, 3

	loop2:
		la $a0, name
		li $v0, 4
		syscall
		move $a0, $t0
		syscall
		
		la $a0, age
		li $v0, 4
		syscall
		lw $a0, 40( $t0 )
		li $v0, 1
		syscall
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, salary
		li $v0, 4
		syscall
		lw $a0, 44( $t0 )
		li $v0, 1
		syscall
		la $a0, newLine
		li $v0, 4
		syscall

		addi $t0, $t0, 48
		addi $t1, $t1, -1
		bgtz $t1, loop2

	b end

end:
	li $v0, 10
	syscall
		
