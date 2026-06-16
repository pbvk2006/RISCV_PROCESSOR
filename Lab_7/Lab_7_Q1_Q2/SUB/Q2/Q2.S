.section .data
.global ans # need to declare as a global variable
ans: .space 40
dec: .ascii "kopvmdjhfysitxuqzngbreawlc"

.section .text
.global decrypt # need to declare as a global variable

decrypt:
    # perform decryption over the string cipher_text
    li t1, 0
    la t3, ans
    li s1, 'a'
    li t0, '\n'
    li t6, '\0'
    li t2, 40
    la a1, dec

    loop:
        bge t1, t2, end
        
        lb t4, 0(a0)
        beq t4, t0, end
        beq t4, t6, end
        sub t4, t4, s1

        add t4, t4, a1
        lw t5, 0(t4)
        sw t5, 0(t3)


        addi a0, a0, 1
        addi t3, t3, 1
        addi t1, t1, 1
        j loop
    end:

    li a0, 0
ret

#cipher_text    a0
#substitution   a1