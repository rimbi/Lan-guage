default:
	bison -vtd lan-guage.y
	flex lan-guage.l
	gcc -g -o compiler lex.yy.c lan-guage.tab.c -lm 
	./compiler
