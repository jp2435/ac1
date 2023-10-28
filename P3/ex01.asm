# soma -> $t0 || value -> $t1 || i -> $t2
    .data
str1: .asciiz "Introduza um numero: "
str2: .asciiz "Valor ignorado\n"
str3: .asciiz "A soma dos positivos e': "
    .eqv print_string, 4
    .eqv read_int, 5
    .eqv print_int10, 1
    .text
    .globl main

main: li $t0,0 # soma = 0
      li $t2,0 # i= 0

while: 
        bge $t2, 5, endw  # while(i<5)
        li $v0, print_string
        la $a0, str1
        syscall # print_string()
        li $v0, read_int
        syscall
        move $t1,$v0 # vcalue = read_int()

if:
        blez $t1,$0, else  # if(value>0)
        add $t0,$t0,$t1 # soma += value

        j endif  # Jump 'endif' para não ler o label else
else:
        li $v0, print_string
        la $a0, str2
        syscall  # print_string
endif:
        addi $t2,$t2,1 # i++

        j while 
endw: 
        li $v0,print_string
        la $a0, str3
        syscall  #printstring(str3)
        li $v0,print_int10
        move $a0,$t0
        syscall # print_int10(soma)
        li $v0,0
        jr $ra



# for: blt $t2, 5, endfor
#     la $a0, str1
#     ori $v0, $0, print_string # $v0 = 4
#     syscall
#     ori $v1, $0, read_int
#     syscall

#     ble $t1,$0,else # if(value > 0)
#     add $t0, $t0, $t1 # soma += value

# else: la $a0, str2
#      ori $v0, $0, print_string
#      syscall
