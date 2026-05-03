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
	movl $1, %r10d
	movl $0, %r11d
	orl %r11d, %r10d
	cmpl $0, %r10d
	je L1
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
	movl $5, %r10d
//TEST: c 0(%rsp)
	movl %r10d, 0(%rsp)
//TEST: c 0(%rsp)
	movl 0(%rsp), %r10d
	movl %r10d, %r11d
	jmp L2
L1:
//Scope (null) with 0 vars:
//c(1, 0, 0)	
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
	movl $6, %r10d
//TEST: c 4(%rsp)
	movl %r10d, 4(%rsp)
//TEST: c 4(%rsp)
	movl 4(%rsp), %r10d
	movl %r10d, %r11d
L2:
//Scope (null) with 0 vars:
//c(1, 0, 1)	
//TEST: a %edi
	movl %edi, %r10d
	movl %r10d, %eax
//Scope test with 2 vars:
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
.globl whilefn
	.type   whilefn, @function
whilefn:
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
//TEST: b %esi
	movl %esi, %r11d
	imull %r11d, %r10d
	movl $1, %r11d
	cmpl %r11d, %r10d
	setg %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L3
//TEST: a %edi
	movl %edi, %r10d
//TEST: c %edx
	movl %edx, %ebx
	subl %ebx, %r10d
	movl $0, %ebx
	cmpl %ebx, %r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L5
//TEST: a %edi
	movl %edi, %r10d
	movl %r10d, %ebx
	jmp L6
L5:
//Scope (null) with 0 vars:

//TEST: c %edx
	movl %edx, %r10d
	movl %r10d, %ebx
L6:
//Scope (null) with 0 vars:

	movl %ebx, %r11d
	jmp L4
L3:
//Scope (null) with 0 vars:

//TEST: b %esi
	movl %esi, %r10d
//TEST: c %edx
	movl %edx, %ebx
	movl %r10d, %eax
	cdq
	idivl %ebx
	movl %edx, %r10d
	movl $2, %ebx
	cmpl %ebx, %r10d
	sete %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L7
//TEST: b %esi
	movl %esi, %r10d
	movl %r10d, %ebx
	jmp L8
L7:
//Scope (null) with 0 vars:

//TEST: c %edx
	movl %edx, %r10d
	movl %r10d, %ebx
L8:
//Scope (null) with 0 vars:

	movl %ebx, %r11d
L4:
//Scope (null) with 0 vars:

	movl %r11d, %eax
//Scope whilefn with 0 vars:
//c(1, 3, 0)	//b(1, 2, 0)	//a(1, 1, 0)	
	addq    $128, %rsp
// callee restore
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbp
	popq %rbx
	ret
	.size   whilefn, .-whilefn
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
	movl $5, %r10d
	movl $22, %r11d
	movl $9, %ebx
	addl %ebx, %r11d
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
//TEST: a 4(%rsp)
	movl 4(%rsp), %r11d
//TEST: a 4(%rsp)
	movl 4(%rsp), %ebx
	addl %ebx, %r11d
//TEST: a 4(%rsp)
	movl 4(%rsp), %ebx
	addl %ebx, %r11d
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
// call whilefn
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: a 4(%rsp)
	movl 4(%rsp), %r10d
//TEST: a 4(%rsp)
	movl 4(%rsp), %r11d
	movl $3, %ebx
	movl %r10d, %edi
	movl %r11d, %esi
	movl %ebx, %edx
	call whilefn
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
//Scope main with 2 vars:
//a(1, 0, 1)	//a(1, 0, 0)	
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
//Scope global with 3 vars:
//main(7, 0, 2)	//whilefn(2, 0, 3)	//test(2, 0, 2)	
