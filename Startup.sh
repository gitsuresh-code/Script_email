#!/bin/bash

user=$(id -u)
logpath="/tmp/shell-script/backuplogs"
name=$( echo $0 | cut -d "." -f1 )
logfile="$logpath/$name.log" #/tmp/shell-script/backuplogs/backup.log

mkdir -p "$logpath"

if [ $user -ne 0 ];then
    echo "Please take root permission"
    exit 1
fi


dnf list installed msmtp &>>$logfile
if [ $? -ne 0 ];then
    sudo dnf install msmtp -y &>>$logfile
    echo "Installing msmtp on system"
    else
    echo "msmtp is already installed"
fi

validate(){
if [ $? -ne 0 ]; then
    echo "$2 is failure"
    else
    echo "$2 is success"
fi
}


touch /etc/msmtprc
cp ./msmtprc /etc/msmtprc
validate $? "Copying File"

chmod ugo+x /etc/msmtprc
validate $? "Giving permission to msmtprc"


touch /var/log/msmtp.log
chmod ugo+x /var/log/msmtp.log
validate $? "Giving permission to msmtp.log"

{
echo "To: usuresh123456@gmail.com"
echo "Subject: Test Email Alert"
echo "Content-Type: text/html"
echo ""
echo "This is test email"
} | msmtp "usuresh123456@gmail.com"

validate $? "Test email sent"