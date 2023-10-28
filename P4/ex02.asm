    .data
str: .space 21 # 20 caracteres mais \0
    .eqv SIZE,20
    .eqv read_string,8
    .eqv print_int10,1
    .text
    .globl main

# num -> $t0 | p -> $t1 | *p -> $t2
main:
      li $t0,0 # num = 0
      
      li $v0,read_string
      la $a0,str # str[0]
      li $a1, SIZE
      syscall #read_string(str,SIZE)
      la $t1,str # p = str

while:
      lb $t2,0($t1) # *p = str[i]
      beq $t2,'\0', endw # if(*p = '\0') jump to endWhile
      j if
if:
     blt $t2,'0', else # if(*p>='0') &&
     bgt $t2,'9', else # if(*p<='9')
     addi $t0,$t0,1 # num++
     j else
else:
    addi $t1,$t1,1 # p++ , adcionar o proximo endereço do pointer
    j while
endw:
     move $a0,$t0
     li $v0,print_int10
     syscall #print_int10(num)
     jr $ra