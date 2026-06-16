.section .text
.global main

main:
	# Write code here to jump to supervisor mode 
	li t0, 0x1F
    csrw pmpcfg0, t0
    li t0, -1
    csrw pmpaddr0, t0

	la t0, supervisor
	csrw mepc, t0
	li t0, 0x1000
	csrc mstatus, t0
	li t0, 0x800
	csrs mstatus, t0
	li t0, 0x100
	csrs medeleg, t0

	mret

supervisor: 
################ Initialize your page tables here ################
	li t0, 0xad003000
	li t1, 0x1
	li t2, 0xad004000
	srli t2, t2, 2
	or t1, t1, t2
	sd t1, 0(t0)

	li t2, 0xad004000
	li t1, 0xad005000
	srli t1, t1, 2
	ori t1, t1, 0x1
	sd t1, 0(t2)

	li t0, 0xad007000
	srli t0, t0, 2
	ori t0, t0, 0x1
	sd t0, 16(t2)

	li t0, 0xad005000
	li t1, 0xad006000
	srli t1, t1, 2
	ori t1, t1, 0x1
	sd t1, 0(t0)

	li t0, 0xad007000
	li t1, 0xad008000
	srli t1, t1, 2
	ori t1, t1, 0x1
	li t2, 2880			
	add t2, t2, t0
	sd t1, 0(t2)

	li t2, 0xad006000
	li t1, 0xad001000
	srli t1, t1, 2
	ori t1, t1, 0xdf		
	sd t1, 0(t2)

	li t0, 0xad002000
	srli t0, t0, 2
	ori t0, t0, 0xdf		
	sd t0, 8(t2)

	li t0, 0xad008000
	li t1, 0xad000000
	srli t1, t1, 2
	ori t1, t1, 0xcb
	sd t1, 0(t0)

####################################################################

	# Prepare a jump to user mode
	li t0, 0x100
	csrc sstatus, t0

	li t0, 0xad003000
    srli t0, t0, 12
    li t1, 9 << 60
    or t0, t0, t1

    la t1, satp_config
    sd t0, 0(t1)

################ DO NOT MODIFY THESE INSTRUCTIONS ################
	la t1, satp_config # load satp val
	ld t2, 0(t1)
	sfence.vma zero, zero
	csrrw zero, satp, t2
	sfence.vma zero, zero

	li t4, 0
	csrrw zero, sepc, t4
	sret
#################################################################### 

.balign 4096
user_code:
	# Write user code here that does the following:
		# 1. Initialize four variables var1 , var2 , var3 , var4 in the data section with values 1 , 2 , 3 , 4.
		# 2. The user_code must load these variables into t1 , t2 , t3 , t4 registers (for reading during debug mode) and then loop back to itself.
		li t0, 0x1000
		
		ld t1, 0(t0)
		ld t2, 8(t0)
		ld t3, 16(t0)
		ld t4, 24(t0)
	lp:
		j lp
	# Don't forget to align the data section and user_code propely. For assembly directive usage, use the last reference given.



.section .data 
.balign 4096
var1: .dword 1
var2: .dword 2
var3: .dword 3
var4: .dword 4

satp_config: .dword 0
# Set appropriate value for satp here.
