%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stab.h"
#include "codegen.h"
extern int lineno;
extern int yyerror(char*);
extern int yylex();

int gen_code = 1;

char *fn_name;
int label_ctr = 1;
int str_ctr = 1;

/* Load the value of a variable into a freshly allocated register.
 * Returns the register index. */
static int load_var(char *name) {
	var_ptr v = lookup_var(name);
	int r = get_reg();
	if (!v) return r;
	if (v->is_param) {
		printf("//TEST: %s %s\n", name, param_reg32(v->is_param));
		printf("\tmovl %s, %s\n", param_reg32(v->is_param), reg32(r));
	} else if (v->type == IS_INT_ARRAY || v->type == IS_BOOL_ARRAY) {
		printf("//TEST: %s %d(%%rsp)\n", name, v->ctr * 4);
		printf("\tmovq %d(%%rsp), %s\n", v->ctr * 4, reg64(r));
	} else {
		printf("//TEST: %s %d(%%rsp)\n", name, v->ctr * 4);
		printf("\tmovl %d(%%rsp), %s\n", v->ctr * 4, reg32(r));
	}
	return r;
}

%}

%token BOOL_T FN_T I32_T LET_T MAIN_T MUT_T PRINT_T PRINTLN_T
%token TRUE_T FALSE_T ELSE_T VOID_T RET_SYM
%token READ_T
%token <ival> INT_LIT WHILE_T IF_T
%token <sval> ID STR_LIT
%type  <ival> opt_return_t type
%type  <node_info> expr statements statement
%type  <ival> formal_params actuals

%nonassoc '='
%left OR
%left AND
%nonassoc EQ_SYM NE_SYM
%nonassoc LT_SYM GT_SYM LE_SYM GE_SYM
%left '+' '-'
%left '*' '/' '%'
%right NOT UMINUS

%union {
   char *sval;
   int ival;
   struct info{
	int type;
	int reg;
   } node_info;
}

%%

program		: 	functions main_function
		;

main_function	:	FN_T MAIN_T '(' ')' '{'
			{ new_var("main",IS_VOID_FUNCT,1,0);
			  create_scope("main");
			  reset_regs();
			  emit_func_prologue("rusty_main");
			}
			statements '}'
			{ /* for main, we don't emit a return value copy */
			  if ($7.reg >= 0) free_reg($7.reg);
			  exit_scope();
			  emit_func_epilogue("rusty_main");
			  printf("\t.section        .note.GNU-stack,\"\",@progbits\n");
			}
		;
functions	:	functions function
		|
		;

function	:	FN_T ID '('
			{ new_var($2,IS_VOID_FUNCT,1,0);
			  create_scope($2);
			  reset_regs();
			  emit_func_prologue($2);
			}
			')' opt_return_t
			{ if ($6 == IS_INT)
				update_funct($2,IS_INT_FUNCT,0);
			  else if ($6 == IS_BOOL)
				update_funct($2,IS_BOOL_FUNCT,0);
			  else update_funct($2,IS_VOID_FUNCT,0);
			}
			'{' statements '}'
			{ /* copy last-statement value into %eax as the return value */
			  if ($9.reg >= 0) {
				printf("\tmovl %s, %%eax\n", reg32($9.reg));
				free_reg($9.reg);
			  } else {
				printf("\tmovl %%eax, %%eax\n");
			  }
			  exit_scope();
			  emit_func_epilogue($2);
			}
		|	FN_T ID '('
			{ new_var($2,IS_VOID_FUNCT,1,0);
			  create_scope($2);
			  reset_regs();
			  emit_func_prologue($2);
			}
			formal_params ')' opt_return_t
			{ if ($7 == IS_INT)
				update_funct($2,IS_INT_FUNCT,$5);
			  else if ($7 == IS_BOOL)
				update_funct($2,IS_BOOL_FUNCT,$5);
			  else update_funct($2,IS_VOID_FUNCT,$5);
			}
			'{' statements '}'
			{ if ($10.reg >= 0) {
				printf("\tmovl %s, %%eax\n", reg32($10.reg));
				free_reg($10.reg);
			  } else {
				printf("\tmovl %%eax, %%eax\n");
			  }
			  exit_scope();
			  emit_func_epilogue($2);
			}
		;
