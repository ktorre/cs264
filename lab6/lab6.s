# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 6 - Recursion and Stack

    .data
intArray:   .space  20
inputText:  .asciiz "Enter 5 integers: "
inPrompt:   .asciiz ">> "
newLine:    .asciiz "\n"
smallText:  .asciiz "\nSmallest integer: "

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
    beq $a1, $a2, baseCase
    la $a0, intArray
    addiu $sp, $sp, -16
    sw $ra, 0( $sp )	    	# Store current address, will be overwritten when recursing so this step necessary
    sw $a1, 4( $sp )
    sw $a2, 8( $sp )

    add $a2, $a1, $a2		# Calculate mid using a middle variable
    div $a2, $a2, 2
    jal Min		# Min 1 = Min( int[] A, low, mid )
    sw $v0, 12( $sp )	# Save result of first min cause $v0, gonna be overwritten and we'd lose min1

    lw $a1, 4( $sp )
    addi $a1, $a1, 1
    lw $a2, 8( $sp )
    jal Min
    # After running second min, $v0 = min2
    
    lw $t0, 12( $sp )	# $t0 = min1
    bgt $t0, $v0, return
    move $v0, $t0
    b return


    baseCase:
	mul $t0, $a1, 4
	add $t0, $t0, $a0
	lw $v0, 0( $a0 )
	jr $ra

    return:
	lw $ra, 0( $sp )
	addiu $sp, $sp, 16
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
	sw $v0, 0( $t0 )
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
