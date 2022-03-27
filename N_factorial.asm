Calculate N! (factorial of N).
Input: one integer N (1<=N<=1000).
Output: factorial of N.

.data
	res: .space 800
	n: .asciiz "Enter number : "
	err: .asciiz "You entered negative number"
	message: .asciiz "Factorial is: "

.text
	main:
		li $v0, 4
		la $a0, n
		syscall
		li $v0, 5
		syscall
		move $t0, $v0
		la $a0, message
		li $v0, 4
		syscall
		move $a0, $t0
		jal factorial
		li $v0,10
		syscall
	factorial:
		li $v1, 0
		move $t0, $a0
		bge $t0, 0, no_error
		li $v0, 4
		la $a0, err
		syscall
		jr $ra
		no_error:
		li $t1, 2
		move $t2, $zero
		addi $t5, $zero, 0
		addi $s0, $zero, 1
		sw $s0, res($t5)
		loop1:
			blt $t0, $t1, loop1_end
			move $t3, $zero
			move $t4, $zero
			loop2:
				bgt $t4, $t2, loop2_end
				mul $s1, $t4, 4
				lw $t6, res($s1)
				mul $t6, $t6, $t0
				add $t3, $t3, $t6
				rem $t8, $t3, 10
				sw $t8, res($s1)
				div $t3, $t3, 10
				addiu $t4, $t4, 1
				j loop2
			loop2_end:
			loop3:
				ble $t3, $zero, loop3_end
				addi $t2, $t2, 1
				rem $t8, $t3, 10
				mul $t9, $t2, 4
				sw $t8, res($t9)
				div $t3, $t3, 10
				j loop3
			loop3_end:	
			subiu $t0, $t0, 1
			j loop1
		loop1_end: 
		loop4:
			blt $t2, 0, loop4_end
			mul $s1, $t2, 4
			lw $t7, res($s1)
			li $v0, 1
			add $a0, $zero, $t7
        		syscall
			subiu $t2, $t2, 1
			j loop4
		loop4_end:
		jr $ra