# Day 17 – Shell Scripting: Loops, Arguments & Error Handling

## Objective
Learn loops, command-line arguments, package installation, and basic error handling in shell scripting.

---

# Task 1: For Loop

### for_loop.sh

1. Create `for_loop.sh` that:
   - Loops through a list of 5 fruits and prints each one

```bash
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat for_loop.sh
#!/bin/bash

for fruit in Kiwi Apple Mango Orange
do
	echo "Fruit: $fruit"
done

ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./for_loop.sh
Fruit: Kiwi
Fruit: Apple
Fruit: Mango
Fruit: Orange
```
2. Create `count.sh` that:
   - Prints numbers 1 to 10 using a for loop

```
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat count.sh
#!/bin/bash

for i in {1..10}
do
	echo "$i"
done

ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./count.sh
1
2
3
4
5
6
7
8
9
10
```

### Task 2: While Loop
1. Create `countdown.sh` that:
   - Takes a number from the user
   - Counts down to 0 using a while loop
   - Prints "Done!" at the end
```
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat countdown.sh
#!/bin/bash

read -p "Provide a No: " num

while [ $num -gt 0 ]; do
	echo $num
	num=$((num - 1))
done

echo "Done!"

ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./countdown.sh
Provide a No: 12
12
11
10
9
8
7
6
5
4
3
2
1
Done!
```


### Task 3: Command-Line Arguments
1. Create `greet.sh` that:
   - Accepts a name as `$1`
   - Prints `Hello, <name>!`
   - If no argument is passed, prints "Usage: ./greet.sh <name>"
    ```
    ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat greet.sh
    #!/bin/bash

    echo "Hello $1"

    ubuntu@ip-172-31-17-136:~/scripts/Task17$ sh greet.sh Nilamadhab
    Hello Nilamadhab
    ```
2. Create `args_demo.sh` that:
   - Prints total number of arguments (`$#`)
   - Prints all arguments (`$@`)
   - Prints the script name (`$0`)
```
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat args_demo.sh
#!/bin/bash

echo "Script name: $0"
echo "Total arguments: $#"
echo "All arguments: $@"

## Special Variables
# $0 giving Script Name
# $# giving No of Arguments you have passed
# $@ show all arguments
# $? showing status of exit
# $1,$2,$3 to access individual arguments

ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./args_demo.sh Nilamadhab Purohit
Script name: ./args_demo.sh
Total arguments: 2
All arguments: Nilamadhab Purohit
```

### Task 4: Install Packages via Script
1. Create `install_packages.sh` that:
   - Defines a list of packages: `nginx`, `curl`, `wget`
   - Loops through the list
   - Checks if each package is installed (use `dpkg -s` or `rpm -q`)
   - Installs it if missing, skips if already present
   - Prints status for each package

> Run as root: `sudo -i` or `sudo su`

```
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat install_packages.sh
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

ubuntu@ip-172-31-17-136:~/scripts/Task17$
ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./install_packages.sh
Please run this script as root
ubuntu@ip-172-31-17-136:~/scripts/Task17$ sudo -i ./install_packages.sh
-bash: line 1: ./install_packages.sh: No such file or directory
ubuntu@ip-172-31-17-136:~/scripts/Task17$ sudo  ./install_packages.sh
Checking nginx...
nginx is already installed
---
Checking curl...
curl is already installed
---
Checking wget...
wget is already installed
---
```

---

### Task 5: Error Handling
1. Create `safe_script.sh` that:
   - Uses `set -e` at the top (exit on error)
   - Tries to create a directory `/tmp/devops-test`
   - Tries to navigate into it
   - Creates a file inside
   - Uses `||` operator to print an error if any step fails

Example:

```bash
mkdir /tmp/devops-test || echo "Directory already exists"
```

Ans:
```
ubuntu@ip-172-31-17-136:~/scripts/Task17$ cat safe_script.sh
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || { echo "Failed to enter directory"; exit 1; }

touch test.txt || echo "Failed to create file"

echo "Script completed successfully"

ubuntu@ip-172-31-17-136:~/scripts/Task17$ ./safe_script.sh
mkdir: cannot create directory ‘/tmp/devops-test’: File exists
Directory already exists
Script completed successfully
```

2. Modify your `install_packages.sh` to check if the script is being run as root — exit with a message if not. (Not Understand Will do leter )
