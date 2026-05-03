CC      = gcc
CFLAGS  = -g -Wno-implicit-function-declaration

rusty:	lex.yy.c rusty.tab.c stab.c stab.h codegen.c codegen.h
	$(CC) $(CFLAGS) -o rusty lex.yy.c rusty.tab.c stab.c codegen.c

lex.yy.c:	rusty.l rusty.tab.h
	flex rusty.l

rusty.tab.c rusty.tab.h:	rusty.y
	bison -vd rusty.y

clean:
	rm -f lex.yy.c rusty.tab.* rusty.output rusty *.stackdump *.s a.out
