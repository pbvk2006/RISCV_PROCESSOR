.section .data
Array : .word 10,10,10,10,10
size : .word 5

.section .text
.global main

main :
    li t1, 0
    li t2, 0
    li t3, 0
    la t0, size
    lw t6, 0(t0)
    la t0, Array

loop :
    bge t1, t6, out
    
    li t5, 1
    AND t4, t1, t5
    lw t5, 0(t0)

    beq t4, t2, else
        addi t5, t5, -1
        j e_end
    else :
        addi t5, t5, 1
    e_end:
        sw t5, 0(t0)
        addi t0, t0, 4
        addi t1, t1, 1
        j loop

out :
    li a7, 93
    ecall