opt_return_t	:	RET_SYM type { $$ = $2; }
		|	RET_SYM VOID_T { $$ = IS_VOID_FUNCT; }
		|	{ $$ = IS_VOID_FUNCT; }
		;
formal_params	:	formal_params ',' ID ':' type
			{ $$ = $1 + 1;
			  new_var($3,$5,1,$$);
			}
		|	formal_params ',' ID ':' type '[' ']'
			{ $$ = $1 + 1;
			  if ($5 == IS_INT) new_var($3,IS_INT_ARRAY,1,$$);
			  else              new_var($3,IS_BOOL_ARRAY,1,$$);
			}
		|	ID ':' type '[' ']'
			{ $$ = 1;
			  if ($3 == IS_INT) new_var($1,IS_INT_ARRAY,1,$$);
			  else              new_var($1,IS_BOOL_ARRAY,1,$$);
			}
		|	ID ':' type
			{ $$ = 1;
			  new_var($1,$3,1,1);
			}
		;
type		:	I32_T  { $$ = IS_INT; }
		|	BOOL_T { $$ = IS_BOOL; }
		;
statements	:	statements statement ';'
			{ if ($1.reg >= 0) free_reg($1.reg);
			  $$ = $2;
			}
		|	statement ';'
			{ $$ = $1; }
		;
