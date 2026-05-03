	.text
.globl incr
	.type   incr, @function
incr:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
//TEST: a %edi
	movl %edi, %r10d
	movl $1, %r11d
	addl %r11d, %r10d
	movl %r10d, %eax
	addq    $128, %rsp
// callee restore 
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   incr, .-incr
//Scope incr with 0 vars:
//a(1, 1, 0)	
	.text
.globl sum
	.type   sum, @function
sum:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
//TEST: a %edi
	movl %edi, %r10d
	movl $0, %r11d
	cmpl %r11d,%r10d
	setg %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L1
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: a %edi
	movl %edi, %r11d
	movl $1, %ebx
	addl %ebx, %r11d
	movl %r11d, %edi
//TEST: b %esi
	movl %esi, %r11d
	movl %r11d, %esi
	call sum
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
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: b %esi
	movl %esi, %ebx
	movl %ebx, %edi
	call incr
// caller restore 
	movq 64(%rsp), %rdi
	movq 72(%rsp), %rsi
	movq 80(%rsp), %rdx
	movq 88(%rsp), %rcx
	movq 96(%rsp), %r8
	movq 104(%rsp), %r9
	movq 112(%rsp), %r10
	movq 120(%rsp), %r11
	movl %eax, %ebx
//Scope (null) with 0 vars:

	jmp L2
L1:
	movl $0, %ebp
//Scope (null) with 0 vars:

	movl %ebp, %ebx
L2:
	movl %ebx, %eax
	addq    $128, %rsp
// callee restore 
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   sum, .-sum
//Scope sum with 0 vars:
//b(1, 2, 0)	//a(1, 1, 0)	
	.text
.globl test
	.type   test, @function
test:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
//TEST: b %esi
	movl %esi, %r10d
	movl $2, %r11d
	cmpl %r11d,%r10d
	setne %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L3
//TEST: b %esi
	movl %esi, %r11d
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
//Scope (null) with 0 vars:

	jmp L4
L3:
//TEST: b %esi
	movl %esi, %r11d
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
//Scope (null) with 0 vars:

	movl %eax, %eax
L4:
//TEST: a %edi
	movl %edi, %r10d
	movl %r10d, %eax
	addq    $128, %rsp
// callee restore 
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   test, .-test
//Scope test with 0 vars:
//b(1, 2, 0)	//a(1, 1, 0)	
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
	movl $2, %r10d
	movl $2, %r11d
	addl %r11d, %r10d
//TEST: a 0(%rsp)
	movl %r10d, 0(%rsp)
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
	movl 0(%rsp), %r10d
	movl %r10d, %edi
//TEST: a 0(%rsp)
	movl 0(%rsp), %r10d
	movl %r10d, %esi
	call test
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
//TEST: a 0(%rsp)
	movl 0(%rsp), %r11d
	addl %r11d, %r10d
//TEST: a 4(%rsp)
	movl %r10d, 4(%rsp)
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $2, %r10d
	movl $3, %r11d
	addl %r11d, %r10d
	movl %r10d, %edi
	movl $5, %r10d
	movl %r10d, %esi
	call test
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
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl %r10d, %esi
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
//Scope (null) with 0 vars:
//a(1, 0, 1)	
//Scope main with 2 vars:
//a(1, 0, 0)	
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
//Scope global with 4 vars:
//main(7, 0, 3)	//test(2, 0, 2)	//sum(2, 0, 2)	//incr(2, 0, 1)	
	.section        .note.GNU-stack,"",@progbits
