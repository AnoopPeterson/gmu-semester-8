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
	movl $2, %r10d
	movl $2, %r11d
	addl %r11d, %r10d
//TEST: a 0(%rsp)
	movl %r10d, 0(%rsp)
	movl $5, %r10d
//TEST: a 0(%rsp)
	movl %r10d, 0(%rsp)
	movl $2, %r10d
//TEST: a 0(%rsp)
	movl 0(%rsp), %r11d
	addl %r11d, %r10d
//TEST: a 4(%rsp)
	movl %r10d, 4(%rsp)
//TEST: a 4(%rsp)
	movl 4(%rsp), %r10d
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
//TEST: b %edi
	movl %edi, %r10d
//TEST: a 4(%rsp)
	movl 4(%rsp), %r11d
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
	.size   test, .-test
//Scope test with 2 vars:
//a(1, 0, 1)	//a(1, 0, 0)	//b(1, 1, 0)	
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
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
	movl $2, %r11d
	movl %r11d, %edi
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
	addl %r11d, %r10d
//TEST: a 0(%rsp)
	movl %r10d, 0(%rsp)
	movl $2, %r10d
//TEST: a 0(%rsp)
	movl 0(%rsp), %r11d
	addl %r11d, %r10d
//TEST: a 4(%rsp)
	movl %r10d, 4(%rsp)
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
//Scope global with 2 vars:
//main(7, 0, 1)	//test(2, 0, 1)	
	.section        .note.GNU-stack,"",@progbits
