##############################################################################
#
#  COURSE: CMSC 133; Computer Architecture and Organization
#	
#  DATE: March 29, 2021
#
#  NAME: Fayne Roxenne A. Bagaipo			
#
#
#
##############################################################################

	.data
	
ARRAY_SIZE:
	.word	10	# Change here to try other values (less than 10)
FIBONACCI_ARRAY:
	.word	1, 1, 2, 3, 5, 8, 13, 21, 34, 55
STR_str:
	.asciiz "Hunden, Katten, Glassen"
	
	.globl DBG
	.text

##############################################################################
#
# DESCRIPTION:  For an array of integers, returns the total sum of all
#		elements in the array.
#
# INPUT:        $a0 - address to first integer in array.
#		$a1 - size of array, i.e., numbers of integers in the array.
#
# OUTPUT:       $v0 - the total sum of all integers in the array.
#
##############################################################################
integer_array_sum:  

DBG:	##### DEBUG BREAKPOINT ######

    addi $v0, $zero, 0   			# Initialize Sum to zero.
    add	$t0, $zero, $zero			# Initialize array index i to zero.
	
for_all_in_array:
	
	slt $t1, $t0, $a1 			# Compare, $t1 = i < sum ? 1 : 0
	beq $t1, $0, end_for_all 		# If i is not < 10, exit the loop
	lw $t1, 0($a0) 				# Load current array element into t1
	add $v0, $v0, $t1 			# Add value to sum
	addi $t0, $t0, 1 			# Increment the count (i)
	addi $a0, $a0, 4 			# Increment current array element pointer
	j for_all_in_array

end_for_all:
	
	jr	$ra				# Return to caller.
	
##############################################################################
#
# DESCRIPTION: Gives the length of a string.
#
#       INPUT: $a0 - address to a NUL terminated string.
#
#      OUTPUT: $v0 - length of the string (NUL excluded).
#
#     EXAMPLE: string_length("abcdef") == 6.
#
##############################################################################	


string_length:
	li $t0, 0 				# Initialize count to zero

	loop1:
	lb $t1, 0($a0) 				# Load next character into $t1
	beq $t1, $zero, end_for_all 		# Check null character
	addi $a0, $a0, 1 			# Increment the string pointer
	addi $t0, $t0, 1 			# Increment the count
	addi $v0, $t0, 0 			# Move length of string to $v0
	
	j loop1 						

	
##############################################################################
#
#  DESCRIPTION: For each of the characters in a string (from left to right),
#		call a callback subroutine.
#
#		The callback suboutine will be called with the address of
#	        the character as the input parameter ($a0).
#	
#      	 INPUT: $a0 - address to a NUL terminated string.
#
#		$a1 - address to a callback subroutine.
#
##############################################################################	
string_for_each:

	addi $sp, $sp, -12		# PUSH return address to caller
	sw $ra, 0($sp)
	sw $a1, 8($sp)                 # Store $a1
	
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
	lw	$ra, 0($sp)		# Pop return address to caller
	addi $sp, $sp, 12		
	jr	$ra

##############################################################################
#
#  DESCRIPTION: Transforms a lower case character [a-z] to upper case [A-Z].
#	
#        INPUT: $a0 - address of a character 
#
##############################################################################		
to_upper:

	lb $t1, 0($a0) 				#Load character from the memory address
    	blt $t1, 'a', upper_end			#Two branches: less than or greater than
    	bgt $t1, 'z', upper_end			#to check if upper or lower
    	sub $t1, $t1, 32				#$t1 = $t1 - 32
    	sb $t1, 0($a0) 				#Store back changed $t1 to memory address
	upper_end:
	jr $ra
	
##############################################################################
#
#  DESCRIPTION: Gives the reversal of the string.
#	
#        INPUT: $a0 - address of a character
#		$a1 - length of the string
#
##############################################################################
reverse_string:
	blt $a1, 2, end_for_all				#Branch for string length input
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
		beq $t0, $t1, end_for_all		#Branch to check if $t0 and $t1 are equal, otherwise end
		addi $t1, $t1, -1			#Decrement rightmost by 1
		beq $t0, $t1, end_for_all
		j reverse_loop

