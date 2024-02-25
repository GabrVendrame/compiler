%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYDEBUG 1

extern int yylex();
extern int yyparse();
extern void yyerror(const char*);
extern FILE *yyin;
%}

%token TK_INT TK_FLOAT TK_CHAR TK_STRING TK_ARRAY
%token TK_CLASS TK_MAIN TK_FUNC TK_RETURN TK_NEW
%token TK_IF TK_ELSE TK_WHILE
%token TK_PRINT TK_SCAN
%token TK_NUMBER TK_ID TK_PALAVRA
%token TK_LESS TK_GREATER TK_NE TK_LE TK_GE TK_EQ TK_OR TK_AND TK_NOT
%token TK_PLUS TK_MINUS TK_TIMES TK_SLASH TK_ATRIB TK_MODULE
%token '.' TK_COMMA TK_SEMICOLON ':' '\"'
%token TK_LPAR TK_RPAR TK_LBRACKET TK_RBRACKET TK_LBRACE TK_RBRACE

%left TK_PLUS TK_MINUS
%left TK_TIMES TK_SLASH
%right TK_ATRIB
%nonassoc TK_GREATER TK_LESS TK_NE TK_LE TK_GE TK_EQ TK_OR TK_AND TK_NOT

%%

program
    : classes funcoes main
    ;

classe
    : TK_CLASS TK_ID TK_LBRACE declaracao TK_RBRACE

classes
    :
    | classe classes
    ;

funcao
    : TK_FUNC TK_ID TK_LPAR parametros TK_RPAR TK_LBRACE comandos TK_RETURN expressao TK_SEMICOLON TK_RBRACE
    | TK_FUNC TK_ID TK_LPAR parametros TK_RPAR TK_LBRACE comandos TK_RETURN expressao_booleana TK_SEMICOLON TK_RBRACE
    ;

funcoes
    :
    | funcao funcoes
    ;

parametros
    :
    | tipo TK_ID
    | tipo TK_ID TK_COMMA parametrosAux
    ;

parametrosAux
    : tipo TK_ID
    | tipo TK_ID TK_COMMA parametrosAux
    ;

main
    : TK_MAIN TK_LPAR TK_RPAR TK_LBRACE comandos TK_RBRACE
    ;

comandos
    :
    | declaracao comandos
    | atribuicao comandos
    | expressao_condicional comandos
    | expressao_repeticao comandos
    | expressao_scan comandos
    | expressao_print comandos
    ;

declaracao
    : tipo atribuicao
    | tipo_array atribuicao
    | tipo_classe atribuicao
    ;

atribuicao
    : TK_ID TK_ATRIB expressao TK_SEMICOLON
    | TK_ID TK_ATRIB TK_LBRACKET conteudo_array TK_RBRACKET TK_SEMICOLON
    | TK_ID TK_ATRIB TK_NEW TK_ID TK_LPAR TK_RPAR TK_SEMICOLON
    ;

conteudo_array
    :
    | expressao
    | expressao TK_COMMA conteudo_arrayAux
    ;

conteudo_arrayAux
    : expressao
    | expressao TK_COMMA conteudo_arrayAux
    ;

tipo
    : TK_INT
    | TK_FLOAT
    | TK_CHAR
    | TK_STRING
    ;

tipo_array
    : TK_ARRAY TK_LESS tipo TK_GREATER
    ;

tipo_classe
    : TK_ID
    ;

expressao
    : termo expressaoAux
    ;

expressaoAux
    :
    | TK_MINUS termo expressaoAux
    | TK_PLUS termo expressaoAux
    ;

termo
    : fator termoAux
    ;

termoAux
    :
    | TK_TIMES fator termoAux
    | TK_SLASH fator termoAux
    | TK_MODULE fator termoAux
    ;

fator
    : TK_ID
    | TK_NUMBER
    | TK_PALAVRA
    | TK_LPAR expressao TK_RPAR
    ;

expressao_condicional
    : TK_IF TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE
    | TK_IF TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE TK_ELSE TK_LBRACE comandos TK_RBRACE
    ;

expressao_booleana
    : termo_booleano expressao_booleanaAux
    ;

expressao_booleanaAux
    :
    | TK_OR termo_booleano expressao_booleanaAux
    ;

termo_booleano
    : fator_booleano termo_booleanoAux
    ;

termo_booleanoAux
    :
    | TK_AND fator_booleano termo_booleanoAux
    ;

fator_booleano
    : TK_NOT comparacao
    | comparacao
    | TK_NOT TK_LPAR expressao_booleana TK_RPAR
    | TK_LPAR expressao_booleana TK_RPAR
    ;

comparacao
    : expressao op_logico expressao
    ;

op_logico
    : TK_LESS
    | TK_GREATER
    | TK_NE
    | TK_LE
    | TK_GE
    | TK_EQ
    ;

expressao_repeticao
    : TK_WHILE TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE
    ;

expressao_scan
    : TK_SCAN TK_LPAR TK_ID TK_RPAR TK_SEMICOLON
    ;

expressao_print
    : TK_PRINT TK_LPAR expressao TK_RPAR TK_SEMICOLON
    | TK_PRINT TK_LPAR expressao_booleana TK_RPAR TK_SEMICOLON
    ;

%%

void yyerror(const char *s){
    extern char* yytext;
    fprintf(stderr, "%s - %s\n", s, yytext);
}

int main(int argc, char *argv[]){
    if(argc < 2){
        printf("Modo de uso: %s <input_file>\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if(!file){
        perror("Erro ao abrir o arquivo!\n");
        return 1;
    }

    yyin = file;
    yyparse();

    fclose(file);
    return 0;
}
