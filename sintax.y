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
%token '<' '>' TK_NE TK_LE TK_GE TK_EQ TK_OR TK_AND TK_NOT
%token '+' '-' '*' '/' '=' '|'
%token '.' ',' ';' ':' '\"'
%token '(' ')' '[' ']' '{' '}'

%left '+' '-'
%left '*' '/'
%right '='
%nonassoc '>' '<' TK_NE TK_LE TK_GE TK_EQ TK_OR TK_AND TK_NOT

%%

program
    : classes funcoes main
    ;

classe
    : TK_CLASS TK_ID '{' declaracao '}'

classes
    :
    | classe classes
    ;

funcao
    : TK_FUNC TK_ID '(' parametros ')' '{' comandos TK_RETURN expressao ';' '}'
    | TK_FUNC TK_ID '(' parametros ')' '{' comandos TK_RETURN expressao_booleana ';' '}'
    ;

funcoes
    :
    | funcao funcoes
    ;

parametros
    :
    | tipo TK_ID
    | tipo TK_ID ',' parametrosAux
    ;

parametrosAux
    : tipo TK_ID
    | tipo TK_ID ',' parametrosAux
    ;

main
    : TK_MAIN '(' ')' '{' comandos '}'
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
    : TK_ID '=' expressao ';'
    | TK_ID '=' '[' conteudo_array ']' ';'
    | TK_ID '=' TK_NEW TK_ID '(' ')' ';'
    ;

conteudo_array
    :
    | expressao
    | expressao ',' conteudo_arrayAux
    ;

conteudo_arrayAux
    : expressao
    | expressao ',' conteudo_arrayAux
    ;

tipo
    : TK_INT
    | TK_FLOAT
    | TK_CHAR
    | TK_STRING
    ;

tipo_array
    : TK_ARRAY '<' tipo '>'
    ;

tipo_classe
    : TK_ID
    ;

expressao
    : termo expressaoAux
    ;

expressaoAux
    :
    | '-' termo expressaoAux
    | '+' termo expressaoAux
    ;

termo
    : fator termoAux
    ;

termoAux
    :
    | '*' fator termoAux
    | '/' fator termoAux
    | '%' fator termoAux
    ;

fator
    : TK_ID
    | TK_NUMBER
    | TK_PALAVRA
    | '(' expressao ')'
    ;

expressao_condicional
    : TK_IF '(' expressao_booleana ')' '{' comandos '}'
    | TK_IF '(' expressao_booleana ')' '{' comandos '}' TK_ELSE '{' comandos '}'
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
    | TK_NOT '(' expressao_booleana ')'
    | '(' expressao_booleana ')'
    ;

comparacao
    : expressao op_logico expressao
    ;

op_logico
    : '<'
    | '>'
    | TK_NE
    | TK_LE
    | TK_GE
    | TK_EQ
    ;

expressao_repeticao
    : TK_WHILE '(' expressao_booleana ')' '{' comandos '}'
    ;

expressao_scan
    : TK_SCAN '(' TK_ID ')' ';'
    ;

expressao_print
    : TK_PRINT '(' expressao ')' ';'
    | TK_PRINT '(' expressao_booleana ')' ';'
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
