# Student: Luke Walsh	    Date: 21 November 2016
# Description:	Takes in three input values for an array and returns two values, the seed location and the number of seed occurances.

.data
    Array1:	.word	1, -1, 2, -2, 3, -3, 4, -4, 5, -5

    Array2: .word	28, -17, 0, 51, -12, 11, 5, 22, -2, -9, 13, , 16, 2, 1, 36, -13, -32, -71, 101, 30, 130, -120, 13, 11, -91, 14, 48, 53, -50, 44

    Array3: .word	1, 5, 4, 6, 4, 4, 9, 10

.text
.globl main
main:	
    la $a0, Array1
    li $a1, 8
    li $a2, 4
    jal seed
    move $t0, $v0
    move $t1, $v1

    la $a0, Array2
    li $a1, 10
    li $a2, 0
    jal seed
    move $t2, $v0
    move $t3, $v1

    la $a0, Array3
    li $a1, 30
    li $a2, 13
    jal seed
    move $t4, $v0
    move $t5, $v1

    li $v0, 10
    syscall
    
seed:	move $t0, $a0		#hole the array starting value in a temp variable
	move $t1, $a1		#hold the length of the array in a temporary variable
	li $t3, 0		#holds the number of times the seed appears
	li $t4, -1		#holds the location of the seed, and -1 if none
Loop:	lw $t2, 0($t0)
	beq $t2, $a2, equal
	j next
equal:	beqz $t3, first
	addi $t3, $t3, 1
	j next
first:	sub $t4, $a1, $t1	#holds the position of the first seed
	addi $t3, $t3, 1
next:	addi $t1, $t1, -1
	addi $t0, $t0, 4
	beq $zero, $t1, return	#branches the loop if the counter hasnt gone through the full array
	j Loop
return:	move $v0, $t4
	move $v1, $t3
	jr $ra

