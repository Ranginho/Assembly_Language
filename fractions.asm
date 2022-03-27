Write a program that converts proper fraction to the fraction that cannot be shortened anymore.
Input: two integers (numerator and denominator) that has a maximum value 1000.
Output - fraction that cannot be shortened anymore.

.data
	num1:.asciiz"Enter the first value:"
	num2: .asciiz"Enter the second value:"
	isGCD: .asciiz " is GCD\n"
	fraction: .asciiz " / "
.text
.globl main
main:
    li $v0,4
    la $a0,num1
    syscall
    
    li  $v0, 5      #User Input for num1
    syscall
    move $t0,$v0 #Storing user input in another register since $a0 will be occupied in the next command
    move $t4, $v0 #storing user input in $t4 for dividing final result on GCD
  
    li $v0,4
    la $a0,num2
    syscall

    li  $v0, 5      #User input for num2
    syscall
    move $a1,$v0
    move $a0,$t0    #Transfering the user input for num1 in $a0
    move $t5, $v0 #storing user input in $t5 for dividing final result on GCD

    jal GCD #Calling GCD func
    
    move $t6, $v0 #store GCD in $t6
    
    add $a0,$v0,$zero 
    li $v0,1
    syscall # print result
    
    li $v0, 4
    la $a0, isGCD
    syscall 
    
    div $t4, $t4, $t6
    div $t5, $t5, $t6
    
    li $v0, 1
    add $a0, $t4, $zero
    syscall
    
    li $v0, 4
    la $a0, fraction
    syscall 
    
    li $v0, 1
    add $a0, $t5, $zero
    syscall
    
    li $v0, 10 # exit the program
    syscall
    
GCD:
    #GCD(num1, num2)
    # num1 = $a0
    # num2 = $a1

    addi $sp, $sp, -12
    sw $ra, 0($sp) # Func stored in stack
    sw $s0, 4($sp) # Value stored in stack
    sw $s1, 8($sp) # Value stored in stack

    add $s0, $a0, $zero # s0 = a0 ( value num1 ) 
    add $s1, $a1, $zero # s1 = a1 ( value num2 ) 

    addi $t1, $zero, 0 # $t1 = 0
    beq $s1, $t1, return # if s1 == 0 return

    add $a0, $zero, $s1 # make a0 = $s1
    div $s0, $s1 # num1/num2
    mfhi $a1 # reminder of num1/num2 = to num1%num2

    jal GCD
    
exitGCD:
    lw $ra, 0 ($sp)  # read registers from stack
    lw $s0, 4 ($sp)
    lw $s1, 8 ($sp)
    addi $sp,$sp , 12 # bring back stack pointer
    jr $ra
return:
    add $v0, $zero, $s0 # return $v0 = $s0 ( num1)
    j exitGCD 