/* Bianca Pelegrini - 279598 */

/* TODO
- Get the lines counting scheme figured out
- Handle identifiers
*/

%{
    #include <stdio.h>
    #include <string>
    #include <map>
    #include "tokens.h"

    #define ENTRY_IDENTIFIER 0
    #define ENTRY_LIT_INT 1
    #define ENTRY_LIT_CHAR 2
    #define ENTRY_LIT_STRING 6
    
    int running = 1;
    int lines = 1;
    std::map<std::string, int> symbolsTable;

    void initMe() {
        // re-initialize the map
        symbolsTable = std::map<std::string, int>();  // Assign an empty map
    }

    int getLineNumber() {
        return lines;
    }

    int isRunning() {
        return running;
    }

    // Helper methods for debugging
    void printSymbolsTable() {
        for (auto it = symbolsTable.begin(); it != symbolsTable.end(); ++it) {
            printf("%s => %d\n", it->first.c_str(), it->second);
        }
    }

    void insertSymbol(std::string value, int symbolType) {
        symbolsTable.insert(std::make_pair(value, symbolType));
        return;
    }

    void temp(char* token) {
        printf("line: %d; token %s\n", lines, token);
    }
%}

%x LINE_COMMENT BLOCK_COMMENT

%%

"char"                              { temp(yytext); return KW_CHAR; }
"int"                               { temp(yytext); return KW_INT; }
"if"                                { temp(yytext); return KW_IF; }
"then"                              { temp(yytext); return KW_THEN; }
"else"                              { temp(yytext); return KW_ELSE; }
"while"                             { temp(yytext); return KW_WHILE; }
"read"                              { temp(yytext); return KW_READ; }
"print"                             { temp(yytext); return KW_PRINT; }
"return"                            { temp(yytext); return KW_RETURN; }

"\n"                                { lines++; }
" "|\t|\r|\f|\v                     { /* skip any whitespaces except new line */}

"#"[0-9]+                           { insertSymbol(yytext, ENTRY_LIT_INT); temp(yytext); return LIT_INT; }
"'"."'"                             { insertSymbol(yytext, ENTRY_LIT_CHAR); temp(yytext); return LIT_CHAR; }
\"([^"\\]|\\.)*\"                   { insertSymbol(yytext, ENTRY_LIT_STRING); temp(yytext); return LIT_STRING; }


\,|\;|\:|\(|\)|\[|\]\{|\}           { temp(yytext); return yytext[0]; }
\=|\+|\-|\*|\/|\%|\<|\>|\&|\||\~    { temp(yytext); return yytext[0]; }

"//"                                { BEGIN(LINE_COMMENT); }
"/*"                                { BEGIN(BLOCK_COMMENT); }
<LINE_COMMENT>.                     { }
<LINE_COMMENT>"\n"                  { lines++; BEGIN(INITIAL); }
<BLOCK_COMMENT>.                    { }
<BLOCK_COMMENT>"\n"                 { lines++; }
<BLOCK_COMMENT>"*/"                 { BEGIN(INITIAL); }

.                                   { temp(yytext); return TOKEN_ERROR; }

%%
/*
#define TK_IDENTIFIER     280
*/

int yywrap() {
    running = 0;
    return 1;
}