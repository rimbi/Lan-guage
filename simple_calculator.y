/* Infix notation calculator. */
%{ 
#define YYSTYPE int 
#include <math.h> 
#include <stdio.h> 

extern int yydebug;
extern const char *yytext;
extern YYSTYPE yylval;
extern YYSTYPE yylineno;

int if_statement_valid = 0;

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s-%s-%d\n",str, yytext, yylineno);
}
 
int yywrap()
{
        return 1;
} 
  
main()
{
	yydebug=1;
        yyparse();
} 
%}

/* Bison declarations. */ 
%token IFT THENT ELSET BEGINT ENDT NUMT SEMICOLONT SYMBOLT
%left PLUST

%% /* The grammar follows. */ 

program: block { printf("program bitti\n"); return 0; }
	;

block: BEGINT statement_list ENDT 
	;

statement_list: 
	| statement_list statement
	| statement_list block
	;

statement: exp {printf(";\n");}
	| if_statement
	| SYMBOLT '=' exp {printf(";\n");}
	;

if_statement: IFT exp THENT block 
	| IFT exp THENT block ELSET block 
	;

exp: NUMT 
	| exp PLUST exp { $$=$1 + $3; }
	;
%% 

