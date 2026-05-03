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
//Scope incr with 0 vars:
//a(1, 1, 0)	
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
	cmpl %r11d, %r10d
	setg %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L1
// call sum
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
	movl %edi, %r10d
	movl $1, %ebx
	addl %ebx, %r10d
//TEST: b %esi
	movl %esi, %ebx
	movl %r10d, %edi
	movl %ebx, %esi
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
	movl %eax, %r10d
// call incr
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
	movl %ebx, %r11d
	jmp L2
L1:
//Scope (null) with 0 vars:

	movl $0, %r10d
	movl %r10d, %r11d
L2:
//Scope (null) with 0 vars:

	movl %r11d, %eax
//Scope sum with 0 vars:
//b(1, 2, 0)	//a(1, 1, 0)	
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
	cmpl %r11d, %r10d
	setne %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L3
//TEST: b %esi
	movl %esi, %r10d
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
	jmp L4
L3:
//Scope (null) with 0 vars:

//TEST: b %esi
	movl %esi, %r10d
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
L4:
//Scope (null) with 0 vars:

//TEST: a %edi
	movl %edi, %r10d
	movl %r10d, %eax
//Scope test with 0 vars:
//b(1, 2, 0)	//a(1, 1, 0)	
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
// call test
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
//TEST: a 0(%rsp)
	movl 0(%rsp), %r11d
	movl %r10d, %edi
	movl %r11d, %esi
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
// call test
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
	movl $5, %r11d
	movl %r10d, %edi
	movl %r11d, %esi
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
	.section        .note.GNU-stack,"",@progbits
//Scope global with 4 vars:
//main(7, 0, 3)	//test(2, 0, 2)	//sum(2, 0, 2)	//incr(2, 0, 1)	
