reverse_string:
	blt $a1, 2, end_for_all			#Branch for string length input
	la $t0, 0($a0)					#Load character from address into $t0
	la $t1, 0($a0)					#Load character from address into $t1
	add $t1, $t1, $a1				#Add string length value to $t1
	addi $t1, $t1, -1
	
	reverse_loop:
		lb $t2, 0($t0)				#Save leftmost character into $t0 register
		lb $t3, 0($t1)				#Save rightmost character into $t1 regis
		sb $t3, 0($t0)				#Replace rightmost character with leftmost character
		sb $t2, 0($t1)				#Replace leftmost character with rightmost character
		addi $t0, $t0, 1			#Increment leftmost address by 1
		beq $t0, $t1, end_for_all	#Branch to check if $t0 and $t1 are equal, otherwise end
		addi $t1, $t1, -1			#Decrement rightmost by 1
		beq $t0, $t1, end_for_all
		j reverse_loop