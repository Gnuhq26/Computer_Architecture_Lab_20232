.eqv SEVENSEG_LEFT 0xFFFF0011 	# Dia chi cua den led 7 doan trai.
 					# Bit 0 = doan a; 
 					# Bit 1 = doan b; ... 
					# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010 	# Dia chi cua den led 7 doan phai
.data
message: .asciiz "Nhap vao mot so nguyen: "
.text
main:
    	li $v0, 4
    	la $a0, message
    	syscall

    	li $v0, 5
    	syscall
    	move $s0, $v0

    	li $t2, 10
    	div $s0, $t2
    	mfhi $t1

    	# So sánh giá tr? c?a t1 v?i các giá tr? t? 0 ??n 9 và hi?n th? t??ng ?ng
    	beq $t1, 0, R0
    	beq $t1, 1, R1
    	beq $t1, 2, R2
    	beq $t1, 3, R3
    	beq $t1, 4, R4
    	beq $t1, 5, R5
    	beq $t1, 6, R6
    	beq $t1, 7, R7
    	beq $t1, 8, R8
    	beq $t1, 9, R9
R0:
    li $a0, 0x3F
    jal SHOW_7SEG_RIGHT
    j sothuhai
R1:
    li $a0, 0x06
    jal SHOW_7SEG_RIGHT
    j sothuhai
R2:
    li $a0, 0x5B
    jal SHOW_7SEG_RIGHT
    j sothuhai
R3:
    li $a0, 0x4F
    jal SHOW_7SEG_RIGHT
    j sothuhai
R4:
    li $a0, 0x66
    jal SHOW_7SEG_RIGHT
    j sothuhai
R5:
    li $a0, 0x6D
    jal SHOW_7SEG_RIGHT
    j sothuhai
R6:
    li $a0, 0x7D
    jal SHOW_7SEG_RIGHT
    j sothuhai
R7:
    li $a0, 0x07
    jal SHOW_7SEG_RIGHT
    j sothuhai
R8:
    li $a0, 0x7F
    jal SHOW_7SEG_RIGHT
    j sothuhai
R9:
    li $a0, 0x6F
    jal SHOW_7SEG_RIGHT
    j sothuhai
sothuhai:
	sub $s0, $s0, $t1
	div $s0, $t2
	mflo $t3
	div $t3, $t2
	mfhi $t1

	beq $t1, 0, L0
    	beq $t1, 1, L1
    	beq $t1, 2, L2
    	beq $t1, 3, L3
    	beq $t1, 4, L4
    	beq $t1, 5, L5
    	beq $t1, 6, L6
    	beq $t1, 7, L7
    	beq $t1, 8, L8
    	beq $t1, 9, L9
L0:
	li $a0, 0x3F
	jal SHOW_7SEG_LEFT
	j exit
L1:
	li $a0, 0x6
	jal SHOW_7SEG_LEFT
	j exit
L2:
	li $a0, 0x5B
	jal SHOW_7SEG_LEFT
	j exit
L3:
	li $a0, 0x4F
	jal SHOW_7SEG_LEFT
	j exit
L4:
	li $a0, 0x66
	jal SHOW_7SEG_LEFT
	j exit
L5:
	li $a0, 0x6D
	jal SHOW_7SEG_LEFT
	j exit
L6:
	li $a0, 0x7D
	jal SHOW_7SEG_LEFT
	j exit
L7:
	li $a0, 0x7
	jal SHOW_7SEG_LEFT
	j exit
L8:
	li $a0, 0x7F
	jal SHOW_7SEG_LEFT
	j sothuhai
L9:
	li $a0, 0x6F
	jal SHOW_7SEG_LEFT
	j exit
exit:
	li $v0, 10
	syscall

endmain:
    	li $v0, 10
    	syscall

#---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_LEFT:
li $t0, SEVENSEG_LEFT # assign port's address
sb $a0, 0($t0) # assign new value
jr $ra
#---------------------------------------------------------------# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] $a0 value to shown
# remark $t0 changed
#---------------------------------------------------------------
SHOW_7SEG_RIGHT:
li $t0, SEVENSEG_RIGHT # assign port's address
sb $a0, 0($t0) # assign new value
jr $ra