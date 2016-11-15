    .data
intArray:   .word   2, 4, 5, 7, 8, 11, 13, 16, 19, 22, 30, 40
space:	    .asciiz	" "
newLine:    .asciiz	"\n"

    .globl main
    .text

main:
    la $t0, intArray
    li $t1, 12
    li $t2, 3
    li $v0, 1

loop:	
    lw $a0, 0( $t0 )
    syscall
    la $a0, space
    jal printChar
    addi $t1, $t1, -1
    addi $t2, $t2, -1
    addi $t0, $t0, 4
    beqz $t2, printNL 
cont:
    bgtz $t1, loop
    b end

printNL:
    move $t3, $ra
    la $a0, newLine
    jal printChar
    li $t2, 3
    b cont


end:
    li $v0, 10
    syscall

printChar:
    li $v0, 4
    syscall
    li $v0, 1
    jr $ra
