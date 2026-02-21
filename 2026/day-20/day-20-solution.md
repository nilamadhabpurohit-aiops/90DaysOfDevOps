# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Objective
Automate log analysis by generating logs, detecting errors, identifying critical events, and creating a summary report.

---

## Step 1: Sample Log Generation

The instructor provided a script to generate a random log file.  
This helps simulate real production logs for testing.

### Script: log_generator.sh

```bash
#!/bin/bash

# Usage: ./log_generator.sh <log_file_path> <num_lines>

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <log_file_path> <num_lines>"
    exit 1
fi

log_file_path="$1"
num_lines="$2"

if [ -e "$log_file_path" ]; then
    echo "Error: File already exists at $log_file_path."
    exit 1
fi

log_levels=("INFO" "DEBUG" "ERROR" "WARNING" "CRITICAL")
error_messages=("Failed to connect" "Disk full" "Segmentation fault" "Invalid input" "Out of memory")

generate_log_line() {
    local log_level="${log_levels[$((RANDOM % ${#log_levels[@]}))]}"
    local error_msg=""
    if [ "$log_level" == "ERROR" ]; then
        error_msg="${error_messages[$((RANDOM % ${#error_messages[@]}))]}"
    fi
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$log_level] $error_msg - $RANDOM"
}

touch "$log_file_path"
for ((i=0; i<num_lines; i++)); do
    generate_log_line >> "$log_file_path"
done

echo "Log file created at: $log_file_path with $num_lines lines."
```

```
./log_generator.sh sample.log 1000
```

Step 2: Log Analyzer Script
Script: log_analyzer.sh

```bash 
#!/bin/bash

# Input validation
if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE=$1

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File does not exist"
    exit 1
fi

DATE=$(date +%Y-%m-%d)
REPORT="log_report_$DATE.txt"

TOTAL_LINES=$(wc -l < "$LOG_FILE")

ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" \
    | awk '{$1=$2=$3=""; print}' \
    | sort | uniq -c | sort -rn | head -5)

echo "Total lines: $TOTAL_LINES"
echo "Total errors: $ERROR_COUNT"

echo "--- Critical Events ---"
echo "$CRITICAL_EVENTS"

echo "--- Top Errors ---"
echo "$TOP_ERRORS"

# Report generation
{
echo "Log Analysis Report"
echo "Date: $DATE"
echo "Log file: $LOG_FILE"
echo "Total lines: $TOTAL_LINES"
echo "Total errors: $ERROR_COUNT"
echo ""
echo "--- Top Errors ---"
echo "$TOP_ERRORS"
echo ""
echo "--- Critical Events ---"
echo "$CRITICAL_EVENTS"
} > "$REPORT"

# Archive
mkdir -p archive
mv "$LOG_FILE" archive/

echo "Report created: $REPORT"
echo "Log archived."


```

Step 3: Running the Analyzer
```Bash 
./log_analyzer.sh sample.log
```
OutPut :
```bash
```

## Step 4: Generated Report

Example: log_report_2026-02-10.txt


### Tools and Commands Used

- grep → Search log patterns
- awk → Extract error messages
- sort → Sort results
- uniq → Count occurrences
- wc → Count lines
- date → Generate report timestamp
- mv → Archive processed logs


### What I Learned

1. Automating log analysis helps identify system issues quickly.
2. Bash tools like grep, awk, and sort are powerful for production monitoring.
3. Log monitoring and reporting are key responsibilities in DevOps and SRE roles.