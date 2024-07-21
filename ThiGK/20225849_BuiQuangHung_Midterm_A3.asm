.data
mess1: .asciiz "Nhap so nguyen duong N: "    
mess2: .asciiz "Cac so nguyen to nho hon "    
newline: .asciiz "\n"    
space: .asciiz " "   
mess3: .asciiz "Khong co so nt nao"   

.text
.globl main

main:
    # In ra man hinh mess1
    li $v0, 4
    la $a0, mess1
    syscall

    # Doc N tu ban phim
    li $v0, 5
    syscall
    move $t0, $v0 # Luu N vao $t0

    # Kiem tra xem  N <= 2
    ble $t0, 2, exit_program

    # In ra man hinh mess2
    li $v0, 4
    la $a0, mess2
    syscall
    move $a0, $t0 # Truyen N nhu mot doi so
    li $v0, 1
    syscall

    # In ki tu xuong dong \n
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 1
    li $a0, 2
    syscall
    
    li $v0, 4
    la $a0, space
    syscall
    
    # Khoi tao bien dem i bat dau tu 2
    li $t1, 1

loop:
    # Kiem tra xem i co phai so nguyen to khong
    move $a0, $t1 # Truyen i nhu mot doi so
    jal isPrime

    # Neu $s3 == 1 (la so nguyen to), in ra i
    beq $s3, 1, print_prime

    # Tang i len 1: i=i+1
    addi $t1, $t1, 1

    # Kiem tra xem i < N
    blt $t1, $t0, loop

    # Thoat khoi vong lap neu i >= N
    j exit

print_prime:
    # In ra i
    li $v0, 1
    move $a0, $t1
    syscall

    # In ra ki tu khoang trang
    li $v0, 4
    la $a0, space
    syscall

    # Tang i len 1 : i=i+1
    addi $t1, $t1, 1

    # Ki?m tra xem i < N
    blt $t1, $t0, loop

exit:
    li $v0, 10 #Ket thuc chuong trinh
    syscall

exit_program:
    #In ra man hinh mess3
    li $v0, 4
    la $a0, mess3
    syscall

    #Ket thuc chuong trinh
    li $v0, 10
    syscall

# Hàm ki?m tra xem m?t s? có ph?i là s? nguyên t? hay không
isPrime:
    sw $ra, 0($sp) # Luu dia chi tra ve
    li $t2, 2	#Khoi tao so chia la 2
    ble $a0, $t2, not_prime	# Neu so nho hon 2, tra ve 0
    
# Kiem tra tinh chia het
chiahet:
    div $a0, $t2
    mfhi $t3
    beq $t3, $zero, not_prime

    # Tang so chia len 1
    addi $t2, $t2, 1

    #Kiem tra xem ($t2)^2 > i không
    mul $t4, $t2, $t2
    bgt $t4, $a0, prime

    # Neu ($t2)^2 <= i, tiep tuc kiem tra tinh chia het
    j chiahet

prime:
    # la so nguyen to, return 1
    li $s3, 1
    j end

not_prime:
    # khong phai so nt, return 0
    li $s3, 0

end:
    # Khoi phuc dia chi va tra ve
    lw $ra, 0($sp)
    jr $ra
