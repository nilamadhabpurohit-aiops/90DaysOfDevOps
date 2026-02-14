# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts

## Objective
Learn reusable scripting using functions, strict mode, return values, and build a real-world system monitoring script.

---

### Task 1: Basic Functions
1. Create `functions.sh` with:
   - A function `greet` that takes a name as argument and prints `Hello, <name>!`
   - A function `add` that takes two numbers and prints their sum
   - Call both functions from the script
```
ubuntu@ip-172-31-17-136:~/scripts/Task18$ cat function.sh
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
ubuntu@ip-172-31-17-136:~/scripts/Task18$ ./function.sh
Hello, Nilamadhab!
Sum is: 30
```
---

### Task 2: Functions with Return Values
1. Create `disk_check.sh` with:
   - A function `check_disk` that checks disk usage of `/` using `df -h`
   - A function `check_memory` that checks free memory using `free -h`
   - A main section that calls both and prints the results
```
ubuntu@ip-172-31-17-136:~/scripts/Task18$ cat disk_check.sh
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo "Memory Usage:"
    free -h
}

check_disk
check_memory
ubuntu@ip-172-31-17-136:~/scripts/Task18$ ./disk_check.sh
Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       6.8G  2.2G  4.6G  32% /
Memory Usage:
               total        used        free      shared  buff/cache   available
Mem:           914Mi       333Mi       260Mi       2.7Mi       483Mi       580Mi
Swap:             0B          0B          0B
```
---

### Task 3: Strict Mode — `set -euo pipefail`
1. Create `strict_demo.sh` with `set -euo pipefail` at the top
2. Try using an **undefined variable** — what happens with `set -u`?
3. Try a command that **fails** — what happens with `set -e`?
4. Try a **piped command** where one part fails — what happens with `set -o pipefail`?



**Document:** What does each flag do?
**Explanation**
- set -e : Script exits immediately if any command fails.
- set -u : Script exits if an undefined variable is used.
- set -o pipefail : If any command in a pipeline fails, the whole pipeline fails.

---

### Task 4: Local Variables
1. Create `local_demo.sh` with:
   - A function that uses `local` keyword for variables
   - Show that `local` variables don't leak outside the function
   - Compare with a function that uses regular variables
```
ubuntu@ip-172-31-17-136:~/scripts/Task18$ cat local_demo.sh
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

ubuntu@ip-172-31-17-136:~/scripts/Task18$ ./local_demo.sh
Inside function:
Outside function:
Global variable: I am Global Variable
```
---

### Task 5: Build a Script — System Info Reporter
Create `system_info.sh` that uses functions for everything:
1. A function to print **hostname and OS info**
2. A function to print **uptime**
3. A function to print **disk usage** (top 5 by size)
4. A function to print **memory usage**
5. A function to print **top 5 CPU-consuming processes**
6. A `main` function that calls all of the above with section headers
7. Use `set -euo pipefail` at the top

```
ubuntu@ip-172-31-17-136:~/scripts/Task18$ cat system_info.sh
#!/bin/bash
set -euo pipefail

print_header() {
    echo "----------------------------"
    echo "$1"
    echo "----------------------------"
}

system_info() {
    print_header "Hostname and OS Info"
    hostname
    uname -a
}

uptime_info() {
    print_header "System Uptime"
    uptime
}

disk_info() {
    print_header "Top 5 Disk Usage"
    du -h / 2>/dev/null | sort -hr | head -5
}

memory_info() {
    print_header "Memory Usage"
    free -h
}

cpu_info() {
    print_header "Top 5 CPU Processes"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
    system_info
    uptime_info
    disk_info
    memory_info
    cpu_info
}

main

ubuntu@ip-172-31-17-136:~/scripts/Task18$ ./system_info.sh
----------------------------
Hostname and OS Info
----------------------------
ip-172-31-17-136
Linux ip-172-31-17-136 6.14.0-1018-aws #18~24.04.1-Ubuntu SMP Mon Nov 24 19:46:27 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
----------------------------
System Uptime
----------------------------
 14:41:24 up  3:38,  1 user,  load average: 0.01, 0.01, 0.00
----------------------------
Top 5 Disk Usage
----------------------------
3.1G	/
1.5G	/usr
894M	/usr/lib
878M	/snap
693M	/var
ubuntu@ip-172-31-17-136:~/scripts/Task18$
```