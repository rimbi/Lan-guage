%{
#include <stdio.h>
#include "lan-guage.tab.h"
%}

char			[a-zA-Z]
digit			[0-9]
number			{digit}+
symbol			{char}+{digit}*

%%
if			printf("if ("); return IFT;
then			printf(")\n"); return THENT;
else			printf("else\n"); return ELSET;
begin			printf("{\n"); return BEGINT;
end			printf("}\n"); return ENDT;
{number}                yylval=atoi(yytext); printf("%d", yylval); return NUMT;
{symbol}                printf("%s", yytext); return SYMBOLT;
[ \t]			;
\n			return '\n';
"+"			printf(" + "); return PLUST;
.			printf("%c", yytext[0]); return yytext[0];
%%

