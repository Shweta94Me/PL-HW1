%{
int yylex();
int yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
void insertFirst(char key, int data);
int find1(char key);
void update_link(char key1,int val);


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

stmt: {exit(EXIT_SUCCESS);}
	| expr_stmt TOK_SEMICOLON stmt
;

expr_stmt:
	TOK_IDENTIFIERS TOK_EQUAL expr
	{
		update_link($1,$3);
	}
   |
   TOK_IDENTIFIERS TOK_MUL TOK_EQUAL expr
   {
      $$ = find1($1);
      $$ = $$ * $4;
      update_link($1,$$);
   }
   |
   TOK_IDENTIFIERS TOK_ADD TOK_EQUAL expr
   {
      $$ = find1($1);
      $$ = $$ + $4;
      update_link($1,$$);
   }
	| 
   TOK_PRINT expr
	{
		// fprintf(stdout, "the value is %d\n", $2);
		printf("The value is %d\n", $2);
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
		$$ = find1($1);
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

struct node {
   int data;
   char key;
   struct node *next;
};

struct node *head = NULL;
struct node *current = NULL;

void insertFirst(char key, int data) {
   //create a link
   struct node *link = (struct node*) malloc(sizeof(struct node));
   link->key = key;
   link->data = data;
   //point it to old first node
   link->next = head;
   //point first to new first node
   head = link;
}

int find1(char key) {

   //start from the first link
   struct node* current = head;
   //if list is empty
   if(head == NULL) {
      return 0;
   }
   //navigate through list
   while(current->key != key) {
      //if it is last node
      if(current->next == NULL) {
         return 0;
      } else {
         //go to next link
         current = current->next;
      }
   }      
   //if data found, return the current Link
   return current->data;
}

void update_link(char key1,int val){
	int pos = 0;
	if(head==NULL) {
	  insertFirst(key1,val);
      return;
   } 
   current = head;
   while(current->next!=NULL) {
      if(current->key == key1) {
         current->data = val;
         return;
      }
      current = current->next;
      pos++;
   }
   
   insertFirst(key1,val);
}

int yyerror(char *s)
{
	printf("\n Parsing error: line %d\n", yylineno);
	exit(0);
	return 0;
}

int main()
{
   yyparse();
   return 0;
}
