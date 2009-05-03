default:
	bison -vtd simple_calculator.y
	flex simple_calculator.l
	gcc -g -o simple_calculator lex.yy.c simple_calculator.tab.c -lm 
	./simple_calculator
