	.text
.globl test1
	.type   test1, @function
test1:
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
	.size   test1, .-test1
//Scope test1 with 0 vars:
//a(1, 1, 0)	
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
//TEST: x %edi
	movl %edi, %r10d
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
//TEST: x %edi
	movl %edi, %r10d
//TEST: y %esi
	movl %esi, %r11d
	imull %r11d, %r10d
	movl %r10d, %edi
	call test1
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
//y(1, 2, 0)	//x(1, 1, 0)	
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
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $42, %r10d
	movl %r10d, %edi
	movl $2, %r10d
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
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $64, %r11d
	movl %r11d, %edi
	movl $3, %r11d
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
	movl %eax, %r11d
//Scope main with 0 vars:

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
//main(7, 0, 2)	//test(7, 0, 2)	//test1(7, 0, 1)	
	.section        .note.GNU-stack,"",@progbits
