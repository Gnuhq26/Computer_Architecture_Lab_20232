.data
A: .word -1,2,-4,5,-15,6,-135,7,-3,-20
.text
	li $s1, 10 #n=10
	li $s2, 0 #i=0
	li $s3, 0 #max=0
	la $s4, A
loop:
	slt $t2, $s2, $s1
	beq $t2, $zero, endloop
	add $t1, $s2, $s2
	add $t1, $t1, $t1
	add $t1, $t1, $s4
	lw $t0, 0($t1)
	abs $t0, $t0
	slt $t3, $s3, $t0
	beq $t3, $zero, else
	add $s3, $t0, $zero
else: 
	addi $s2, $s2, 1
	j loop
endloop: