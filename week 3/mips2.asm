#Laboratory 3, Home Assigment 2
.data
	A: .word 3,5,7,-20,9,11
.text
	li,$t1,6
	li,$t2,0 #sum=0
	li,$t3,0, #i=0
	la $t4,A #luu dc cua mang A vao t4
loop:
	slt $s1,$t2,$zero #if sum<0 --> s1=1
	bne $s1,$zero, endloop
	add $s2, $t3, $t3 
	add $s2,$s2,$s2
	add $s2, $s2, $t4 #store address of A[i]
	lw $s0, 0($s2)
	add $t2, $t2, $s0 #sum = sum + A[i]
	addi $t3, $t3, 1
	j loop
endloop:
	