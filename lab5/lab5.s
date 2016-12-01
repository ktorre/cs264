# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 5

	.data
records: .space	480 # ( 40 char ) + ( 4 int ) + ( 4 int )
tmpRecord:	.space 48
name:	.asciiz	"Name: "
age:	.asciiz "Age: "
salary:	.asciiz	"Salary: "
rec1Prompt:	.asciiz	"Enter first record num: "
rec2Prompt:	.asciiz	"Enter second record num: "
newLine:	.asciiz	"\n"

	.globl main
	.text
main:
	la $t0, records
	li $t1, 10
	
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
	li $t1, 10

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

	la $a0, rec1Prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t2, $v0

	la $a0, rec2Prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t3, $v0

	la $t0, records
	addi $t2, $t2, -1 # Because we're asking for 1-10 input, this'll get it to 0 based
	mul $t2, $t2, 48  # Moves the pointer to the record needed ( 48 bytes each record )
	add $t0, $t0, $t2 # Pointing to first record to be swapped
	la $t4, tmpRecord
	li $t1, 48

	loop3: # Copy first record to tmpRecord
		lw $t5, 0( $t0 )
		sw $t5, 0( $t4 )
		addi $t0, $t0, 4
		addi $t4, $t4, 4
		addi $t1, $t1, -4
		bgtz $t1, loop3
		
	addi $t0, $t0, -48 # Get first record to swap back at head
	la $t4, tmpRecord  # Holding tmpRecord head
	
	la $t2, records # holding second record to swap head of address
	addi $t3, $t3, -1
	mul $t3, $t3, 48
	add $t2, $t2, $t3
	li $t1, 48


	loop4: # Copy second record to first record
		lw $t5, 0( $t2 )
		sw $t5, 0( $t0 )
		addi $t2, $t2, 4
		addi $t0, $t0, 4
		addi $t1, $t1, -4
		bgtz $t1, loop4
	
	addi $t2, $t2, -48	
	li $t1, 48
	loop5: # Copy tmpRecord to second
		lw $t5, 0( $t4 )
		sw $t5, 0( $t2 )
		addi $t4, $t4, 4
		addi $t2, $t2, 4
		addi $t1, $t1, -4
		bgtz $t1, loop5

	la $t0, records
	li $t1, 10

	loop6:
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
		bgtz $t1, loop6

	
	b end

end:
	li $v0, 10
	syscall
		
