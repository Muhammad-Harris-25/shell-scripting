#!/bin/bash

# This is a C-style for loop in Bash
#for ((i=1; i<=5; i++))
#do
#    mkdir "demo$i"
#done


# Usage: ./script.sh folderPrefix start end
# Example: ./script.sh demo 1 5
# Output: demo1 demo2 demo3 demo4 demo5

# This is a C-style for loop in Bash
for ((i=$2; i<=$3; i++))
do
    mkdir "$1$i"
done