expr		:	ID
			{ int t = var_type($1);
			  $$.type = (t ? t : IS_INT);
			  $$.reg = load_var($1);
			}
		|	TRUE_T
			{ $$.type = IS_BOOL; $$.reg = get_reg();
			  printf("\tmovl $1, %s\n", reg32($$.reg));
			}
		|	FALSE_T
			{ $$.type = IS_BOOL; $$.reg = get_reg();
			  printf("\tmovl $0, %s\n", reg32($$.reg));
			}
		|	INT_LIT
			{ $$.type = IS_INT; $$.reg = get_reg();
			  printf("\tmovl $%d, %s\n", $1, reg32($$.reg));
			}
		|	'-' expr %prec UMINUS
			{ printf("\tnegl %s\n", reg32($2.reg));
			  $$ = $2;
			}
		|	expr '+' expr
			{ printf("\taddl %s, %s\n", reg32($3.reg), reg32($1.reg));
			  free_reg($3.reg);
			  $$ = $1;
			}
		|	expr '-' expr
			{ printf("\tsubl %s, %s\n", reg32($3.reg), reg32($1.reg));
			  free_reg($3.reg);
			  $$ = $1;
			}
		|	expr '*' expr
			{ printf("\timull %s, %s\n", reg32($3.reg), reg32($1.reg));
			  free_reg($3.reg);
			  $$ = $1;
			}
		|	expr '/' expr
			{ emit_divmod($1.reg, $3.reg, 1);
			  free_reg($3.reg);
			  $$ = $1;
			}
		|	expr '%' expr
			{ emit_divmod($1.reg, $3.reg, 0);
			  free_reg($3.reg);
			  $$ = $1;
			}
		|	expr EQ_SYM expr
			{ emit_cmp("sete",  $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr NE_SYM expr
			{ emit_cmp("setne", $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr GT_SYM expr
			{ emit_cmp("setg",  $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr GE_SYM expr
			{ emit_cmp("setge", $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr LT_SYM expr
			{ emit_cmp("setl",  $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr LE_SYM expr
			{ emit_cmp("setle", $1.reg, $3.reg); free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL; }
		|	expr AND expr
			{ printf("\tandl %s, %s\n", reg32($3.reg), reg32($1.reg));
			  free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL;
			}
		|	expr OR expr
			{ printf("\torl %s, %s\n", reg32($3.reg), reg32($1.reg));
			  free_reg($3.reg);
			  $$ = $1; $$.type = IS_BOOL;
			}
		|	NOT expr
			{ printf("\txorl $1, %s\n", reg32($2.reg));
			  $$ = $2; $$.type = IS_BOOL;
			}
		|	'(' expr ')'
			{ $$ = $2; }
		|	ID '[' expr ']'
			{ /* load a[idx] into a fresh reg */
			  int aoff = var_offset($1);
			  int pr = get_reg();
			  printf("//TEST: %s %d(%%rsp)\n", $1, aoff);
			  printf("\tmovq %d(%%rsp), %s\n", aoff, reg64(pr));
			  printf("\tmovl (%s,%s,4), %s\n",
				 reg64(pr), reg64($3.reg), reg32(pr));
			  free_reg($3.reg);
			  $$.reg = pr;
			  $$.type = IS_INT;
			}
		|	ID '('
			{ /* caller-save before a call with no args */
			  printf("// call %s\n", $1);
			  emit_caller_save();
			}
			')'
			{ printf("\tcall %s\n", $1);
			  emit_caller_restore();
			  int r = get_reg();
			  printf("\tmovl %%eax, %s\n", reg32(r));
			  $$.reg = r;
			  int t = var_type($1);
			  if (t == IS_BOOL_FUNCT) $$.type = IS_BOOL;
			  else if (t == IS_VOID_FUNCT) $$.type = IS_VOID;
			  else $$.type = IS_INT;
			}
		|	ID '('
			{ printf("// call %s\n", $1);
			  emit_caller_save();
			}
			actuals ')'
			{ printf("\tcall %s\n", $1);
			  emit_caller_restore();
			  int r = get_reg();
			  printf("\tmovl %%eax, %s\n", reg32(r));
			  $$.reg = r;
			  int t = var_type($1);
			  if (t == IS_BOOL_FUNCT) $$.type = IS_BOOL;
			  else if (t == IS_VOID_FUNCT) $$.type = IS_VOID;
			  else $$.type = IS_INT;
			}
		|	IF_T expr '{'
			{ /* L1 = else-label */
			  $<ival>$ = label_ctr++;
			  printf("\tcmpl $0, %s\n", reg32($2.reg));
			  free_reg($2.reg);
			  printf("\tje L%d\n", $<ival>$);
			  create_scope(NULL);
			}
			statements
			{ /* free body result, jump past else */
			  $<ival>$ = label_ctr++;
			  if ($5.reg >= 0) free_reg($5.reg);
			  printf("\tjmp L%d\n", $<ival>$);
			  printf("L%d:\n", $<ival>4);
			  exit_scope();
			}
			'}' ELSE_T '{'
			{ create_scope(NULL); }
			statements '}'
			{ if ($11.reg >= 0) free_reg($11.reg);
			  printf("L%d:\n", $<ival>6);
			  exit_scope();
			  $$.type = IS_VOID;
			  $$.reg  = -1;
			}
		|	READ_T '(' ')'
			{ printf("// INPUT\n");
			  emit_caller_save();
			  printf("\tcall rusty_input\n");
			  emit_caller_restore();
			  int r = get_reg();
			  printf("\tmovl %%eax, %s\n", reg32(r));
			  $$.reg = r;
			  $$.type = IS_INT;
			}
		;
actuals		:	actuals ',' expr
			{ $$ = $1 + 1;
			  printf("\tmovl %s, %s\n", reg32($3.reg), param_reg32($$));
			  free_reg($3.reg);
			}
		|	expr
			{ $$ = 1;
			  printf("\tmovl %s, %s\n", reg32($1.reg), param_reg32(1));
			  free_reg($1.reg);
			}
		;
statement	:	LET_T ID '=' expr
			{ new_var($2,$4.type ? $4.type : IS_INT,1,0);
			  int off = var_offset($2);
			  printf("//TEST: %s %d(%%rsp)\n", $2, off);
			  printf("\tmovl %s, %d(%%rsp)\n", reg32($4.reg), off);
			  free_reg($4.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	LET_T MUT_T ID '=' expr
			{ new_var($3,$5.type ? $5.type : IS_INT,0,0);
			  int off = var_offset($3);
			  printf("//TEST: %s %d(%%rsp)\n", $3, off);
			  printf("\tmovl %s, %d(%%rsp)\n", reg32($5.reg), off);
			  free_reg($5.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	LET_T MUT_T ID '[' type ';' INT_LIT ']' '=' expr
			{ int t = ($5 == IS_INT) ? IS_INT_ARRAY : IS_BOOL_ARRAY;
			  new_var($3,t,0,0);
			  int off = var_offset($3);
			  printf("// array allocation\n");
			  emit_caller_save();
			  printf("\tmovl $4, %%esi\n");
			  printf("\tmovl $%d, %%edi\n", $7);
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall calloc\n");
			  printf("//TEST: %s %d(%%rsp)\n", $3, off);
			  printf("\tmovq %%rax, %d(%%rsp)\n", off);
			  emit_caller_restore();
			  free_reg($10.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	ID '=' expr
			{ var_ptr v = lookup_var($1);
			  if (v && v->is_param) {
				printf("\tmovl %s, %s\n",
				       reg32($3.reg), param_reg32(v->is_param));
			  } else if (v) {
				printf("//TEST: %s %d(%%rsp)\n", $1, v->ctr * 4);
				printf("\tmovl %s, %d(%%rsp)\n",
				       reg32($3.reg), v->ctr * 4);
			  }
			  free_reg($3.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	ID '[' expr ']' '=' expr
			{ int aoff = var_offset($1);
			  int pr = get_reg();
			  printf("//TEST: %s %d(%%rsp)\n", $1, aoff);
			  printf("\tmovq %d(%%rsp), %s\n", aoff, reg64(pr));
			  printf("\tmovl %s, (%s,%s,4)\n",
				 reg32($6.reg), reg64(pr), reg64($3.reg));
			  free_reg(pr);
			  free_reg($3.reg);
			  free_reg($6.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	PRINT_T '(' expr ')'
			{ printf("// printf\n");
			  emit_caller_save();
			  printf("\tmovl %s, %%esi\n", reg32($3.reg));
			  printf("\tmovq S1(%%rip), %%rdi\n");
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  free_reg($3.reg);
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	PRINTLN_T '(' expr ')'
			{ int sc = str_ctr++;
			  printf("// println\n");
			  emit_caller_save();
			  printf("\tmovl %s, %%esi\n", reg32($3.reg));
			  printf("\tmovq S1(%%rip), %%rdi\n");
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  free_reg($3.reg);
			  printf("\t.data\n.STR%d:\n\t.string \"\\n\"\n\t.text\n", sc);
			  emit_caller_save();
			  printf("\tmovl $.STR%d, %%edi\n", sc);
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	PRINT_T '(' STR_LIT ')'
			{ int sc = str_ctr++;
			  printf("// printf\n");
			  printf("\t.data\n.STR%d:\n\t.string %s\n\t.text\n",
				 sc, $3);
			  emit_caller_save();
			  printf("\tmovl $.STR%d, %%edi\n", sc);
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	PRINTLN_T '(' STR_LIT ')'
			{ int sc = str_ctr++;
			  int sc2 = str_ctr++;
			  printf("// println\n");
			  printf("\t.data\n.STR%d:\n\t.string %s\n\t.text\n",
				 sc, $3);
			  emit_caller_save();
			  printf("\tmovl $.STR%d, %%edi\n", sc);
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  printf("\t.data\n.STR%d:\n\t.string \"\\n\"\n\t.text\n", sc2);
			  emit_caller_save();
			  printf("\tmovl $.STR%d, %%edi\n", sc2);
			  printf("\tmovl $0, %%eax\n");
			  printf("\tcall printf\n");
			  emit_caller_restore();
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	WHILE_T
			{ $<ival>$ = label_ctr++;
			  printf("L%d:\n", $<ival>$);
			}
			expr '{'
			{ $<ival>$ = label_ctr++;
			  printf("\tcmpl $0, %s\n", reg32($3.reg));
			  free_reg($3.reg);
			  printf("\tje L%d\n", $<ival>$);
			  create_scope(NULL);
			}
			statements '}'
			{ if ($6.reg >= 0) free_reg($6.reg);
			  printf("\tjmp L%d\n", $<ival>2);
			  printf("L%d:\n", $<ival>5);
			  exit_scope();
			  $$.type = IS_VOID; $$.reg = -1;
			}
		|	'{'
			{ create_scope(NULL); }
			statements '}'
			{ exit_scope(); $$ = $3; }
		|	expr
			{ $$ = $1; }
		;
%%

int
yyerror(char *s) {
	printf("Syntax error line %d\n",lineno);
	return 0;
}

int
main () {
	create_scope("global");
	yyparse();
	exit_scope();
	return 0;
}
