    .data
floatConst: .float 2.59375
    .eqv read_int,5
    .eqv print_float,2
    .text
    .globl main

main:
do:
    li $v0,read_int
    syscall         # read_int()
    move $t0,$v0    # $t0 = read_int()
    mtc1 $t0,$f6
    cvt.s.w $f6,$f6 # float ftp = (float) val
    la $t1, floatConst      #
    l.s $f2, 0($t1)
    mul.s $f0, $f6, $f2 # res = ftp * 2.59375
    mov.s $f12, $f0
    li $v0, print_float
    syscall             # print_float (res)
    mtc1 $0, $f4
    cvt.s.w $f4, $f4
    c.eq.s $f0, $f4
    bc1f do             # while ( res != 0.0)
    li $v0, 0           # return 0
    jr $ra