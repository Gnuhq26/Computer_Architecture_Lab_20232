#Laboratory Exercise 4, Home Assignment 2
.text
addi $s0, $s0, 0x20225849 #load test value for these function
andi $t0, $s0, 0xff000000 #Extract the MSB of $s0
srl $t4, $t0, 24
andi $t1, $s0, 0xffffff00 #Clear LBS of $s0
ori $t2, $t1, 0x000000ff #$t2 = set LBS of $s0
andi $s0, $s0, 0x00000000 #$s0 = 0
