.data
	line1:  .asciiz "                                            ************* \n"
	line2:  .asciiz "**************                             *3333333333333*\n"
	line3:  .asciiz "*222222222222222*                          *33333******** \n"
	line4:  .asciiz "*22222******222222*                        *33333*        \n"
	line5:  .asciiz "*22222*      *22222*                       *33333******** \n"
	line6:  .asciiz "*22222*       *22222*      *************   *3333333333333*\n"
	line7:  .asciiz "*22222*       *22222*    **11111*****111*  *33333******** \n"
	line8:  .asciiz "*22222*       *22222*  **1111**      **    *33333*        \n"
	line9:  .asciiz "*22222*      *222222*  *1111*              *33333******** \n"
	line10: .asciiz "*22222*******222222*  *11111*              *3333333333333*\n"
	line11: .asciiz "*2222222222222222*    *11111*               ************* \n"
	line12: .asciiz "***************       *11111*                             \n"
	line13: .asciiz "      ---              *1111**                            \n"
	line14: .asciiz "    / o o \\             *1111****   *****                 \n"
	line15: .asciiz "    \\   > /              **111111***111*                  \n"
	line16: .asciiz "     -----                 ***********     dce.hust.edu.vn\n" 
	MENU: 	.asciiz "\n ----MENU----\n 1.Show picture.\n 2.Show picture without color.\n 3.Change the order.\n 4.Change the color.\n 5.Exit.\n Enter your option(From 1 to 5): "
	ERROR: 	.asciiz "Your option is invalid. Please choose again.\n"
	ColorD: .asciiz "Choose the color of D(From 0 to 9):"
	ColorC: .asciiz "Chooes the color of C(From 0 to 9):"
	ColorE: .asciiz "Choose the color of E(From 0 to 9):"
.text
main:
	# Display the menu
	li $v0, 4
	la $a0, MENU	
	syscall
	
	# Get the user's option
	li $v0, 5 	
	syscall
	
	# Check user input and branch to the corresponding option
	beq $v0, 1, Option1
	beq $v0, 2, Option2
	beq $v0, 3, Option3
	beq $v0, 4, Option4
	beq $v0, 5, Option5
	
	# If input is invalid, print error message and restart
	li $v0, 4
	la $a0, ERROR
	syscall	
	j main
#Function1
Option1:
	li $t0, 0 	# Initialize loop counter i=0
	li $t1, 16	# Set loop limit to 16
	la $a0, line1	#Load address of line1 to $a0
Loop_1:
	beq $t0, $t1, main	# If all rows are printed, return to main menu
	li $v0, 4		#Print line1
	syscall	
	
	addi $a0,$a0, 60 	#Move to the next line
	addi $t0, $t0, 1	# Increment loop counter
	j Loop_1		# Jump back to the start of the loop
	
#Function2
Option2:
	li $t0, 0 		# Initialize row counter i=0
	li $t1, 16		# Set row limit to 16
	la $t2,line1 		# Load address of line1 into $t2
Loop_row:
	beq $t0, $t1, main 	# If all rows are visited, return to main menu
	li $t3, 0 		# Initialize column counter j=0
	li $t4, 60 		# Set column limit to 60
Loop_col:
	beq $t3, $t4, Next_row  # If all columns are visited, go to next row
	lb $t5, 0($t2) 		# Load current byte from memory into $t5
	blt $t5, 48, Print_char	# If character is not a digit, print it
	bgt $t5, 57, Print_char	
	li $t5, 32 		# Replace digit with a space
Print_char:
	li $v0, 11
	move $a0, $t5
	syscall
	
	addi $t2, $t2, 1 	# Move to the next character in the current row
	addi $t3, $t3, 1 	# Increment the column counter
	j Loop_col		# Jump back to column loop
Next_row:
	addi $t0, $t0, 1  	# Increment the row counter
	j Loop_row		# Jump back to row loop
	
#Function3	
Option3:
	li $t0, 0 	# Initialize row counter i = 0
	li $t1, 16 	# Set row limit to 16
	la $t2,line1 	# Load address of line1 into $t2
