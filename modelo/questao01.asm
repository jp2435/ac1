    .data
str1: .asciiz "Digite ate 20 inteiros (zero para terminar):"
str2: .asciiz "Maximo/minimo são: "
    .eqv print_int10, 1
    .eqv print_str,4
    .eqv read_int, 5
    .eqv print_char, 11
    .text
    .globl main

# val -> $t0 | n -> $t1 | min -> $t2 | max -> $t3
main:
      li $t1,0  #n = 0
      li $t2, 0x7FFFFFFF    # min = 0x7FFFFFFF
      li $t3, 0x80000000    # max = 0x80000000


      li $v0, print_str
      la $a0,str1
      syscall               # print_str(str1)

do:
      li $v0,read_int
      syscall               # read_int()
      move $t0,$v0          # val = read_int()
      beq $t0,0, endif      # if(val != 0)

      blt $t0,$t3, endif    #   if(val > max)
      move $t3,$t0            #       max = val
      bgt $t0,$t2, endif    #   if(val < min)
      move $t2,$t0            #       min = val


endif:
      addiu $t1,$t1,1
while:
      bgt $t1,20, endmain   # while( n<20 && val!=0)
      beq $t0,0,endmain
      j do
endmain:
      li $v0,print_str
      la $a0,str2
      syscall               # print_str(str2)
      li $v0,print_int10
      move $a0,$t3
      syscall               # print_int10(max)
      li $v0, print_char
      li $a0, ';'
      syscall               # print_char(';')
      li $v0,print_int10
      move $a0,$t2
      syscall               # print_int10(min)
      jr $ra