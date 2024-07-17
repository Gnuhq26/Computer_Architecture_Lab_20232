.eqv HEADING 0xffff8010
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020
.eqv WHEREX 0xffff8030
.eqv WHEREY 0xffff8040
.text
main:
    # Thiết lập giá trị ban đầu
    addi $a0, $zero, 90   # Góc quay ban đầu
    jal ROTATE
    jal GO

    addi $v0,$zero,32     # Giữ chạy bằng cách ngủ trong 1000 ms
    li $a0,15000
    syscall

    # Di chuyển và vẽ hình chữ nhật
    addi $a0, $zero, 90   # Góc quay để di chuyển theo chiều dọc
    jal ROTATE
    jal GO
    jal UNTRACK           # Dừng vẽ dấu vết cũ
    jal TRACK             # Bắt đầu vẽ dấu vết mới
    addi $v0,$zero,32     # Giữ chạy bằng cách ngủ trong 1000 ms
    li $a0,7000
    syscall

    addi $a0, $zero, 270  # Góc quay để di chuyển theo chiều ngang
    jal ROTATE
    jal GO
    addi $v0,$zero,32     # Giữ chạy bằng cách ngủ trong 1000 ms
    li $a0,7000
    syscall

    # Di chuyển để kết thúc vẽ hình chữ nhật và quay trở lại vị trí ban đầu
    jal UNTRACK           # Dừng vẽ dấu vết
    addi $a0, $zero, 0    # Góc quay để quay về vị trí ban đầu
    jal ROTATE
    jal GO
    addi $v0,$zero,32     # Giữ chạy bằng cách ngủ trong 1000 ms
    li $a0,3000
    syscall

    jal STOP             # Dừng robot
    li $v0, 10
    syscall

# Hàm ROTATE: xoay robot với góc được chỉ định
ROTATE:
    li $at, HEADING      # Đặt cổng HEADING
    sw $a0, 0($at)       # Ghi giá trị góc vào cổng
    jr $ra

# Hàm GO: bắt đầu robot di chuyển
GO:
    li $at, MOVING       # Đặt cổng MOVING
    addi $k0, $zero, 1   # Đặt logic 1
    sb $k0, 0($at)       # Ghi vào cổng để bắt đầu di chuyển
    jr $ra

# Hàm STOP: dừng robot
STOP:
    li $at, MOVING       # Đặt cổng MOVING về 0
    sb $zero, 0($at)     # Dừng di chuyển
    jr $ra

# Hàm TRACK: bắt đầu vẽ dấu vết
TRACK:
    li $at, LEAVETRACK   # Đặt cổng LEAVETRACK
    addi $k0, $zero, 1   # Đặt logic 1
    sb $k0, 0($at)       # Ghi vào cổng để bắt đầu vẽ dấu vết
    jr $ra

# Hàm UNTRACK: dừng vẽ dấu vết
UNTRACK:
    li $at, LEAVETRACK   # Đặt cổng LEAVETRACK về 0
    sb $zero, 0($at)     # Dừng vẽ dấu vết
    jr $ra
