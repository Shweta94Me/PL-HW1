%{
int yylex();
%}
%{
#include <stdio.h>
%}

%token TOK_SEMICOLON TOK_ADD TOK_SUB TOK_MUL TOK_DIV TOK_NUM TOK_PRINTLN TOK_NEGNUMBER TOK_EQUAL TOK_IDENTIFIERS TOK_MAINFN TOK_OPEN_CURLY TOK_CLOSE_CURLY TOK_PRINT TOK_OPEN_ROUND TOK_CLOSE_ROUND

%union{
        int int_val;
}

/*%type <int_val> expr TOK_NUM*/
%type <int_val> expr TOK_NUM

%left TOK_ADD TOK_SUB
%left TOK_MUL TOK_DIV

%%

prog: TOK_MAINFN TOK_OPEN_CURLY stmt TOK_CLOSE_CURLY;

stmt: 
	| expr_stmt TOK_SEMICOLON stmt
;

expr_stmt:
	TOK_IDENTIFIERS TOK_EQUAL expr
	| TOK_IDENTIFIERS TOK_MUL TOK_EQUAL expr
	| TOK_IDENTIFIERS TOK_ADD TOK_EQUAL expr
	| TOK_PRINT expr
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
	| TOK_NUM
	  { 	
		$$ = $1;
	  }
	| TOK_OPEN_ROUND TOK_NEGNUMBER TOK_NUM TOK_CLOSE_ROUND
;


%%

int yyerror(char *s)
{
	printf("syntax error\n");
	return 0;
}

int main()
{
   yyparse();
   return 0;
}
