void yyerror(const char *s);
int yyparse();
int yylex();

struct arv {
    int tipo_no;
    struct arv *esq;
    struct arv *dir;
};

struct classe {
    char *id;

    struct declaracao *d;
};

struct classes {
    struct classe *cl;
    struct classes *cls;
};

struct funcao {
    int tipo_regra;
    char *id;

    struct parametros *p;
    struct comandos *c;
    struct expressao *e;
    struct exp_bool *ep;
};

struct funcoes {
    struct funcao *f;
    struct funcoes *fs;
};

struct parametros {
    int tipo_regra;
    char *id;

    struct tipo *t;
    struct parametrosAux *pA;
};

struct parametrosAux {
    int tipo_regra;
    char *id;

    struct tipo *t;
    struct parametrosAux *pA;
};

struct main {
    struct comandos *c;
};

struct comandos {
    int tipo_regra;

    struct declaracao *d;
    struct atribuicao *a;
    struct exp_cond *ec;
    struct exp_rep *er;
    struct exp_scan *es;
    struct exp_print *ep;
    struct comandos *c;
};

struct declaracao {
    int tipo_regra;

    struct tipo *t;
    struct tipo_array *ta;
    struct tipo_classe *tc;
    struct atribuicao *a;
};

struct atribuicao {
    int tipo_regra;
    char *id;

    struct expressao *e;
    struct conteudo_array *ca;
    struct parametros_chamada_funcao *pcf;
};

struct conteudo_array {
    int tipo_regra;

    struct expressao *e;
    struct conteudo_arrayAux *caA;
};

struct conteudo_arrayAux {
    int tipo_regra;

    struct expressao *e;
    struct conteudo_arrayAux *caA;
};

struct tipo {
    char tipo_token;
};

struct tipo_array {
    struct tipo *t;
};

struct tipo_classe {
    char* id;
};

struct parametros_chamada_funcao {
    int tipo_regra;

    struct expressao *e;
    struct parametros_chamada_funcaoAux *pcfA;
};

struct parametros_chamada_funcaoAux {
    int tipo_regra;

    struct expressao *e;
    struct parametros_chamada_funcaoAux *pcfA;
};

struct expressao {
    struct termo *t;
    struct expressaoAux *eA;
};

struct expressaoAux {
    int tipo_regra;

    struct termo *t;
    struct expressaoAux *eA;
};

struct termo {
    struct fator *f;
    struct termoAux *tA;
};

struct termoAux {
    int tipo_regra;

    struct fator *f;
    struct termoAux *tA;
};

struct fator {
    int tipo_regra;
    char *id;

    struct expressao *e;
};

struct exp_cond {
    int tipo_regra;

    struct exp_bool *eb;
    struct comandos *c;
    struct comandos *ce;
};

struct exp_bool {
    struct termo_booleano *tb;
    struct exp_boolAux *ebA;
};

struct exp_boolAux {
    struct termo_booleano *tb;
    struct exp_boolAux *ebA;
};

struct termo_booleano {
    struct fator_booleano *fb;
    struct termo_booleanoAux *tbA;
};

struct termo_booleanoAux {
    struct fator_booleano *fb;
    struct termo_booleanoAux *tbA;
};

struct fator_booleano {
    int tipo_regra;

    struct comparacao *c;
    struct exp_bool *eb;
};

struct comparacao {
    struct expressao *e;
    struct op_logico *ol;
    struct expressao *e2;
};

struct op_logico {
    char *tipo_token;
};

struct exp_rep {
    struct exp_bool *eb;
    struct comandos *c;
};

struct exp_scan {
    char *id;
};

struct exp_print {
    int tipo_regra;

    struct expressao *e;
    struct exp_bool *eb;
};

struct arv *newArv(int tipo_no, struct arv *esq, struct arv *dir);
struct classe *newClasse(char *id, struct declaracao *d);
struct classes *newClasses(struct classe *cl, struct classes *cls);
struct funcao *newFuncao(int tipo_regra, char *id, struct parametros *p, struct comandos *c, struct expressao *e, struct exp_bool *ep);
struct funcoes *newFuncoes(struct funcao *f, struct funcoes *fs);
struct parametros *newParametros(int tipo_regra, char *id, struct tipo *t, struct parametrosAux *pA);
struct parametrosAux *newParametrosAux(int tipo_regra, char *id, struct tipo *t, struct parametrosAux *pA);
struct main *newMain(struct comandos *c);
struct comandos *newComandos(int tipo_regra, struct declaracao *d, struct atribuicao *a, struct exp_cond *ec, struct exp_rep *er, struct exp_scan *es, struct exp_print *ep, struct comandos *c);
struct declaracao *newDeclaracao(int tipo_regra, struct tipo *t, struct tipo_array *ta, struct tipo_classe *tc, struct atribuicao *a);
struct atribuicao *newAtribuicao(int tipo_regra, char *id, struct expressao *e, struct conteudo_array *ca, struct parametros_chamada_funcao *pcf);
struct conteudo_array *newConteudoArray(int tipo_regra, struct expressao *e, struct conteudo_arrayAux *caA);
struct conteudo_arrayAux *newConteudoArrayAux(int tipo_regra, struct expressao *e, struct conteudo_arrayAux *caA);
struct tipo *newTipo(char tipo_token);
struct tipo_array *newTipoArray(struct tipo *t);
struct tipo_classe *newTipoClasse(char *id);
struct parametros_chamada_funcao *newParametrosChamadaFuncao(int tipo_regra, struct expressao *e, struct parametros_chamada_funcaoAux *pcfA);
struct parametros_chamada_funcaoAux *newParametrosChamadaFuncaoAux(int tipo_regra, struct expressao *e, struct parametros_chamada_funcaoAux *pcfA);
struct expressao *newExpressao(struct termo *t, struct expressaoAux *eA);
struct expressaoAux *newExpressaoAux(int tipo_regra, struct termo *t, struct expressaoAux *eA);
struct termo *newTermo(struct fator *f, struct termoAux *tA);
struct termoAux *newTermoAux(int tipo_regra, struct fator *f, struct termoAux *tA);
struct fator *newFator(int tipo_regra, char *id, struct expressao *e);
struct exp_cond *newExpCond(int tipo_regra, struct exp_bool *eb, struct comandos *c, struct comandos *ce);
struct exp_bool *newExpBool(struct termo_booleano *tb, struct exp_boolAux *ebA);
struct exp_boolAux *newExpBoolAux(struct termo_booleano *tb, struct exp_boolAux *ebA);
struct termo_booleano *newTermoBooleano(struct fator_booleano *fb, struct termo_booleanoAux *tbA);
struct termo_booleanoAux *newTermoBooleanoAux(struct fator_booleano *fb, struct termo_booleanoAux *tbA);
struct fator_booleano *newFatorBooleano(int tipo_regra, struct comparacao *c, struct exp_bool *eb);
struct comparacao *newComparacao(struct expressao *e, struct op_logico *ol, struct expressao *e2);
struct op_logico *newOpLogico(char *tipo_token);
struct exp_rep *newExpRep(struct exp_bool *eb, struct comandos *c);
struct exp_scan *newScan(char *id);
struct exp_print *newPrint(int tipo_regra, struct expressao *e, struct exp_bool *eb);

double seman(struct arv *arvore);
