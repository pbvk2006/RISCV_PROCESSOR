	.file	"matmul.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"usage: %s <N>\n"
.LC3:
	.string	"N must be positive\n"
.LC4:
	.string	"allocation failed for N=%d\n"
.LC14:
	.string	"checksum=%f\n"
.LC15:
	.string	"cycles=%llu\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6646:
	.cfi_startproc
	endbr64
	leaq	8(%rsp), %r10
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp
	pushq	-8(%r10)
	pushq	%rbp
	movq	%rsp, %rbp
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%r10
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx
	subq	$96, %rsp
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	cmpl	$1, %edi
	jle	.L52
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	testl	%eax, %eax
	movl	%eax, %ebx
	jle	.L53
	movslq	%eax, %r14
	movl	$8, %esi
	movq	%rax, -56(%rbp)
	movq	%r14, %r15
	imulq	%r14, %r15
	movq	%r15, %rdi
	call	calloc@PLT
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%rax, %r12
	call	calloc@PLT
	movl	$8, %esi
	movq	%r15, %rdi
	movq	%rax, %r13
	call	calloc@PLT
	testq	%r12, %r12
	movq	%rax, %r10
	sete	%al
	testq	%r13, %r13
	sete	%dl
	orb	%dl, %al
	jne	.L6
	testq	%r10, %r10
	je	.L6
	movq	-56(%rbp), %rcx
	vxorps	%xmm2, %xmm2, %xmm2
	movl	%ecx, %r9d
	imull	%ecx, %r9d
	leal	-1(%r9), %r11d
	cmpl	$6, %r11d
	jbe	.L29
	movl	$8, %esi
	movl	%r9d, %edx
	vmovdqa	.LC0(%rip), %ymm3
	movq	%r12, %rax
	vmovd	%esi, %xmm7
	movl	$2021161081, %esi
	shrl	$3, %edx
	vmovd	%esi, %xmm5
	movl	$1, %esi
	salq	$6, %rdx
	vmovdqa	%ymm3, %ymm4
	vmovd	%esi, %xmm6
	addq	%r12, %rdx
	vpbroadcastd	%xmm7, %ymm7
	vpbroadcastd	%xmm5, %ymm5
	vpbroadcastd	%xmm6, %ymm6
.L8:
	vmovdqa	%ymm4, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm4, %ymm4
	vpmuldq	%ymm5, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm5, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpslld	$4, %ymm1, %ymm8
	vpaddd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vmovupd	%ymm1, -64(%rax)
	vcvtdq2pd	%xmm0, %ymm0
	vmovupd	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L8
	movl	%r9d, %esi
	andl	$-8, %esi
	cmpl	%esi, %r9d
	movl	%esi, %eax
	je	.L9
.L7:
	movl	%r9d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %edi
	cmpl	$2, %edi
	jbe	.L10
	vmovd	%esi, %xmm7
	movl	$2021161081, %edi
	leaq	(%r12,%rax,8), %rax
	vmovd	%edi, %xmm3
	vpshufd	$0, %xmm7, %xmm0
	movl	$1, %edi
	vpaddd	.LC5(%rip), %xmm0, %xmm0
	vpshufd	$0, %xmm3, %xmm3
	vpmuldq	%xmm3, %xmm0, %xmm1
	vpsrlq	$32, %xmm0, %xmm4
	vpmuldq	%xmm3, %xmm4, %xmm3
	vpshufd	$245, %xmm1, %xmm1
	vpblendd	$10, %xmm3, %xmm1, %xmm1
	vpsrad	$3, %xmm1, %xmm1
	vpslld	$4, %xmm1, %xmm3
	vpaddd	%xmm1, %xmm3, %xmm1
	vpsubd	%xmm1, %xmm0, %xmm0
	vmovd	%edi, %xmm1
	vpshufd	$0, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm1
	vpshufd	$238, %xmm0, %xmm0
	vmovupd	%xmm1, (%rax)
	vcvtdq2pd	%xmm0, %xmm0
	vmovupd	%xmm0, 16(%rax)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %esi
	andl	$3, %edx
	je	.L11
.L10:
	movl	%esi, %eax
	movl	$17, %r8d
	movslq	%esi, %r15
	cltd
	leaq	0(,%r15,8), %rdi
	idivl	%r8d
	leal	1(%rsi), %eax
	addl	$1, %edx
	cmpl	%r9d, %eax
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, (%r12,%r15,8)
	jge	.L11
	cltd
	idivl	%r8d
	leal	2(%rsi), %eax
	addl	$1, %edx
	cmpl	%eax, %r9d
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, 8(%r12,%rdi)
	jle	.L11
	cltd
	idivl	%r8d
	addl	$1, %edx
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmovsd	%xmm0, 16(%r12,%rdi)
.L11:
	cmpl	$6, %r11d
	jbe	.L30
	vmovdqa	.LC0(%rip), %ymm3
