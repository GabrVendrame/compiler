#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "semantic.h"

struct arv *newArv(int tipo_no, struct arv *esq, struct arv *dir) {
    struct arv *arvore = (struct arv*)malloc(sizeof(struct arv));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_no = tipo_no;
    arvore->esq = esq;
    arvore->dir = dir;

    return arvore;
}

struct classe *newClasse(char *id, struct declaracao *d) {
    struct classe *arvore = (struct classe*)malloc(sizeof(struct classe));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->id = id;
    arvore->d = d;

    return arvore;
}

struct classes *newClasses(struct classe *cl, struct classes *cls) {
    struct classes *arvore = (struct classes*)malloc(sizeof(struct classes));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->cl = cl;
    arvore->cls = cls;

    return arvore;
}

struct funcao *newFuncao(int tipo_regra, char *id, struct parametros *p, struct comandos *c, struct expressao *e, struct exp_bool *ep) {
    struct funcao *arvore = (struct funcao*)malloc(sizeof(struct funcao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->id = id;
    arvore->p = p;
    arvore->c = c;
    arvore->e = e;
    arvore->ep = ep;

    return arvore;
}

struct funcoes *newFuncoes(struct funcao *f, struct funcoes *fs) {
    struct funcoes *arvore = (struct funcoes*)malloc(sizeof(struct funcoes));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->f = f;
    arvore->fs = fs;

    return arvore;
}

struct parametros *newParametros(int tipo_regra, char *id, struct tipo *t, struct parametrosAux *pA) {
    struct parametros *arvore = (struct parametros*)malloc(sizeof(struct parametros));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->id = id;
    arvore->t = t;
    arvore->pA = pA;

    return arvore;
}

struct parametrosAux *newParametrosAux(int tipo_regra, char *id, struct tipo *t, struct parametrosAux *pA){
    struct parametrosAux *arvore = (struct parametrosAux*)malloc(sizeof(struct parametrosAux));

    if(!arvore) {
        yyerror("sem espaco\n");
    }

    arvore->tipo_regra = tipo_regra;
    arvore->id = id;
    arvore->t = t;
    arvore->pA = pA;
}

struct main *newMain(struct comandos *c) {
    struct main *arvore = (struct main*)malloc(sizeof(struct main));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->c = c;

    return arvore;
}

struct comandos *newComandos(int tipo_regra, struct declaracao *d, struct atribuicao *a, struct exp_cond *ec, struct exp_rep *er, struct exp_scan *es, struct exp_print *ep, struct comandos *c) {
    struct comandos *arvore = (struct comandos*)malloc(sizeof(struct comandos));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->d = d;
    arvore->a = a;
    arvore->ec = ec;
    arvore->er = er;
    arvore->es = es;
    arvore->ep = ep;
    arvore->c = c;

    return arvore;
}

struct declaracao *newDeclaracao(int tipo_regra, struct tipo *t, struct tipo_array *ta, struct tipo_classe *tc, struct atribuicao *a) {
    struct declaracao *arvore = (struct declaracao*)malloc(sizeof(struct declaracao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->t = t;
    arvore->ta = ta;
    arvore->tc = tc;
    arvore->a = a;

    return arvore;
}

struct atribuicao *newAtribuicao(int tipo_regra, char *id, struct expressao *e, struct conteudo_array *ca, struct parametros_chamada_funcao *pcf) {
    struct atribuicao *arvore = (struct atribuicao*)malloc(sizeof(struct atribuicao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->id = id;
    arvore->e = e;
    arvore->ca = ca;
    arvore->pcf = pcf;

    return arvore;
}

struct conteudo_array *newConteudoArray(int tipo_regra, struct expressao *e, struct conteudo_arrayAux *caA) {
    struct conteudo_array *arvore = (struct conteudo_array*)malloc(sizeof(struct conteudo_array));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->e = e;
    arvore->caA = caA;

    return arvore;
}

struct conteudo_arrayAux *newConteudoArrayAux(int tipo_regra, struct expressao *e, struct conteudo_arrayAux *caA) {
    struct conteudo_arrayAux *arvore = (struct conteudo_arrayAux*)malloc(sizeof(struct conteudo_arrayAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->e = e;
    arvore->caA = caA;

    return arvore;
}

struct tipo *newTipo(char tipo_token) {
    struct tipo *arvore = (struct tipo*)malloc(sizeof(struct tipo));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_token = tipo_token;

    return arvore;
}

struct tipo_array *newTipoArray(struct tipo *t) {
    struct tipo_array *arvore = (struct tipo_array*)malloc(sizeof(struct tipo_array));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->t = t;

    return arvore;
}

struct tipo_classe *newTipoClasse(char *id) {
    struct tipo_classe *arvore = (struct tipo_classe*)malloc(sizeof(struct tipo_classe));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->id = id;

    return arvore;
}

struct parametros_chamada_funcao *newParametrosChamadaFuncao(int tipo_regra, struct expressao *e, struct parametros_chamada_funcaoAux *pcfA) {
    struct parametros_chamada_funcao *arvore = (struct parametros_chamada_funcao*)malloc(sizeof(struct parametros_chamada_funcao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->e = e;
    arvore->pcfA = pcfA;

    return arvore;
}

struct parametros_chamada_funcaoAux *newParametrosChamadaFuncaoAux(int tipo_regra, struct expressao *e, struct parametros_chamada_funcaoAux *pcfA){
    struct parametros_chamada_funcaoAux *arvore = (struct parametros_chamada_funcaoAux*)malloc(sizeof(struct parametros_chamada_funcaoAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->e = e;
    arvore->pcfA = pcfA;

    return arvore;
}

struct expressao *newExpressao(struct termo *t, struct expressaoAux *eA) {
    struct expressao *arvore = (struct expressao*)malloc(sizeof(struct expressao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->t = t;
    arvore->eA = eA;

    return arvore;
}

struct expressaoAux *newExpressaoAux(int tipo_regra, struct termo *t, struct expressaoAux *eA) {
    struct expressaoAux *arvore = (struct expressaoAux*)malloc(sizeof(struct expressaoAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->t = t;
    arvore->eA = eA;

    return arvore;
}

struct termo *newTermo(struct fator *f, struct termoAux *tA) {
    struct termo *arvore = (struct termo*)malloc(sizeof(struct termo));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->f = f;
    arvore->tA = tA;

    return arvore;
}

struct termoAux *newTermoAux(int tipo_regra, struct fator *f, struct termoAux *tA) {
    struct termoAux *arvore = (struct termoAux*)malloc(sizeof(struct termoAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->f = f;
    arvore->tA = tA;

    return arvore;
}

struct fator *newFator(int tipo_regra, char *id, struct expressao *e) {
    struct fator *arvore = (struct fator*)malloc(sizeof(struct fator));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->id = id;
    arvore->e = e;

    return arvore;
}

struct exp_cond *newExpCond(int tipo_regra, struct exp_bool *eb, struct comandos *c, struct comandos *ce) {
    struct exp_cond *arvore = (struct exp_cond*)malloc(sizeof(struct exp_cond));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->eb = eb;
    arvore->c = c;
    arvore->ce = ce;

    return arvore;
}

struct exp_bool *newExpBool(struct termo_booleano *tb, struct exp_boolAux *ebA) {
    struct exp_bool *arvore = (struct exp_bool*)malloc(sizeof(struct exp_bool));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tb = tb;
    arvore->ebA = ebA;

    return arvore;
}

struct exp_boolAux *newExpBoolAux(struct termo_booleano *tb, struct exp_boolAux *ebA){
    struct exp_boolAux *arvore = (struct exp_boolAux*)malloc(sizeof(struct exp_boolAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tb = tb;
    arvore->ebA = ebA;

    return arvore;
}

struct termo_booleano *newTermoBooleano(struct fator_booleano *fb, struct termo_booleanoAux *tbA) {
    struct termo_booleano *arvore = (struct termo_booleano*)malloc(sizeof(struct termo_booleano));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->fb = fb;
    arvore->tbA = tbA;

    return arvore;
}

struct termo_booleanoAux *newTermoBooleanoAux(struct fator_booleano *fb, struct termo_booleanoAux *tbA) {
    struct termo_booleanoAux *arvore = (struct termo_booleanoAux*)malloc(sizeof(struct termo_booleanoAux));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->fb = fb;
    arvore->tbA = tbA;

    return arvore;
}

struct fator_booleano *newFatorBooleano(int tipo_regra, struct comparacao *c, struct exp_bool *eb) {
    struct fator_booleano *arvore = (struct fator_booleano*)malloc(sizeof(struct fator_booleano));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->c = c;
    arvore->eb = eb;

    return arvore;
}

struct comparacao *newComparacao(struct expressao *e, struct op_logico *ol, struct expressao *e2) {
    struct comparacao *arvore = (struct comparacao*)malloc(sizeof(struct comparacao));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->e = e;
    arvore->ol = ol;
    arvore->e2 = e2;

    return arvore;
}

struct op_logico *newOpLogico(char *tipo_token) {
    struct op_logico *arvore = (struct op_logico*)malloc(sizeof(struct op_logico));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_token = tipo_token;

    return arvore;
}

struct exp_rep *newExpRep(struct exp_bool *eb, struct comandos *c) {
    struct exp_rep *arvore = (struct exp_rep*)malloc(sizeof(struct exp_rep));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->eb = eb;
    arvore->c = c;

    return arvore;
}

struct exp_scan *newScan(char *id) {
    struct exp_scan *arvore = (struct exp_scan*)malloc(sizeof(struct exp_scan));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->id = id;

    return arvore;
}

struct exp_print *newPrint(int tipo_regra, struct expressao *e, struct exp_bool *eb) {
    struct exp_print *arvore = (struct exp_print*)malloc(sizeof(struct exp_print));

    if(!arvore) {
        yyerror("sem espaco\n");
        exit(0);
    }

    arvore->tipo_regra = tipo_regra;
    arvore->e = e;
    arvore->eb = eb;

    return arvore;
}

double seman(struct arv *arvore){
}

void yyerror(const char *s){
    extern char* yytext;
    extern int yylineno;
    fprintf(stderr, "Erro - %s na linha %d: %s\n", s, yylineno, yytext);
}
