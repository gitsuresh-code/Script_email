#!/bin/bash
R="\e[31m"
G="\e[32m"
Y="\e[33m"

DISK_USAGE=$(free -h | awk '/^Mem:/ {print $7}' | cut -d "M" -f1)
DISK_THRESHOLD=100 # in project we keep it as 75
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
MESSAGE=""
AVAILABLE=$(free -h | awk '/^Mem:/ {print "Available:", $7}')

    if [ $DISK_USAGE -le $DISK_THRESHOLD ]; then
        MESSAGE="Memory is low $R $AVAILABLE $N % <br>"
        echo -e "$MESSAGE"
        else
         MESSAGE+="$G Memory looks good $G $AVAILABLE $N <br>"
         echo -e "$MESSAGE"
    fi


sh mail.sh "usuresh123456@gmail.com" "Memory Check Alert" "Low Memory" "$MESSAGE" "$IP_ADDRESS" "Suresh DevOps"
