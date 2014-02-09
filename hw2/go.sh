#!/bin/bash
rm -r target
mkdir target
cd target
flex ../src/homework.l
echo "===bison------------------------------------------------------- "
bison ../src/homework.y
echo "===g++=========================================================="
g++ homework.tab.c -o parser

