## Shell Scripting Cheat Sheet

- Quick reference for DevOps tasks: log parsing, deployments, monitoring, and automation.

### Quick Reference Table
**Topic**	**Key** **Syntax**	**Example**
Variable	VAR="value"	NAME="DevOps"
Argument	$1, $2	./script.sh arg1
If	if [ condition ]; then	if [ -f file ]; then
For loop	for i in list; do	for i in 1 2 3; do
Function	name() { ... }	greet() { echo "Hi"; }
Grep	grep pattern file	grep -i "error" log.txt
Awk	awk '{print $1}' file	awk -F: '{print $1}' /etc/passwd
Sed	sed 's/old/new/g' file	sed -i 's/foo/bar/g' config.txt
### 1. Basics
**Shebang**
```bash
#!/bin/bash
```
- Tells system which interpreter to use. Makes script executable and portable.

**Running Scripts**
```bash
chmod +x script.sh    # Make executable
./script.sh           # Run directly
bash script.sh        # Run with bash
```
**Comments**
```bash
# Single line comment
echo "Hello" # Inline comment
```
**Variables**
```bash
NAME="DevOps"           # Declare
echo $NAME              # Use (word split)
echo "$NAME"            # Safe expansion
echo '$NAME'            # Literal
Read Input
bash
read -p "Enter name: " NAME
echo "Hello $NAME"
```
**Command Arguments**

```bash
#!/bin/bash
echo "Script: $0"      # Script name
echo "First arg: $1"   # First argument
echo "Arg count: $#"
echo "All args: $@"    # All as separate words
echo "Last exit: $?"   # Previous command exit code
```
### 2. Operators & Conditionals
**String Comparisons**
```bash
[ "$str1" = "$str2" ]   # Equal
[ "$str1" != "$str2" ]  # Not equal
[ -z "$str" ]           # Empty
[ -n "$str" ]           # Not empty
```
**Integer Comparisons**
```bash
[ 5 -eq 5 ]   # Equal
[ 5 -ne 3 ]   # Not equal
[ 5 -lt 10 ]  # Less than
[ 10 -gt 5 ]  # Greater than
```
**File Tests**
```bash
[ -f file.txt ]   # Regular file
[ -d /tmp ]       # Directory
[ -e file ]       # Exists
[ -r file ]       # Readable
[ -w file ]       # Writable
[ -x script ]     # Executable
[ -s file ]       # Non-empty
```
**If/Elif/Else**
```bash
if [ "$1" = "prod" ]; then
    echo "Production mode"
elif [ "$1" = "dev" ]; then
    echo "Dev mode"
else
    echo "Unknown: $1"
fi
```
**Logical Operators**
```bash
[ -f file ] && echo "Exists"    # AND
[ ! -f file ] || echo "Missing" # OR
```
**Case Statement**
```bash
case "$1" in
    start) echo "Starting.." ;;
    stop)  echo "Stopping.." ;;
    *)     echo "Usage: $0 {start\|stop}" ;;
esac
```
### 3. Loops
**For Loop (List)**
```bash
for service in nginx mysql redis; do
    systemctl restart $service
done
```
**For Loop (C-style)**
```bash
for ((i=1; i<=5; i++)); do
    echo "Iteration $i"
done
```
**While Loop**
```bash
count=1
while [ $count -le 5 ]; do
    echo $count
    ((count++))
done
```
**Until Loop**
```bash
until ping -c1 google.com; do
    echo "No internet, retrying.."
    sleep 5
done
```
**Loop Control**
```bash
for i in {1..10}; do
    if [ $i -eq 5 ]; then break; fi    # Exit loop
    if [ $((i%2)) -eq 0 ]; then continue; fi  # Skip iteration
    echo $i
done
```
**Loop Over Files**
```bash
for log in *.log; do
    echo "Processing $log"
done
```
**Loop Over Command Output**
```bash
ps aux | while read user pid cmd; do
    echo "User: $user, PID: $pid"
done
```
### 4. Functions
**Define & Call**
```bash
backup() {
    cp "$1" "$1.bak"
}

backup /etc/hosts    # Call
Arguments in Functions
bash
greet() {
    echo "Hello $1, you have $2 tasks"
}
greet "DevOps" 5
Return vs Echo
bash
check_file() {
    if [ -f "$1" ]; then
        echo "exists"
    else
        echo "missing"
    fi
}

status=$(check_file config.yaml)
Local Variables
bash
myfunc() {
    local temp=/tmp/$$    # Local to function
    # temp available only here
}
```
### 5. Text Processing
**Grep**
```bash
grep "ERROR" app.log          # Basic search
grep -i error log             # Case insensitive
grep -r "TODO" /app           # Recursive
grep -c "404" access.log      # Count
grep -n "error" log           # Line numbers
grep -v "OK" status.log       # Invert match
grep -E "error|warn" log      # Extended regex
```
**Awk**
```bash
awk '{print $1}' /etc/passwd              # First column
awk -F: '{print $1,$3}' /etc/passwd       # Colon separator
awk '/error/ {print $0}' log              # Pattern match
awk 'BEGIN {print "Start"} {print $1} END {print "End"}' file
```
**Sed**
```bash
sed 's/old/new/g' file                    # Substitute
sed '2d' file                             # Delete line 2
sed -i 's/http/https/g' config            # In-place edit
sed '/^#/d' config                        # Delete comment lines
```
**Cut**
```bash
cut -d: -f1 /etc/passwd         # First field, colon delimiter
cut -c1-5 names.txt             # Characters 1-5
Sort & Uniq
bash
sort file.txt                    # Alphabetical
sort -n nums.txt                 # Numerical
sort -r file.txt                 # Reverse
sort -u file.txt                 # Unique
uniq access.log                  # Deduplicate consecutive
uniq -c access.log | sort -nr    # Count + sort by count
```
**Tr**
```bash
tr 'a-z' 'A-Z' < file          # Uppercase
tr -d '[:space:]' < file       # Remove whitespace
Wc, Head, Tail
bash
wc -l file.txt                  # Line count
head -5 log                     # First 5 lines
tail -f /var/log/app.log        # Follow live
tail -n +100 log                # From line 100
```
### 6. Useful One-Liners
```bash
# Find and delete files older than 7 days
find /logs -name "*.log" -mtime +7 -delete

# Count ERRORs in all .log files
grep -r "ERROR" /var/log/*.log | wc -l

# Replace string across all config files
sed -i 's/oldhost/newhost/g' /etc/*.conf

# Check if service running
systemctl is-active --quiet nginx && echo "nginx OK"

# Monitor disk usage with alert
df -h / | awk 'NR==2 {if($5+0 > 80) print "DISK ALERT!"}'

# Tail errors in real-time
tail -f /var/log/app.log | grep --line-buffered ERROR

# Parse CSV usernames
cut -d, -f1 users.csv | sort -u

# Memory usage top 5 processes
ps aux --sort=-%mem | head -6
```
### 7. Error Handling & Debugging
**Exit Codes**
```bash
ls missing.txt
echo $?    # 2 (error)
exit 0     # Success
exit 1     # Failure
Set Options
bash
set -e      # Exit on any error
set -u      # Error on unset variables
set -o pipefail  # Pipe errors propagate
set -x      # Debug: print commands
```
**Trap for Cleanup**
```bash
#!/bin/bash
set -e
trap 'echo "Cleaning up.."; rm -f /tmp/mytemp' EXIT
```


