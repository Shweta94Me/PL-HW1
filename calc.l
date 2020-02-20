%{
#include <stdio.h>
#include "calc.tab.h"
%}

digit	([0-9])
ID ([a-z]+[0-9]*)

%%

"println"       {       return(TOK_PRINTLN);}


{digit}+	{
		sscanf(yytext, "%d", &yylval);
		return TOK_NUM;
		}

{ID} { return TOK_IDENTIFIERS;}
"=" { return(TOK_EQUAL);}
";"	{	return(TOK_SEMICOLON);	}
"-" { return(TOK_NEGNUMBER)}
"+"	{	return(TOK_ADD);	}
"*"	{	return(TOK_MUL);	}

[ \n] 	{}

.	{printf("Invalid character '%c', ignored\n", 
			yytext[0]);
	}

%%

