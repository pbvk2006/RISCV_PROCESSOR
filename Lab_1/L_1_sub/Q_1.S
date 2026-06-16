.section .data
A : .word 10
B : .word 5
Array : .word 0,0,0,0,0

.section .text
.global main

main :
    la t0, A
    lw t1, 0(t0)
    la t0, B
    lw t2, 0(t0)

    add t3, t1 ,t2
    la t0, Array
    sw t3, 0(t0)

    sub t3, t1, t2
    la t0, Array
    sw t3, 4(t0)

    AND t3, t1, t2
    la t0, Array
    sw t3, 8(t0)

    OR t3, t1, t2
    la t0, Array
    sw t3, 12(t0)

    not t3, t1
    xor t3, t3, t2
    la t0, Array
    sw t3, 16(t0)

    li a7, 93
    ecall