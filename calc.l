%{
#include <stdio.h>
#include "calc.tab.h"
%}

digit	([0-9])
ID ([a-z]+[0-9]*)

%%

"main()" { printf("TOK_MAINFN"); return(TOK_MAINFN);}
"{" { printf("TOK_OPEN_CURLY");return (TOK_OPEN_CURLY);}

"}" {printf("TOK_CLOSE_CURLY"); return (TOK_CLOSE_CURLY);}

"print" {printf("TOK_PRINT"); return (TOK_PRINT);}



"println"       {       return(TOK_PRINTLN);}


{digit}+	{
		sscanf(yytext, "%d", &(yylval.int_val));
		printf("TOK_NUM");
		return (TOK_NUM);
		}

{ID} { printf("TOK_IDENTIFIERS"); return (TOK_IDENTIFIERS);}
"=" { printf("TOK_EQUAL"); return(TOK_EQUAL);}
";"	{ printf("TOK_SEMICOLON");	return(TOK_SEMICOLON);	}
"-" { printf("TOK_NEGNUMBER"); return(TOK_NEGNUMBER);}
"+"	{ printf("TOK_ADD");	return(TOK_ADD);	}
"*"	{ printf("TOK_MUL");	return(TOK_MUL);	}
[\t] {}
[ \n] 	{}

.	{printf("Invalid character '%c', ignored\n", 
			yytext[0]);
	}

%%

int main(){
	yylex();
	return 0;
}

