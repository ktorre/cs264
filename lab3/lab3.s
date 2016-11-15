#   Author   : Kevin De La Torre
#   Class    : CS264
#   Professor: Salloum
#   Project  : Lab 3
#   Purpose  : Get a string from the user, then output frequency of upper/lowercase letters, and spaces. Finally output if it is a palindrome or not

	.data
inText:	.asciiz "\nEnter a string: "
upText:	.asciiz	"\nUppercase frequency   : "
lwText:	.asciiz	"\nLowercase frequency   : "
spText:	.asciiz	"\nSpace frequency       : "
msText:	.asciiz	"\nOther Letter Frequency: "
palTxt:	.asciiz	"\nIs Palindrome         : "
boolT:	.asciiz	"True\n"
boolF:	.asciiz	"False\n"

inStr:	.space	100 # Allocate space for 100 characters

	.globl main
	.text
main:
    # $s0 = inStr
    # $s1 = inStr.length
    # $s2 = isPalindrome()
    # $s3 = upperFrequency
    # $s4 = lowerFrequency
    # $s5 = spaceFrequency
    # $s6 = otherFrequency

    la $s0, inStr
    jal getString
    jal isPalindrome
    jal countFrequency
    jal printOutput
    b end

getString:
    # Usage: getString()
    la $a0, inText
    li $v0, 4
    syscall
    li $v0, 8
    la $a0, inStr
    li $a1, 100
    syscall
    move $t0, $ra
    jal getLength
    addi $s1, $s1, -1
    jr $t0

getLength: 
    # Usage: getLength()
    li $s1, 0
    la $t1, 0( $s0 )
    aLoop:
	lb $t2, 0( $t1 )
	beqz $t2, return
	addi $s1, $s1, 1
	addi $t1, $t1, 1
	b aLoop
return:	jr $ra

isPalindrome:
    move $t5, $ra
    li $s2, 1		# Default to true, so if string empty it'll be considered palindrome
    la $t0, 0( $s0 )	# Head of string
    la $t1, 0( $s0 )	# Tail of string
    add $t1, $t1, $s1
    addi $t1, $t1, -1
    move $t2, $s1	# Counter
    addi $t2, $t2, -1
    pLoop:
	beqz $t2, return

	lb $t3, 0( $t0 )
	move $a0, $t3
	jal convertLower
	move $t3, $v0

	lb $t4, 0( $t1 )
	move $a0, $t4
	jal convertLower
	move $t4, $v0

	bne $t3, $t4, pEnd
	addi $t0, $t0, 1
	addi $t1, $t1, -1
	addi $t2, $t2, -1
	b pLoop
    pEnd:
	li $s2, 0
	jr $t5

convertLower:
    # Usage: convertLower( char )
    # Purpose: Converts char to lowercase if it's uppercase
    move $v0, $a0
    bgt $v0, 90, return
    blt $v0, 65, return
    addi $v0, $v0, 32
    b return


countFrequency:
    li $s3, 0		# Uppercase 
    li $s4, 0		# Lowercase 
    li $s5, 0		# Spaces
    li $s6, 0		# Others
    addi $s6, $s6, -1	# Need to subtract 1 from others because it's counting newline from inStr
    la $t0, 0( $s0 )

    cLoop:
	lb $t1, 0( $t0 )
	beqz $t1, return
	beq $t1, 32, space
	blt $t1, 90, chkUp
	blt $t1, 122, chkLow
	other:	addi $s6, $s6, 1
	fCont:
	    addi $t0, $t0, 1
	b cLoop

	space:
	    addi $s5, $s5, 1
	    b fCont
	
	chkUp:
	    blt $t1, 65, other
	    addi $s3, $s3, 1
	    b fCont
	
	chkLow:
	    blt $t1, 97, other
	    addi $s4, $s4, 1
	    b fCont
    
    
printOutput:
    move $t0, $ra

    la $a0, upText
    move $a1, $s3
    jal printString

    la $a0, lwText
    move $a1, $s4
    jal printString

    la $a0, spText
    move $a1, $s5
    jal printString

    la $a0, msText
    move $a1, $s6
    jal printString

    jal printPalindrome
    jr $t0

printPalindrome:
    la $a0, palTxt
    li $v0, 4
    syscall
    beqz $s2, pFalse
    b pTrue
    pFalse:
	la $a0, boolF
	b pCont
    pTrue: 
	la $a0, boolT
    pCont:
	li $v0, 4
	syscall
	b return
    
printString:
    # Usage: printString( text, int  )
    li $v0, 4
    syscall
    move $a0, $a1
    li $v0, 1
    syscall
    jr $ra

end:
    li $v0, 10
    syscall
