#!/bin/bash

read -p "Provide a No: " num

while [ $num -gt 0 ]; do
	echo $num
	num=$((num - 1))
done

echo "Done!"