#include <stdio.h>
#include <stdlib.h>
#include "codegen.h"

/* Register allocator: 8 callee/general registers used for temporaries. */
static char *regs32[8] = {"%r10d","%r11d","%ebx","%ebp","%r12d","%r13d","%r14d","%r15d"};
static char *regs64[8] = {"%r10","%r11","%rbx","%rbp","%r12","%r13","%r14","%r15"};
static int free_list[8] = {1,1,1,1,1,1,1,1};

int get_reg(void) {
	for (int i = 0; i < 8; i++) {
		if (free_list[i]) { free_list[i] = 0; return i; }
	}
	fprintf(stderr, "// ERROR: out of registers\n");
	return 0;
}

void free_reg(int r) { if (r >= 0 && r < 8) free_list[r] = 1; }

void reset_regs(void) { for (int i = 0; i < 8; i++) free_list[i] = 1; }

char *reg32(int r) { if (r < 0 || r >= 8) return "%r10d"; return regs32[r]; }
char *reg64(int r) { if (r < 0 || r >= 8) return "%r10";  return regs64[r]; }

static char *p32[6] = {"%edi","%esi","%edx","%ecx","%r8d","%r9d"};
static char *p64[6] = {"%rdi","%rsi","%rdx","%rcx","%r8","%r9"};

char *param_reg32(int i) { if (i < 1 || i > 6) return "%edi"; return p32[i-1]; }
char *param_reg64(int i) { if (i < 1 || i > 6) return "%rdi"; return p64[i-1]; }

void emit_caller_save(void) {
	printf("// caller save\n");
	printf("\tmovq %%rdi, 64(%%rsp)\n");
	printf("\tmovq %%rsi, 72(%%rsp)\n");
	printf("\tmovq %%rdx, 80(%%rsp)\n");
	printf("\tmovq %%rcx, 88(%%rsp)\n");
	printf("\tmovq %%r8, 96(%%rsp)\n");
	printf("\tmovq %%r9, 104(%%rsp)\n");
	printf("\tmovq %%r10, 112(%%rsp)\n");
	printf("\tmovq %%r11, 120(%%rsp)\n");
}

void emit_caller_restore(void) {
	printf("// caller restore\n");
	printf("\tmovq 64(%%rsp), %%rdi\n");
	printf("\tmovq 72(%%rsp), %%rsi\n");
	printf("\tmovq 80(%%rsp), %%rdx\n");
	printf("\tmovq 88(%%rsp), %%rcx\n");
	printf("\tmovq 96(%%rsp), %%r8\n");
	printf("\tmovq 104(%%rsp), %%r9\n");
	printf("\tmovq 112(%%rsp), %%r10\n");
	printf("\tmovq 120(%%rsp), %%r11\n");
}

void emit_func_prologue(const char *name) {
	printf("\t.text\n");
	printf(".globl %s\n", name);
	printf("\t.type   %s, @function\n", name);
	printf("%s:\n", name);
	printf("// callee save\n");
	printf("\tpushq %%rbx\n");
	printf("\tpushq %%rbp\n");
	printf("\tpushq %%r12\n");
	printf("\tpushq %%r13\n");
	printf("\tpushq %%r14\n");
	printf("\tpushq %%r15\n");
	printf("\tsubq $128, %%rsp\n");
}

void emit_func_epilogue(const char *name) {
	printf("\taddq    $128, %%rsp\n");
	printf("// callee restore\n");
	printf("\tpopq %%r15\n");
	printf("\tpopq %%r14\n");
	printf("\tpopq %%r13\n");
	printf("\tpopq %%r12\n");
	printf("\tpopq %%rbp\n");
	printf("\tpopq %%rbx\n");
	printf("\tret\n");
	printf("\t.size   %s, .-%s\n", name, name);
}

/*
 * emit_cmp: emit relational compare and materialize a 0/1 result into lhs.
 * Uses: cmpl rhs, lhs  -> flags reflect (lhs - rhs); the caller passes the
 * set-instruction suffix (sete, setne, setl, setle, setg, setge).
 */
void emit_cmp(const char *setop, int lhs, int rhs) {
	printf("\tcmpl %s, %s\n", reg32(rhs), reg32(lhs));
	printf("\t%s %%al\n", setop);
	printf("\tmovzbq %%al, %%rax\n");
	printf("\tmovl %%eax, %s\n", reg32(lhs));
}

void emit_divmod(int lhs, int rhs, int is_div) {
	printf("\tmovl %s, %%eax\n", reg32(lhs));
	printf("\tcdq\n");
	printf("\tidivl %s\n", reg32(rhs));
	if (is_div) printf("\tmovl %%eax, %s\n", reg32(lhs));
	else        printf("\tmovl %%edx, %s\n", reg32(lhs));
}
