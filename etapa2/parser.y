/* Bianca M Pelegrini - 279598 */

%{
	#include <stdio.h>
	#include <stdlib.h>

	int getLineNumber();
	int yylex();

    #define SYMBOL_LIT_INT 1
    #define SYMBOL_LIT_CHAR 2
    #define SYMBOL_IDENTIFIER 7
%}


%token KW_CHAR
%token KW_INT

%token KW_IF
%token KW_THEN
%token KW_ELSE
%token KW_WHILE
%token KW_READ
%token KW_PRINT
%token KW_RETURN

%token TK_IDENTIFIER

%token LIT_INT
%token LIT_CHAR
%token LIT_STRING

%token TOKEN_ERROR

%%

program:
	|
	;

%%