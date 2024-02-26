%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantic.h"

extern int yylex();
extern int yyparse();
extern FILE *yyin;
%}

%union{
    struct classe *c;
    struct classes *cs;
    struct funcao *f;
    struct funcoes *fs;
    struct parametros *p;
    struct parametrosAux *pA;
    struct main *m;
    struct comandos *cmd;
    struct declaracao *d;
    struct atribuicao *a;
    struct conteudo_array *ca;
    struct conteudo_arrayAux *caA;
    struct tipo *t;
    struct tipo_array *ta;
    struct tipo_classe *tc;
    struct parametros_chamada_funcao *pcf;
    struct parametros_chamada_funcaoAux *pcfA;
    struct expressao *e;
    struct expressaoAux *eA;
    struct termo *term;
    struct termoAux *termAux;
    struct fator *fat;
    struct exp_cond *ec;
    struct exp_bool *eb;
    struct exp_boolAux *ebA;
    struct termo_booleano *tb;
    struct termo_booleanoAux *tbA;
    struct fator_booleano *fb;
    struct comparacao *comp;
    struct op_logico *ol;
    struct exp_rep *ep;
    struct exp_scan *es;
    struct exp_print *print;
    char *str;
    int nint;
    float nfloat;
}

%type<c> classe
%type<cs> classes
%type<f> funcao
%type<fs> funcoes
%type<p> parametros
%type<pA> parametrosAux
%type<m> main
%type<cmd> comandos
%type<d> declaracao
%type<a> atribuicao
%type<ca> conteudo_array
%type<caA> conteudo_arrayAux
%type<t> tipo
%type<ta> tipo_array
%type<tc> tipo_classe
%type<pcf> parametros_chamada_funcao
%type<pcfA> parametros_chamada_funcaoAux
%type<e> expressao
%type<eA> expressaoAux
%type<term> termo
%type<termAux> termoAux
%type<fat> fator
%type<ec> expressao_condicional
%type<eb> expressao_booleana
%type<ebA> expressao_booleanaAux
%type<tb> termo_booleano
%type<tbA> termo_booleanoAux
%type<fb> fator_booleano
%type<comp> comparacao
%type<ol> op_logico
%type<ep> expressao_repeticao
%type<es> expressao_scan
%type<print> expressao_print

%token TK_INT TK_FLOAT TK_CHAR TK_STRING TK_ARRAY
%token TK_CLASS TK_MAIN TK_FUNC TK_RETURN TK_NEW
%token TK_IF TK_ELSE TK_WHILE
%token TK_PRINT TK_SCAN
%token<nint> TK_NINT
%token<nfloat> TK_NFLOAT
%token<str> TK_PALAVRA
%token<str> TK_ID
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
    : classes funcoes main { printf("Sem erro\n"); }
    ;

classe
    : TK_CLASS TK_ID TK_LBRACE declaracao TK_RBRACE
    { $$ = newClasse($2, $4); }
    ;

classes
    : { $$ = NULL; }
    | classe classes
    { $$ = newClasses($1, $2); }
    ;

funcao
    : TK_FUNC TK_ID TK_LPAR parametros TK_RPAR TK_LBRACE comandos TK_RETURN expressao TK_SEMICOLON TK_RBRACE { $$ = newFuncao(1, $2, $4, $7, $9, NULL); }
    | TK_FUNC TK_ID TK_LPAR parametros TK_RPAR TK_LBRACE comandos TK_RETURN expressao_booleana TK_SEMICOLON TK_RBRACE { $$ = newFuncao(2, $2, $4, $7, NULL, $9); }
    ;

funcoes
    : { $$ = NULL; }
    | funcao funcoes { $$ = newFuncoes($1, $2); }
    ;

parametros
    : { $$ = NULL; }
    | tipo TK_ID { $$ = newParametros(1, $2, $1, NULL); }
    | tipo TK_ID TK_COMMA parametrosAux { $$ = newParametros(2, $2, $1, $4); }
    ;

parametrosAux
    : tipo TK_ID { $$ = newParametrosAux(1, $2, $1, NULL); }
    | tipo TK_ID TK_COMMA parametrosAux { $$ = newParametrosAux(2, $2, $1, $4); }
    ;

main
    : TK_MAIN TK_LPAR TK_RPAR TK_LBRACE comandos TK_RBRACE { $$ = newMain($5); }
    ;

comandos
    : { $$ = NULL; }
    | declaracao comandos { $$ = newComandos(1, $1, NULL, NULL, NULL, NULL, NULL, $2); }
    | atribuicao comandos { $$ = newComandos(2, NULL, $1, NULL, NULL, NULL, NULL, $2); }
    | expressao_condicional comandos { $$ = newComandos(3, NULL, NULL, $1, NULL, NULL, NULL, $2); }
    | expressao_repeticao comandos { $$ = newComandos(4, NULL, NULL, NULL, $1, NULL, NULL, $2); }
    | expressao_scan comandos { $$ = newComandos(5, NULL, NULL, NULL, NULL, $1, NULL, $2); }
    | expressao_print comandos { $$ = newComandos(6, NULL, NULL, NULL, NULL, NULL, $1, $2); }
    ;

declaracao
    : tipo atribuicao { $$ = newDeclaracao(1, $1, NULL, NULL, $2); }
    | tipo_array atribuicao { $$ = newDeclaracao(2, NULL, $1, NULL, $2); }
    | tipo_classe atribuicao { $$ = newDeclaracao(3, NULL, NULL, $1, $2); }
    ;

