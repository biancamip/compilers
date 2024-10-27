/* Bianca M Pelegrini - 279598 */

%{
    #include "table.h"
	#include <stdio.h>
	#include <stdlib.h>

	int yylex();
	int yyerror(char *msg);
	int getLineNumber();
    struct table_entry;
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
%token TOKEN_ERROR

%token<symbol> TOKEN_IDENTIFIER
%token<symbol> LIT_INT
%token<symbol> LIT_CHAR
%token<symbol> LIT_STRING
%union { table_entry* symbol; };

%%

program:
    var_def program
    | func program
	|
	;

var_def:
    var_type TOKEN_IDENTIFIER '=' literal ';'
    | var_type TOKEN_IDENTIFIER '[' LIT_INT ']' '=' literal_list ';'
    | var_type TOKEN_IDENTIFIER '[' LIT_INT ']' ';'
    ;

var_type:
	KW_INT
	| KW_CHAR
	;

literal:
	LIT_INT
	| LIT_CHAR
	;

literal_list:
    literal
    | literal literal_list
    ;

func:
	var_type TOKEN_IDENTIFIER '(' func_params_list ')' cmd_block
	| var_type TOKEN_IDENTIFIER '(' ')' cmd_block
	;

func_params_list:
    var_type TOKEN_IDENTIFIER ',' func_params_list
    | var_type TOKEN_IDENTIFIER
    ;

cmd:
	cmd_single
	| cmd_block
	| cmd_list
	;

cmd_single:
    attribution ';'
    | flow_ctrl
    | KW_RETURN expr ';'
    | KW_PRINT print_args_list ';'
    | KW_READ TOKEN_IDENTIFIER ';'
	| ';'
    ;

cmd_block:
	'{' cmd_list '}'
	| '{' cmd_block '}'
	| '{' '}'
	;

cmd_list:
	cmd_single cmd_list
	| cmd_single
	;

attribution:
	TOKEN_IDENTIFIER '[' expr ']' '=' expr
	| TOKEN_IDENTIFIER '=' expr
	;

flow_ctrl:
    KW_IF '(' expr ')' KW_THEN cmd
    | KW_IF '(' expr ')' KW_THEN cmd KW_ELSE cmd
    | KW_WHILE '(' expr ')' cmd
    ;

expr:
	TOKEN_IDENTIFIER
	| literal
	| TOKEN_IDENTIFIER '[' expr ']'
	| expr '+' expr
	| expr '-' expr
	| expr '*' expr
	| expr '/' expr
	| expr '<' expr
	| expr '>' expr
    | expr '=' expr
    | expr '&' expr
    | expr '|' expr
    | '~' expr
	| TOKEN_IDENTIFIER '(' func_args_list ')'
	| '(' expr ')'
	;

func_args_list:
    expr ',' func_args_list
    | expr
    ;

print_args_list:
    expr print_args_list
	| LIT_STRING print_args_list
    | expr
	| LIT_STRING
    ;

%%

int yyerror(char *error_msg){
	fprintf(stderr,"Error in line %d: %s\n", getLineNumber(), error_msg);
	exit(3);
}
