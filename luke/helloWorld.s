# Student: Luke Walsh	    Date: 4 October 2016
# Description: Hello World Program. Prints out the message "Hello World!"

.data
message: .asciiz "Hello World!"

.text
.globl main
main:
    la $a0, message	#message to display
    li $v0, 4		#prepare the syscall
    syscall

    li $v0, 10		#exit command
    syscall		#exit the program