atribuicao
    : TK_ID TK_ATRIB expressao TK_SEMICOLON { $$ = newAtribuicao(1, $1, $3, NULL, NULL); }
    | TK_ID TK_ATRIB TK_LBRACKET conteudo_array TK_RBRACKET TK_SEMICOLON { $$ = newAtribuicao(2, $1, NULL, $4, NULL); }
    | TK_ID TK_ATRIB TK_NEW TK_ID TK_LPAR TK_RPAR TK_SEMICOLON { $$ = newAtribuicao(3, $1, NULL, NULL, NULL); }
    | TK_ID TK_ATRIB TK_ID TK_LPAR parametros_chamada_funcao TK_RPAR TK_SEMICOLON { $$ = newAtribuicao(4, $1, NULL, NULL, $5); }
    ;

conteudo_array
    : { $$ = NULL; }
    | expressao { $$ = newConteudoArray(1, $1, NULL); }
    | expressao TK_COMMA conteudo_arrayAux { $$ = newConteudoArray(2, $1, $3); }
    ;

conteudo_arrayAux
    : expressao { $$ = newConteudoArrayAux(1, $1, NULL); }
    | expressao TK_COMMA conteudo_arrayAux { $$ = newConteudoArrayAux(1, $1, $3); }
    ;

tipo
    : TK_INT { $$ = newTipo('i');}
    | TK_FLOAT { $$ = newTipo('f');}
    | TK_CHAR { $$ = newTipo('c');}
    | TK_STRING { $$ = newTipo('s');}
    ;

tipo_array
    : TK_ARRAY TK_LESS tipo TK_GREATER { $$ = newTipoArray($3); }
    ;

tipo_classe
    : TK_ID { $$ = newTipoClasse($1); }
    ;

parametros_chamada_funcao
    : { $$ = NULL; }
    | expressao { $$ = newParametrosChamadaFuncao(1, $1, NULL); }
    | expressao TK_COMMA parametros_chamada_funcaoAux { $$ = newParametrosChamadaFuncao(2, $1, $3); }
    ;

parametros_chamada_funcaoAux
    : expressao { $$ = newParametrosChamadaFuncaoAux(1, $1, NULL); }
    | expressao TK_COMMA parametros_chamada_funcaoAux { $$ = newParametrosChamadaFuncaoAux(1, $1, $3); }
    ;

expressao
    : termo expressaoAux { $$ = newExpressao($1, $2); }
    ;

expressaoAux
    : { $$ = NULL; }
    | TK_MINUS termo expressaoAux { $$ = newExpressaoAux(1, $2, $3); }
    | TK_PLUS termo expressaoAux { $$ = newExpressaoAux(1, $2, $3); }
    ;

termo
    : fator termoAux { $$ = newTermo($1, $2); }
    ;

termoAux
    : { $$ = NULL; }
    | TK_TIMES fator termoAux { $$ = newTermoAux(1, $2, $3); }
    | TK_SLASH fator termoAux { $$ = newTermoAux(2, $2, $3); }
    | TK_MODULE fator termoAux { $$ = newTermoAux(3, $2, $3); }
    ;

fator
    : TK_ID { $$ = newFator(1, $1, NULL); }
    | TK_NINT { $$ = newFator(2, NULL, NULL); }
    | TK_NFLOAT { $$ = newFator(3, NULL, NULL); }
    | TK_PALAVRA { $$ = newFator(4, NULL, NULL); }
    | TK_LPAR expressao TK_RPAR { $$ = newFator(5, NULL, $2); }
    ;

expressao_condicional
    : TK_IF TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE { $$ = newExpCond(1, $3, $6, NULL); }
    | TK_IF TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE TK_ELSE TK_LBRACE comandos TK_RBRACE { $$ = newExpCond(1, $3, $6, $10); }
    ;

expressao_booleana
    : termo_booleano expressao_booleanaAux { $$ = newExpBool($1, $2); }
    ;

expressao_booleanaAux
    : { $$ = NULL; }
    | TK_OR termo_booleano expressao_booleanaAux { $$ = newExpBoolAux($2, $3); }
    ;

termo_booleano
    : fator_booleano termo_booleanoAux { $$ = newTermoBooleano($1, $2); }
    ;

termo_booleanoAux
    : { $$ = NULL; }
    | TK_AND fator_booleano termo_booleanoAux { $$ = newTermoBooleanoAux($2, $3); }
    ;

fator_booleano
    : TK_NOT comparacao { $$ = newFatorBooleano(1, $2, NULL); }
    | comparacao { $$ = newFatorBooleano(2, $1, NULL); }
    | TK_NOT TK_LPAR expressao_booleana TK_RPAR { $$ = newFatorBooleano(3, NULL, $3); }
    | TK_LPAR expressao_booleana TK_RPAR { $$ = newFatorBooleano(4, NULL, $2); }
    ;

comparacao
    : expressao op_logico expressao { $$ = newComparacao($1, $2, $3); }
    ;

op_logico
    : TK_LESS { $$ = newOpLogico("<"); }
    | TK_GREATER { $$ = newOpLogico(">"); }
    | TK_NE { $$ = newOpLogico("!="); }
    | TK_LE { $$ = newOpLogico("<="); }
    | TK_GE { $$ = newOpLogico(">="); }
    | TK_EQ { $$ = newOpLogico("=="); }
    ;

expressao_repeticao
    : TK_WHILE TK_LPAR expressao_booleana TK_RPAR TK_LBRACE comandos TK_RBRACE { $$ = newExpRep($3, $6); }
    ;

expressao_scan
    : TK_SCAN TK_LPAR TK_ID TK_RPAR TK_SEMICOLON { $$ = newScan($3); }
    ;

expressao_print
    : TK_PRINT TK_LPAR expressao TK_RPAR TK_SEMICOLON { $$ = newPrint(1, $3, NULL); }
    | TK_PRINT TK_LPAR expressao_booleana TK_RPAR TK_SEMICOLON { $$ = newPrint(1, NULL, $3); }
    ;

%%

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