Loop_row3:
	beq $t0, $t1, main	# If all columns are visited, go to next row
	sb $0, 21($t2) 		# Set the 22nd character in the line to null (end of D)
	sb $0, 42($t2) 		# Set the 43rd character in the line to null (end of C)
	sb $zero, 58($t2) 	# Set the 59th character in the line to null (end of E)
	
	li $v0, 4
	addi $a0, $t2, 43	# Set $a0 to the start of E
	syscall 		# Print the string starting at the 43rd character (E)
	
	li $v0, 11 
	li $a0, 32		# Set $a0 to space character
	syscall 		# Print a space
	
	li $v0, 4
	addi $a0, $t2, 22	# Set $a0 to the start of C
	syscall 		# Print the string starting at the 22nd character (C)
	
	li $v0, 11 
	li $a0, 32		# Set $a0 to space character
	syscall 		# Print a space
		
	li $v0, 4
	add $a0, $t2, $0	# Set $a0 to the start of D (beginning of the line)
	syscall 		# Print the string starting at the beginning of the line (D)
	
	li $v0, 11
	li $a0, 10 		# Set $a0 to newline character
	syscall 		# Print a newline
	
	# Restore original characters
	li $t3, 32		# Set $t3 to space character
	sb $t3, 21($t2) 	# Restore the 22nd character to space
	sb $t3, 42($t2)		# Restore the 43rd character to space
	li $t3, 10		# Set $t3 to newline character
	sb $t3, 58($t2) 	# Restore the 59th character to newline
	
	addi $t0, $t0, 1	# Increment the row counter
	addi $t2, $t2, 60 	# Move to the next row
	j Loop_row3		# Jump back to row loop
	
#Function4
Option4:

D_color:
	li $v0, 4
	la $a0, ColorD
	syscall			# Print the prompt to choose color for D
	li $v0, 5		# Read the user input (color for D)
	syscall			
	blt $v0, 0, D_color	# If input is less than 0, ask again
	bgt $v0, 9, D_color	# If input is less than 0, ask again
	addi $s4, $v0, 48	# Convert the number to its ASCII character equivalent
C_color:
	li $v0, 4
	la $a0, ColorC
	syscall			# Print the prompt to choose color for C
	li $v0, 5		# Read the user input (color for C)
	syscall
	blt $v0, 0, C_color    	# If input is less than 0, ask again
	bgt $v0, 9, C_color    	# If input is greater than 9, ask again
	addi $s5, $v0, 48      	# Convert the number to its ASCII character equivalent
E_color:
	li $v0, 4
	la $a0, ColorE
	syscall			# Print the prompt to choose color for E
	li $v0, 5		# Read the user input (color for E)
	syscall
	blt $v0, 0, E_color   	# If input is less than 0, ask again
	bgt $v0, 9, E_color    	# If input is greater than 9, ask again
	addi $s6, $v0, 48      	# Convert the number to its ASCII character equivalent
Func4:
	li $t0, 0 	# Initialize row counter i = 0
	li $t1, 16 	# Set row limit to 16
	la $t2,line1 	# Load address of line1 into $t2
Loop_row4:
	beq $t0, $t1, main # If all columns are visited, go to next row
	li $t3, 0 	   # Initialize column counter j = 0
	li $t4, 60 	   # Set the maximum column count to 60
Loop_col4:
	beq $t3, $t4, Next_row4	# If all columns are visited, go to next row
	lb $t6, 0($t2)		# Load the current character into $t6
	blt $t3, 21, Check_D	# If column is less than 21, check if it's part of D
	blt $t3, 42, Check_C	# Otherwise, check if it's part of C
	j Check_E		# Otherwise, check if it's part of E
Check_D:
	beq $t6,'2', Change_color_D	# If character is '2' (part of D), change color
	j Print				# Otherwise, print the character
Check_C:
	beq $t6, '1', Change_color_C	# If character is '1' (part of C), change color
	j Print				# Otherwise, print the character
Check_E:
	beq $t6, '3', Change_color_E	# If character is '3' (part of E), change color
	j Print				# Otherwise, print the character
Change_color_D:		
	move $t6, $s4	# Change character to the chosen color for D
	j Print
Change_color_C:
	move $t6, $s5	# Change character to the chosen color for C
	j Print
Change_color_E:
	move $t6, $s6	# Change character to the chosen color for E
	j Print
Print:
	li $v0, 11
	move $a0, $t6	# Move character to $a0	
	syscall

	addi $t2, $t2, 1	# Move to the next character
	addi $t3, $t3, 1	# Increment column counter
	j Loop_col4		# Jump back to column loop
Next_row4:
	addi $t0, $t0, 1	# Increment row counter
	j Loop_row4		# Jump back to row loop
#End program
Option5:
	li $v0, 10
 	syscall


