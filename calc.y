%{
int yylex();
int yyerror (char *s);
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
int symbols[100];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);

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
		// updateSymbolVal($1,$3);
		update_link($1,$3);
	}
	| TOK_PRINT expr
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
		// $$ = symbolVal($1);
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

// int computeSymbolIndex(char token)
// {
// 	int idx = -1;
// 	if(islower(token)) {
// 		idx = token - 'a' + 26;
// 	} else if(isupper(token)) {
// 		idx = token - 'A';
// 	}
// 	return idx;
// } 

// /* returns the value of a given symbol */
// int symbolVal(char symbol)
// {
// 	int bucket = computeSymbolIndex(symbol);
// 	return symbols[bucket];
// }

// /* updates the value of a given symbol */
// void updateSymbolVal(char symbol, int val)
// {
// 	int bucket = computeSymbolIndex(symbol);
// 	symbols[bucket] = val;
// }

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

//delete first item
struct node* deleteFirst() {

   //save reference to first link
   struct node *tempLink = head;
	
   //mark next to first link as first 
   head = head->next;
	
   //return the deleted link
   return tempLink;
}

//is list empty
bool isEmpty() {
   return head == NULL;
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
         printf("\n%d found at position %d, replaced with %d\n", key1, pos, val);
         return;
      }
      current = current->next;
      pos++;
   }
   
   insertFirst(key1,val);
}

//display the list
void printList() {
   struct node *ptr = head;
   printf("\n[ ");
	
   //start from the beginning
   while(ptr != NULL) {
      printf("(%c,%d) ",ptr->key,ptr->data);
      ptr = ptr->next;
   }
	
   printf(" ]");
}

int yyerror(char *s)
{
	printf("\n Parsing error: line %d\n", yylineno);
	exit(0);
	return 0;
}

int main()
{
	/* init symbol table */
	// int i;
	// for(i=0; i<52; i++) {
	// 	symbols[i] = 0;
	// }

   yyparse();
   return 0;
}
