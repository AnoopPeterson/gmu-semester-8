#ifndef CODEGEN_H
#define CODEGEN_H

int  get_reg(void);
void free_reg(int r);
void reset_regs(void);
char *reg32(int r);
char *reg64(int r);

char *param_reg32(int i); /* i: 1..6 */
char *param_reg64(int i);

void emit_caller_save(void);
void emit_caller_restore(void);
void emit_func_prologue(const char *name);
void emit_func_epilogue(const char *name);
void emit_cmp(const char *setop, int lhs, int rhs);
void emit_divmod(int lhs, int rhs, int is_div);

#endif
