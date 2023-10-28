    .data
    .eqv SIZE,20
    .eqv read_string, 8
    .eqv print_int10,1
str: .space 21 # 21 Caracteres
    .text
    .globl main

#num -> $t0 | i -> $t1 | str -> $t2 | str[i] -> $t4
main:                   # int main(){
        li $v0, read_string
        la $a0, str
        li $a1, SIZE # tamanho de leitura
        syscall

        li $t0, 0       # num = 0
        li $t1, 0       # i = 0

while:                  # while()
        la $t2, str     #   char* pt = str
        addu $t3, $t2,$t1   # char * pi = str+i    # addu é um add de unsigned
        lb $t4, 0($t3)  #   char cc = *pi
        beq $t4,$0, endw #  if(cc= '\0') break
if:
        blt $t4, '0', endif
        bgt $t4, '9', endif    #if (cc>= '0' && cc<='9')
        addi $t0,$t0,1          #   num++
endif:
        addi $t1,$t1, 1         # i++
        j while
endw:
    li $v0, print_int10
    move $a0,$t0
    syscall                     # print_int10(num)

    li $v0,0
    jr $ra