%{
#include <stdio.h>
%}

%%

"/\*.*\*/" {
  printf("Token comentario multilinha: %s\n", yytext);
}

[a-zA-Z][a-zA-Z0-9]* { 
  printf("Token identificador: %s\n", yytext);
}

[0-9]+ {
  printf("Token constante numerica: %d\n", atoi(yytext)); 
}

[+\-*/%] {
  printf("Token operador aritmetico: %c\n", yytext[0]);
}

[<>!=] {
  printf("Token operador relacional: %c\n", yytext[0]);
}

[++--] {
  printf("Token operador incremento|decremento: %c\n", yytext[0]);
}

[(){}.;] {
  printf("Token operador controle de fluxo: %c\n", yytext[0]);
}


"//" {
  printf("Token comentario: %s\n", yytext);
}

%%

int yywrap() {
    return 1;
}

int main() {
  yylex();
  return 0;
}