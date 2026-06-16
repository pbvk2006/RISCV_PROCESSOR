.section .data
N   : .word 58764
res : .word 0
low : .word 0
high: .word 0

.section .text
.global main

sd :
    #prologue
    addi sp, sp, -8
    la t0, low
    lw t6, 0(t0)
    bltu t6, sp, low_sp_1
    sw sp, 0(t0)
    low_sp_1:

    sw a0, 0(sp)
    sw ra, 4(sp)

    blt a0, t1, sd_end

    div a0, a0, t1
    jal ra, sd
    addi t5, a0, 0
    j end

    sd_end:
        li t5, 0
    
    end:
        #epilogue
        lw a0, 0(sp)
        lw ra, 4(sp)
        addi sp, sp, 8
        la t0, high
        lw t6, 0(t0)
        bgeu t6, sp, high_sp
        sw sp, 0(t0)
        high_sp:

        rem a0, a0, t1
        add a0, a0, t5

        la t0, high
        lw a1, 0(t0)

        la t0, low
        lw t6, 0(t0)
        sub a1, a1, t6
        ret


main :
    li t1, 10
    la t0, N
    lw a0, 0(t0)

    la t0, low
    sw sp, 0(t0)

    la t0, high
    sw sp, 0(t0)

    jal ra, sd
    la t0, res
    sw a0, 0(t0)

out:
    li a7, 93
    ecall