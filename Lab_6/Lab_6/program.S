.section .data  #A as a1 and the B as a2 register values
.align 4
A: .word 5
B: .word 3

.section .text
.global main

main:
    # Configure CSR registers (medeleg, mstatus, mepc, mtvec, stvec etc.)
    # Execute mret to initiate downward transition to User code
        
        la t0, mtrap_handler
        csrw mtvec, t0

        la t0, strap_handler
        csrw stvec, t0 

        li t0, 256
        csrs medeleg, t0

        li t0, 3
        slli t0, t0, 11
        not t0, t0
        csrr t1, mstatus
        and t1, t1, t0
        csrw mstatus, t1

        la t0, ucode
        csrw mepc, t0

        mret

.align 4
mtrap_handler:
    # Process traps originating from the strap_handler
    # Perform the multiplication operation
    # Flip a0 to 0
    # Set mepc back to strap_handler and execute mret

        mul a1, a1, a2
        li a0, 0
        
        la t0, strap_handler
        csrw mepc, t0

        li t0, 1
        slli t0, t0, 11
        not t0, t0
        csrr t1, mstatus
        and t1, t1, t0
        csrw mstatus, t1

        csrr t6, mstatus
        
        mret

scode:
    # Execute sret to initiate transition to User mode after setting the CSRs

    li t0, 1
    slli t0, t0, 8
    not t0, t0
    csrr t1, sstatus
    and t1, t1, t0
    csrw sstatus, t1
    
    la t0, ucode1
    csrw sepc, t0
    
    sret

.align 4
strap_handler:
    # The Dispatcher
    # Check if a0 == 0 or a0 == 1
    # If a0 == 0: jump to scode (to setup S to U transition)
    # If a0 == 1: execute ecall to jump up to mtrap_handler

        bne a0, zero, asc
        csrr t6, sstatus
    des:
        j scode
    asc:
        ecall

ucode:
    # Note: Handle initial variable loading here if using a single User block

    la t0, A
    lw a1, 0(t0)
    la t0, B
    lw a2, 0(t0)

    li a0, 0
    ecall

ucode1:
    # Perform the addition operation
    # Flip a0 to 1
    # The ecall should invoke the supervisor’s trap handler

    add a1, a1, a2    
    li a0, 1
    ecall