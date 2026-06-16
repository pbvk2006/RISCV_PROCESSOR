.section .data
Size : .word 6
Array : .word 5,2,9,1,3,6

.section .text
.global main

main :
    la t0, Size
    lw t5, 0(t0)
    addi t5, t5, -1

    loop_1:
        la t0, Array
        li t6, 1
        li t1, 0

        loop_2:
            beq t5, t1 ,end_2

            lw t2, 0(t0)
            lw t3, 4(t0)
            bge t3, t2, else
                sw t2, 4(t0)
                sw t3, 0(t0)
                li t6, 0
            else:

            addi t0, t0, 4
            addi t1, t1, 1
            j loop_2
        end_2:

        beq t6, zero, loop_1

out:
    li a7, 93
    ecall