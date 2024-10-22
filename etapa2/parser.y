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
    var program
    | func program
	|
	;

var:
    var_type TOKEN_IDENTIFIER '=' literal ';'
    | var_type array '=' literal_list ';'
    | var_type array ';'
    ;

var_type:
	KW_INT
	| KW_CHAR
	;

literal:
	LIT_INT
	| LIT_STRING
	| LIT_CHAR
	;

array:
	TOKEN_IDENTIFIER '[' LIT_INT ']'
	;

literal_list:
    literal
    | literal literal_list
    ;

func:
	var_type TOKEN_IDENTIFIER '(' func_params_list ')' cmd
	;

func_params_list:
    var_type TOKEN_IDENTIFIER ',' func_params_list
    | var_type TOKEN_IDENTIFIER
    |
    ;

cmd:
    attribution
    | flow_ctrl
    | cmd_block
    | KW_RETURN expr
    | KW_PRINT print_args_list
    | KW_READ TOKEN_IDENTIFIER
    |
    ;

attribution:
	array '=' expr
	| TOKEN_IDENTIFIER '=' expr
	;

flow_ctrl:
    KW_IF '(' expr ')' KW_THEN cmd
    | KW_IF '(' expr ')' KW_THEN cmd KW_ELSE cmd
    | KW_WHILE '(' expr ')' cmd
    ;

cmd_block:
	'{' cmd_list '}'
	;

cmd_list:
	cmd ';' cmd_list
	|
	;

expr:
	TOKEN_IDENTIFIER
	| literal
	| array
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
	| TOKEN_IDENTIFIER '(' args_list ')'
	| '(' expr ')'
	|
	;

args_list:
    expr ',' args_list
    | expr
    ;

print_args_list:
    expr ' ' print_args_list
    | expr
    ;

%%

int yyerror(char *error_msg){
	fprintf(stderr,"Error in line %d: %s\n", getLineNumber(), error_msg);
	exit(3);
}
