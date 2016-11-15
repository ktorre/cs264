    .data
testString: .asciiz "Hello World"
lowerText:  .asciiz "Largest lowercase: "
upperText:  .asciiz "Smallest uppercase: "
newLine:    .asciiz "\n"

    .globl main
    .text
main:
    la $a0, testString
    jal SL
    move $t0, $v0
    move $t1, $v1

    la $a0, lowerText
    move $a1, $t0
    jal printText

    la $a0, upperText
    move $a1, $t1
    jal printText

    li $v0, 10
    syscall

printText:
    li $v0, 4
    syscall
    move $a0, $a1
    li $v0, 11
    syscall
    la $a0, newLine
    li $v0, 4
    syscall
    jr $ra

SL:
    li $v0, 97 # Largest lower
    li $v1, 90 # Smallest upper

    loop:
	lb $t0, 0( $a0 )
	beqz $t0, return
	bgt $t0, 96, chkLower
	bgt $t0, 64, chkUpper
	cont:	addi $a0, $a0, 1
    b loop

    chkUpper:
	blt $t0, $v1, newUpper
	b cont

    chkLower:
	bgt $t0, $v0, newLower
	b cont

    newLower:
	move $v0, $t0
	b cont

    newUpper:
	move $v1, $t0
	b cont

    return: jr $ra

