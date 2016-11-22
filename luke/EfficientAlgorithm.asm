# Student: Luke Walsh	    Date: 14 November 2016
# Description:	Creates an efficient algorithm that performs multiple tasks

.data
    A:	.word	13, -3, 12, -4, 15, 14, 8, 17, 16, 5
.text
.globl main
main:
    la $t0, A	# A pointer
    li $t1, 10	# counter
Loop1:	lw $t3, 0($t0)
	andi $t2, $t3, 1 #find if the number is odd/even
	bnez $t2, Odd	    #branch if odd
	srl $t3, $t3, 1	    #divide by 2 if even
	sw $t3, 0($t0)	    #put the value back in the array
	j Exit		    #skip the instructions for odd since its even
Odd:	sll $t3, $t3, 1	    #multiply by 2 since its odd
	sw $t3, 0($t0)
Exit:	addi $t0, $t0, 4	    #go to the next value in the array
	addi $t1, $t1, -1
	bnez $t1, Loop1

    la $t0, A
    la $t1, A
    li $t2, 10
    addi $t1, $t1, 4
Loop2:	lw $t4, 0($t0)	#swap the values in the array
	lw $t5, 0($t1)
	sw $t5, 0($t0)
	sw $t4, 0($t1)
	addi $t2, $t2, -1
	addi $t0, $t0, 8
	addi $t1, $t1, 8
	bnez $t2, Loop2

    la $t0, A
    li $t1, 10
Loop3:	li $v0, 1
	lw $a0, 0($t0)	#print the array
	syscall
	li $v0, 11
	li $a0, 32	#print a space
	syscall
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bnez $t1, Loop3

    li $v0, 10	#exit the program
    syscall
