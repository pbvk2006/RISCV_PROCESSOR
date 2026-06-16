.section .data
M1: .word 1,2,3,4,5,6,7,8,9
M2: .word 9,8,7,6,5,4,3,2,1
R : .word 0,0,0,0,0,0,0,0,0

.section .text
.global main

main:
    li t5, 9
    la t6, R
    li t1, 3
    li t2, 0
    li t3, 0

    loop_1:
        beq t5, zero, out

        bne t1, zero, else
        li t1, 3
        li t2, 0
        addi t3, t3, 12
        else:

        li t4, 3
        la a0, M1
        la a1, M2
        add a0, a0, t3
        add a1, a1, t2

        loop_2:
            beq t4, zero, end_2

            lw a2, 0(a0)
            lw a3, 0(a1)

            mul t0, a2, a3
            lw a2, 0(t6)
            add t0, t0, a2
            sw t0, 0(t6)

            addi t4, t4, -1
            addi a0, a0, 4
            addi a1, a1, 12
            j loop_2
        end_2:

        addi t1, t1, -1
        addi t2, t2, 4
        addi t5, t5, -1
        addi t6, t6, 4
        j loop_1

out:
    li a7, 93
    ecall