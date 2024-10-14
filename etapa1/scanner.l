/* Bianca Pelegrini - 279598 */

%{
    #include <stdio.h>
    #include <string>
    #include <map>
    #include "tokens.h"

    #define ENTRY_IDENTIFIER 0
    #define ENTRY_LIT_INT 1
    #define ENTRY_LIT_CHAR 2
    #define ENTRY_LIT_STRING 6
    
    int running = 0;
    int lines = 1;
    std::map<std::string, int> symbolsTable;

    void initMe() {
        running = 1;
        symbolsTable = std::map<std::string, int>();    // re-init the map
    }

    int getLineNumber() {
        return lines;
    }

    int isRunning() {
        return running;
    }

    // Helper methods for debugging purposes
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

"#"[0-9]+                           { temp(yytext); insertSymbol(yytext, ENTRY_LIT_INT); return LIT_INT; }
"'"."'"                             { temp(yytext); insertSymbol(yytext, ENTRY_LIT_CHAR); return LIT_CHAR; }
\"([^"\\]|\\.)*\"                   { temp(yytext); insertSymbol(yytext, ENTRY_LIT_STRING); return LIT_STRING; }
[a-zA-Z0-9]+                        { temp(yytext); insertSymbol(yytext, ENTRY_IDENTIFIER); return TK_IDENTIFIER; }

\,|\;|\:|\(|\)|\[|\]\{|\}           { temp(yytext); return yytext[0]; }
\=|\+|\-|\*|\/|\%|\<|\>|\&|\||\~    { temp(yytext); return yytext[0]; }

"\n"                                { temp(yytext); lines++; }
" "|\t|\r|\f|\v                     { temp(yytext); /* skip any whitespaces BUT new line */}

"//"                                { temp(yytext); BEGIN(LINE_COMMENT); }
"/*"                                { temp(yytext); BEGIN(BLOCK_COMMENT); }

<LINE_COMMENT>.                     { temp(yytext); }
<LINE_COMMENT>"\n"                  { temp(yytext); lines++; BEGIN(INITIAL); }

<BLOCK_COMMENT>.                    { temp(yytext); }
<BLOCK_COMMENT>"\n"                 { temp(yytext); lines++; }
<BLOCK_COMMENT>"*/"                 { temp(yytext); BEGIN(INITIAL); }

.                                   { temp(yytext); return TOKEN_ERROR; }

%%

int yywrap() {
    running = 0;
    return 1;
}