%{
#include <stdio.h>
%}

%%
"main" {
    printf("Token funcao principal");
    return TK_FMAIN;
}

"inteiro" {
    printf("Token tipo inteiro");
    return TK_TINT;
}

"decimal" {
    printf("Token tipo decimal");
    return TK_TDECIMAL;
}

"caracter" {
    printf("Token tipo caracter");
    return TK_TCARACTER;
}

"booleano" {
    printf("Token tipo booleano");
    return TK_TBOOL;
}

"vazio" {
    printf("Token tipo vazio");
    return TK_TVAZIO;
}

"se" {
    printf("Token condicional");
    return TK_SE;
}

"senao" {
    printf("Token senao");
    return TK_SENAO;
}

"switch" {
    printf("Token condicional switch");
    return TK_SWITCH;
}

"caso" {
    printf("Token condicional case");
    return TK_CASO;
}

"pare" {
    printf("Token parada forcada");
    return TK_PARE;
}

"for" {
    printf("Token laco de repeticao");
    return TK_LOOP;
}

"enquanto" {
    printf("Token laco de repeticao");
    return TK_LOOP;
}

"print" {
    printf("Token de saida");
    return TK_PRINT;
}

"retorna" {
    printf("Token return");
    return TK_RETURN;
}

"+" {
    printf("Token operador soma");
    return TK_OPSOMA;
}

"-" {
    printf("Token operador subtracao");
    return TK_OPSUB;
}

"*" {
    printf("Token operador mutiplicacao");
    return TK_OPMULT;
}

"/" {
    printf("Token operador divisao");
    return TK_OPDIV;
}

"%" {
    printf("Token operador modulo");
    return TK_OPMOD;
}

"=" {
    printf("Token operador atribuicao");
    return TK_OPATRIB;
}

"==" {
    printf("Token operador igualdade");
    return TK_OPIGUAL;
}

"!=" {
    printf("Token operador diferente");
    return TK_OPDIFERENTE;
}

">" {
    printf("Token operador maior");
    return TK_OPMAIOR;
}

"<" {
    printf("Token operador menor");
    return TK_OPMENOR;
}

">=" {
    printf("Token operador maior ou igual");
    return TK_OPMENORIGUAL;
}

"<=" {
    printf("Token operador menor ou igual");
    return TK_OPMENORIGUAL;
}

"&&" {
    printf("Token operador logico e");
    return TK_OPE;
}

"||" {
    printf("Token operador logico ou");
    return TK_OU;
}

"!" {
    printf("Token operador logico nao");
    return TK_NAO;
}

"(" {
    printf("Token parenteses aberto");
    return TK_PABRE;
}

")" {
    printf("Token parenteses fechado");
    return TK_PFECHA;
}

"{" {
    printf("Token chave aberta");
    return TK_CHABRE;
}

"}" {
    printf("Token chave fechada");
    return TK_CHFECHA;
}

"[" {
    printf("Token colchete aberto");
    return TK_CABRE;
}

"]" {
    printf("Token colchete fechado");
    return TK_CFECHA;
}

";" {
    printf("Token ponto e virgula");
    return TK_PONTOVIRGULA;
}

"," {
    printf("Token virgula");
    return TK_VIRGULA;
}

"\"" {
    printf("Token aspas duplas");
    return TK_ASPASDUPLAS;
}

"'" {
    printf("Token aspas simples");
    return TK_ASPASSIMPLES;
}

"//" {
    printf("Token comentario de linha");
    return TK_COMENTARIOLINHA;
}

"/*" {
    printf("Token comentario de bloco");
    return TK_COMENTARIOBLOCO;
}

"*/" {
    printf("Token comentario de bloco");
    return TK_COMENTARIOBLOCO;
}

"verdadeiro" {
    printf("Token booleano verdadeiro");
    return TK_BOOLVERDADEIRO;
}

"falso" {
    printf("Token booleano falso");
    return TK_BOOLFALSO;
}
%%

int main() {
    yylex();
    return 0;
}
