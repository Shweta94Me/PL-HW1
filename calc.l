%{
#include <stdio.h>
#include "calc.tab.h"
int yylex();
int yyerror (char *s);
%}

%option yylineno

digit	([0-9])
ID  [a-z][a-zA-Z0-9]*

%%

"main()"                        { return(TOK_MAINFN);}
"{"                             {return (TOK_OPEN_CURLY);}
"}"                             { return (TOK_CLOSE_CURLY);}
"print"                         {return (TOK_PRINT);}
"("                             {return (TOK_OPEN_ROUND);}
")"                             {return (TOK_CLOSE_ROUND);}

{digit}+	                    {yylval.int_val = atoi(yytext);      return (TOK_NUM);}
{ID}                            {yylval.str_val = yytext[0];  return (TOK_IDENTIFIERS);}

"="                             {return(TOK_EQUAL);}
";"	                            {return(TOK_SEMICOLON);	}
"+"	                            {return(TOK_ADD);	}
"*"	                            {return(TOK_MUL);	}
"-"                             {return(TOK_NEGNUMBER);}
[ \t\n]                         {}
[^a-z][a-zA-Z0-9]*              {printf("Lexical Error: %c\n", yytext[0]);}
.	                            {printf("Lexical Error: %c\n", yytext[0]);}

%%
