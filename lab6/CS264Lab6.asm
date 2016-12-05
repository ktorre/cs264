
	.data
array: .space 20
prompt: .asciiz"Please enter an 5 integers"
input: .asciiz">>"
smallest: .asciiz"smallest int:"
newline: .asciiz"\n"
entern: .asciiz"Please enter a value greater than 0 for n: "
enterr: .asciiz"Please enter a value greater than or equal to 0 for r:"
combination: .asciiz"The combination is: "
	.globl main
	.text
main:
	la $t0, array
	li $t1, 5
	
	la $a0, prompt
	li $v0, 4
	syscall
	la $a0, newline
	li $v0, 4
	syscall
	
loopR:
	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t0)
	addi $t1, $t1, -1
	addi $t0, $t0, 4
	bgtz $t1, loopR
	
part1:
	la $a0, array
	li $a1, 0
	li $a2, 4
	li $a3, 2
	
	la $a0, smallest
	li $v0, 4
	syscall
	
	jal small

	move $a0, $v0
	li $v0, 1
	syscall
	jal part2
	
		
small:
    la $a0, array
	bne $a1, $a2, recuMin
	mul	$t0, $a1, 4
	add $a0, $a0, $t0
	lw $v0, 0($a0)
	jr $ra

recuMin:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	add $a2, $a2, $a1
	divu $a2, $a2, $a3
	jal small
	sw $v0, 12($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	addi $a1, $a1, 1
	jal small
	lw $t1, 12($sp)
	ble $t1, $v0, returnMin1
	lw $ra, 0($sp)
	addiu $sp, $sp, 16
	jr $ra
returnMin1: move $v0, $t1
            lw $ra, 0($sp)
            addiu $sp, $sp, 16
            jr $ra

	
part2:	
	la $a0, newline
	la $v0, 4
	syscall
	la $a0, entern
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	la $a0, enterr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	
	la $a0, combination
	li $v0, 4
	syscall
	jal comb
	
	move $a0, $v0
	li $v0, 1
	syscall

	b exit
	
comb: 
	bne $t0, $t1,  testc
	li $v0, 1
	jr $ra
testc:
	bgtz $t1, rec
	li $v0, 1
	jr $ra
rec:
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	addi $t0, $t0, -1
	jal comb
	sw $v0, 12($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	addi $t0, $t0, -1
	addi $t1, $t1, -1
	jal comb
	lw $t0, 12($sp)
	add $v0, $v0, $t0
	lw $ra, 0($sp)
	addiu $sp, $sp, 16
	jr $ra
	

	
exit: 
	li $v0 ,10
	syscall
	
