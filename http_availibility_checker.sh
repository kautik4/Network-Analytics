#!/bin/bash

# ----------------------------------------
# HTTP / Website Availability Checker
# ----------------------------------------

# Log file
LOG_FILE="$HOME/http_check_log.csv"

# Ask user for website name
read -p "Enter website URL (e.g. https://example.com): " SITE

# Validate input
if [ -z "$SITE" ]; then
    echo "No website entered. Exiting."
    exit 1
fi

# Create log file with headers if not exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Website,Status_Code,Response_Time(s),Status" > "$LOG_FILE"
fi

# Get current date and time
DATE=$(date '+%Y-%m-%d')
TIME=$(date '+%H:%M:%S')

# Perform the check using curl
RESULT=$(curl -o /dev/null -s -w "%{http_code} %{time_total}" "$SITE")
STATUS_CODE=$(echo $RESULT | awk '{print $1}')
RESPONSE_TIME=$(echo $RESULT | awk '{print $2}')

# Determine availability
if [ "$STATUS_CODE" -eq 200 ]; then
    STATUS="Available"
else
    STATUS="Unavailable"
fi

# Log the result
echo "$DATE,$TIME,$SITE,$STATUS_CODE,$RESPONSE_TIME,$STATUS" >> "$LOG_FILE"

# Display the result
echo "----------------------------------------"
echo "HTTP / Website Availability Checker"
echo "Date: $DATE Time: $TIME"
echo "Website: $SITE"
echo "Status Code: $STATUS_CODE"
echo "Response Time: $RESPONSE_TIME s"
echo "Status: $STATUS"
echo "Results logged in $LOG_FILE"
echo "----------------------------------------"