##############################################################################
##############################################################################
##
##	  You don't have to change anything below this line.
##	
##############################################################################
##############################################################################

	
##############################################################################
#
# Strings used by main:
#
##############################################################################

	.data

NLNL:	.asciiz "\n\n"
	
STR_sum_of_fibonacci_a:	
	.asciiz "The sum of the " 
STR_sum_of_fibonacci_b:
	.asciiz " first Fibonacci numbers is " 

STR_string_length:
	.asciiz	"\n\nstring_length(str) = "

STR_for_each_ascii:	
	.asciiz "\n\nstring_for_each(str, ascii)\n"

STR_for_each_to_upper:
	.asciiz "\n\nstring_for_each(str, to_upper)\n\n"

	.text
	.globl main

##############################################################################
#
# MAIN: Main calls various subroutines and print out results.
#
##############################################################################	
main:
	addi	$sp, $sp, -4	# PUSH return address
	sw	$ra, 0($sp)

	##
	### integer_array_sum
	##
	
	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_a
	syscall

	lw 	$a0, ARRAY_SIZE
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_b
	syscall
	
	la	$a0, FIBONACCI_ARRAY
	lw	$a1, ARRAY_SIZE
	jal 	integer_array_sum

	# Print sum
	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, NLNL
	syscall
	
	la	$a0, STR_str
	jal	print_test_string

	##
	### string_length 
	##
	
	li	$v0, 4
	la	$a0, STR_string_length
	syscall

	la	$a0, STR_str
	jal 	string_length

	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	##
	### string_for_each(string, ascii)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_ascii
	syscall
	
	la	$a0, STR_str
	la	$a1, ascii
	jal	string_for_each

	##
	### string_for_each(string, to_upper)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_to_upper
	syscall

	la	$a0, STR_str
	la	$a1, to_upper
	jal	string_for_each
	
	la	$a0, STR_str
	jal	print_test_string
	
	li	$v0, 4
	la	$a0, NLNL
	syscall
	
	##
	### reverse_string
	##
	la $a0, STR_str 		#Load address of string
	jal string_length 		#Jump to get the length of string
	add	$a1, $v0, $zero		#Add length of string to $v0

	la $a0, STR_str

	jal reverse_string		#Jump to reverse_string subroutine

	la	$a0, STR_str
	jal	print_test_string	#Print the new reversed string

	lw	$ra, 0($sp)	#POP return address
	addi $sp, $sp, 4	
	
	jr $ra
	
##############################################################################
#
#  DESCRIPTION : Prints out 'str = ' followed by the input string surronded
#		 by double quotes to the console. 
#
#        INPUT: $a0 - address to a NUL terminated string.
#
##############################################################################
print_test_string:	

	.data
STR_str_is:
	.asciiz "str = \""
STR_quote:
	.asciiz "\""	

	.text

	add	$t0, $a0, $zero
	
	li	$v0, 4
	la	$a0, STR_str_is
	syscall

	add	$a0, $t0, $zero
	syscall

	li	$v0, 4	
	la	$a0, STR_quote
	syscall
	
	jr	$ra
	

##############################################################################
#
#  DESCRIPTION: Prints out the Ascii value of a character.
#	
#        INPUT: $a0 - address of a character 
#
##############################################################################
ascii:	
	.data
STR_the_ascii_value_is:
	.asciiz "\nAscii('X') = "

	.text

	la	$t0, STR_the_ascii_value_is

	# Replace X with the input character
	
	add	$t1, $t0, 8	# Position of X
	lb	$t2, 0($a0)	# Get the Ascii value
	sb	$t2, 0($t1)

	# Print "The Ascii value of..."
	
	add	$a0, $t0, $zero 
	li	$v0, 4
	syscall

	# Append the Ascii value
	
	add	$a0, $t2, $zero
	li	$v0, 1
	syscall


	jr	$ra
	
