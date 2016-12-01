# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 6 - Recursion and Stack

    .data
inputText:  .asciiz "Enter 5 integers: "
inPrompt:   .asciiz ">> "
newLine:    .asciiz "\n"
smallText:  .asciiz "\nSmallest integer: "
intArray:   .space  20

    .globl main
    .text
main:
    jal getInput
    la $a0, intArray	# Hold my intArray
    li $a1, 0		# Lowest position
    li $a2, 4		# Highest 0-based position
    jal Min
    jal printSmall
    b exit

Min:
    # Usage: Min( int[] A, int low, int high )
    # Purpose: Recursively find smallest number in array

    # Stack visual: |$ra|mid|high|min1| 4-bytes each
    addiu $sp, $sp, -4
    sw $ra, 0( $sp )	    	# Store current address, will be overwritten when recursing so this step necessary
    beq $a1, $a2, baseCase 

    addiu $sp, $sp, -12		# Need to store mid in stack cause we'll lose it next callthrough
    add $t0, $a1, $a2		# Calculate mid using a middle variable
    sw $t0, 0( $sp )		# Need mid to call first min

    sw $a2, 4( $sp )	# Store high in stack, cause we overwrite in first min call
    move $a2, $t0	# Set mid to high for min1
    jal min		# Min 1 = Min( int[] A, low, mid )
    sw $v0, 8( $sp )	# Save result of first min cause $v0, gonna be overwritten and we'd lose min1

    lw $t0, 0( $sp )
    addi $t0, $t0, 1
    move $a1, $t0
    lw $a2, 4( $sp )
    jal min
    # After running second min, $v0 = min2
    
    lw $t0, 8( $sp )	# $t0 = min1
    bgt $t0, $v0, return
    move $v0, $t0
    addiu $sp, $sp, 12
    b return



    baseCase:
	li $v0, 1
	b return

    return:
	lw $ra, 0( $sp )
	addi $sp, $sp, 4
	jr $ra
    
getInput:
    # Purpose: get $inputCount integers from user
    la $a0, inputText
    li $v0, 4
    syscall
    la $a0, newLine
    syscall

    la $t0, intArray
    li $t1, 5 # counter
    inputLoop:
	la $a0, inPrompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $sp, $v0
	addi $t0, $t0, 4
	addi $t1, $t1, -1
	bgtz $t1, inputLoop
    jr $ra

printSmall:
    addiu $sp, $sp, -4
    move $sp, $v0
    la $a0, smallText
    li $v0, 4
    syscall
    move $a0, $sp
    li $v0, 1
    syscall
    addiu $sp, $sp, 4
    jr $ra



exit:
    li $v0, 10
    syscall
