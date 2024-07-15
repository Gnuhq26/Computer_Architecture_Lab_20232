.text
      addi $s0, $zero, -3 #Gan so de nhan vao thanh ghi $s0
      addi $s1, $zero, 16 #Gan so la luy thua cua 2 vao thanh ghi $s1
      addi $t0, $zero, 1
loop:
      beq $s1,$t0,exit #Neu luy thua cua 2 chi con gia tri la 1 thi end vong lap
      sll $s0, $s0, 1 #Thuc hien tang gtri $s0 len 2 lan
      srl $s1, $s1, 1 #Giam gtri cua $s1 xuong 2 lan
      j loop #Tiep tuc vong lap
exit:
      add $s3, $zero, $s0 #Gan kqua cuoi cung vao thanh ghi $s3      
      
