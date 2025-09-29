#!/bin/bash

user=$(id -u)

if [ $user -ne 0 ];then
    echo "Please take root permission"
    exit 1
fi


sudo dnf install msmtp -y
if [ $? -ne 0 ];then
    echo "Installing msmtp on system"
    else
    echo "msmtp is already installed"
fi
touch /etc/msmtprc
cp /root/script_email/msmtprc /etc/msmtprc

chmod ugo+x /etc/msmtprc

touch /var/log/msmtp.log
chmod ugo+x /var/log/msmtp.log


{
echo "To: usuresh123456@gmail.com"
echo "Subject: Test Email Alert"
echo "Content-Type: text/html"
echo ""
echo "This is test email"
} | msmtp "usuresh123456@gmail.com"
