/* Infix notation calculator. */
%{ 
#define YYSTYPE int 
#include <stdlib.h> 
#include <math.h> 
#include <stdio.h> 

extern int yydebug;
extern const char *yytext;
extern YYSTYPE yylval;
extern YYSTYPE yylineno;

char *usage = "%s: usage [infile] [outfile]\n";

void yyerror(const char *str)
{
        fprintf(stderr,"error: %s-%s-%d\n",str, yytext, yylineno);
}
 
int yywrap()
{
        return 1;
} 
  
main(int argc, char *argv[])
{
	char *outfile;
	char *infile;
	extern FILE *yyin, *yyout;
	const char *progname = argv[0];

	if (argc > 3)
	{
		fprintf(stderr,usage, progname);
		exit(1);
	}

	if (argc > 1)
	{
		infile = argv[1];
		/* open for read */
		yyin = fopen(infile,"r");
		if (yyin == NULL) /* open failed */
		{
			fprintf(stderr,"%s:cannot open %s\n",progname, infile);
			exit (1);
		}
	}

	if(argc > 2)
	{
		outfile = argv[2];
		yyout = fopen(outfile,"w");
		if (yyout == NULL) /* open failed */
		{
			fprintf(stderr,"%s: cannot open %s\n", progname, outfile);
			exit(1);
		}
	}

	yydebug=0;
        yyparse();
} 
%}

/* Bison declarations. */ 
%token IFT THENT ELSET BEGINT ENDT NUMT SEMICOLONT SYMBOLT '\n'
%left PLUST

%% /* The grammar follows. */ 

program: block { printf("program bitti\n"); return 0; }
	;

block: BEGINT '\n' statement_list ENDT '\n'
	;

statement_list: 
	| statement_list statement 
	| statement_list block
	;

statement: exp '\n' {printf(";\n");}
	| if_statement
	| SYMBOLT '=' exp '\n' {printf(";\n");}
	;

if_statement: IFT exp THENT '\n' block 
	| IFT exp THENT '\n' block ELSET '\n' block
	;

exp: NUMT
	| exp PLUST exp { $$=$1 + $3; }
	;
%% 

