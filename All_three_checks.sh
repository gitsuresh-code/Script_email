#!/bin/bash

# Email settings
TO_ADDRESS="usuresh123456@gmail.com"
SUBJECT="System Resource Alert"
SENDER="Suresh DevOps"
IP_ADDRESS=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

# Thresholds
MEM_THRESHOLD=500        # in MB
DISK_THRESHOLD=80        # in % (used)
CPU_THRESHOLD=80         # in % (used)

# Get system stats
MEM_AVAILABLE=$(free -m | awk '/^Mem:/ {print $7}')        # in MB
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//') # root partition %
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {print int($2+$4)}') # user+system %

# Initialize message
MESSAGE="<html><body>"
MESSAGE+="<h3>System Resource Report - $IP_ADDRESS</h3>"

# Memory check
if [ "$MEM_AVAILABLE" -le "$MEM_THRESHOLD" ]; then
    MESSAGE+="<p style='color:red;'>Memory is LOW: Available $MEM_AVAILABLE MB</p>"
else
    MESSAGE+="<p style='color:green;'>Memory looks good: Available $MEM_AVAILABLE MB</p>"
fi

# Disk check
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    MESSAGE+="<p style='color:red;'>Disk usage is HIGH: $DISK_USAGE%</p>"
else
    MESSAGE+="<p style='color:green;'>Disk usage looks good: $DISK_USAGE%</p>"
fi

# CPU check
if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    MESSAGE+="<p style='color:red;'>CPU usage is HIGH: $CPU_USAGE%</p>"
else
    MESSAGE+="<p style='color:green;'>CPU usage looks good: $CPU_USAGE%</p>"
fi

MESSAGE+="<p>Sender: $SENDER</p>"
MESSAGE+="</body></html>"

# Send email (ensure mail.sh handles HTML)
sh mail.sh "$TO_ADDRESS" "$SUBJECT" "$MESSAGE" "$IP_ADDRESS" "$SENDER"