.L9:
	movl	$8, %esi
	movl	%r9d, %edx
	movq	%r13, %rax
	vbroadcastsd	.LC12(%rip), %ymm5
	vmovd	%esi, %xmm7
	movl	$2021161081, %esi
	shrl	$3, %edx
	vmovd	%esi, %xmm4
	movl	$1, %esi
	salq	$6, %rdx
	vpbroadcastd	%xmm7, %ymm7
	vmovd	%esi, %xmm6
	addq	%r13, %rdx
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm6, %ymm6
.L14:
	vmovdqa	%ymm3, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm3, %ymm3
	vpmuldq	%ymm4, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm4, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpsrad	$3, %ymm1, %ymm1
	vpslld	$4, %ymm1, %ymm8
	vpaddd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vmulpd	%ymm5, %ymm1, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vcvtdq2pd	%xmm0, %ymm0
	vmulpd	%ymm5, %ymm0, %ymm0
	vmovupd	%ymm1, -64(%rax)
	vmovupd	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L14
	movl	%r9d, %esi
	andl	$-8, %esi
	cmpl	%r9d, %esi
	movl	%esi, %eax
	je	.L15
.L13:
	movl	%r9d, %edx
	subl	%eax, %edx
	leal	-1(%rdx), %edi
	cmpl	$2, %edi
	jbe	.L16
	vmovd	%esi, %xmm7
	movl	$2021161081, %edi
	leaq	0(%r13,%rax,8), %rax
	vmovd	%edi, %xmm3
	vpshufd	$0, %xmm7, %xmm0
	movl	$1, %edi
	vpaddd	.LC5(%rip), %xmm0, %xmm0
	vpshufd	$0, %xmm3, %xmm3
	vpmuldq	%xmm3, %xmm0, %xmm1
	vpsrlq	$32, %xmm0, %xmm4
	vpmuldq	%xmm3, %xmm4, %xmm3
	vpshufd	$245, %xmm1, %xmm1
	vpblendd	$10, %xmm3, %xmm1, %xmm1
	vpsrad	$3, %xmm1, %xmm1
	vpslld	$4, %xmm1, %xmm3
	vpaddd	%xmm1, %xmm3, %xmm1
	vmovddup	.LC12(%rip), %xmm3
	vpsubd	%xmm1, %xmm0, %xmm0
	vmovd	%edi, %xmm1
	vpshufd	$0, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm1
	vmulpd	%xmm3, %xmm1, %xmm1
	vpshufd	$238, %xmm0, %xmm0
	vcvtdq2pd	%xmm0, %xmm0
	vmulpd	%xmm3, %xmm0, %xmm0
	vmovupd	%xmm1, (%rax)
	vmovupd	%xmm0, 16(%rax)
	movl	%edx, %eax
	andl	$-4, %eax
	addl	%eax, %esi
	andl	$3, %edx
	je	.L15
.L16:
	movl	%esi, %eax
	movl	$17, %r8d
	vmovsd	.LC12(%rip), %xmm1
	movslq	%esi, %r15
	cltd
	leaq	0(,%r15,8), %rdi
	idivl	%r8d
	leal	1(%rsi), %eax
	addl	$1, %edx
	cmpl	%eax, %r9d
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, 0(%r13,%r15,8)
	jle	.L15
	cltd
	idivl	%r8d
	leal	2(%rsi), %eax
	addl	$1, %edx
	cmpl	%r9d, %eax
	vcvtsi2sdl	%edx, %xmm2, %xmm0
	vmulsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, 8(%r13,%rdi)
	jge	.L15
	cltd
	idivl	%r8d
	addl	$1, %edx
	vcvtsi2sdl	%edx, %xmm2, %xmm2
	vmulsd	%xmm1, %xmm2, %xmm0
	vmovsd	%xmm0, 16(%r13,%rdi)
.L15:
	rdtsc
	salq	$32, %rdx
	movl	%ecx, %edi
	movq	%r13, -64(%rbp)
	movq	%r14, %r8
	orq	%rdx, %rax
	movl	%ecx, -56(%rbp)
	andl	$-2, %edi
	salq	$4, %r8
	movq	%rax, -96(%rbp)
	movl	%ecx, %eax
	leaq	0(,%r14,8), %r15
	movq	%r10, %rdx
	shrl	%eax
	movq	%r10, -104(%rbp)
	salq	$4, %rax
	movl	%r9d, -108(%rbp)
	movq	%rax, -72(%rbp)
	movl	%ecx, %eax
	andl	$1, %eax
	movq	%r10, -120(%rbp)
	movl	%eax, -76(%rbp)
	movl	%r11d, -112(%rbp)
	movl	%edi, -80(%rbp)
	xorl	%edi, %edi
	.p2align 4,,10
	.p2align 3
