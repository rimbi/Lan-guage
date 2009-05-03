%{
#include <stdio.h>
#include "simple_calculator.tab.h"
%}

%%
[0-9]+                  yylval=atoi(yytext); return NUM;
[ \t\n]			;
"+"			return PLUS;
";"			return SEMICOLON;
%%

