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
	cmpl $0, %r10d
	je L1
//TEST: b %esi
	movl %esi, %ebx
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
	movl %ebx, %esi
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
	movl $5, %ebx
//TEST: c 0(%rsp)
	movl %ebx, 0(%rsp)
//TEST: c 0(%rsp)
	movl 0(%rsp), %ebx
//Scope (null) with 0 vars:
//c(1, 0, 0)	
	jmp L2
L1:
//TEST: b %esi
	movl %esi, %ebp
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
	movl $6, %ebp
//TEST: c 4(%rsp)
	movl %ebp, 4(%rsp)
//TEST: c 4(%rsp)
	movl 4(%rsp), %ebp
//Scope (null) with 0 vars:
//c(1, 0, 1)	
	movl %ebp, %ebx
L2:
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
//Scope test with 2 vars:
//b(1, 2, 0)	//a(1, 1, 0)	
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
	cmpl %r11d,%r10d
	setg %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L3
//TEST: a %edi
	movl %edi, %r11d
//TEST: c %edx
	movl %edx, %ebx
	subl %ebx, %r11d
	movl $0, %ebx
	cmpl %ebx,%r11d
	setl %al
	movzbq %al, %rax
	movl %eax, %r11d
	cmpl $0, %r11d
	je L5
//TEST: a %edi
	movl %edi, %ebx
//Scope (null) with 0 vars:

	jmp L6
L5:
//TEST: c %edx
	movl %edx, %ebp
//Scope (null) with 0 vars:

	movl %ebp, %ebx
L6:
//Scope (null) with 0 vars:

	jmp L4
L3:
//TEST: b %esi
	movl %esi, %r11d
//TEST: c %edx
	movl %edx, %ebp
	movl $2, %ebp
	cmpl %ebp,%r11d
	sete %al
	movzbq %al, %rax
	movl %eax, %r11d
	cmpl $0, %r11d
	je L7
//TEST: b %esi
	movl %esi, %ebp
//Scope (null) with 0 vars:

	jmp L8
L7:
//TEST: c %edx
	movl %edx, %r12d
//Scope (null) with 0 vars:

	movl %r12d, %ebp
L8:
//Scope (null) with 0 vars:

	movl %ebp, %ebx
L4:
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
	.size   whilefn, .-whilefn
//Scope whilefn with 0 vars:
//c(1, 3, 0)	//b(1, 2, 0)	//a(1, 1, 0)	
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
	movl $5, %r10d
	movl %r10d, %edi
	movl $22, %r10d
	movl $9, %r11d
	addl %r11d, %r10d
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
	movl %r10d, %edi
//TEST: a 4(%rsp)
	movl 4(%rsp), %r10d
//TEST: a 4(%rsp)
	movl 4(%rsp), %r11d
	addl %r11d, %r10d
//TEST: a 4(%rsp)
	movl 4(%rsp), %r11d
	addl %r11d, %r10d
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
	movl %r10d, %edi
//TEST: a 4(%rsp)
	movl 4(%rsp), %r10d
	movl %r10d, %esi
	movl $3, %r10d
	movl %r10d, %edx
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
//Scope global with 3 vars:
//main(7, 0, 2)	//whilefn(2, 0, 3)	//test(2, 0, 2)	
	.section        .note.GNU-stack,"",@progbits
