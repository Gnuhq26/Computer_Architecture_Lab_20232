.data
    array: .word 5, 2, 4, 3, 1   # M?ng c?n s?p x?p
    array_size: .word 5          # Kích th??c c?a m?ng

.text
main:
    # L?y kích th??c c?a m?ng
    lw $t0, array_size      # Load kích th??c m?ng vào $t0

    # B?t ??u vòng l?p s?p x?p
    li $t1, 1               # Kh?i t?o ch? s? b?t ??u t? ph?n t? th? 2 c?a m?ng
outer_loop:
    beq $t1, $t0, end_sort  # N?u ch? s? ?ã ?i ??n cu?i m?ng thì k?t thúc vòng l?p

    # L?y giá tr? c?a ph?n t? hi?n t?i trong m?ng
    lw $t2, 0($t1)      # $t2 = array[i]

    # Kh?i t?o bi?n $t3 ?? duy?t qua các ph?n t? ?ã ???c s?p x?p
    move $t3, $t1           # $t3 = i
    li $t4, 0               # Kh?i t?o ch? s? $t4 ?? so sánh v?i giá tr? c?a ph?n t? ?ang xét

inner_loop:
    beq $t4, $zero, insert_element  # N?u ?ã ?i h?t m?ng ?ã s?p x?p thì chèn ph?n t? vào ?úng v? trí
    lw $t5, array($t4)      # $t5 = array[j - 1]
    ble $t5, $t2, insert_element   # N?u ph?n t? tr??c l?n h?n ph?n t? ?ang xét thì chèn vào ?úng v? trí
    addi $t4, $t4, -1       # Di chuy?n v? ph?n t? tr??c ?ó
    j inner_loop

insert_element:
    # Chèn ph?n t? vào v? trí ?úng
    sw $t2, array($t4)      # array[j] = array[i]

    # Di chuy?n t?i ph?n t? ti?p theo trong m?ng ch?a ???c s?p x?p
    addi $t1, $t1, 1        # T?ng ch? s? l?p
    j outer_loop            # Quay l?i vòng l?p ngoài ?? ti?p t?c s?p x?p

end_sort:
    # K?t thúc ch??ng trình
    li $v0, 10              # syscall 10: k?t thúc ch??ng trình
    syscall
