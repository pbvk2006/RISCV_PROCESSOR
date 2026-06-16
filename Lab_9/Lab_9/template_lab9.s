
.section .text
.global main



main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xfb # D | A | G | U | X | - | R |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:
    la t0, r_s
    sd a0, 0(t0)
    sd a1, 8(t0)
    sd a2, 16(t0)
    sd t1, 24(t0)
    sd t2, 32(t0)
    sd t3, 40(t0)
    sd t4, 48(t0)
    sd t5, 56(t0)
    sd t6, 64(t0)

    csrr a0, mcause
    csrr a1, mtval 

    srli t1, a1, 21
    andi t1, t1, 0x1FF
    slli t1, t1, 3
    li t2, 0x82001000
    add t1, t1, t2 

    ld t2, 0(t1)
    andi t3, t2, 1
    bnez t3, l1_vld
    
    la t3, new_l0
    ld t2, 0(t3)
    li t6, 4096
    add t4, t2, t6
    sd t4, 0(t3)
    srli t4, t2, 2       
    ori t4, t4, 1
    sd t4, 0(t1)
    mv t2, t4 

l1_vld:
    srli t3, a1, 12
    andi t3, t3, 0x1FF 
    slli t3, t3, 3
    
    srli t2, t2, 10      
    slli t2, t2, 12 
    add t1, t2, t3

    li t2, 12
    bne a0, t2, data_flt

inst_flt:
    la t2, new_pg
    ld t3, 0(t2)
    add t4, t3, t6
    sd t4, 0(t2)
    
    li a2, 0x80001000 
    mv t4, t3
    li t5, 512
copy_loop:
    ld a0, 0(a2)
    sd a0, 0(t4)
    addi a2, a2, 8
    addi t4, t4, 8
    addi t5, t5, -1
    bnez t5, copy_loop

    srli t3, t3, 2
    ori t3, t3, 0xFB
    j write_pte

data_flt:
    li t3, 0x80002000
    srli t3, t3, 2
    ori t3, t3, 0xF7

write_pte:
    sd t3, 0(t1)
    sfence.vma zero, zero 

    la t0, r_s
    ld a0, 0(t0)
    ld a1, 8(t0)
    ld a2, 16(t0)
    ld t1, 24(t0)
    ld t2, 32(t0)
    ld t3, 40(t0)
    ld t4, 48(t0)
    ld t5, 56(t0)
    ld t6, 64(t0)
    
    mret

###################################################################
###################################################################



.align 12
user_code:
    la t1,var_count
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    la t5, code_jump_position
    lw t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sw t3, 0(t5)
    
    jalr x0, t3


.data
.align 12
var_count:  .word  0
code_jump_position: .word 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000
r_s: .space 72
new_pg: .dword 0x80003000
new_l0: .dword 0x83002000
