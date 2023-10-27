    .data
array: .word 7692,23,5, 234
    .eqv SIZE,4
    .eqv print_int10, 1
    .text
    .globl main

# p -> $t0 | pultimo -> $t1 | *p -> $t2 | soma -> $t3
main: li $t3,0         # soma = 0
      la $t0,array      # p = array[0]
      li $t4, SIZE      # $t4 = SIZE
      addi $t4,$t4,-1     # $t4 = SIZE + (-1)
      sll $t4,$t4, 2    # $t4 = 0xC enderço do fim do array
      addu $t1,$t0,$t4 # pultimo = array+ SIZE-1    


while:
    bgtu $t0,$t1,endw #if(p <= pultimo) else jump endW
    lw $t2,0($t0)  # em *p load o conteudo de que está em p
    add $t3,$t3,$t2 # soma = soma + *p (valor)
    addiu $t0,$t0,4 # salto de de 4 em 4 bytes por ser inteiro

    j while
endw:
    li $v0,print_int10
    move $a0, $t3
    syscall # print_int10(soma)
    jr $ra
