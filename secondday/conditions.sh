#!/bin/bash

# this is if, elif, else

read -p "enter the name: " name

if [[ $name == "haris" ]]; then
    echo "correct name"
elif [[ $name == *"hri"* ]]; then
    echo "near to match"
else
    echo "name mismatch"
fi

