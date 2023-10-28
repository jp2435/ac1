    .data

val: .word 8,4,15,-1987,327,-9,27,16
str1: .asciiz "Result is: "
    .eqv SIZE, 8
    .eqv print_int10,1
    .eqv print_string,4
    .eqv print_char,11
    .text
    .globl main

# i -> $t0 | v -> $t1
main:
      li $t0,0  #i = 0
      la $t2, val # p = val[0] (int* p=val[0])
do:

      sll $t3,$t0,2 # ProxEndereço = i*4
      addu $t4, $t2,$t3 # p = p + i
      lw $t7,0,($t4) # *p = val[i] (*p = v)
      move $t1,$t7 # v=*p
      
      li $t5, SIZE # temp0 = SIZE
      srl $t5,$t5,1 # temp0 = temp0/2
      sll $t5,$t5,2 # temp0 = temp0*4 (endereços)
      add $t5,$t4,$t5 # temp0 = i + temp0
      lw $t6,0($t5) # *p2 = val[i+SIZE/2]
      
      move $t7,$t6 # val[i] = val[i+SIZE/2]
      move $t6,$t1 # val[i+SIZE/2] = v
while:
      addi $t0,$t0,1 # ++i
      li $t7,SIZE # temp1 = SIZE
      srl $t7,$t7,1 # temp1 = temp1/2
      bgt $t0,$t7,do # if(++i < (SIZE/2))
end1w:
    li $v0, print_string
    la $a0, str1
    syscall # print_String(str1)
    li $t0,0    # i = 0
doSegundo:
    sll $t3,$t0,2 # Endereço = i*4 (bytes)
    addu $t4,$t2,$t3 # p3= p + i
    lw $t5 ,0($t4) # *p3 = val[i++]
    
    li $v0,print_int10
    move $a0, $t5
    syscall # print_int10(vall[i++])
    addi $t0,$t0,1
    
    li $v0,print_char
    li $a0, ','
    syscall # print_char(',')
whileSegundo:
      li $t7, SIZE # temp2 = SIZE
      bgt $t0,$t7, do
end:
    jr $ra

      



      
      
