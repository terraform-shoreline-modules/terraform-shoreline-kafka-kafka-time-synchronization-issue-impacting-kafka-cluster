

#!/bin/bash



# Set the correct time zone

sudo timedatectl set-timezone ${TIME_ZONE}



# Install NTP if not already installed

sudo apt-get install ntp -y



# Stop NTP service

sudo systemctl stop ntp.service



# Sync time with a reliable time server

sudo ntpdate ${TIME_SERVER}



# Start NTP service

sudo systemctl start ntp.service