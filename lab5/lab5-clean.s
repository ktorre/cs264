# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 5

	.data
# Records consist of 1 String ( 40 char max ), and 2 ints
recordData:	.space	480	# 10 records, 48 bytes per record
tmpRecord:	.space 48	# Used for swapping records
recordText:	.asciiz	"Record"
nameText:	.asciiz	"Name"
ageText:	.asciiz	"Age"
salaryText:	.asciiz	"Salary"
namePrompt:	.asciiz	"Enter name: "
agePrompt:	.asciiz	"Enter age: "
salaryPrompt:	.asciiz	"Enter salary: "
firstRecPrompt:	.asciiz	"First record to swap (1-10): "
secRecPrompt:	.asciiz	"Second record to swap (1-10): "
topLineText:	.asciiz	"\n| R# |                   Name                   | Age |   Salary   "
space:		.asciiz	" "
newLine:	.asciiz	"\n"
vertLine:	.asciiz	"|"
horLine:	.asciiz	"-"

	.globl main
	.text
main:
	jal getRecords
	jal printRecords
	#jal swapRecords
	#jal printRecords
	b exit

getRecords:
	la $t0, recordData
	li $t1, 10 # Number of records
	li $t2, 1  # Record counter for aesthetic purposes
	getRecLoop:
		la $a0, recordText
		li $v0, 4
		syscall
		la $a0, space
		syscall
		move $a0, $t2
		li $v0, 1
		syscall
		la $a0, newLine
		li $v0, 4
		syscall

		la $a0, namePrompt
		syscall
		move $a0, $t0
		li $a1, 40
		li $v0, 8
		syscall
		
		la $a0, agePrompt
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 40( $t0 )
		
		la $a0, salaryPrompt
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 44( $t0 )
		la $a0, newLine
		li $v0, 4
		syscall

		addi $t0, $t0, 48
		addi $t1, $t1, -1
		addi $t2, $t2, 1
		bgtz $t1, getRecLoop
	jr $ra

printRecords:
	# Purpose: Print out a chart with all records
	move $s0, $ra
	jal printHorLine
	la $a0, topLineText
	syscall
	jal printHorLine
	
	la $t0, recordData
	li $t1, 10
	li $t2, 1
	printRecLoop:
		move $a0, $t0
		move $a1, $t2
		jal printLine
		jal printHorLine
		addi $t0, $t0, 48
		addi $t1, $t1, -1
		addi $t2, $t2, 1
		bgtz $t1, printRecLoop
		
	jr $s0

printLine:
	move $s1, $ra
	
	move $t3, $a0 # Current record address
	
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, vertLine
	syscall
	la $a0, space
	syscall

	# Printing record number
	move $a0, $a1
	li $v0, 1
	syscall
	bgt $a1, 9, singleCont
	la $a0, space
	li $v0, 4
	syscall # Print extra space if single digit
	singleCont:	jal printVertLine # Prints " | "
	
	# Printing name
	jal printFillName
	jal printVertLine 

	# Printing Age
	lw $a0, 40( $t3 )
	jal printNum
	jal printVertLine

	# Printing Salary
	lw $a0, 44( $t3 )
	jal printNum

	la $a0, newLine
	li $v0, 4
	syscall
	
	jr $s1

printNum:
	li $v0, 1
	move $t4, $a0
	syscall
	bgt $t4, 99, cont # greater than 100, no extra spaces
	la $a0, space
	li $v0, 4
	syscall
	bgt $t4, 9, cont # 10 - 99 only print one space
	syscall		 # 0 - 9 Print extra space to align
	cont:	jr $ra

printFillName:
	move $t4, $t3
	li $t5, 0 # Length of string
	li $t7, 40 # needed to subtract
	nameLengthLoop: # Get length of string
		lb $t6, 0( $t4 )
		beq $t6, 10, removeNewline
		nameCont: beqz $t6, fillNameCont
		addi $t4, $t4, 1
		addi $t5, $t5, 1
		b nameLengthLoop
	fillNameCont:	sub $t5, $t7, $t5 # Number of spaces needed to fill, 40 - length = extra space left
	
	la $a0, 0( $t3 )
	li $v0, 4
	syscall
	la $a0, space
	nameSpaceLoop:
		beqz $t5, nameSpaceCont
		syscall
		addi $t5, $t5, -1
		b nameSpaceLoop
	nameSpaceCont:	jr $ra
	
removeNewline: # Newline in string was causing formatting issues so we get rid of it
	add $t3, $t3, $t5
	sb $0, 0( $t3 )
	sub $t3, $t3, $t5
	b nameCont
	
printVertLine:
	la $a0, space
	li $v0, 4
	syscall
	la $a0, vertLine
	syscall
	la $a0, space
	syscall
	jr $ra
	
printHorLine:
	li $t3, 68
	la $a0, horLine
	li $v0, 4
	horLineLoop:
		syscall
		addi $t3, $t3, -1
		bgtz $t3, horLineLoop
	jr $ra

exit:
	li $v0, 10
	syscall
