.data
message: .asciiz "Nhap vao 4 so x1,y1,x2,y2( sau moi lan nhap vao 1 so an enter ) : "
.eqv MONITOR_SCREEN 0x10010000 #Dia chi bat dau cua bo nho man hinh 
.eqv RED 0x00FF0000 #Cac gia tri mau thuong su dung 
.eqv GREEN 0x0000FF00 
.eqv BLUE 0x000000FF 
.eqv WHITE 0x00FFFFFF 
.eqv YELLOW 0x00FFFF00
.text 
li $v0 , 4 
la $a0 , message 
syscall
li $v0 , 5 
syscall 
move $s0 , $v0 
li $v0 , 5 
syscall 
move $s1, $v0 
li $v0 , 5 
syscall 
move $s2, $v0 
li $v0 , 5 
syscall 
move $s3, $v0 #nhap vao du lieu 
main:
blt $s0,$s2,next #if $x1 < x2
move $t0 , $s0
move $s0 , $s2 
move $s2, $t0 
next: 
blt $s1,$s3,solve #if $x1 < x2
move $t1 , $s1
move $s1 , $s3 
move $s3, $t1 
solve:
li $k0, MONITOR_SCREEN 

addi $s0,$s0,-1 
addi $s1,$s1,-1
addi $s2,$s2,-1
addi $s3,$s3,-1

li $a1 , 8 
li $a2 ,4
mul $t0 , $s1, $a1
add $t0 , $t0, $s0 
mul $t0 , $t0 , 4 
add $k0 , $k0 , $t0 

move $k1,$k0 
move $t1,$s1  # i = y1 
loop:
bgt $t1,$s3,end
move $t2,$s0 #j = x1
beq $t1,$s1,loop_print1
beq $t1,$s3,loop_print1
j loop_print2 
loop_print1:
bgt $t2,$s2,next_row
li $t0, RED 
sw $t0, 0($k1) 
addi $t2 ,$t2 ,1 
addi $k1,$k1,4
j loop_print1
loop_print2:
bgt $t2,$s2,next_row
beq $t2,$s0,print1 
beq $t2,$s2,print1 
li $t0 , YELLOW
sw $t0,0($k1)
addi $t2, $t2 ,1 
addi $k1,$k1,4
j loop_print2 
print1:
li $t0 , RED
sw $t0 , 0($k1)
addi $t2 , $t2 ,1 
addi $k1 , $k1 , 4 
j loop_print2
next_row:
addi $t1,$t1 ,1 
addi $k0 , $k0 , 32
move $k1 , $k0 
j loop 
end:
li $v0 , 10 
syscall