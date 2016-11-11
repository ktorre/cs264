# Author   : Kevin De La Torre
# Professor: Salloum
# Class    : CS 264
# Date     : 10-19-2016

	.data
intArray:	.space	80 			# Allocate space for 20 ints
initText:	.asciiz	"\nEnter 20 integers\n"
inPrompt:	.asciiz	">> "
smallText:	.asciiz	"\nSmallest int: "
largeText:	.asciiz "\nLargest int: "
divText:	.asciiz	"\nNumber divisible by 4: "

	.globl	main	
	.text

main:	
	jal getInput
	jal print
	b end


getInput:
	# Purpose: Get 20 integers from user
	# Didn't use prpArray for this because to print stuff we'd have to keep overwriting $a0, so I'd have to save to temp anyways
	la $t0, intArray
	li $t1, 20
	la $a0, initText
	li $v0, 4
	syscall
	inLoop:	
		la $a0, inPrompt
		li $v0, 4
		syscall
		li $v0, 5
		syscall
		sw $v0, 0( $t0 )	# Store integer in array
		addi $t0, $t0, 4	# Move array forward 1 int
		addi $t1, $t1, -1	# Decrement counter
		bgtz $t1, inLoop
	jr $ra				# Jump back to main


prpArr:	
	# Usage: prpArr()
	# Purpose: Set up args for functions
	# Note: Every function pretty much uses these same args, so helps when reseting them
	la $a0, intArray		# Load intArray into first argument
	li $a1, 20			# Load array length into second argument
	jr $ra


smallestLargest:	
	# Usage: smallestLargest( intArray, length ) 
	# Purpose: return smallest and largest integer in given array
	# Output: v0: smallest, v1: largest
	lw $t0, 0( $a0 )	
	move $v0, $t0
	move $v1, $t1
	sLoop:	
		lw $t0, 0( $a0 )
		blt $t0, $v0, small
		bgt $t0, $v1, large
	sCont:	addi $a0, $a0, 4
		addi $a1, $a1, -1
		bgtz $a1, sLoop
	jr $ra
	small:	
		move $v0, $t0
		b sCont
	large:	
		move $v1, $t0
		b sCont


divisible:
	# Usage: divisible( intArray, length )
	# Purpose: Return number of integers divisible by 4

	# Implementation: A number is divisible by 2^n, if rightmost n bits all equal 0
	# so we left shift to get rid of all bits except the final 2 bits in this case ( because were checking for 2^2/4 )
	# and if we're left with 0 as the final number, it means the number was divisible by 4

	# Note: I'm sure there are other ways of doing this but bitshifting's cool
	li $v0, 0			# div counter
	dLoop:	
		lw $t0, 0( $a0 )
		beqz $t0, dCont		# Skip num if it equals 0
		sllv $t0, $t0, 30	# Left shift integer by 30, if it equals 0 means last 2 bits were 0 and was divisible
		beqz $t0, divAdd
	dCont:	addi $a0, $a0, 4
		addi $a1, $a1, -1
		bgtz $a1, dLoop
	jr $ra
	divAdd:	
		add $v0, $v0, 1
		b dCont			# Branch to dCont so it'll decrement and move array in main loop


print:		
	# Usage: print()
	# Purpose: Print required text
	move $t2, $ra			# I have to save the $ra because I'm calling helper functions from in here and they overwrite $ra when called
	jal prpArr
	jal smallestLargest
	move $t0, $v0			# Smallest
	move $t1, $v1			# Largest

	la $a0, smallText
	move $a1, $t0
	jal printText

	la $a0, largeText
	move $a1, $t1
	jal printText
	
	jal prpArr
	jal divisible			# v0 = div counter
	la $a0, divText
	move $a1, $v0
	jal printText

	jr $t2

printText:
	# Usage: printNum( string, int )
	# Purpose: Didn't want to have to keep rewriting this
	li $v0, 4
	syscall
	move $a0, $a1
	li $v0, 1
	syscall
	jr $ra

end:	
	# Purpose: Exit program
	li $v0, 10
	syscall
