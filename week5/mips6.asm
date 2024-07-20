.data
    Message: .asciiz "Nhap vao xau"
    string: .space 20
    reversed: .space 20
.text
    add $s0, $zero, $zero #index = 0
    la $t2, string  #Luu dia chi cua chuoi vao $t2
read_character:
    li $v0, 12      # ??c m?t ký t?
    syscall
    sb $v0, 0($t2)  # L?u ký t? v?a ??c vào chu?i
    addi $t2, $t2, 1  # D?ch con tr? chu?i sang ph?i
    bnez $v0, read_character  # N?u ký t? khác NULL thì ti?p t?c nh?p
    sb $zero, 0($t2)  # Ghi NULL k?t thúc chu?i
    j reverse_string

reverse_string:
    li $t0, 0
    la $t3, reversed
reverse_loop:
    subi $t2, $t2, 1  # Di chuy?n con tr? chu?i v? phía tr??c
    lb $t4, 0($t2)   # ??c ký t? t? chu?i ban ??u
    beqz $t4, exit   # N?u g?p NULL thì thoát kh?i vòng l?p
    sb $t4, 0($t3)   # L?u ký t? vào chu?i reversed
    addi $t3, $t3, 1   # D?ch con tr? chu?i reversed sang ph?i
    j reverse_loop

exit:
    li $v0, 4
    la $a0, reversed # In chu?i reversed ra màn hình
    syscall
    li $v0, 10   #Thoát
    syscall
