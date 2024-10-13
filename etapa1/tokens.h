/*
 * Compiladores - etapa1 - tokens.h - semestre 2024/2 - M Johann
 *
 * Lista dos tokens, com valores constantes associados.
 * Este arquivo serah posterioremente substituido, nao acrescente nada.
 * Os valores das constantes sao arbitrarios, mas nao podem ser alterados.
 * Cada valor deve ser distinto e fora da escala ascii.
 * Assim, nao conflitam entre si e com os tokens representados pelo proprio
 * valor ascii de caracteres isolados.
 */

#define KW_CHAR           256
#define KW_INT            257

#define KW_IF             261
#define KW_THEN           262
#define KW_ELSE           263
#define KW_WHILE          264
#define KW_READ           266
#define KW_PRINT          267
#define KW_RETURN         268

#define TK_IDENTIFIER     280

#define LIT_INT           281
#define LIT_CHAR          282
#define LIT_STRING        286

#define TOKEN_ERROR       290

/* END OF FILE */

