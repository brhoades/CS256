/*
      example.y

     Example of a yacc specification file.

      Grammar is:

        <expr> -> intconst | ident | foo <identList> <intconstList>
        <identList> -> epsilon | <identList> ident
        <intconstList> -> intconst | <intconstList> intconst

      To create the syntax analyzer:

        flex example.l
        bison example.y
        g++ example.tab.c -o parser
        parser < inputFileName
 */

%{
#include <stdio.h>

int numLines = 0; 

void printRule(const char *lhs, const char *rhs);
int yyerror(const char *s);
void printTokenInfo(const char* tokenType, const char* lexeme);

extern "C" {
    int yyparse(void);
    int yylex(void);
    int yywrap() { return 1; }
}

%}

/* Token declarations */
%token  T_IDENT T_INTCONST T_UNKNOWN T_FOO T_LPAREN T_RPAREN T_STRCONST T_ADD T_MULT T_DIV T_SUB T_LT T_GT T_LE T_GE T_EQ T_NE T_LETSTAR T_IF T_LAMBDA T_PRINT T_INPUT T_AND T_OR T_NOT T_T T_NIL

/* Starting point */
%start        N_START

/* Translation rules */
%%
N_START           : N_EXPR
                    {
                    printRule ("START", "EXPR");
                    printf("\n-- Completed parsing --\n\n");
                    return 0;
                    };

N_EXPR            : N_CONST                             { printRule("EXPR", "CONST"); }
                  | T_IDENT                                { printRule("EXPR", "IDENT"); }
                  | T_LPAREN N_PARENTHESIZED_EXPR T_RPAREN { printRule("EXPR", "( PARENTHESIZED_EXPR )"); } 
                  ;

N_CONST : T_STRCONST { printRule("CONST", "STRCONST"); }
        | T_INTCONST { printRule("CONST", "INTCONST"); }
        | T_NIL { printRule("CONST", "nil"); }
        | T_T { printRule("CONST", "t"); }
        ;

N_IDENT_LIST      : /* epsilon */                      { printRule("IDENT_LIST", "epsilon"); }
                  | N_IDENT_LIST T_IDENT               { printRule("IDENT_LIST", "IDENT_LIST IDENT"); } 
                  ;

N_INTCONST_LIST   : T_INTCONST                         { printRule("INTCONST_LIST", "INTCONST"); }
                  | N_INTCONST_LIST T_INTCONST         { printRule("INTCONST_LIST", "INTCONST_LIST INTCONST"); } 
                  ;

N_PARENTHESIZED_EXPR : N_ARITHLOGIC_EXPR { printRule("PARENTHESIZED_EXPR" , "ARITHLOGIC_EXPR"); }
                     ;

N_ARITHLOGIC_EXPR : N_BIN_OP EXPR EXPR { printRule("ARITHLOGIC_EXPR", "BIN_OP EXPR EXPR"); }
                  : N_UN_OP EXPR       { printRule("ARITHLOGIC_EXPR", "UN_OP EXPR"); }
                  ;

N_BIN_OP : N_LOG_OP   { printRule("BIN_OP", "LOG_OP"); }
         | N_REL_OP   { printRule("BIN_OP", "REL_OP"); }
         | N_ARITH_OP { printRule("BIN_OP", "ARITH_OP"); }
         ;

N_UN_OP : T_NOT { printRule("UN_OP", "not"); }
        ;

N_LOG_OP : T_AND { printRule("LOG_OP", "and"); }
         | T_OR { printRule("LOG_OP", "or"); }
         ;

N_REL_OP : T_LT { printRule("REL_OP", "<"); }
         | T_GT { printRule("REL_OP", ">"); }
         | T_LE { printRule("REL_OP", "<="); }
         | T_GE { printRule("REL_OP", ">="); }
         | T_EQ { printRule("REL_OP", "="); }
         | T_NE { printRule("REL_OP", "/="); }
         ;

N_ARITH_OP : T_ADD { printRule("ARITH_OP", "+"); }
           | T_MULT { printRule("ARITH_OP", "*"); }
           | T_DIV { printRule("ARITH_OP", "/"); }
           | T_SUB { printRule("ARITH_OP", "-"); }
           ;
%%

#include "lex.yy.c"
extern FILE    *yyin;

void printRule(const char *lhs, const char *rhs) {
  printf("%s -> %s\n", lhs, rhs);
  return;
}

int yyerror(const char *s) {
  printf("%s\n", s);
  return(1);
}

void printTokenInfo(const char* tokenType, const char* lexeme) {
  printf("TOKEN: %s  LEXEME: %s\n", tokenType, lexeme);
}

int main() {
  do {
    yyparse();
  } while (!feof(yyin));

  printf("%d lines processed\n", numLines);
  return 0;
}
