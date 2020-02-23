%{
int yylex();
int yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int symbols[100];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
extern int yylineno;
%}

%token TOK_SEMICOLON TOK_ADD TOK_MUL TOK_NUM TOK_NEGNUMBER TOK_EQUAL TOK_IDENTIFIERS TOK_MAINFN TOK_OPEN_CURLY TOK_CLOSE_CURLY TOK_PRINT TOK_OPEN_ROUND TOK_CLOSE_ROUND

%union{
        int int_val;
		char str_val;
}

%start prog
/*%type <int_val> expr TOK_NUM*/
%type <int_val> expr TOK_NUM 
%type <str_val> TOK_IDENTIFIERS expr_stmt
%left TOK_ADD TOK_SUB
%left TOK_MUL TOK_DIV

%%

prog: TOK_MAINFN TOK_OPEN_CURLY stmt TOK_CLOSE_CURLY;

stmt:
	| expr_stmt TOK_SEMICOLON stmt
;

expr_stmt:
	TOK_IDENTIFIERS TOK_EQUAL expr
	{
		updateSymbolVal($1,$3);
	}
	| TOK_PRINT expr TOK_SEMICOLON
		{
			fprintf(stdout, "the value is %d\n", $2);
		}
;

expr: 	 
	expr TOK_ADD expr
	  {
		$$ = $1 + $3;
	  }
	| expr TOK_MUL expr
	  {
		$$ = $1 * $3;
	  }
	| TOK_IDENTIFIERS
	{
		fprintf(stdout, "The identifier :%c\n", $1);
		$$ = symbolVal($1);
	}
	| TOK_NUM
	  { 	
		$$ = $1;
	  }
	| TOK_OPEN_ROUND TOK_NEGNUMBER TOK_NUM TOK_CLOSE_ROUND
	{
		$$ = -$3;
	}
;


%%

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
} 

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	int bucket = computeSymbolIndex(symbol);
	printf("Symbol:%c, Index:%d", symbol, bucket);
	return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
	int bucket = computeSymbolIndex(symbol);
	symbols[bucket] = val;
}


int yyerror(char *s)
{
	printf("\n Line no %d:%s\n", yylineno,s);
	exit(0);
	return 0;
}

int main()
{
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

   yyparse();
   return 0;
}
