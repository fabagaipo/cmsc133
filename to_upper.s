to_upper:

	lb $t1, 0($a0) 					#Load character from the memory address
    blt $t1, 'a', upper_end			#Two branches: less than or greater than
    bgt $t1, 'z', upper_end			#to check if upper or lower
    sub $t1, $t1, 32				#$t1 = $t1 - 32
    sb $t1, 0($a0) 					#Store back changed $t1 to memory address
	upper_end:
	jr $ra