.data
str: .space 100        
mess1: .asciiz "Nhap vao xau ky tu: "
mess2: .asciiz "Xau sau khi chuyen doi: "

.text
main:
    	# Hi?n th? thông báo nh?p chu?i
    	li $v0, 4          
    	la $a0, mess1      
    	syscall
    	# Nh?p chu?i t? bàn phím
    	li $v0, 8           
    	la $a0, str         
    	li $a1, 100         
    	syscall
    	# G?i hàm convert
    	la $a0, str         # Load ??a ch? c?a m?ng str vào $a0
    	jal convert         # G?i hàm convert
    
    	# Hi?n th? k?t qu?
    	li $v0, 4           
    	la $a0, mess2      
    	syscall
    	# Hi?n th? chu?i sau khi chuy?n ??i
    	li $v0, 4           
   	 la $a0, str        
    	syscall
    	# K?t thúc ch??ng trình
    	li $v0, 10          # S? d?ng syscall 10 ?? thoát ch??ng trình
    	syscall
	# Hàm convert
	# ??u vào: $a0 -??a ch?c?a chu?i c?n chuy?n ??i
	# ??u ra: Chu?i ?ã ???c chuy?n ??i
convert:
    	move $t0, $a0       # Sao chép ??a ch? c?a chu?i vào $t0

loop:
    	lb $t1, 0($t0)      # Load ký t? hi?n t?i t? chu?i
    	beqz $t1, done  # N?u g?p ký t? k?t thúc chu?i thì thoát kh?i vòng l?p

    	# Ki?m tra n?u là ch? hoa
    	li $t2, 'A'         # Gán giá tr? 'A' vào $t2
    	li $t3, 'Z'         # Gán giá tr? 'Z' vào $t3
    	blt $t1, $t2, lowcase 
    	bgt $t1, $t3, lowcase
    	addi $t1, $t1, 32   # Chuy?n ch? hoa thành ch? th??ng b?ng cách t?ng giá tr? ký t? lên 32
    	sb $t1, 0($t0)      # L?u ký t? ?ã ???c chuy?n ??i vào chu?i
    	j continue   # Ti?p t?c vòng l?p

lowcase:
    	li $t2, 'a'         # Gán giá tr? 'a' vào $t2
    	li $t3, 'z'         # Gán giá tr? 'z' vào $t3
    	blt $t1, $t2, continue  # N?u ký t? không ph?i ch? th??ng thì ti?p t?c vòng l?p
    	bgt $t1, $t3, continue  # N?u ký t? không ph?i ch? th??ng thì ti?p t?c vòng l?p
    	addi $t1, $t1, -32  # Chuy?n ch? th??ng thành ch? hoa b?ng cách gi?m giá tr? ký t? xu?ng 32
    	sb $t1, 0($t0)      # L?u ký t? ?ã ???c chuy?n ??i vào chu?i

continue:
    	addi $t0, $t0, 1    # Ti?n t?i ký t? ti?p theo trong chu?i
    j loop       # L?p l?i vòng l?p
done:
    	jr $ra              # Tr? v? ??a ch? tr? v?