.L18:
	xorl	%ecx, %ecx
	xorl	%r11d, %r11d
	cmpl	$1, -56(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%r12, %r9
	movq	%rdx, %r10
	je	.L31
	.p2align 4,,10
	.p2align 3
.L54:
	movq	-72(%rbp), %rax
	movq	-64(%rbp), %rdx
	vxorpd	%xmm1, %xmm1, %xmm1
	leaq	(%r9,%rax), %rsi
	movq	%r9, %rax
	.p2align 4,,10
	.p2align 3
.L20:
	vmovsd	(%rdx), %xmm0
	addq	$16, %rax
	vmovhpd	(%rdx,%r14,8), %xmm0, %xmm0
	addq	%r8, %rdx
	vmulpd	-16(%rax), %xmm0, %xmm0
	cmpq	%rsi, %rax
	vaddsd	%xmm0, %xmm1, %xmm1
	vunpckhpd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm1, %xmm0, %xmm1
	jne	.L20
	movl	-76(%rbp), %eax
	testl	%eax, %eax
	je	.L19
	movl	-80(%rbp), %eax
.L23:
	movl	%ebx, %edx
	imull	%eax, %edx
	addl	%ecx, %eax
	cltq
	addl	%edi, %edx
	movslq	%edx, %rdx
	vmovsd	0(%r13,%rdx,8), %xmm6
	vfmadd231sd	(%r12,%rax,8), %xmm6, %xmm1
.L19:
	movl	-56(%rbp), %esi
	leal	1(%r11), %eax
	vmovsd	%xmm1, (%r10)
	addq	%r15, %r9
	addq	%r15, %r10
	addl	%esi, %ecx
	cmpl	%eax, %ebx
	je	.L22
	cmpl	$1, -56(%rbp)
	movl	%eax, %r11d
	jne	.L54
.L31:
	vxorpd	%xmm1, %xmm1, %xmm1
	xorl	%eax, %eax
	jmp	.L23
.L22:
	movq	-88(%rbp), %rdx
	addq	$8, -64(%rbp)
	leal	1(%rdi), %eax
	addq	$8, %rdx
	cmpl	%edi, %r11d
	je	.L24
	movl	%eax, %edi
	jmp	.L18
.L24:
	movq	-104(%rbp), %r10
	movl	-108(%rbp), %r9d
	movq	-120(%rbp), %rsi
	movl	-112(%rbp), %r11d
	rdtsc
	salq	$32, %rdx
	movq	%rax, %rbx
	orq	%rdx, %rbx
	cmpl	$2, %r11d
	jbe	.L26
	movl	%r9d, %eax
	vxorpd	%xmm0, %xmm0, %xmm0
	shrl	$2, %eax
	salq	$5, %rax
	addq	%r10, %rax
.L27:
	vaddsd	(%rsi), %xmm0, %xmm0
	addq	$32, %rsi
	vaddsd	-24(%rsi), %xmm0, %xmm0
	vaddsd	-16(%rsi), %xmm0, %xmm0
	vaddsd	-8(%rsi), %xmm0, %xmm0
	cmpq	%rax, %rsi
	jne	.L27
	movl	%r9d, %eax
	andl	$-4, %eax
	testb	$3, %r9b
	je	.L28
	movslq	%eax, %rcx
	vaddsd	(%r10,%rcx,8), %xmm0, %xmm0
	leaq	0(,%rcx,8), %rdx
	leal	1(%rax), %ecx
	cmpl	%r9d, %ecx
	jge	.L28
	addl	$2, %eax
	vaddsd	8(%r10,%rdx), %xmm0, %xmm0
	cmpl	%r9d, %eax
	jge	.L28
	vaddsd	16(%r10,%rdx), %xmm0, %xmm0
.L28:
	movq	%r10, -56(%rbp)
	movl	$2, %edi
	movl	$1, %eax
	leaq	.LC14(%rip), %rsi
	vzeroupper
	call	__printf_chk@PLT
	movq	-96(%rbp), %rax
	leaq	.LC15(%rip), %rsi
	movl	$2, %edi
	subq	%rax, %rbx
	xorl	%eax, %eax
	movq	%rbx, %rdx
	call	__printf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	-56(%rbp), %rdi
	call	free@PLT
	xorl	%eax, %eax
.L1:
	addq	$96, %rsp
	popq	%rbx
	popq	%r10
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	leaq	-8(%r10), %rsp
	.cfi_def_cfa 7, 8
	ret
.L52:
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
.L29:
	xorl	%eax, %eax
	xorl	%esi, %esi
	jmp	.L7
.L53:
	movq	stderr(%rip), %rcx
	movl	$19, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
	jmp	.L3
.L30:
	xorl	%eax, %eax
	xorl	%esi, %esi
	jmp	.L13
.L26:
	vxorpd	%xmm0, %xmm0, %xmm0
	vaddsd	(%r10), %xmm0, %xmm0
	jmp	.L28
.L6:
	movq	stderr(%rip), %rdi
	movl	%ebx, %ecx
	movl	$2, %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdx
	movq	%r10, -56(%rbp)
	call	__fprintf_chk@PLT
	movq	%r12, %rdi
	call	free@PLT
	movq	%r13, %rdi
	call	free@PLT
	movq	-56(%rbp), %rdi
	call	free@PLT
	jmp	.L3
	.cfi_endproc
.LFE6646:
	.size	main, .-main
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.set	.LC5,.LC0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC12:
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
