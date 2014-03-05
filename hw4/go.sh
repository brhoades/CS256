#!/bin/bash
rm -r target
mkdir target
cd target
echo "===FLEX============================================================"
flex ../src/homework.l
echo "===BISON==========================================================="
bison ../src/homework.y
echo "===G++============================================================="
cp ../src/*.h .
g++ homework.tab.c -o parser
echo "===DONE==="
