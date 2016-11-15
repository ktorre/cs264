    .data
inText:		.asciiz	"\nEnter integers ( -1 to stop )\n"
lengthText:	.asciiz	"Length: "
sumText:	.asciiz	"\nSum: "
inPrompt:       .asciiz ">> "
intArray:	.space 400 # Max 100 ints

    .globl main
    .text
main:
    la $a0, inText
    li $v0, 4
    syscall

    la $a0, intArray
    jal Test1
    move $t0, $v0
    la $a0, lengthText
    li $v0, 4
    syscall
    move $a0, $t0
    li $v0, 1
    syscall
    la $a0, sumText
    li $v0, 4
    syscall
    move $a0, $v1
    li $v0, 1
    syscall

    b end

Test1:
    li $t0, 100
    li $t1, 0 # Current length
    li $v1, 0 # Sum

    loop:
	beq $v0, $t0, return
	la $a0, inPrompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	bltz $v0, return
	move $a0, $v0
	addi $a0, $a0, 4
	addi $t1, $t1, 1
	addi $t0, $t0, -1
	add $v1, $v1, $v0
	b loop
    return: 
	move $v0, $t1
	jr $ra

end:
    li $v0, 10
    syscall
