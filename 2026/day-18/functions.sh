#!/bin/bash


# Function to greet
greet() {
    name=$1
    echo "Hello, $name!"
}

# Function to add two numbers
add() {
    sum=$(($1 + $2))
    echo "Sum is: $sum"
}

# Calling functions
greet "Nilamadhab"
add 10 20