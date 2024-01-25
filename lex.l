%{
#include <stdio.h>
%}


%%

"if"                                    { printf("PALAVRA RESERVADA: %s\n", yytext); }
"else"                                  { printf("PALAVRA RESERVADA: %s\n", yytext); }
"for"                                   { printf("PALAVRA RESERVADA: %s\n", yytext); }
"int"                                   { printf("PALAVRA RESERVADA: %s\n", yytext); }
"float"                                 { printf("PALAVRA RESERVADA: %s\n", yytext); }
"char"                                  { printf("PALAVRA RESERVADA: %s\n", yytext); }
"void"                                  { printf("PALAVRA RESERVADA: %s\n", yytext); }
"return"                                { printf("PALAVRA RESERVADA: %s\n", yytext); }
"main"                                  { printf("PALAVRA RESERVADA: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*                  { printf("IDENTIFIER: %s\n", yytext); }
-?[0-9]+(\.[0-9]+([eE][-+]?[0-9]+)?)?   { printf("NUMBER: %s\n", yytext); }
\"([^"\\]|\\.)*\"                       { printf("STRING: %s\n", yytext); }
"="                                     { printf("ATRIB %s\n", yytext); }
"=="                                    { printf("IGUAL %s\n", yytext); }
"+"                                     { printf("SOMA %s\n", yytext); }
"-"                                     { printf("SUB %s\n", yytext); }
"*"                                     { printf("MULT %s\n", yytext); }
"//".*                                  { /* Ignora comentários de linha única */ }
"/"                                     { printf("DIV %s\n", yytext); }
"<"                                     { printf("MENOR %s\n", yytext); }
"<="                                    { printf("MENORIGUAL %s\n", yytext); }
">"                                     { printf("MAIOR %s\n", yytext); }
">="                                    { printf("MAIORIGUAL %s\n", yytext); }
"!="                                    { printf("DIFERENTE %s\n", yytext); }
"\("                                    { printf("ABREPAR %s\n", yytext); }
"\)"                                    { printf("FECHAPAR %s\n", yytext); }
"\{"                                    { printf("ABRECHAVE %s\n", yytext); }
"\}"                                    { printf("FECHACHAVE %s\n", yytext); }
";"                                     { printf("PONTOVIRGULA %s\n", yytext); }
","                                     { printf("VIRGULA %s\n", yytext); }
[ \t\n]+                                { /* Ignora espaços em branco */ }
.                                       { printf("UNRECOGNIZED: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}
