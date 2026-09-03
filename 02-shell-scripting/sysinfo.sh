#!/bin/bash
# sysinfo.sh - prints basic system info, then saves a snapshot of running processes.
# DevOps homework, shell scripting task.

current_date=$(date)
host_name=$(hostname)
user_name=$(whoami)

echo "=========================================="
echo "         SYSTEM INFORMATION REPORT        "
echo "=========================================="
echo "Date and time : $current_date"
echo "Hostname      : $host_name"
echo "Logged in as  : $user_name"
echo

echo "----- Disk usage (df -h) -----"
df -h
echo

echo "----- Running processes (top 10 by CPU) -----"
ps aux | head -11
echo

read -p "Name the folder where the report should be saved: " report_dir
read -p "Name the file for the process snapshot: " report_file

mkdir -p "$report_dir"
touch "$report_dir/$report_file"

# the full list goes to the file, not just the 10 shown above
ps aux > "$report_dir/$report_file"

echo
echo "Saved the process list to: $report_dir/$report_file"
echo "Lines written: $(wc -l < "$report_dir/$report_file")"
echo "=========================================="
