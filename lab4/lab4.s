# Author   : Kevin De La Torre
# Class    : CS 264
# Professor: Salloum
# Project  : Lab 4
# Date     : 11-6-2016

	.data
newLine:	.asciiz	"\n"
space:	.asciiz " "
exText:	.asciiz "Explanation:\n\n\n\n\n\n\n\n" # Create some space for explaining the stuff

# vvvvv Not fun to input vvvvv
text1:	.asciiz	"1. srl $t4, $t0, 2: "
text2:	.asciiz	"2. sra $t4, $t0, 2: "
text3:	.asciiz "3. sll $t4, $t0, 1: "
text4:	.asciiz "4. rol $t4, $t0, 2: "
text5:	.asciiz "5. ror $t4, $t0, 2: "
text6:	.asciiz "6. xor $t4, $t0, $t1: "
text7:	.asciiz "7. xor $t4, $t1, -8: "
text8:	.asciiz "8. add $t4, $t0, $t1: "
text9:	.asciiz "9. addu $t4, $t0, $t1: "
text10:	.asciiz "10. mul $t4, $t1, $t2: "
text11:	.asciiz "11. mulo $t4, $t1, $t2: "
text12:	.asciiz "12. mulou $t4, $t0, $t0: "
text13:	.asciiz "13. mulou $t4, $t3, $t3: "
text14:	.asciiz "14. div $t4, $t1, $t0: "
text15:	.asciiz "15. div $t4, $t3, $t0: "
text16:	.asciiz "16. divu $t4, $t1, $t0: "
text17:	.asciiz "17. sub $t4, $t1, $t0: "
text18:	.asciiz "18. subu $t4, $t1, $t0: "
text19a:	.asciiz "19a. mult $t1, $t2 ( hi ) : "
text19b:	.asciiz "19b. mult $t1, $t2 ( low ): "
text20a:	.asciiz "20a. multu $t0, $t3 ( hi ) : "
text20b:	.asciiz "20b. multu $t0, $t3 ( low ): "

# Was thinking of putting explanations into the code itself
# but that sounds like a ton more work that I can easily do externally so I'm not

	.globl main
	.text
main:
	# $t0 = -4
	# $t1 = -2^31
	# $t2 = 2^31 - 1 - due to integer overflow
	# $t3 = 65

	# vvvvv Still no fun but much easier to input than above, copy/paste ftw vvvvv
	la $a0, text1
	jal printText
	srl $t4, $t0, 2
	jal printResult

	la $a0, text2
	jal printText
	sra $t4, $t0, 2
	jal printResult

	la $a0, text3
	jal printText
	sll $t4, $t0, 1
	jal printResult

	la $a0, text4
	jal printText
	rol $t4, $t0, 2
	jal printResult

	la $a0, text5
	jal printText
	ror $t4, $t0, 2
	jal printResult

	la $a0, text6
	jal printText
	xor $t4, $t0, $t1
	jal printResult

	la $a0, text7
	jal printText
	xor $t4, $t1, -8
	jal printResult

	la $a0, text8
	jal printText
	add $t4, $t0, $t1
	jal printResult

	la $a0, text9
	jal printText
	addu $t4, $t0, $t1
	jal printResult

	la $a0, text10
	jal printText
	mul $t4, $t1, $t2
	jal printResult

	la $a0, text11
	jal printText
	mulo $t4, $t1, $t2
	jal printResult

	la $a0, text12
	jal printText
	mulou $t4, $t0, $t0
	jal printResult

	la $a0, text13
	jal printText
	mulou $t4, $t3, $t3
	jal printResult

	la $a0, text14
	jal printText
	div $t4, $t1, $t0
	jal printResult

	la $a0, text15
	jal printText
	div $t4, $t3, $t0
	jal printResult

	la $a0, text16
	jal printText
	divu $t4, $t1, $t0
	jal printResult

	la $a0, text17
	jal printText
	sub $t4, $t1, $t0
	jal printResult

	la $a0, text18
	jal printText
	subu $t4, $t1, $t0
	jal printResult

	la $a0, text19a
	jal printText
	mult $t1, $t2
	mfhi $t4
	jal printResult

	la $a0, text19b
	jal printText
	mflo $t4
	jal printResult

	la $a0, text20a
	jal printText
	multu $t0, $t3
	mfhi $t4
	jal printResult

	la $a0, text20b
	jal printText
	mflo $t4
	jal printResult

	b end

printText:
	move $t4, $ra
	li $v0, 4
	syscall
	jal resetVariables
	jr $t4

printResult:
	move $t5, $ra
	move $a0, $t4
	li $v0, 1
	syscall
	la $a0, space
	li $v0, 4
	syscall
	jal printBinary
	la $a0, newLine
	li $v0, 4
	syscall
	la $a0, exText
	syscall
	jr $t5

resetVariables:
	li $t0, -4
	li $t1, 2
	ror $t1, $t1, 2 # Bitshift $t1 to make it -2^31
	li $t2, -2
	# Following unable get full 2^31 because of integer overflow so it is equal to 2^31 - 1
	ror $t2, $t2, 1 
	li $t3, 65
	jr $ra

printBinary:
	li $t6, 32 # Max loop counter
	li $v0, 1 # Set to print ints
	rol $t4, $t4, 1 # Set 'cursor' to last bit
	loop:
		# Prints bit then shifts left
		andi $a0, $t4, 1
		syscall
		rol $t4, $t4, 1
		addi $t6, $t6, -1
		bgtz $t6, loop
		jr $ra

end:
	li $v0, 10
	syscall
