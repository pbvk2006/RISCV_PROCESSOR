.section .data
N   : .word 4
buffer: .space 21 
newline : .asciz "\n"

.section .text
.global main

pri:
    #prologue
        addi sp, sp, -16
        sw a0, 0(sp)
        sw a1, 4(sp)
        sw a2, 8(sp)
        sw ra, 12(sp)

    beq a0, zero, iff_1
        j if_1

        iff_1:
            beq a1, zero, iff_2
            j if_1

            iff_2:
                la t0, buffer
                add t0, t0, a2
                sb zero, 0(t0)

                li a0, 1
                la a1, buffer
                addi a2, t6, 0
                li a7, 64
                ecall

                li a0, 1
                la a1, newline
                li a2, 1
                li a7, 64
                ecall
                j end

    if_1:
        blt zero, a0, iff_3
        j if_2

        iff_3:
            la t0, buffer
            add t0, t0, a2
            sb t4, 0(t0)

            addi a0, a0, -1
            addi a2, a2, 1
            jal ra, pri

            lw a0, 0(sp)
            lw a1, 4(sp)
            lw a2, 8(sp)
    
    if_2:
        blt a0, a1, iff_4
        j if_3

        iff_4:
            la t0, buffer
            add t0, t0, a2
            sb t5, 0(t0)

            addi a1, a1, -1
            addi a2, a2, 1
            jal ra, pri
    
    if_3:


    end:
    #epilogue
        lw a0, 0(sp)
        lw a1, 4(sp)
        lw a2, 8(sp)
        lw ra, 12(sp)
        addi sp, sp, 16
        ret

main:
    la t0, N
    li a2, 0
    lw a0, 0(t0)
    lw a1, 0(t0)
    add t6, a0, a1
    li t4, '('
    li t5, ')'
    

    jal ra, pri

out:
    li a7, 93
    ecall