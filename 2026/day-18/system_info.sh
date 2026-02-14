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