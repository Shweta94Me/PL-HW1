%{
#include <stdio.h>
#include "calc.tab.h"
int yylex();
int yyerror (char *s);
%}

%option yylineno

digit	([0-9])
ID ([a-z]+[0-9]*)

%%

"main()" { printf("TOK_MAINFN\n");return(TOK_MAINFN);}
"{" {printf("TOK_OPEN_CURLY\n");return (TOK_OPEN_CURLY);}

"}" {printf("TOK_CLOSE_CURLY\n"); return (TOK_CLOSE_CURLY);}

"print" {printf("TOK_PRINT\n");return (TOK_PRINT);}
"(" {printf("TOK_OPEN_ROUND\n");return (TOK_OPEN_ROUND);}
")" {printf("TOK_CLOSE_ROUND\n"); return (TOK_CLOSE_ROUND);}



{digit}+	{ yylval.int_val = atoi(yytext);
		printf("TOK_NUM\n");
		return (TOK_NUM);
		}

{ID} {	yylval.str_val = yytext[0];
		printf("TOK_IDENTIFIERS\n");
		return (TOK_IDENTIFIERS);}
"=" {printf("TOK_EQUAL\n"); return(TOK_EQUAL);}
";"	{printf("TOK_SEMICOLON\n"); return(TOK_SEMICOLON);	}
"-" {printf("TOK_NEGNUMBER\n"); return(TOK_NEGNUMBER);}
"+"	{printf("TOK_ADD\n"); return(TOK_ADD);	}
"*"	{printf("TOK_MUL\n"); return(TOK_MUL);	}
[ \t\n] {}
.	{printf("Invalid character : %c, ignored\n", yytext[0]);}

%%
