/* Bianca Pelegrini - 279598 */

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

"\n"                                        { ++lines; }
"//"                                        { BEGIN(LINE_COMMENT); }
<LINE_COMMENT>.                             { };
<LINE_COMMENT>"\n"                          { ++lines; BEGIN(INITIAL); }

"/*"                                        { BEGIN(BLOCK_COMMENT); }
<BLOCK_COMMENT>.                            { }
<BLOCK_COMMENT>"\n"                         { ++lines; }
<BLOCK_COMMENT>"*/"                         { BEGIN(INITIAL); }

%%

int yywrap() {
    running = 0;
    return 1;
}