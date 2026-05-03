%{
#include <stdio.h>
#include "stab.h"
extern int lineno;
extern int yyerror(char*);
extern int yylex();

int gen_code = 1;

char *fn_name;
int label_ctr = 1;
int str_ctr = 1;

%}
%token BOOL_T FN_T I32_T LET_T MAIN_T MUT_T PRINT_T PRINTLN_T
%token TRUE_T FALSE_T ELSE_T VOID_T RET_SYM
%token READ_T
%token <ival> INT_LIT WHILE_T IF_T
%token <sval> ID STR_LIT
%type <ival> opt_return_t type
%type <node_info> expr statements statement
%type <ival> formal_params actuals
%nonassoc '='
%nonassoc OR
%nonassoc AND
%nonassoc EQ_SYM NE_SYM
%nonassoc LT_SYM GT_SYM LE_SYM GE_SYM
%left '+' '-'
%left '*' '/' '%'
%right NOT UMINUS

%union {
   char *sval;
   int ival;
   struct info{
	int type;   // used below
	int reg;   // added for your convenience
   } node_info;
}

%%
program		: 	functions main_function
	 	;
main_function	:	FN_T MAIN_T '(' ')' '{' 
	      		{ new_var("main",IS_VOID_FUNCT,1,0); 
			create_scope("main");} 
			statements '}'  
			{ exit_scope(); }
	      	;
functions	:	functions function
	  	|
		;
function	:	FN_T ID '(' 
	 		{new_var($2,IS_VOID_FUNCT,1,0); create_scope($2);
			} 
			')' opt_return_t 
			{ if ($6 == IS_INT) 
				update_funct($2,IS_INT_FUNCT,0); 
			  else if ($6 == IS_BOOL)
			 	update_funct($2,IS_BOOL_FUNCT,0);
			  else update_funct($2,IS_VOID_FUNCT,0);
			}
			'{' statements '}'  
			 { exit_scope(); }
	 	|	FN_T ID '('  
	 		{new_var($2,IS_VOID_FUNCT,1,0); 
			 create_scope($2);} 
			formal_params ')' opt_return_t 
			{ if ($7 == IS_INT) 
				update_funct($2,IS_INT_FUNCT,$5); 
			  else if ($7 == IS_BOOL)
			 	update_funct($2,IS_BOOL_FUNCT,$5);
			  else update_funct($2,IS_VOID_FUNCT,$5);
			}
			
			'{' statements '}'  
			{ exit_scope(); }
	  	;
opt_return_t	:	RET_SYM type 
	     		{$$ = $2; }
		|	RET_SYM VOID_T
			{$$ = IS_VOID_FUNCT; }
		|
			{$$ = IS_VOID_FUNCT; }
		;
formal_params	:	formal_params ',' ID ':' type 
	      		{$$ = $1+1;
			 new_var($3,$5,1,$$); 
			}
		|	formal_params ',' ID ':' type '[' ']'
			{$$ = $1+1; 
			 if ($5 == IS_INT)
			 new_var($3,IS_INT_ARRAY,1,$$); 
			 else new_var($3,IS_BOOL_ARRAY,1,$$); 
			}

	      	|	ID ':' type '[' ']'
			{ $$ = 1; 
			 if ($3 == IS_INT)
			 new_var($1,IS_INT_ARRAY,1,$$); 
			 else new_var($1,IS_BOOL_ARRAY,1,$$); 
			}

	      	|	ID  ':' type
			{$$ = 1; 
			 new_var($1,$3,1,1); }

		;
	
		;
type		:	I32_T 
      			{$$ = IS_INT; }
      		| 	BOOL_T
			{$$ = IS_BOOL; }
      		;
statements	:	statements   statement ';' 
	   		{$$ = $2; }
	   	|	statement ';' 	 
		;
expr		:	ID
      			{int t = check_type($1); $$.type = t; }
      		|	TRUE_T
			{$$.type = IS_BOOL; }
		|	FALSE_T
			{$$.type = IS_BOOL; }
      		|	INT_LIT
			{$$.type = IS_INT; }
		|	'-' expr
			{$$ = $2;}
		|	expr '+' expr
			{// just to show typchecking.  Not required.
                          if (($1.type == IS_INT)&&($3.type ==IS_INT)) 
				$$ = $1; 
			else {
			   printf("Illegal operand for / operator line %d\n",lineno);
			   $$=$1; $$.type = IS_INT;
			}
			}
		|	expr '-' expr
		|	expr '*' expr
		|	expr '/' expr
		|	expr '%' expr
		|	expr EQ_SYM expr
		|	expr NE_SYM expr
		|	expr GT_SYM expr
		|	expr GE_SYM expr
		|	expr LT_SYM expr
		|	expr LE_SYM expr
		|	expr AND expr
		|	expr OR expr
		|	NOT expr 
			{$$ = $2; }
		|	'(' expr ')'
			{$$ = $2; }
		|	ID '[' expr ']'
			{$$.type = IS_INT;}
		|	ID '(' ')'
			{$$.type = IS_INT;}
		|	ID '('  actuals ')'
			{$$.type = IS_INT;}
		|	IF_T  expr '{' 
			{create_scope(NULL); }
			statements 
			{exit_scope(); }
			'}' ELSE_T '{' 
			{create_scope(NULL); }
			statements '}' 
			{ exit_scope(); $$ = $5; 
			}
			
		|	READ_T '(' ')'
			{ $$.type = IS_INT; 
			}
		;
actuals		:	actuals ',' expr 
	 		{ $$ = $1+1; }
	 	| 	expr	
	 		{ $$ = 1; }
		;
statement	:	LET_T ID '=' expr  
	  		{new_var($2,IS_INT,1,0);
			$$.type = IS_VOID;
			}
	  	|	LET_T MUT_T ID '=' expr  
	  		{new_var($3,IS_INT,0,0);
			 $$.type = IS_VOID;
			}
		|	LET_T MUT_T ID '[' type ';' INT_LIT ']' '=' expr
	  		{if ($5== IS_INT) new_var($3,IS_INT_ARRAY,0,0);
			 else new_var($3,IS_BOOL_ARRAY,0,0); 
			 $$.type = IS_VOID;
			}
		|	ID '=' expr 
			{ $$.type = IS_VOID; }
		|	ID '[' expr ']' '=' expr 
			{ $$.type = IS_VOID;}
		|	PRINT_T '(' expr ')'      
			{$$.type = IS_VOID; }
		|	PRINTLN_T '(' expr ')'   
			{ $$.type = IS_VOID; 
			}
		|	PRINT_T '(' STR_LIT ')'   
			{$$.type = IS_VOID; 
			}
		|	PRINTLN_T '(' STR_LIT ')'    
			{$$.type = IS_VOID; }
		|	WHILE_T  expr '{' 
			{ create_scope(NULL); } 
		
			statements '}' 
			{ exit_scope();  
			$$.type = IS_VOID; 
			}
			
		|	'{' 
			{create_scope(NULL); } 
			statements '}'  
			{exit_scope(); $$ = $3;}
		|	expr       
		;
%%

int
yyerror(char *s) {
  printf("Syntax error line %d\n",lineno);
}

int
main () {
    create_scope("global");
    yyparse();
    exit_scope();

}
