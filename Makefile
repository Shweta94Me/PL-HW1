all: compile_flex compile_bison link_flex_bison

compile_flex:
	flex -l calc.l

compile_bison:
	bison -dv calc.y

link_flex_bison:
	gcc -o calc calc.tab.c lex.yy.c -lfl

clean: 
	rm -rf lex.yy.c calc.tab.c calc.tab.h calc calc.output calc.dSYM