.data
    A: .word -1,-2,-3,-4,-5,-6    # M?ng c?n s?p x?p
    Aend: .word                      # ??a ch? k?t th�c m?ng (kh?i t?o sau)
.text
    la $a0, A         # $a0 l?u ??a ch? c?a A[0]
    la $a1, Aend
    add $a2, $a0, 4   # $a2 l?u ??a ch? c?a A[1]
    la $a3, Aend
    add $a1, $a1, -4  # $a1 l?u ??a ch? c?a A[n-1]
    j sort            # Nh?y ??n ph?n con s?p x?p

after_sort:
    li $v0, 10        # syscall ?? k?t th�c ch??ng tr�nh
    syscall
end_main:

sort:
    li $s0, 1         # i (v? tr� ph?n t? c?n s?p x?p)
loop:
    li $s1, 0         # Bi?n ki?m tra xem c� c?n ch�n kh�ng?
    add $t0, $s0, $s0        
    add $t0, $t0, $t0
    add $t0, $a0, $t0   # L?y ??a ch? c?a ph?n t? A[i]
    addi $t2, $t0, -4   # L?y ??a ch? c?a ph?n t? A[j] (j = i - 1)
    move $t5, $t0       # $t5 l?u v? tr� s? ch�n (kh?i t?o t?i v? tr� A[i])

loop1:
    lw $t1, 0($t0)     # $t1 l?u gi� tr? c?a A[i]
    lw $t3, 0($t2)     # $t3 l?u gi� tr? c?a A[j]
    slt $t4, $t1, $t3  # N?u A[j] < A[i]
    beq $t4, $zero, tru_tiep  # Th� nh?y ??n j--
    move $t5, $t2      # A[j] > A[j] th� v? tr� ch�n s? l� $t2
    li $s1, 1          # Bi?n ki?m tra = 1

tru_tiep:
    beq $t2, $a0, chen  # N?u j-- ?� ??n v? tr� A[0] th� b?t ??u ch�n
    addi $t2, $t2, -4  # j--
    j loop1

chen:
    beq $s1, 0, print  # Ki?m tra xem A[i] ?� ?�ng v? tr� ch?a? N?u $s1 = 0 th� ?� ?�ng v� in d�y lu�n

loop_chen:
    addi $t0, $t0, -4  # A[j]
    lw $s2, 0($t0)     # L?u A[j] v�o v? tr� A[i]
    sw $s2, 4($t0)
    bne $t0, $t5, loop_chen  # N?u A[j] ch?a ??n v? tr� c?n ch�n th� ti?p t?c
    sw $t1, 0($t5)     # N?u ?� ??n v? tr� ch�n th� th?c hi?n ch�n A[i]

print:
    li $s4, 0          # Bi?n ch? m?c cho vi?c in
print_char:
    la $a0, A
    add $s5, $s4, $s4
    add $s5, $s5, $s5
    add $s5, $a0, $s5
    lw $s6, 0($s5)     # L?u A[j] v�o v? tr� A[i]
    beq $s5, $a3, in_xuong_dong
    li $v0, 1          # In s? nguy�n
    move $a0, $s6
    syscall
    addi $s7, $a3, -4
    beq $s5, $s7, skip
    li $v0, 11         # In k� t? d?u c�ch
    li $a0, ' '
    syscall
    skip:
    addi $s4, $s4, 1  # T?ng bi?n ch? m?c
    j print_char

in_xuong_dong:
    li $v0, 11         # In k� t? xu?ng d�ng
    li $a0, '\n'
    syscall
    la $a0, A

    beq $a1, $a2, after_sort  # Th?c hi?n v�ng l?p ??n A[n-1]
    addi $s0, $s0, 1  # i++
    addi $a2, $a2, 4  # T?ng $a2, th?c hi?n ki?m tra ti?p A[2]
    j loop
