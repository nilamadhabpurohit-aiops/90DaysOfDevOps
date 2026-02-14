#!/bin/bash

demo_local() {
    local var1="I am Local Variable "
    echo "Inside function: $var"
}

demo_global() {
    var2="I am Global Variable"
}

demo_local
echo "Outside function: $var1"

demo_global
echo "Global variable: $var2"