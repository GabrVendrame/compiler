%option noyywrap
%{
    #include "semantic.h"
    #include "sintax.tab.h"
%}


%%

"inteiro" { yylval.typeC = 'a'; return TK_TYPE; }
"real" { yylval.typeC = 'b'; return TK_TYPE; }
"caracter" { yylval.typeC = 'c'; return TK_TYPE; }
"frase" { yylval.typeC = 'd'; return TK_TYPE; }

"class" { printf("%s\n", yytext); return TK_CLASS; }
"new" { printf("%s\n", yytext); return TK_NEW; }
"main" { printf("%s\n", yytext); return TK_MAIN; }
"se" { printf("%s\n", yytext); return TK_IF; }
"senao" { printf("%s\n", yytext); return TK_ELSE; }
"enquanto" { printf("%s\n", yytext); return TK_WHILE; }
"print" { printf("%s\n", yytext); return TK_PRINT; }
"scan" { printf("%s\n", yytext); return TK_SCAN; }
"vetor" { printf("%s\n", yytext); return TK_VECTOR; }

[a-zA-Z][a-zA-Z0-9]* { yylval.id = lookUp(yytext); return TK_ID; }
[0-9]+"."+[0-9]+ |
[0-9]+ { yylval.d = atof(yytext); return TK_NUMBER; }

"+"	|
"-" |
"*"	|
"/"	|
"="	|
"|"	|
","	|
";"	|
":"	|
"."	|
"["	|
"]"	|
"{"	|
"}"	|
"("	|
")"	{ return yytext[0]; }

"<" | { yylval.fn = 1; return TK_CMP; }
">" | { yylval.fn = 2; return TK_CMP; }
"!=" | { yylval.fn = 3; return TK_CMP; }
"<=" | { yylval.fn = 4; return TK_CMP; }
">=" | { yylval.fn = 5; return TK_CMP; }
"==" | { yylval.fn = 6; return TK_CMP; }

"//".* { /*regex para ignorar comentarios*/ }
[ \t\n] { /*regex para ignorar espacos em branco*/ }
. { yyerror("Caractere não reconhecido\n"); }

%%
