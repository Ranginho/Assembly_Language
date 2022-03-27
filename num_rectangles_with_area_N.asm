Area of rectange is width*height. How many different rectanges could we have with area N?
Input: One integer N (1 <= N <= 106) - area of rectangle
Output: Number of different rectangles that have area equal to N.

# t0 - N
# t1 - result
# t2 - i (for loop)
# t3 - (i*i)
# t4 - N % i

.data 
	area: .asciiz "Enter area: "
	message: .asciiz "\n square is: "
	finalMsg: .asciiz "Total number of different rectangles: "
.text
	main:
		# user enters area:
		li $v0, 4
		la $a0, area
		syscall
	
		#get the users input(area)
		li $v0, 5
		syscall
		#store the input(area) in $t0:
		move $t0, $v0
		
		#at first counter is zero and it is stored in $t1
		li $t1, 0
		#at first i is 1 and it is storen in $t2
		li $t2, 1
		mul $t3, $t2, $t2 # i*i is stored in $t3
		#while i*i <= N
		while: 
			bge $t3, $t0, exit #if i*i>N then exit
			jal checkNumber #calling method checkNumber 
			addi $t2, $t2, 1 #i++
			mul $t3, $t2, $t2 #i*i
			j while #go back to while
		exit:
			#if every number is checked then print final message and result
			li $v0, 4
			la $a0, finalMsg
			syscall 
		
			li $v0, 1
			add $a0, $t1, $zero
			syscall
		li $v0, 10
		syscall 
	#check if current number can be width of rectangle(for example if i is 5, can 5 be width of rectangle if Srec = 20? if this number can be width,
	#then counter++
	checkNumber:
		# N%i
		div $t0, $t2 
		mfhi $t4
		bne $t4, $zero exitIf # if n % i == 0 then counter++
			addi $t1, $t1, 1
		exitIf:
			jr $ra
