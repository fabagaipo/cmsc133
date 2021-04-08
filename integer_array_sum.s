integer_array_sum:  

DBG:	##### DEBUG BREAKPOINT ######

    	addi $v0, $zero, 0   			# Initialize Sum to zero.
	add	$t0, $zero, $zero		# Initialize array index i to zero.
	
for_all_in_array:
	
	slt $t1, $t0, $a1 			# Compare, $t1 = i < sum ? 1 : 0
	beq $t1, $0, end_for_all 		# If i is not < 10, exit the loop
	lw $t1, 0($a0) 				# Load current array element into t1
	add $v0, $v0, $t1 			# Add value to sum
	addi $t0, $t0, 1 			# Increment the count (i)
	addi $a0, $a0, 4 			# Increment current array element pointer
	j for_all_in_array

end_for_all:
	
	jr	$ra						# Return to caller.
