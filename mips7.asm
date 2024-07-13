.data
    array: .word 5, 2, 4, 3, 1   # M?ng c?n s?p x?p
    array_size: .word 5          # K�ch th??c c?a m?ng

.text
main:
    # L?y k�ch th??c c?a m?ng
    lw $t0, array_size      # Load k�ch th??c m?ng v�o $t0

    # B?t ??u v�ng l?p s?p x?p
    li $t1, 1               # Kh?i t?o ch? s? b?t ??u t? ph?n t? th? 2 c?a m?ng
outer_loop:
    beq $t1, $t0, end_sort  # N?u ch? s? ?� ?i ??n cu?i m?ng th� k?t th�c v�ng l?p

    # L?y gi� tr? c?a ph?n t? hi?n t?i trong m?ng
    lw $t2, 0($t1)      # $t2 = array[i]

    # Kh?i t?o bi?n $t3 ?? duy?t qua c�c ph?n t? ?� ???c s?p x?p
    move $t3, $t1           # $t3 = i
    li $t4, 0               # Kh?i t?o ch? s? $t4 ?? so s�nh v?i gi� tr? c?a ph?n t? ?ang x�t

inner_loop:
    beq $t4, $zero, insert_element  # N?u ?� ?i h?t m?ng ?� s?p x?p th� ch�n ph?n t? v�o ?�ng v? tr�
    lw $t5, array($t4)      # $t5 = array[j - 1]
    ble $t5, $t2, insert_element   # N?u ph?n t? tr??c l?n h?n ph?n t? ?ang x�t th� ch�n v�o ?�ng v? tr�
    addi $t4, $t4, -1       # Di chuy?n v? ph?n t? tr??c ?�
    j inner_loop

insert_element:
    # Ch�n ph?n t? v�o v? tr� ?�ng
    sw $t2, array($t4)      # array[j] = array[i]

    # Di chuy?n t?i ph?n t? ti?p theo trong m?ng ch?a ???c s?p x?p
    addi $t1, $t1, 1        # T?ng ch? s? l?p
    j outer_loop            # Quay l?i v�ng l?p ngo�i ?? ti?p t?c s?p x?p

end_sort:
    # K?t th�c ch??ng tr�nh
    li $v0, 10              # syscall 10: k?t th�c ch??ng tr�nh
    syscall
