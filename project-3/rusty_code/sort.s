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
//TEST: size %esi
	movl %esi, %r11d
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
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: x 4(%rsp)
	movl 4(%rsp), %ebx
//TEST: arr %edi
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
//i(1, 0, 0)	//size(1, 2, 0)	//arr(3, 1, 0)	
	.text
.globl writearray
	.type   writearray, @function
writearray:
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
L3:
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: size %esi
	movl %esi, %r11d
	cmpl %r11d,%r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L4
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
// get address then add expr*4
//TEST: arr %edi
	movq %rdi, %rbx
	movq (%rbx,%r11,4),%rbx
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
// printf
	.data
.STR1:
	.string " "
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
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
	movl $1, %ebx
	addl %ebx, %r11d
//TEST: i 0(%rsp)
	movl %r11d, 0(%rsp)
//Scope (null) with 0 vars:

	jmp L3
L4:
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
	.size   writearray, .-writearray
//Scope writearray with 1 vars:
//i(1, 0, 0)	//size(1, 2, 0)	//arr(3, 1, 0)	
	.text
.globl find_smallest
	.type   find_smallest, @function
find_smallest:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
//TEST: start %esi
	movl %esi, %r10d
//TEST: small_index 0(%rsp)
	movl %r10d, 0(%rsp)
//TEST: start %esi
	movl %esi, %r10d
	movl $1, %r11d
	addl %r11d, %r10d
//TEST: i 4(%rsp)
	movl %r10d, 4(%rsp)
L5:
//TEST: i 4(%rsp)
	movl 4(%rsp), %r10d
//TEST: stop %edx
	movl %edx, %r11d
	cmpl %r11d,%r10d
	setle %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L6
//TEST: small_index 0(%rsp)
	movl 0(%rsp), %r11d
// get address then add expr*4
//TEST: arr %edi
	movq %rdi, %rbx
	movq (%rbx,%r11,4),%rbx
//TEST: i 4(%rsp)
	movl 4(%rsp), %r11d
// get address then add expr*4
//TEST: arr %edi
	movq %rdi, %rbp
	movq (%rbp,%r11,4),%rbp
	cmpl %ebp,%ebx
	setg %al
	movzbq %al, %rax
	movl %eax, %ebx
	cmpl $0, %ebx
	je L7
//TEST: i 4(%rsp)
	movl 4(%rsp), %r11d
//Scope (null) with 0 vars:

	jmp L8
L7:
//TEST: small_index 0(%rsp)
	movl 0(%rsp), %ebp
//Scope (null) with 0 vars:

	movl %ebp, %r11d
L8:
//TEST: small_index 0(%rsp)
	movl %r11d, 0(%rsp)
//TEST: i 4(%rsp)
	movl 4(%rsp), %r11d
	movl $1, %ebx
	addl %ebx, %r11d
//TEST: i 4(%rsp)
	movl %r11d, 4(%rsp)
//Scope (null) with 0 vars:

	jmp L5
L6:
//TEST: small_index 0(%rsp)
	movl 0(%rsp), %r10d
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
	.size   find_smallest, .-find_smallest
//Scope find_smallest with 2 vars:
//i(1, 0, 1)	//small_index(1, 0, 0)	//stop(1, 3, 0)	//start(1, 2, 0)	//arr(3, 1, 0)	
	.text
.globl swapelems
	.type   swapelems, @function
swapelems:
// callee save 
	pushq %rbx
	pushq %rbp
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	subq $128, %rsp
//TEST: e1 %esi
	movl %esi, %r10d
// get address then add expr*4
//TEST: arr %edi
	movq %rdi, %r11
	movq (%r11,%r10,4),%r11
//TEST: t 0(%rsp)
	movl %r11d, 0(%rsp)
//TEST: e1 %esi
	movl %esi, %r10d
//TEST: e2 %edx
	movl %edx, %r11d
// get address then add expr*4
//TEST: arr %edi
	movq %rdi, %rbx
	movq (%rbx,%r11,4),%rbx
//TEST: arr %edi
	movq %rdi, %r11
	leaq (%r11,%r10,4), %r11
	movl %ebx, (%r11)
//TEST: e2 %edx
	movl %edx, %r10d
//TEST: t 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: arr %edi
	movq %rdi, %rbx
	leaq (%rbx,%r10,4), %rbx
	movl %r11d, (%rbx)
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
	.size   swapelems, .-swapelems
//Scope swapelems with 1 vars:
//t(1, 0, 0)	//e2(1, 3, 0)	//e1(1, 2, 0)	//arr(3, 1, 0)	
	.text
.globl sortarray
	.type   sortarray, @function
sortarray:
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
L9:
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: size %esi
	movl %esi, %r11d
	movl $1, %ebx
	subl %ebx, %r11d
	cmpl %r11d,%r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L10
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: arr %edi
	movq %rdi, %r11
// ARRAY PARAM!!!
	movq %r11, %rdi
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
	movl %r11d, %esi
//TEST: size %esi
	movl %esi, %r11d
	movl $1, %ebx
	subl %ebx, %r11d
	movl %r11d, %edx
	call find_smallest
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
//TEST: small 4(%rsp)
	movl %r11d, 4(%rsp)
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: arr %edi
	movq %rdi, %r11
// ARRAY PARAM!!!
	movq %r11, %rdi
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
	movl %r11d, %esi
//TEST: small 4(%rsp)
	movl 4(%rsp), %r11d
	movl %r11d, %edx
	call swapelems
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
//TEST: i 0(%rsp)
	movl 0(%rsp), %ebx
	movl $1, %ebp
	addl %ebp, %ebx
//TEST: i 0(%rsp)
	movl %ebx, 0(%rsp)
//Scope (null) with 0 vars:
//small(1, 0, 1)	
	jmp L9
L10:
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
	.size   sortarray, .-sortarray
//Scope sortarray with 2 vars:
//i(1, 0, 0)	//size(1, 2, 0)	//arr(3, 1, 0)	
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
	movq 0(%rsp), %r11
// ARRAY PARAM!!!
	movq %r11, %rdi
	movl $10, %r11d
	movl %r11d, %esi
	call sortarray
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
//TEST: a 0(%rsp)
	movq 0(%rsp), %rbx
// ARRAY PARAM!!!
	movq %rbx, %rdi
	movl $10, %ebx
	movl %ebx, %esi
	call writearray
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
//Scope main with 2 vars:
//a(3, 0, 0)	
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
//Scope global with 6 vars:
//main(7, 0, 5)	//sortarray(7, 0, 2)	//swapelems(7, 0, 3)	//find_smallest(2, 0, 3)	//writearray(7, 0, 2)	//readarray(7, 0, 2)	
	.section        .note.GNU-stack,"",@progbits
