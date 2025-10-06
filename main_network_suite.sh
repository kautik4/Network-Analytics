#!/bin/bash

# -----------------------------
# Main Network Analytics Suite
# -----------------------------

# Directory where individual scripts are located
SCRIPT_DIR="$HOME/network_scripts"

# Combined log file
MASTER_LOG="$HOME/network_analytics_master_log.csv"

# Create master log with headers if not exists
if [ ! -f "$MASTER_LOG" ]; then
    echo "Date,Time,Module,Details" > "$MASTER_LOG"
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

echo "Starting network analytics suite..."
echo "Date: $DATE Time: $TIME"
echo "-------------------------"

# 1. Run Network Speed Tester
if [ -f "/home/kautik/Documents/speedtest-noapi/speedtest_noapi.sh" ]; then
    echo "Running Network Speed Test..."
    SPEED_OUTPUT=$("/home/kautik/Documents/speedtest-noapi/speedtest_noapi.sh")
    echo "$DATE,$TIME,Network Speed Test,\"$(echo "$SPEED_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "Network speed script not found!"
fi

# 2. Run Network Interface Info
if [ -f "/home/kautik/Documents/speedtest-noapi/interfaceinfo.sh" ]; then
    echo "Running Network Interface Info..."
    IFACE_OUTPUT=$("/home/kautik/Documents/speedtest-noapi/interfaceinfo.sh")
    echo "$DATE,$TIME,Network Interface Info,\"$(echo "$IFACE_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "Network interface script not found!"
fi

# 3. Run DNS Resolver Check
if [ -f "/home/kautik/Documents/speedtest-noapi/dnsresolver.sh" ]; then
    echo "Running DNS Resolver Check..."
    DNS_OUTPUT=$("/home/kautik/Documents/speedtest-noapi/dnsresolver.sh")
    echo "$DATE,$TIME,DNS Resolver Check,\"$(echo "$DNS_OUTPUT" | tr '\n' ' ')\"" >> "$MASTER_LOG"
else
    echo "DNS resolver script not found!"
fi

echo "-------------------------"
echo "Network analytics completed."
echo "Master log saved at $MASTER_LOG"
