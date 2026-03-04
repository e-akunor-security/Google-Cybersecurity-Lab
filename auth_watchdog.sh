#!/bin/bash

# --- AUTH WATCHDOG v1.0 ---
# Purpose: Detect potential Brute Force attacks

LOG_FILE="/var/log/auth.log"
THRESHOLD=5

# Count how many times 'authentication failure' appears
FAIL_COUNT=$(sudo grep -c "authentication failure" $LOG_FILE)

echo "---------------------------------------"
echo "Security Audit started at: $(date)"
echo "Current Failed Attempts: $FAIL_COUNT"
echo "---------------------------------------"

if [ $FAIL_COUNT -gt $THRESHOLD ]; then
    echo "[!] ALERT: High number of login failures detected!"
    echo "[!] Action Required: Check /var/log/auth.log immediately."
else
    echo "[+] System Status: Normal."
fi
