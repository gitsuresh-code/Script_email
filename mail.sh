#!/bin/bash

# Input arguments
TO_ADDRESS=$1
SUBJECT=$2
ALERT_TYPE=$3      # e.g., "System Resource Alert"
MESSAGE=$4         # HTML message body from Script1
IP_ADDRESS=$5
TO_TEAM=$6
SENDER=${7:-"DevOps Team"}   # Default sender if not provided

# Build HTML email body
#FINAL_BODY="<html><body>"
#FINAL_BODY+="<h3>$ALERT_TYPE - $IP_ADDRESS</h3>"
#FINAL_BODY+="$MESSAGE"
#FINAL_BODY+="<p>Sender: $SENDER</p>"
#FINAL_BODY+="</body></html>"

# Send email using msmtp

{
    echo "To: $TO_ADDRESS"
    echo "Subject: $SUBJECT"
    echo "Content-Type: text/html"
    echo ""
    echo "$MESSAGE"
} | msmtp "$TO_ADDRESS"

