#!/bin/bash

#Check root:
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi

# List of packages
packages="nginx curl wget"

# Loop through packages
for pkg in $packages
do
    echo "Checking $pkg..."

    if dpkg -s "$pkg" > /dev/null 2>&1; then
        echo "$pkg is already installed"
    else
        echo "Installing $pkg..."
        apt install -y "$pkg"
    fi

    echo "---"
done