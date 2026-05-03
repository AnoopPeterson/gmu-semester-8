	.text
.globl readarray
	.type   readarray, @function
readarray:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	movl $0, %r10d
//TEST: i 0(%rsp)
	movl %r10d, 0(%rsp)
L1:
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
	movl $10, %r11d
	cmpl %r11d,%r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L2
// INPUT
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	call rusty_input
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
	movl %eax, %r11d
//TEST: x 4(%rsp)
	movl %r11d, 4(%rsp)
//TEST: x 4(%rsp)
	movl 4(%rsp), %r11d
// printf
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl %r11d, %esi
	movq S1(%rip), %rdi
	movl $0, %eax
	call printf
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: x 4(%rsp)
	movl 4(%rsp), %ebx
//TEST: a %edi
	movq %rdi, %rbp
	leaq (%rbp,%r11,4), %rbp
	movl %ebx, (%rbp)
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
	movl $1, %ebx
	addl %ebx, %r11d
//TEST: i 0(%rsp)
	movl %r11d, 0(%rsp)
//Scope (null) with 0 vars:
//x(1, 0, 1)	
	jmp L1
L2:
	movl %eax, %eax
	addq    $128, %rsp
// callee restore 
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   readarray, .-readarray
//Scope readarray with 2 vars:
//i(1, 0, 0)	//size(1, 2, 0)	//a(3, 1, 0)	
	.text
.globl rusty_main
	.type   rusty_main, @function
rusty_main:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
	movl $0, %r10d
// array allocation
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $4, %esi
	movl $10, %edi
	movl $0, %eax
	call calloc
//TEST: a 0(%rsp)
	movq %rax, 0(%rsp)
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
	movl $0, %r10d
//TEST: i 8(%rsp)
	movl %r10d, 8(%rsp)
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: a 0(%rsp)
	movq 0(%rsp), %r10
// ARRAY PARAM!!!
	movq %r10, %rdi
	movl $10, %r10d
	movl %r10d, %esi
	call readarray
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
	movl %eax, %r10d
// printf
	.data
.STR1:
	.string "\n"
	.text
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $.STR1, %edi
	movl $0, %eax
	call printf
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
L3:
//TEST: i 8(%rsp)
	movl 8(%rsp), %r11d
	movl $10, %ebx
	cmpl %ebx,%r11d
	setl %al
	movzbq %al, %rax
	movl %eax, %r11d
	cmpl $0, %r11d
	je L4
//TEST: i 8(%rsp)
	movl 8(%rsp), %ebx
// get address then add expr*4
//TEST: a 0(%rsp)
	movq 0(%rsp), %rbp
	movq (%rbp,%rbx,4),%rbp
// printf
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl %ebp, %esi
	movq S1(%rip), %rdi
	movl $0, %eax
	call printf
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
//TEST: i 8(%rsp)
	movl 8(%rsp), %ebx
	movl $1, %ebp
	addl %ebp, %ebx
//TEST: i 8(%rsp)
	movl %ebx, 8(%rsp)
//Scope (null) with 0 vars:

	jmp L3
L4:
//Scope main with 3 vars:
//i(1, 0, 2)	//a(3, 0, 0)	
	addq    $128, %rsp
// callee restore 
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   rusty_main, .-rusty_main
//Scope global with 2 vars:
//main(7, 0, 1)	//readarray(7, 0, 2)	
	.section        .note.GNU-stack,"",@progbits
