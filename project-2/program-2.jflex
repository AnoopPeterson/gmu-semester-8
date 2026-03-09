%%

%class program2
%int
%line

%{
  static final int EOF_T = 0;
  static final int FN_T = 1;
  static final int ID = 2;
  static final int LPAREN = 3;
  static final int RPAREN = 4;
  static final int LBRACE = 5;
  static final int RBRACE = 6;
  static final int SEMI = 7;
  static final int COMMA = 8;
  static final int COLON = 9;
  static final int ASSIGN = 10;
  static final int PLUS = 11;
  static final int MINUS = 12;
  static final int MULT = 13;
  static final int DIV = 14;
  static final int I32_T = 15;
  static final int LET_T = 16;
  static final int MUT_T = 17;
  static final int PRINTLN_T = 18;
  static final int IF_T = 19;
  static final int THEN_T = 20;
  static final int ELSE_T = 21;
  static final int INT_LIT = 22;
  static final int RET_SYM = 23;
  static final int AT = 24;
  static final int MOD = 25;

  static program2 lexer;
  static int currentToken;
  static int lineCount = 0;

  static int getToken() {
    try {
      return lexer.yylex();
    } catch (Exception e) {
      return EOF_T;
    }
  }

  static void match(int expected) {
    if (currentToken == expected) {
      currentToken = getToken();
    } else {
      error();
    }
  }

  static void error() {
    System.out.println("Syntax error found on line " + (lexer.yyline + 1));
    System.exit(1);
  }

  /* rusty -> functions EOF */
  static void rusty() {
    functions();
    if (currentToken != EOF_T) {
      error();
    }
  }

  /* functions -> function functions'
     functions' -> function functions' | e */
  static void functions() {
    function_rule();
    while (currentToken == FN_T) {
      function_rule();
    }
  }

  /* function -> FN_T ID ( opt_parameter ) opt_return { statements } */
  static void function_rule() {
    match(FN_T);
    match(ID);
    match(LPAREN);
    opt_parameter();
    match(RPAREN);
    opt_return();
    match(LBRACE);
    statements();
    match(RBRACE);
  }

  /* opt_parameter -> params | e */
  static void opt_parameter() {
    if (currentToken == ID) {
      params();
    }
  }

  /* params -> param params'
     params' -> , param params' | e */
  static void params() {
    param();
    while (currentToken == COMMA) {
      match(COMMA);
      param();
    }
  }

  /* param -> ID : I32_T */
  static void param() {
    match(ID);
    match(COLON);
    match(I32_T);
  }

  /* opt_return -> RET_SYM I32_T | e */
  static void opt_return() {
    if (currentToken == RET_SYM) {
      match(RET_SYM);
      match(I32_T);
    }
  }

  /* statements -> statement statements'
     statements' -> statement statements' | e */
  static void statements() {
    statement();
    while (currentToken == LET_T || currentToken == ID || currentToken == INT_LIT
           || currentToken == LPAREN || currentToken == PRINTLN_T || currentToken == IF_T
           || currentToken == LBRACE) {
      statement();
    }
  }

  /* statement -> LET_T [MUT_T] ID = expr ;
               | PRINTLN_T ( expr ) ;
               | IF_T expr THEN_T statement [ELSE_T statement]
               | { statements }
               | expr ; */
  static void statement() {
    if (currentToken == LET_T) {
      match(LET_T);
      if (currentToken == MUT_T) {
        match(MUT_T);
      }
      match(ID);
      match(ASSIGN);
      expr();
      match(SEMI);
    } else if (currentToken == PRINTLN_T) {
      match(PRINTLN_T);
      match(LPAREN);
      expr();
      match(RPAREN);
      match(SEMI);
    } else if (currentToken == IF_T) {
      match(IF_T);
      expr();
      match(THEN_T);
      statement();
      if (currentToken == ELSE_T) {
        match(ELSE_T);
        statement();
      }
    } else if (currentToken == LBRACE) {
      match(LBRACE);
      statements();
      match(RBRACE);
    } else {
      expr();
      match(SEMI);
    }
  }

  /* opt_actual -> actuals | e */
  static void opt_actual() {
    if (currentToken == ID || currentToken == INT_LIT || currentToken == LPAREN) {
      actuals();
    }
  }

  /* actuals -> expr actuals'
     actuals' -> , expr actuals' | e */
  static void actuals() {
    expr();
    while (currentToken == COMMA) {
      match(COMMA);
      expr();
    }
  }

  /* expr -> term expr'
     expr' -> + term expr' | - term expr' | e */
  static void expr() {
    term();
    while (currentToken == PLUS || currentToken == MINUS) {
      currentToken = getToken();
      term();
    }
  }

  /* term -> factor term'
     term' -> * factor term' | / factor term' | e */
  static void term() {
    factor();
    while (currentToken == MULT || currentToken == DIV || currentToken == MOD) {
      currentToken = getToken();
      factor();
    }
  }

  /* factor -> ID [ ( opt_actual ) ] | INT_LIT | ( expr ) */
  static void factor() {
    if (currentToken == ID) {
      match(ID);
      if (currentToken == LPAREN) {
        match(LPAREN);
        opt_actual();
        match(RPAREN);
      }
    } else if (currentToken == INT_LIT) {
      match(INT_LIT);
    } else if (currentToken == LPAREN) {
      match(LPAREN);
      expr();
      match(RPAREN);
    } else {
      error();
    }
  }

  public static void main(String[] args) throws Exception {
    lexer = new program2(System.in);
    currentToken = getToken();
    rusty();
    System.out.println("Input accepted with " + lineCount + " lines");
  }
%}

%eofval{
  return EOF_T;
%eofval}

%%

"!"[^\n]*       { /* skip comments */ }
"//"[^\n]*      { /* skip comments */ }
[ \t\r]+        { /* skip whitespace */ }
\n              { lineCount++; }

"else"          { return ELSE_T; }
"fn"            { return FN_T; }
"if"            { return IF_T; }
"i32"           { return I32_T; }
"let"           { return LET_T; }
"mut"           { return MUT_T; }
"println"       { return PRINTLN_T; }
"then"          { return THEN_T; }

"->"            { return RET_SYM; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"%"             { return MOD; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMI; }
"="             { return ASSIGN; }
":"             { return COLON; }
","             { return COMMA; }
"@"             { return AT; }

[a-zA-Z][a-zA-Z0-9]*  { return ID; }
[0-9]+                 { return INT_LIT; }

.               { /* skip unknown characters */ }
