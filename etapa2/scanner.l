/* Bianca M Pelegrini - 279598 */

%{
    #include <stdio.h>
    #include <string>
    #include <map>
    #include "parser.tab.h"

    #define YY_NO_UNPUT
    
    int running = 0;
    int lines = 1;
    std::map<std::string, table_entry> symbolsTable;

    void initMe() {
        symbolsTable = std::map<std::string, table_entry>();    // re-init the map
        lines = 1;
        running = 1;
    }

    int getLineNumber() {
        return lines;
    }

    int isRunning() {
        return running;
    }

    void insertSymbol(std::string symbolValue, int symbolType) {
        table_entry symbolEntry = { symbolType, symbolValue };
        symbolsTable.insert(symbolEntry);
        return;
    }

    // Helper functions for debugging purposes
    void printSymbolsTable() {
        for (auto it = symbolsTable.begin(); it != symbolsTable.end(); ++it) {
            printf("%s => %d\n", it->first.c_str(), it->second);
        }
    }

    void temp(char* token) {
        printf("line: %d; token %s\n", lines, token);
    }
%}

%x LINE_COMMENT BLOCK_COMMENT

%%

"char"                              { return KW_CHAR; }
"int"                               { return KW_INT; }
"if"                                { return KW_IF; }
"then"                              { return KW_THEN; }
"else"                              { return KW_ELSE; }
"while"                             { return KW_WHILE; }
"read"                              { return KW_READ; }
"print"                             { return KW_PRINT; }
"return"                            { return KW_RETURN; }

"#"[0-9]+                           { insertSymbol(yytext, SYMBOL_LIT_INT); return LIT_INT; }
"'"."'"                             { insertSymbol(yytext, SYMBOL_LIT_CHAR); return LIT_CHAR; }
\"([^"\\]|\\.)*\"                   { insertSymbol(yytext, SYMBOL_LIT_STRING); return LIT_STRING; }
[a-zA-Z0-9]+                        { insertSymbol(yytext, SYMBOL_IDENTIFIER); return TK_IDENTIFIER; }

\,|\;|\:|\(|\)|\[|\]|\{|\}          { return yytext[0]; }
\=|\+|\-|\*|\/|\%|\<|\>|\&|\||\~    { return yytext[0]; }

"\n"                                { lines++; }
" "|\t|\r|\f|\v                     { /* skip any whitespaces BUT new line */ }

"//"                                { BEGIN(LINE_COMMENT); }
"/*"                                { BEGIN(BLOCK_COMMENT); }

<LINE_COMMENT>.+                    { }
<LINE_COMMENT>"\n"                  { lines++; BEGIN(INITIAL); }

<BLOCK_COMMENT>.                    { }
<BLOCK_COMMENT>"\n"                 { lines++; }
<BLOCK_COMMENT>"*/"                 { BEGIN(INITIAL); }

.                                   { return TOKEN_ERROR; }

%%

int yywrap() {
    running = 0;
    return 1;
}