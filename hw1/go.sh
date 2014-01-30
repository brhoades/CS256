#!/bin/bash
flex "$1"
g++ lex.yy.c -o lexer
./lexer < "$2"
