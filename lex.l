%option noyywrap
%{
    #include <stdio.h>
    #include "sintax.tab.h"
    // #define TK_INT 260
    // #define TK_FLOAT 261
    // #define TK_CHAR 262
    // #define TK_STRING 263
    // #define TK_CLASS 264
    // #define TK_MAIN 265
    // #define TK_IF 266
    // #define TK_ELSE 267
    // #define TK_WHILE 268
    // #define TK_PRINT 269
    // #define TK_SCAN 270
    // #define TK_ID 271
    // #define TK_NUMBER 272
    // #define TK_NE 273
    // #define TK_LE 274
    // #define TK_GE 275
    // #define TK_EQ 276
%}


%%

"inteiro" { printf("%s\n", yytext); return TK_INT; }
"real" { printf("%s\n", yytext); return TK_FLOAT; }
"caracter" { printf("%s\n", yytext); return TK_CHAR; }
"cadeia" { printf("%s\n", yytext); return TK_STRING; }
"arranjo" { printf("%s\n", yytext); return TK_ARRAY; }

"classe" { printf("%s\n", yytext); return TK_CLASS; }
"novo" { printf("%s\n", yytext); return TK_NEW; }
"principal" { printf("%s\n", yytext); return TK_MAIN; }
"funcao" { printf("%s\n", yytext); return TK_FUNC; }
"devolva" { printf("%s\n", yytext); return TK_RETURN; }
"se" { printf("%s\n", yytext); return TK_IF; }
"senao" { printf("%s\n", yytext); return TK_ELSE; }
"enquanto" { printf("%s\n", yytext); return TK_WHILE; }
"mostrar" { printf("%s\n", yytext); return TK_PRINT; }
"ler" { printf("%s\n", yytext); return TK_SCAN; }


"+"	|
"-" |
"*"	|
"/"	|
"%" |
"="	|
"|"	|
","	|
";"	|
["] |
"." |
":" |
"["	|
"]"	|
"{"	|
"}"	|
"("	|
")"	{ printf("%s\n", yytext); return yytext[0]; }

"<" { printf("%s\n", yytext); return '<'; }
">" { printf("%s\n", yytext); return '>'; }
"nao" { printf("%s\n", yytext); return TK_NOT; }
"e" { printf("%s\n", yytext); return TK_AND; }
"ou" { printf("%s\n", yytext); return TK_OR; }
"!=" { printf("%s\n", yytext); return TK_NE; }
"<=" { printf("%s\n", yytext); return TK_LE; }
">=" { printf("%s\n", yytext); return TK_GE; }
"==" { printf("%s\n", yytext); return TK_EQ; }

[a-zA-Z][a-zA-Z0-9]* { printf("id: %s\n", yytext); return TK_ID; }
[0-9]+"."+[0-9]+ |
[0-9]+ { printf("%s\n", yytext); return TK_NUMBER; }
[a-zA-Z_]?\"(\\.|[^\\"])*\" { printf("%s\n", yytext); return TK_PALAVRA; }

"//".* { /*regex para ignorar comentarios*/ }
[ \t\n\f\r]+ { /*regex para ignorar espacos em branco*/ }
. { printf("Inválido\n"); }

%%
