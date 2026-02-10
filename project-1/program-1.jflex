%%

%class program1
%standalone

%{
    int indent = 0;
    boolean beginLine = true;
    boolean afterCloseBrace = false;
    boolean afterElse = false;

    void emit(String token) {
        // resolve deferred newline after }
        if (afterCloseBrace && !token.equals("else")) {
            System.out.println();
            beginLine = true;
        }
        afterCloseBrace = false;

        // resolve deferred newline after else (when not followed by {)
        if (afterElse && !token.equals("{")) {
            System.out.println();
            beginLine = true;
        }
        afterElse = false;

        if (token.equals("}")) {
            indent--;
            if (!beginLine) System.out.println();
            printIndent();
            System.out.print("}");
            beginLine = false;
            afterCloseBrace = true;
        } else if (token.equals("else")) {
            System.out.print(" else");
            beginLine = false;
            afterElse = true;
        } else if (token.equals("{")) {
            if (!beginLine) System.out.print(" ");
            else printIndent();
            System.out.print("{");
            indent++;
            System.out.println();
            beginLine = true;
        } else if (token.equals(";")) {
            if (!beginLine) System.out.print(" ");
            else printIndent();
            System.out.print(";");
            System.out.println();
            beginLine = true;
        } else if (token.equals("fn")) {
            if (!beginLine) System.out.println();
            System.out.print("fn");
            beginLine = false;
        } else {
            if (beginLine) printIndent();
            else System.out.print(" ");
            System.out.print(token);
            beginLine = false;
        }
    }

    void printIndent() {
        for (int i = 0; i < indent; i++) System.out.print("   ");
    }
%}

%eof{
    if (afterCloseBrace || !beginLine) System.out.println();
%eof}

%%

[ \t\n\r]+                  { /* skip whitespace */ }
"->"                        { emit("->"); }
">="                        { emit(">="); }
"<="                        { emit("<="); }
"<>"                        { emit("<>"); }
"=="                        { emit("=="); }
"fn"                        { emit("fn"); }
"let"                       { emit("let"); }
"if"                        { emit("if"); }
"else"                      { emit("else"); }
"while"                     { emit("while"); }
"println"                   { emit("println"); }
"i32"                       { emit("i32"); }
"mut"                       { emit("mut"); }
\"[^\"]*\"                  { emit(yytext()); }
[a-zA-Z][a-zA-Z0-9_]*      { emit(yytext()); }
[0-9]+                      { emit(yytext()); }
"{"                         { emit("{"); }
"}"                         { emit("}"); }
"("                         { emit("("); }
")"                         { emit(")"); }
","                         { emit(","); }
":"                         { emit(":"); }
";"                         { emit(";"); }
"="                         { emit("="); }
"+"                         { emit("+"); }
"-"                         { emit("-"); }
"*"                         { emit("*"); }
">"                         { emit(">"); }
"<"                         { emit("<"); }
"@"                         { emit("@"); }
.                           { System.err.println("Error: unexpected character '" + yytext() + "'"); }
