/* Infix notation calculator. */
%{ 
#define YYSTYPE int 
#include <math.h> 
#include <stdio.h> 

extern int yydebug;
extern const char *yytext;
extern YYSTYPE yylval;
extern YYSTYPE yylineno;

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
	yydebug=0;
        yyparse();
} 
%}

/* Bison declarations. */ 
%token NUM SEMICOLON
%left PLUS

%% /* The grammar follows. */ 

input: 
	| input exp
	;

exp: NUM 
	| exp PLUS exp { $$=$1 + $3; printf("= %d\n", $$); }
	;
%% 
