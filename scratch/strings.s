	.data
inText:	.asciiz	"Enter a string: "
str1Text:   .asciiz "String 1: "
str2Text:   .asciiz "String 2: "
endText:    .asciiz "Exiting..."
str1:	.space 100
str2:	.space 100

	.globl main
	.text

main: 
    jal getInput
    b end

getInput:
    move $s0, $ra
    la $a0, str1
    jal getString
    la $a0, str1Text
    la $a1, str1
    jal printString

    la $a0, str2
    jal getString
    la $a0, str2Text
    la $a1, str2
    jal printString
    jr $s0

getString:
    move $t0, $a0
    la $a0, inText
    li $v0,4 
    syscall
    la $v0, 8
    move $a0, $t0
    li $a1, 100
    syscall
    jr $ra

printString:
    # Usage: printString( Text, String )
    li $v0, 4
    syscall
    move $a0, $a1
    syscall
    jr $ra

end:
    la $a0, endText
    li $v0, 4
    syscall
    li $v0, 10
    syscall
