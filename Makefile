PROGRAM = compiler

$(PROGRAM): lan-guage.y lan-guage.l
	bison -vtd lan-guage.y
	flex lan-guage.l
	gcc -g -o $@ lex.yy.c lan-guage.tab.c -lm 

clean:
	@rm -f lex.yy.c language.tab.h language.output $(PROGRAM)

run: $(PROGRAM)
	./$<
