	.file	"matmul.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC10:
	.string	"checksum=%f\n"
.LC11:
	.string	"cycles=%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6646:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	cmpl	$1, %edi
	jle	.L50
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %ebx
	testl	%eax, %eax
	jle	.L51
	movslq	%eax, %r13
	movl	$8, %esi
	movq	%rax, (%rsp)
	movq	%r13, %r14
	imulq	%r13, %r14
	movq	%r14, %rdi
	call	calloc@PLT
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%rax, %rbp
	call	calloc@PLT
	movl	$8, %esi
	movq	%r14, %rdi
	movq	%rax, %r12
	call	calloc@PLT
	testq	%rbp, %rbp
	movq	%rax, %r10
	sete	%al
	testq	%r12, %r12
	sete	%dl
	orb	%dl, %al
	jne	.L6
	testq	%r10, %r10
	je	.L6
	movq	(%rsp), %r9
	movl	%r9d, %esi
	imull	%r9d, %esi
	leal	-1(%rsi), %ecx
	cmpl	$2, %ecx
	jbe	.L27
	movdqa	.LC6(%rip), %xmm2
	pxor	%xmm7, %xmm7
	movl	%esi, %edx
	movdqa	.LC0(%rip), %xmm5
	movdqa	%xmm7, %xmm8
	shrl	$2, %edx
	movq	%rbp, %rax
	movdqa	.LC5(%rip), %xmm3
	pcmpgtd	%xmm2, %xmm8
	salq	$5, %rdx
	movdqa	.LC7(%rip), %xmm4
	movdqa	%xmm5, %xmm6
	addq	%rbp, %rdx
.L8:
	movdqa	%xmm6, %xmm0
	movdqa	%xmm7, %xmm9
	movdqa	%xmm8, %xmm10
	addq	$32, %rax
	pcmpgtd	%xmm0, %xmm9
	pmuludq	%xmm0, %xmm10
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm2, %xmm1
	movdqa	%xmm8, %xmm11
	paddd	%xmm3, %xmm6
	pmuludq	%xmm2, %xmm9
	paddq	%xmm10, %xmm9
	movdqa	%xmm7, %xmm10
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm1
	movdqa	%xmm0, %xmm9
	psrlq	$32, %xmm9
	pcmpgtd	%xmm9, %xmm10
	pmuludq	%xmm9, %xmm11
	pmuludq	%xmm2, %xmm9
	pmuludq	%xmm2, %xmm10
	paddq	%xmm11, %xmm10
	psllq	$32, %xmm10
	paddq	%xmm10, %xmm9
	shufps	$221, %xmm9, %xmm1
	pshufd	$216, %xmm1, %xmm1
	psrad	$3, %xmm1
	movdqa	%xmm1, %xmm9
	pslld	$4, %xmm9
	paddd	%xmm9, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm4, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	pshufd	$238, %xmm0, %xmm0
	movups	%xmm1, -32(%rax)
	cvtdq2pd	%xmm0, %xmm0
	movups	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L8
	movl	%esi, %edi
	andl	$-4, %edi
	testb	$3, %sil
	je	.L26
.L7:
	movl	%edi, %eax
	movl	$17, %r8d
	pxor	%xmm0, %xmm0
	movslq	%edi, %r14
	cltd
	leaq	0(,%r14,8), %r11
	idivl	%r8d
	leal	1(%rdi), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 0(%rbp,%r14,8)
	cmpl	%esi, %eax
	jge	.L10
	cltd
	pxor	%xmm0, %xmm0
	idivl	%r8d
	leal	2(%rdi), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 8(%rbp,%r11)
	cmpl	%eax, %esi
	jle	.L48
	cltd
	pxor	%xmm0, %xmm0
	movdqa	.LC0(%rip), %xmm5
	movdqa	.LC5(%rip), %xmm3
	idivl	%r8d
	movdqa	.LC6(%rip), %xmm2
	movdqa	.LC7(%rip), %xmm4
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 16(%rbp,%r11)
.L26:
	pxor	%xmm6, %xmm6
	movl	%esi, %edx
	movq	%r12, %rax
	movsd	.LC9(%rip), %xmm8
	movdqa	%xmm6, %xmm7
	shrl	$2, %edx
	pcmpgtd	%xmm2, %xmm7
	salq	$5, %rdx
	unpcklpd	%xmm8, %xmm8
	addq	%r12, %rdx
