string_for_each:

	addi $sp, $sp, -12				# PUSH return address to caller
	sw	$ra, 0($sp)
	sw  $a1, 8($sp)                 # Store $a1
	
	loop2:
	sw  $a0, 4($sp)                 # Store $a0 as it will be used for argument
    lb  $t0, 0($a0)                 # Get current character
    beq $t0, $zero, end_for_each    # Check null character
    jalr  $a1                       # Call callback subroutine
	lw  $a0, 4($sp)                 # Load stored $ao
    lw  $a1, 8($sp)                 # Load stored $a1
    addi $a0, $a0, 1             	# Increment the count for next character in string
    j   loop2

end_for_each:
	lw	$ra, 0($sp)					# Pop return address to caller
	addi $sp, $sp, 12		
	jr	$ra