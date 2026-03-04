#!/bin/bash

# --- IPS GUARD DOG v2.0 ---
LOG_FILE="/var/log/auth.log"
THRESHOLD=5

# Find the most recent IP that failed to log in
ATTACKER_IP=$(sudo grep "authentication failure" $LOG_FILE | tail -n 1 | awk '{print $NF}' | sed 's/ip=//')
FAIL_COUNT=$(sudo grep -c "authentication failure" $LOG_FILE)

echo "Scan complete. Failures: $FAIL_COUNT"

if [ $FAIL_COUNT -gt $THRESHOLD ]; then
    echo "[!] THREAT DETECTED: $ATTACKER_IP"
    echo "[!] Automatically blocking IP via UFW..."
    
    # THE ACTION: This command adds a firewall rule automatically
    sudo ufw deny from $ATTACKER_IP
    
    echo "[+] IP $ATTACKER_IP has been banned."
else
    echo "[+] System Secure."
fi#!/bin/bash

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
