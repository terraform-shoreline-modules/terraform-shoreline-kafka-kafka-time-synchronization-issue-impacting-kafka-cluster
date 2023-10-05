
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Time synchronization issue impacting Kafka cluster.
---

This incident type relates to an issue with time synchronization that affects the proper functioning of a Kafka cluster. As Kafka relies on accurate time synchronization to maintain data consistency, any failure in this process can cause serious issues. The incident might cause data loss or duplication, service disruptions, or other problems that can impact the overall performance of the system. It requires immediate attention from the engineering team to investigate and resolve the root cause of the issue.

### Parameters
```shell
export TIME_ZONE="PLACEHOLDER"

export TIME_SERVER="PLACEHOLDER"

export SERVER1="PLACEHOLDER"

export SERVER3="PLACEHOLDER"

export SERVER2="PLACEHOLDER"
```

## Debug

### Check system time and date
```shell
date
```

### Check if NTP is installed and running
```shell
ntpstat
```

### Check the status of the NTP service
```shell
systemctl status ntp
```

### Check the NTP configuration file for the correct NTP servers
```shell
cat /etc/ntp.conf
```

### Check the NTP query responses
```shell
ntpq -p
```

### Check the Kafka logs for any time synchronization errors
```shell
grep time /var/log/kafka/server.log
```

### Check the status of the Kafka service
```shell
systemctl status kafka
```

### Check the Kafka configuration file for the correct time zone
```shell
cat /etc/kafka/server.properties
```

### The time zone settings on the affected servers may have been incorrect or changed.
```shell


#!/bin/bash



# Set the list of affected servers

servers="${SERVER1} ${SERVER2} ${SERVER3}"



# Loop through each server and check the time zone setting

for server in $servers

do

    echo "Checking time zone setting on $server..."

    ssh $server "date"

    ssh $server "timedatectl status"

done


```

## Repair

### Check the time synchronization settings on all servers hosting the Kafka cluster and ensure that they are set to the correct time zone and are synced with a reliable time source.
```shell


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


```