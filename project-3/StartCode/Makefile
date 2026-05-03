rusty:	lex.yy.c rusty.tab.c stab.c stab.h 
	gcc -o rusty lex.yy.c rusty.tab.c  stab.c -ly -lfl

lex.yy.c:	rusty.l
	flex rusty.l

rusty.tab.c:	rusty.y
	bison -vd rusty.y

clean:
	rm -f lex.yy.c rusty.tab.*  rusty.output *.stackdump
