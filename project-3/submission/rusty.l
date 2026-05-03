%{
#include "rusty.tab.h"

int lineno = 1;
%}
%%
bool		{return(BOOL_T);}
false		{return(FALSE_T);}
fn		{return(FN_T);}
i32		{return(I32_T);}
if		{return(IF_T);}
else		{return(ELSE_T);}
let		{return (LET_T);}
main		{return(MAIN_T);}
mut		{return(MUT_T);}
read		{return(READ_T);}
print		{return(PRINT_T);}
println		{return(PRINTLN_T);}
true		{return(TRUE_T);}
void		{return(VOID_T);}
while		{return(WHILE_T);}
"//".*		;
"&&"		{return(AND);}
"||"		{return(OR);}
"!"		{return(NOT);}
"->"		{return(RET_SYM);}
"!="		{return(NE_SYM);}
"=="		{return(EQ_SYM);}
"<"		{return(LT_SYM);}
"<="		{return(LE_SYM);}
">"		{return(GT_SYM);}
">="		{return(GE_SYM);}
\+		{return('+');}
\-		{return('-');}
\*		{return('*');}
\%		{return('%');}
\/		{return('/'); }
\=		{return('='); }
\{		{return('{');}
\}		{return('}');}
\(		{return('(');}
\)		{return(')');}
\]		{return(']');}
\:		{return(':'); }
"["		{return('[');}
\;		{return(';');}
\,		{return(',');}
[a-zA-Z][a-zA-Z_0-9]*	{yylval.sval = strdup(yytext); return(ID);}
[0-9]+		{yylval.ival = atoi(yytext); return(INT_LIT);}
\"[^"]*\"	{yylval.sval = strdup(yytext); return(STR_LIT);}
[ \t]		;
[\n]		lineno++;

%%
