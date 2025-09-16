#!/bin/bash

#num=0
#while [[ $num -le 5 ]]
#do
#    echo "nice"
#    num=$num+1   # or simply: ((num++))
#done


num=0
while [[ $num -le 10 ]]
do
    if (( num % 2 == 0 )); then
        echo $num
    fi
    num=$((num+1))
done

