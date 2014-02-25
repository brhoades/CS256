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
%}

/*Regexes*/
WSPACE [ \t\r]+
NEWLINE \n
DIGIT [0-9]
LETTER [a-zA-Z]
OTHER [_]

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

IDENT ({LETTER}|{OTHER})({LETTER}|{DIGIT}|{OTHER})*
INTCONST ({SUB}|{ADD})?{DIGIT}+
COMMENT ;+(.)*
STRCONST (\"(.)*\")|(\'(.)*\')


%%


{STRCONST}  {
               printTokenInfo("STRCONST", yytext);
               return T_STRCONST;
            }

{LETSTAR}   {
               printTokenInfo("LETSTAR", yytext);
               beginScope();
               return T_LETSTAR;
            }

{IF}        {
               printTokenInfo("IF", yytext);
               return T_IF;
            }

{LAMBDA}    {
               printTokenInfo("LAMBDA", yytext);
               beginScope();
               return T_LAMBDA;
            }

{PRINT}     {
               printTokenInfo("PRINT", yytext);
               return T_PRINT;
            }

{INPUT}     {
               printTokenInfo("INPUT", yytext);
               return T_INPUT;
            }

{AND}       {
               printTokenInfo("AND", yytext);
               return T_AND;
            }

{OR}        {
               printTokenInfo("OR", yytext);
               return T_OR;
            }

{NOT}       {
               printTokenInfo("NOT", yytext);
               return T_NOT;
            }

{T}         {
               printTokenInfo("T", yytext);
               return T_T;
            }

{NIL}       {
               printTokenInfo("NIL", yytext);
               return T_NIL;
            }

{ADD}       {
               printTokenInfo("ADD", yytext);
               return T_ADD;
            }

{SUB}       {
               printTokenInfo("SUB", yytext);
               return T_SUB;
            }

{MULT}      {
               printTokenInfo("MULT", yytext);
               return T_MULT;
            }

{DIV}       {
               printTokenInfo("DIV", yytext);
               return T_DIV;
            }

{LT}        {
               printTokenInfo("LT", yytext);
               return T_LT;
            }

{GT}        {
               printTokenInfo("GT", yytext);
               return T_GT;
            }

{GE}        {
               printTokenInfo("GE", yytext);
               return T_GE;
            }

{LE}        {
               printTokenInfo("LE", yytext);
               return T_LE;
            }

{NE}        {
               printTokenInfo("NE", yytext);
               return T_NE;
            }

{EQ}        {
               printTokenInfo("EQ", yytext);
               return T_EQ;
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
               yylval.text = strdup(yytext);
               printTokenInfo("IDENT", yytext);
               return T_IDENT;
            }

{NEWLINE}   {
               numLines++;
            }

{WSPACE}    {}
.           {
               printTokenInfo("UNKNOWN", yytext);
               return T_UNKNOWN;
            }

{COMMENT}   {}

%%
