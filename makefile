run: lex.l
	flex lex.l
	gcc lex.yy.c -o lexer.out
	./lexer.out < input.txt > output.txt
