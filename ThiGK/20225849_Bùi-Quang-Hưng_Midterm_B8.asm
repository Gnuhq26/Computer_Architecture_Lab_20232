.data
array: .space 100      # Khai báo m?ng có th? ch?a t?i ?a 100 ph?n t?
prompt: .asciiz "Nhap so phan tu : "
msg_input: .asciiz "Nhap phan tu thu  "
msg_neg_max: .asciiz "Phan tu am lon nhat la  "
msg_pos: .asciiz " tai vi tri  "
msg_not_found: .asciiz "K co phan tu am "
 
.text
main:
    # In ra thông báo yêu c?u nh?p s? ph?n t? c?a m?ng
    li $v0, 4
    la $a0, prompt
    syscall
 
    # Nh?p s? ph?n t? c?a m?ng t? bàn phím
    li $v0, 5
    syscall
    move $t0, $v0  # L?u s? ph?n t? vào $t0
 
    # Nh?p các ph?n t? c?a m?ng t? bàn phím
    la $t1, array   # ??a ch? b?t ??u c?a m?ng
    li $t2, 0       # Bi?n ??m cho vòng l?p nh?p
 
input_loop:
    bge $t2, $t0, find_max_neg   # N?u ?ã nh?p ?? s? ph?n t? thì chuy?n sang tìm ph?n t? âm l?n nh?t
    addi $t3, $t2, 1  # S? th? t? c?a ph?n t? ?ang nh?p (b?t ??u t? 1)
    li $v0, 4
    la $a0, msg_input
    syscall
    move $a0, $t3  # In ra s? th? t? c?a ph?n t? ?ang nh?p
    li $v0, 1
    syscall
    li $v0, 5
    syscall
    sw $v0, ($t1)   # L?u ph?n t? vào m?ng
    addi $t1, $t1, 4  # ??a ch? c?a ph?n t? ti?p theo trong m?ng
    addi $t2, $t2, 1  # T?ng bi?n ??m
    j input_loop
 
find_max_neg:
    la $t1, array   # L?y ??a ch? b?t ??u c?a m?ng
    li $t2, 0       # Bi?n ??m cho vòng l?p ki?m tra
    li $t4, -99999999 # Kh?i t?o giá tr? l?n nh?t là giá tr? âm nh? nh?t có th?
    li $t5, -1      # Bi?n l?u v? trí c?a ph?n t? âm l?n nh?t, ban ??u ??t là -1
 
find_max_neg_loop:
    bge $t2, $t0, print_result   # N?u ?ã ki?m tra h?t các ph?n t? trong m?ng thì in k?t qu?
    lw $t3, ($t1)   # Load ph?n t? t? m?ng
    bltz $t3, check_max_neg    # N?u ph?n t? là s? âm thì ki?m tra
    addi $t1, $t1, 4  # Chuy?n sang ki?m tra ph?n t? ti?p theo
    addi $t2, $t2, 1  # T?ng bi?n ??m
    j find_max_neg_loop
 
check_max_neg:
    bgt $t3, $t4, update_max_neg  # N?u ph?n t? hi?n t?i l?n h?n ph?n t? âm l?n nh?t hi?n t?i thì c?p nh?t
    addi $t1, $t1, 4  # Chuy?n sang ki?m tra ph?n t? ti?p theo
    addi $t2, $t2, 1  # T?ng bi?n ??m
    j find_max_neg_loop
 
update_max_neg:
    move $t4, $t3   # C?p nh?t giá tr? l?n nh?t
    move $t5, $t2   # L?u v? trí c?a ph?n t? âm l?n nh?t
    addi $t1, $t1, 4  # Chuy?n sang ki?m tra ph?n t? ti?p theo
    addi $t2, $t2, 1  # T?ng bi?n ??m
    j find_max_neg_loop
 
print_result:
    li $v0, 4
    la $a0, msg_neg_max
    syscall
    li $v0, 1
    move $a0, $t4
    syscall
    li $v0, 4
    la $a0, msg_pos
    syscall
    li $v0, 1
        addi $t5,$t5,1
    move $a0, $t5
    syscall
    j exit
 
exit:
    li $v0, 10
    syscall