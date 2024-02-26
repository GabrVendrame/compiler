run: lex.l sintax.y
	rm -rf sintax.tab.c sintax.tab.h lex.yy.c compiler
	bison -d sintax.y
	flex lex.l
	gcc -o compiler semantic.c sintax.tab.c lex.yy.c -lfl

remove: sintax.tab.c sintax.tab.h lex.yy.c
	rm -rf sintax.tab.c sintax.tab.h lex.yy.c compiler
