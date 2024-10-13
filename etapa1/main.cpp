// Bianca Pelegrini - 279598

#include <stdio.h>
#include <stdlib.h>

void initMe();
int getLineNumber();
int isRunning();
int yylex();

int main(int argc, char **argv)
{
    if (argc < 2)
    {
        printf("\033[31mError: no file provided for analysis.\033[0m\nExample usage: \033[34m$ ./etapa1 swsourcecode.txt\033[0m\n");
        return 1;
    }

    initMe();
    extern FILE *yyin;
    yyin = fopen(argv[1], "r");

    int token = 0;
    while (isRunning())
    {
        token = yylex();
        printf("TOKEN %d\n", token);
    }

    printf("Total lines analyzed: %d\n", getLineNumber());
    return 0;
}