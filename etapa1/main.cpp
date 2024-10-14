// Bianca Pelegrini - 279598

#include <stdio.h>
#include <stdlib.h>
#include <string>

int yylex();
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
        printf("\033[31mError: no file provided for analysis.\033[0m\nExample usage: \033[34m$ ./etapa1 swsourcecode.txt\033[0m\n");
        return 1;
    }

    initMe();
    yyin = fopen(argv[1], "r");

    int token = 0;
    while (isRunning())
    {
        token = yylex();
        printf("TOKEN %d %s\n", token, yytext);
    }

    printf("\nTotal lines: %d\n", getLineNumber());

    printf("Symbols table:\n");
    printSymbolsTable();
    return 0;
}