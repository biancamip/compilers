// Bianca M Pelegrini - 279598

#include <stdio.h>
#include <stdlib.h>
#include <string>

int yylex();
int yyparse();
extern FILE *yyin;
extern char *yytext;

void initMe();
int isRunning();
int getLineNumber();
void printSymbolsTable();

int main(int argc, char **argv)
{
	if (argc < 2)
	{
		printf("\033[31mError: no file provided for analysis.\033[0m\nExample usage: \033[34m$ ./etapa1 sourcecode.txt\033[0m\n");
		return 1;
	}

	yyin = fopen(argv[1], "r");
	initMe();
	if (yyparse() == 0)
	{
		printf("All good! Syntax is correct.\n");
	}
	else
	{
		printf("Syntax error at line %d.\n", getLineNumber());
		exit(3);
	}

	printf("Symbols table:\n");
	printSymbolsTable();

	exit(0);
	return 0;
}