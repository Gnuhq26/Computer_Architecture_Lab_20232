.eqv MONITOR_SCREEN 0x10010000 	#Dia chi bat dau cua bo nho man hinh
.eqv RED 	0x00EC145C		#Cac gia tri mau thuong su dung
.eqv BLUE 	0x000000FF
.eqv WHITE 	0x00FFFFFF
.eqv YELLOW 	0x00FFFF00
.data
row1: .word 0x000000FF,0x00FFFF00,0x000000FF,0x00FFFF00,0x000000FF,0x00FFFF00,0x000000FF,0x00FFFF00
row2: .word 0x00FFFF00,0x000000FF,0x00FFFF00,0x000000FF,0x00FFFF00,0x000000FF,0x00FFFF00,0x000000FF


.text

 	li $k0, MONITOR_SCREEN 	#Nap dia chi bat dau cua man hinh
	li $s0, 8

	la $a0,row1			#Luu dia chi tung dong
	jal print_screen
	la $a0,row2
	jal print_screen
	la $a0,row1
	jal print_screen
	la $a0,row2
	jal print_screen
	la $a0,row1
	jal print_screen
	la $a0,row2
	jal print_screen
	la $a0,row1
	jal print_screen
	la $a0,row2
	jal print_screen
end_main:
	li $v0,10			#ket thuc chuong trinh
	syscall
print_screen:
	li $t1,0
loop_print:
	beq $t1,32,end		#kiem tra xem ket thuc row chua
					#i= 7 ?
			
	add $t4,$a0,$t1		#Lay gia tri cua row[i] => $t0
	lw $t0,0($t4)			#

	add $t3,$k0,$t2		#Luu dia chi man hinh vao $t3
	sw $t0, 0($t3)		#In mau $t0 len dia chi $t3
	
	nop


	addi $t1,$t1,4		#i=i+1
	addi $t2,$t2,4		#tang dia chi man hinh len 4 bit
	j loop_print
end:
	jr $ra


