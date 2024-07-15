.text
start:
li $t0,0 # $t0 = 0 neu khong tran so
li $s1, 0x7fffffff
li $s2, 12
addu $s3, $s1, $s2 # s3 = s1 + s2
xor $t1, $s1, $s2 #Kiem tra xem $s1 va $s2 co cung dau khong?
bltz $t1, EXIT #Neu khac dau, exit
xor $t2, $s3, $s1 #Kiem tra xem $s1 va $s3 co cung dau khong
bltz $t2, OVERFLOW #Neu cung dau, exit
j EXIT
OVERFLOW:
li $t0,1 #Neu tran so, $t0 = 1
EXIT: