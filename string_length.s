string_length:
	li $t0, 0 					# Initialize count to zero

	loop1:
	lb $t1, 0($a0) 				# Load next character into $t1
	beq $t1, $zero, end_for_all 		# Check null character
	addi $a0, $a0, 1 			# Increment the string pointer
	addi $t0, $t0, 1 			# Increment the count
	addi $v0, $t0, 0 			# Move length of string to $v0
	
	j loop1 	
	
end_for_all:
	
	jr	$ra						# Return to caller.
