#------------------------------------------------------
# col 0x1 col 0x2 col 0x4 col 0x8
#
# row 0x1 0 1 2 3
# 0x11 0x21 0x41 0x81
#
# row 0x2 4 5 6 7
# 0x12 0x22 0x42 0x82
#
# row 0x4 8 9 a b
# 0x14 0x24 0x44 0x84
#
# row 0x8 c d e f
# 0x18 0x28 0x48 0x88
#
#------------------------------------------------------
# command row number of hexadecimal keyboard (bit 0 to 3)
# Eg. assign 0x1, to get key button 0,1,2,3
# assign 0x2, to get key button 4,5,6,7
# NOTE must reassign value for this address before reading,
# eventhough you only want to scan 1 row
.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012
# receive row and column of the key pressed, 0 if not key pressed
# Eg. equal 0x11, means that key button 0 pressed.
# Eg. equal 0x28, means that key button D pressed.
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.data
Msg: .asciiz "\n"
.text
main: 	
	li $t1, IN_ADDRESS_HEXA_KEYBOARD
	li $t2, OUT_ADDRESS_HEXA_KEYBOARD
	li $s1, 0 # khoi tao gia tri bien kiem tra
start_polling_1:
	li $t3, 0x01 #Check row 1 with key 0, 1, 2, 3 
	sb $t3, 0($t1 ) # must reassign expected row
	jal polling
start_polling_2:
	li $t3, 0x02 #Check row 2 with key 4, 5, 6, 7
	sb $t3, 0($t1 ) # must reassign expected row
	jal polling
start_polling_3:
	li $t3, 0x04 #Check row 3 with key 8, 9, A, B 
	sb $t3, 0($t1 ) # must reassign expected row
	jal polling
start_polling_4:
	li $t3, 0x08 #Check row 4 with key C, D, E, F 
	sb $t3, 0($t1 ) # must reassign expected row
	jal polling
check_after_polling_4:
	beq $a0, 0x0, print
	j start_polling_1
polling:
	sb $t3, 0($t1 ) # must reassign expected row
	lb $a0, 0($t2) # read scan code of key button
	bne $a0, 0x00, print
	jr $ra
print: 
	li $v0, 34 # print integer (hexa)
	syscall
	li $v0, 4 # Print Msg
	la $a0, Msg
	syscall
sleep: 	
	li $a0, 4000 # sleep 4000ms
	li $v0, 32
	syscall
back_to_polling: 
	j start_polling_1 # continue polling