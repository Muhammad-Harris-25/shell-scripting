#!/bin/bash

# Define a function
print_even_numbers() {
    local limit=$1
    local num=0
    while (( num <= limit ))
    do
        echo $num
        num=$((num+2))
    done
}

# Call the function with an argument
print_even_numbers 6

