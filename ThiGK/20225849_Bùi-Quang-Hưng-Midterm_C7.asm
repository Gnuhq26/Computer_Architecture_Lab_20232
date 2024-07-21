.data
str: .space 100        
mess1: .asciiz "Nhap vao xau ky tu: "
mess2: .asciiz "Xau sau khi chuyen doi: "

.text
main:
    	# Hi?n th? th�ng b�o nh?p chu?i
    	li $v0, 4          
    	la $a0, mess1      
    	syscall
    	# Nh?p chu?i t? b�n ph�m
    	li $v0, 8           
    	la $a0, str         
    	li $a1, 100         
    	syscall
    	# G?i h�m convert
    	la $a0, str         # Load ??a ch? c?a m?ng str v�o $a0
    	jal convert         # G?i h�m convert
    
    	# Hi?n th? k?t qu?
    	li $v0, 4           
    	la $a0, mess2      
    	syscall
    	# Hi?n th? chu?i sau khi chuy?n ??i
    	li $v0, 4           
   	 la $a0, str        
    	syscall
    	# K?t th�c ch??ng tr�nh
    	li $v0, 10          # S? d?ng syscall 10 ?? tho�t ch??ng tr�nh
    	syscall
	# H�m convert
	# ??u v�o: $a0 -??a ch?c?a chu?i c?n chuy?n ??i
	# ??u ra: Chu?i ?� ???c chuy?n ??i
convert:
    	move $t0, $a0       # Sao ch�p ??a ch? c?a chu?i v�o $t0

loop:
    	lb $t1, 0($t0)      # Load k� t? hi?n t?i t? chu?i
    	beqz $t1, done  # N?u g?p k� t? k?t th�c chu?i th� tho�t kh?i v�ng l?p

    	# Ki?m tra n?u l� ch? hoa
    	li $t2, 'A'         # G�n gi� tr? 'A' v�o $t2
    	li $t3, 'Z'         # G�n gi� tr? 'Z' v�o $t3
    	blt $t1, $t2, lowcase 
    	bgt $t1, $t3, lowcase
    	addi $t1, $t1, 32   # Chuy?n ch? hoa th�nh ch? th??ng b?ng c�ch t?ng gi� tr? k� t? l�n 32
    	sb $t1, 0($t0)      # L?u k� t? ?� ???c chuy?n ??i v�o chu?i
    	j continue   # Ti?p t?c v�ng l?p

lowcase:
    	li $t2, 'a'         # G�n gi� tr? 'a' v�o $t2
    	li $t3, 'z'         # G�n gi� tr? 'z' v�o $t3
    	blt $t1, $t2, continue  # N?u k� t? kh�ng ph?i ch? th??ng th� ti?p t?c v�ng l?p
    	bgt $t1, $t3, continue  # N?u k� t? kh�ng ph?i ch? th??ng th� ti?p t?c v�ng l?p
    	addi $t1, $t1, -32  # Chuy?n ch? th??ng th�nh ch? hoa b?ng c�ch gi?m gi� tr? k� t? xu?ng 32
    	sb $t1, 0($t0)      # L?u k� t? ?� ???c chuy?n ??i v�o chu?i

continue:
    	addi $t0, $t0, 1    # Ti?n t?i k� t? ti?p theo trong chu?i
    j loop       # L?p l?i v�ng l?p
done:
    	jr $ra              # Tr? v? ??a ch? tr? v?
