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
	cmpl %r11d, %r10d
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
	movl %eax, %r10d
//TEST: x 4(%rsp)
	movl %r10d, 4(%rsp)
//TEST: x 4(%rsp)
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
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: x 4(%rsp)
	movl 4(%rsp), %r11d
//TEST: a %rdi
	movq %rdi, %rbx
	movl %r11d, (%rbx,%r10,4)
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
//TEST: i 0(%rsp)
	movl %r10d, 0(%rsp)
	jmp L1
L2:
//Scope (null) with 0 vars:
//x(1, 0, 1)	
	movl %eax, %eax
//Scope readarray with 2 vars:
//i(1, 0, 0)	//size(1, 2, 0)	//a(3, 1, 0)	
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
	movl $10, %r11d
	cmpl %r11d, %r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L4
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: a %rdi
	movq %rdi, %r11
	movl (%r11,%r10,4), %r11d
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
	movl 0(%rsp), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
//TEST: i 0(%rsp)
	movl %r10d, 0(%rsp)
	jmp L3
L4:
//Scope (null) with 0 vars:

	movl %eax, %eax
//Scope writearray with 1 vars:
//i(1, 0, 0)	//size(1, 2, 0)	//a(3, 1, 0)	
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
	cmpl %r11d, %r10d
	setle %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L6
//TEST: small_index 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: arr %rdi
	movq %rdi, %r11
	movl (%r11,%r10,4), %r11d
//TEST: i 4(%rsp)
	movl 4(%rsp), %r10d
//TEST: arr %rdi
	movq %rdi, %rbx
	movl (%rbx,%r10,4), %ebx
	cmpl %ebx, %r11d
	setg %al
	movzbq %al, %rax
	movl %eax, %r11d
	cmpl $0, %r11d
	je L7
//TEST: i 4(%rsp)
	movl 4(%rsp), %r11d
	movl %r11d, %r10d
	jmp L8
L7:
//Scope (null) with 0 vars:

//TEST: small_index 0(%rsp)
	movl 0(%rsp), %r11d
	movl %r11d, %r10d
L8:
//Scope (null) with 0 vars:

//TEST: small_index 0(%rsp)
	movl %r10d, 0(%rsp)
//TEST: i 4(%rsp)
	movl 4(%rsp), %r10d
	movl $1, %r11d
	addl %r11d, %r10d
//TEST: i 4(%rsp)
	movl %r10d, 4(%rsp)
	jmp L5
L6:
//Scope (null) with 0 vars:

//TEST: small_index 0(%rsp)
	movl 0(%rsp), %r10d
	movl %r10d, %eax
//Scope find_smallest with 2 vars:
//i(1, 0, 1)	//small_index(1, 0, 0)	//stop(1, 3, 0)	//start(1, 2, 0)	//arr(3, 1, 0)	
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
//TEST: arr %rdi
	movq %rdi, %r11
	movl (%r11,%r10,4), %r11d
//TEST: t 0(%rsp)
	movl %r11d, 0(%rsp)
//TEST: e1 %esi
	movl %esi, %r10d
//TEST: e2 %edx
	movl %edx, %r11d
//TEST: arr %rdi
	movq %rdi, %rbx
	movl (%rbx,%r11,4), %ebx
//TEST: arr %rdi
	movq %rdi, %r11
	movl %ebx, (%r11,%r10,4)
//TEST: e2 %edx
	movl %edx, %r10d
//TEST: t 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: arr %rdi
	movq %rdi, %rbx
	movl %r11d, (%rbx,%r10,4)
	movl %eax, %eax
//Scope swapelems with 1 vars:
//t(1, 0, 0)	//e2(1, 3, 0)	//e1(1, 2, 0)	//arr(3, 1, 0)	
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
//TEST: size %esi
	movl %esi, %r10d
	movl $1, %r11d
	subl %r11d, %r10d
//TEST: last_elem 4(%rsp)
	movl %r10d, 4(%rsp)
L9:
//TEST: i 0(%rsp)
	movl 0(%rsp), %r10d
//TEST: size %esi
	movl %esi, %r11d
	cmpl %r11d, %r10d
	setl %al
	movzbq %al, %rax
	movl %eax, %r10d
	cmpl $0, %r10d
	je L10
// call find_smallest
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: arr %rdi
	movq %rdi, %r10
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: last_elem 4(%rsp)
	movl 4(%rsp), %ebx
	movq %r10, %rdi
	movl %r11d, %esi
	movl %ebx, %edx
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
	movl %eax, %r10d
//TEST: small 8(%rsp)
	movl %r10d, 8(%rsp)
// call swapelems
// caller save
	movq %rdi, 64(%rsp)
	movq %rsi, 72(%rsp)
	movq %rdx, 80(%rsp)
	movq %rcx, 88(%rsp)
	movq %r8, 96(%rsp)
	movq %r9, 104(%rsp)
	movq %r10, 112(%rsp)
	movq %r11, 120(%rsp)
//TEST: arr %rdi
	movq %rdi, %r10
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
//TEST: small 8(%rsp)
	movl 8(%rsp), %ebx
	movq %r10, %rdi
	movl %r11d, %esi
	movl %ebx, %edx
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
	movl %eax, %r10d
//TEST: i 0(%rsp)
	movl 0(%rsp), %r11d
	movl $1, %ebx
	addl %ebx, %r11d
//TEST: i 0(%rsp)
	movl %r11d, 0(%rsp)
	jmp L9
L10:
//Scope (null) with 0 vars:
//small(1, 0, 2)	
	movl %eax, %eax
//Scope sortarray with 3 vars:
//last_elem(1, 0, 1)	//i(1, 0, 0)	//size(1, 2, 0)	//arr(3, 1, 0)	
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
// printf
	.data
.STR1:
	.string "Unsorted:   "
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
// call readarray
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
	movl $10, %r11d
	movq %r10, %rdi
	movl %r11d, %esi
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
// call sortarray
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
	movl $10, %ebx
	movq %r11, %rdi
	movl %ebx, %esi
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
// printf
	.data
.STR2:
	.string "\nSorted:   "
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
	movl $.STR2, %edi
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
// call writearray
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
	movl $10, %r11d
	movq %r10, %rdi
	movl %r11d, %esi
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
	movl %eax, %r10d
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
	.section        .note.GNU-stack,"",@progbits
//Scope global with 6 vars:
//main(7, 0, 5)	//sortarray(7, 0, 2)	//swapelems(7, 0, 3)	//find_smallest(2, 0, 3)	//writearray(7, 0, 2)	//readarray(7, 0, 2)	
