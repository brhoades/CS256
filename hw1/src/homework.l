/*
 * Copyright (C) 2014 Joshua Michael Hertlein <jmhertlein@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


%{
/*This is vitally important*/
/* Definitions of constants, vars, function prototypes, and #includes go here*/

#define T_IDENT    1
#define T_INTCONST 2
#define T_UNKNOWN  3
#define T_FOO      4
#define T_COMMENT  5
#define T_OPERATOR 6
#define T_LPAREN   7
#define T_RPAREN   8
#define T_KEYWORD  9
#define T_STRCONST 10

int numLines = 0;
void printTokenInfo(const char* tokenType, const char* lexeme);

%}

/*Regexes*/
WSPACE [ \t\r]+
NEWLINE \n
DIGIT [0-9]
LETTER [a-zA-Z]
OTHER [\^_?.]

LETSTAR let\*
IF if
LAMBDA lambda
PRINT print
INPUT input
AND and
OR or
NOT not
T t
NIL nil

ADD \+
MULT \*
DIV \/
SUB \-
LT <
GT >
LE <=
GE >=
EQ =
NE \/=

LPAREN [(]
RPAREN [)]

IDENT {LETTER}({LETTER}|{DIGIT}|{OTHER})*
INTCONST {SUB}?{DIGIT}+
COMMENT ;+(.)*{NEWLINE}
STRCONST [\"\']({OTHER}|{LETTER}|{DIGIT}|{WSPACE})*[\"\']


%%


{STRCONST}  {
               printTokenInfo("STRCONST", yytext);
               return T_STRCONST;
            }

{LETSTAR}   {
               printTokenInfo("LETSTAR", yytext);
               return T_KEYWORD;
            }

{IF}        {
               printTokenInfo("IF", yytext);
               return T_KEYWORD;
            }

{LAMBDA}    {
               printTokenInfo("LAMBDA", yytext);
               return T_KEYWORD;
            }

{PRINT}     {
               printTokenInfo("PRINT", yytext);
               return T_KEYWORD;
            }

{INPUT}     {
               printTokenInfo("INPUT", yytext);
               return T_KEYWORD;
            }

{AND}       {
               printTokenInfo("AND", yytext);
               return T_KEYWORD;
            }

{OR}        {
               printTokenInfo("OR", yytext);
               return T_KEYWORD;
            }

{NOT}       {
               printTokenInfo("NOT", yytext);
               return T_KEYWORD;
            }

{T}         {
               printTokenInfo("T", yytext);
               return T_KEYWORD;
            }

{NIL}       {
               printTokenInfo("NIL", yytext);
               return T_KEYWORD;
            }

{ADD}       {
               printTokenInfo("ADD", yytext);
               return T_OPERATOR;
            }

{SUB}       {
               printTokenInfo("SUB", yytext);
               return T_OPERATOR;
            }

{MULT}      {
               printTokenInfo("MULT", yytext);
               return T_OPERATOR;
            }

{DIV}       {
               printTokenInfo("DIV", yytext);
               return T_OPERATOR;
            }

{LT}        {
               printTokenInfo("LT", yytext);
               return T_OPERATOR;
            }

{GT}        {
               printTokenInfo("GT", yytext);
               return T_OPERATOR;
            }

{GE}        {
               printTokenInfo("GE", yytext);
               return T_OPERATOR;
            }

{LE}        {
               printTokenInfo("LE", yytext);
               return T_OPERATOR;
            }

{NE}        {
               printTokenInfo("NE", yytext);
               return T_OPERATOR;
            }

{EQ}        {
               printTokenInfo("EQ", yytext);
               return T_OPERATOR;
            }

{LPAREN}    {
               printTokenInfo("LPAREN", yytext);
               return T_LPAREN;
            }

{RPAREN}    {
               printTokenInfo("RPAREN", yytext);
               return T_RPAREN;
            }

{INTCONST}  {
               printTokenInfo("INTCONST", yytext);
               return T_INTCONST;
            }

{IDENT}     {
               printTokenInfo("IDENT", yytext);
               return T_IDENT;
            }

{NEWLINE}   {
               numLines++;
               printf("\n");
            }

{WSPACE}    {}
.           {
               printTokenInfo("UNKNOWN", yytext);
               return T_UNKNOWN;
            }

{COMMENT}   {
               numLines++;
               printf("\n");
            }

%%

void printTokenInfo(const char* tokenType, const char* lexeme)
{
  printf("TOKEN: %s\t LEXEME: %s\n", tokenType, lexeme);
}

//You should specify a yywrap function.
//Having it return 1 means only 1 input file will be scanned
int yywrap() {return 1;}

int main()
{
  while (yylex());
  printf("Processed %d lines\n", numLines);
  return 0;
}
