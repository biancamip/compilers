/* Bianca Pelegrini - 279598 */

/* TODO
- Get the lines counting scheme figured out
- Analyze literals and identifiers
*/

%{
    #include <stdio.h>
    #include "tokens.h"

    int running = 1;
    int lines = 1;
    
    void initMe() {}

    int getLineNumber() {
        return lines;
    }

    int isRunning() {
        return running;
    }
%}

%x LINE_COMMENT BLOCK_COMMENT

%%

"char"                              { return KW_CHAR; }
"int"                               { return KW_INT; }
"if'"                               { return KW_IF; }
"then"                              { return KW_THEN; }
"else"                              { return KW_ELSE; }
"while"                             { return KW_WHILE; }
"read"                              { return KW_READ; }
"print"                             { return KW_PRINT; }
"return"                            { return KW_RETURN; }

\,|\;|\:                            { return yytext[0]; }
\(|\)|\[|\]\{|\}                    { return yytext[0]; }
\=|\+|\-|\*|\/|\%                   { return yytext[0]; }
\<|\>|\&|\||\~                      { return yytext[0]; }

"\n"                                { ++lines; }

"//"                                { BEGIN(LINE_COMMENT); }
<LINE_COMMENT>.                     { }
<LINE_COMMENT>"\n"                  { ++lines; BEGIN(INITIAL); }

"/*"                                { BEGIN(BLOCK_COMMENT); }
<BLOCK_COMMENT>.                    { }
<BLOCK_COMMENT>"\n"                 { ++lines; }
<BLOCK_COMMENT>"*/"                 { BEGIN(INITIAL); }

%%
/*
#define TK_IDENTIFIER     280

#define LIT_INT           281
#define LIT_CHAR          282
#define LIT_STRING        286

#define TOKEN_ERROR       290
*/

int yywrap() {
    running = 0;
    return 1;
}