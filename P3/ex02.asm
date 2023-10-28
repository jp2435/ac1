    .data
str1: .asciiz "Introduza um numero: "
str2: .asciiz "\nO valor em binário e': "
    .eqv print_string,4
    .eqv read_int,5
    .eqv print_char,11
    .text
    .globl main

# value -> $t0 | bit -> $t1 | i -> $t2
main:
      li $t2,0

      li $v0,print_string
      la $a0,str1
      syscall   # print_String(str1)
      li $v0,read_int
      syscall
      move $t0, $v0  # value = read_int()
      
      li $v0, print_string
      la $a0,str2

for:
    bge $t2, 32, endfor # for(i<32)
    li $t3, 0x80000000
    and $t1,$t0,$t3  # bit = value & $t3
    beq $t1,$0, else # if bit == 0 go else
    li $v0, print_char
    li $a0, '1'
    syscall         # print_char('1')
    j endif
else:
      li $v0, print_char
      li $a0, '0'
      syscall       # print_char('0')
endif:
      sll $t0,$t0,1 # value = value << 1
      addiu $t2,$t2,1 # i++
      j for

endfor:
      jr $ra