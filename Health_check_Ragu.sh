#!/bin/bash

Threshold_mem=15
Threshold_cpu=0
Threshold_dsk=75

#Condition check
bPassed=true

#Memory Check
mem_value=$(free | grep Mem |awk '{print int($3/$2*100)}')
echo 'Memory value is:'$mem_value

if((mem_value>Threshold_mem));then
echo "Running out of memory"
bPassed=false
fi

#CPU Check
cpu_mem=$(top -n1| grep Cpu | awk '{print int($2)}')
echo 'CPU value is :'$cpu_mem
if((cpu_mem>Threshold_cpu));then
echo 'CPU is running out of memory'
bPassed=false
fi

#Disk Check
#disk_mem=df | grep dev/root | awk '{gsub("%","");print $5}'
disk_mem=$(df / | tail -1 |awk  '{gsub("%","");print $5}')
echo 'Disk Mem is'$disk_mem
if((disk_mem>Threshold_dsk));then
echo 'Running out of disk space! Abort execution'
bPassed=false
fi

if($bPassed);then
echo 'Health check passed....Execution started..'
#bash testAutomatedScript.sh
else
echo 'Health check failed....Execution aborted..................please wait'
#aws ec2 reboot-instances --instance-ids i-08e65b1d0b4ca26ce 
fi