.L13:
	movdqa	%xmm5, %xmm0
	movdqa	%xmm6, %xmm9
	movdqa	%xmm7, %xmm10
	addq	$32, %rax
	pcmpgtd	%xmm0, %xmm9
	pmuludq	%xmm0, %xmm10
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm2, %xmm1
	movdqa	%xmm7, %xmm11
	paddd	%xmm3, %xmm5
	pmuludq	%xmm2, %xmm9
	paddq	%xmm10, %xmm9
	movdqa	%xmm6, %xmm10
	psllq	$32, %xmm9
	paddq	%xmm9, %xmm1
	movdqa	%xmm0, %xmm9
	psrlq	$32, %xmm9
	pcmpgtd	%xmm9, %xmm10
	pmuludq	%xmm9, %xmm11
	pmuludq	%xmm2, %xmm9
	pmuludq	%xmm2, %xmm10
	paddq	%xmm11, %xmm10
	psllq	$32, %xmm10
	paddq	%xmm10, %xmm9
	shufps	$221, %xmm9, %xmm1
	pshufd	$216, %xmm1, %xmm1
	psrad	$3, %xmm1
	movdqa	%xmm1, %xmm9
	pslld	$4, %xmm9
	paddd	%xmm9, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm4, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	mulpd	%xmm8, %xmm1
	pshufd	$238, %xmm0, %xmm0
	cvtdq2pd	%xmm0, %xmm0
	mulpd	%xmm8, %xmm0
	movups	%xmm1, -32(%rax)
	movups	%xmm0, -16(%rax)
	cmpq	%rax, %rdx
	jne	.L13
	movl	%esi, %ecx
	andl	$-4, %ecx
	testb	$3, %sil
	je	.L14
	movl	%ecx, %eax
	movl	$17, %edi
	pxor	%xmm0, %xmm0
	movslq	%ecx, %r11
	cltd
	movsd	.LC9(%rip), %xmm1
	leaq	0(,%r11,8), %r8
	idivl	%edi
	leal	1(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, (%r12,%r11,8)
	cmpl	%esi, %eax
	jge	.L14
	cltd
	pxor	%xmm0, %xmm0
	idivl	%edi
	leal	2(%rcx), %eax
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 8(%r12,%r8)
	cmpl	%esi, %eax
	jge	.L14
	cltd
	pxor	%xmm0, %xmm0
	idivl	%edi
	addl	$1, %edx
	cvtsi2sdl	%edx, %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, 16(%r12,%r8)
.L14:
	rdtsc
	xorl	%edi, %edi
	salq	$32, %rdx
	movq	%r12, (%rsp)
	movq	%r13, %r8
	movl	%r9d, %r14d
	orq	%rdx, %rax
	movl	%esi, 52(%rsp)
	salq	$4, %r8
	movq	%r10, %rdx
	movq	%rax, 32(%rsp)
	movl	%r9d, %eax
	leaq	0(,%r13,8), %r15
	shrl	%eax
	movq	%r10, 40(%rsp)
	salq	$4, %rax
	movq	%r10, 56(%rsp)
	movq	%rax, 8(%rsp)
	movl	%r9d, %eax
	andl	$-2, %eax
	movl	%eax, 48(%rsp)
	movl	%r9d, %eax
	andl	$1, %eax
	movl	%eax, 20(%rsp)
	.p2align 4,,10
	.p2align 3
.L15:
	movq	%rdx, 24(%rsp)
	movq	%rbp, %r9
	movq	%rdx, %r10
	xorl	%ecx, %ecx
	xorl	%r11d, %r11d
	cmpl	$1, %r14d
	je	.L28
	.p2align 4,,10
	.p2align 3
.L52:
	movq	8(%rsp), %rax
	movq	%r9, %rdx
	pxor	%xmm1, %xmm1
	leaq	(%r9,%rax), %rsi
	movq	(%rsp), %rax
	.p2align 4,,10
	.p2align 3
.L17:
	movsd	(%rax), %xmm0
	movupd	(%rdx), %xmm3
	addq	$16, %rdx
	movhpd	(%rax,%r13,8), %xmm0
	addq	%r8, %rax
	mulpd	%xmm3, %xmm0
	addsd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rsi, %rdx
	jne	.L17
	movl	20(%rsp), %eax
	testl	%eax, %eax
	je	.L16
	movl	48(%rsp), %eax
.L20:
	movl	%ebx, %edx
	imull	%eax, %edx
	addl	%ecx, %eax
	cltq
	addl	%edi, %edx
	movslq	%edx, %rdx
	movsd	(%r12,%rdx,8), %xmm0
	mulsd	0(%rbp,%rax,8), %xmm0
	addsd	%xmm0, %xmm1
.L16:
	leal	1(%r11), %eax
	movsd	%xmm1, (%r10)
	addl	%r14d, %ecx
	addq	%r15, %r10
	addq	%r15, %r9
	cmpl	%eax, %ebx
	je	.L19
	movl	%eax, %r11d
	cmpl	$1, %r14d
	jne	.L52
.L28:
	pxor	%xmm1, %xmm1
	xorl	%eax, %eax
	jmp	.L20
.L19:
	movq	24(%rsp), %rdx
	addq	$8, (%rsp)
	leal	1(%rdi), %eax
	addq	$8, %rdx
	cmpl	%edi, %r11d
	je	.L21
	movl	%eax, %edi
	jmp	.L15
.L21:
	movq	40(%rsp), %r10
	movl	52(%rsp), %esi
	movq	56(%rsp), %rcx
	rdtsc
	movq	%rax, %rbx
	salq	$32, %rdx
	orq	%rdx, %rbx
	cmpl	$1, %esi
	je	.L29
	movl	%esi, %eax
	pxor	%xmm0, %xmm0
	shrl	%eax
	salq	$4, %rax
	addq	%r10, %rax
.L24:
	addsd	(%rcx), %xmm0
	addq	$16, %rcx
	addsd	-8(%rcx), %xmm0
	cmpq	%rcx, %rax
	jne	.L24
	testb	$1, %sil
	je	.L25
	movl	%esi, %eax
	andl	$-2, %eax
.L23:
	cltq
	addsd	(%r10,%rax,8), %xmm0
.L25:
	leaq	.LC10(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	movq	%r10, (%rsp)
	call	__printf_chk@PLT
	movq	32(%rsp), %rax
	movl	$2, %edi
	leaq	.LC11(%rip), %rsi
	subq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rbx, %rdx
	call	__printf_chk@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	(%rsp), %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L50:
	.cfi_restore_state
	movq	(%rsi), %rcx
	movq	stderr(%rip), %rdi
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC2(%rip), %rdx
	call	__fprintf_chk@PLT
.L3:
	movl	$1, %eax
	jmp	.L1
.L27:
	xorl	%edi, %edi
	jmp	.L7
.L51:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L48:
	movdqa	.LC0(%rip), %xmm5
	movdqa	.LC5(%rip), %xmm3
	movdqa	.LC6(%rip), %xmm2
	movdqa	.LC7(%rip), %xmm4
	jmp	.L26
.L10:
	cmpl	$2, %ecx
	ja	.L48
	movq	.LC9(%rip), %rax
	movq	%rax, (%r12)
	jmp	.L14
.L29:
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	jmp	.L23
.L6:
	movq	stderr(%rip), %rdi
	movl	%ebx, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	movq	%r10, (%rsp)
	call	__fprintf_chk@PLT
	movq	%rbp, %rdi
	call	free@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	(%rsp), %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE6646:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC5:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC6:
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.long	2021161081
	.align 16
.LC7:
	.long	1
	.long	1
	.long	1
	.long	1
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC9:
	.long	0
	.long	1071644672
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
