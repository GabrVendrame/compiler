run: lex.l sintax.y
	rm -rf sintax.tab.c sintax.tab.h compiler
	bison -d -v sintax.y
	flex lex.l
	gcc -o compiler sintax.tab.c lex.yy.c -lfl

remove: sintax.tab.c sintax.tab.h lex.yy.c
	rm -rf sintax.tab.c sintax.tab.h lex.yy.c compiler
