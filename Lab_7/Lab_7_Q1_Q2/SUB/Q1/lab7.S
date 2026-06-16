.section .text.init
.global _start
_start:
    # 1. Initialize Stack Pointer (sp)
    la sp, _stack_top

    # 2. Setup Trap Vectors (mtvec)
    la t0, mtrap_handler
    csrw mtvec, t0

    # 3. Prepare transition to User Mode (mstatus and mepc)
    li t0, 0x1800
    csrc mstatus, t0
    
    la t0, ucode
    csrw mepc, t0

    # 4. Execute mret to jump to ucode
    mret

.section .text
.align 4
mtrap_handler:
    # --- Context Saving ---
    # Save registers used in ucode. In the ideal case should save all registers.
    addi sp, sp, -32
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)
    sw t3, 12(sp)
    sw t4, 16(sp)
    sw t5, 20(sp)
    sw t6, 24(sp)

    # --- Decode mcause ---
    # Implement logic to handle causes 2, 3, 4, 5, 8
    csrr t0, mcause

    li t1, 2
    beq t0, t1, ill_ins

    li t1, 3
    beq t0, t1, b_pt

    li t1, 4
    beq t0, t1, ld_mis

    li t1, 5
    beq t0, t1, ld_flt

    li t1, 8
    beq t0, t1, u_ec

    ill_ins:
        csrr s9, mtval
        csrr t2, mepc
        addi t2, t2, 4
        csrw mepc, t2
        j end

    b_pt:
        li a0, 0xBEEF
        csrr t2, mepc
        addi t2, t2, 4
        csrw mepc, t2
        j end

    ld_mis:
        csrr s10, mtval
        csrr t2, mepc
        addi t2, t2, 4
        csrw mepc, t2
        j end

    ld_flt:
        csrr s11, mepc
        csrr t2, mepc
        addi t2, t2, 4
        csrw mepc, t2
        j end

    u_ec:
        li a0, 0xFEED
        csrr t2, mepc
        addi t2, t2, 4
        csrw mepc, t2
        j end

    end:

    # --- Context Restoration ---
    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    lw t3, 12(sp)
    lw t4, 16(sp)
    lw t5, 20(sp)
    lw t6, 24(sp)
    addi sp, sp, 32

    mret

ucode:
    # --- Sequence of Exception Tests ---
    # Trigger exceptions one after another to test your handler logic
    .word 0x00000000
    ebreak
    la t0, ucode; ld t0, 0(t0)
    li t0, 0x0; ld t1, 0(t0)
    ecall
    j ucode

.section .bss
.align 16
_stack_low:
.space 4096
_stack_top: