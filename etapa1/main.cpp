// Bianca Pelegrini - 279598

#include <stdio.h>
#include <stdlib.h>

void initMe();
int getLineNumber();
int isRunning();
int yylex();

int main(int argc, char **argv)
{
    initMe();
    extern FILE *yyin;
    yyin = fopen(argv[1], "r");

    int token = 0;
    while (isRunning())
    {
        token = yylex();
    }

    printf("Total lines: %d\n", getLineNumber());
    return 0;
}