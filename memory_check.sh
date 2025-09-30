#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"

DISK_USAGE=$(free -h | awk '/^Mem:/ {print $7}' | cut -d "M" -f1)
DISK_THRESHOLD=500 # in project we keep it as 75
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""
AVAILABLE=$(free -h | awk '/^Mem:/ {print "Available:", $7}')

    if [ $DISK_USAGE -le $DISK_THRESHOLD ]; then
        MESSAGE="<span style='color:red;'>Memory is low: $AVAILABLE</span><br>"
        echo  "$MESSAGE"
        else
          MESSAGE="<span style='color:green;'>Memory looks good: $AVAILABLE</span><br>"
         echo  "$MESSAGE"
    fi


sh mail.sh "usuresh123456@gmail.com" "Memory Check Alert" "Low Memory" "$MESSAGE" "$IP_ADDRESS" "Suresh DevOps"
