#! /bin/bash

# This shell script monitors important system stats like memory, cpu and disk and prints them in tabulated format 


printf "Memory \t\tDisk \t\t    CPU \n"
printf "Usage  \t\tUsage \t\t Utilization\n"

iter=0

# use "while true" to keep the script alive in infinite loop

while [ "$iter" -lt "100" ]; do
memory_used=$(free -m | awk 'NR==2{printf "%.2f%\t\t", $3*100/$2 }')
disk_used=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
cpu_used=$(top -bn1 | grep load | awk '{printf "   %.2f%%\t\t\n", $(NF-2)}')

# we can use 'uptime' as well to get load average as an alternative 
#>> uptime
# 17:48:51 up 21 days, 11:07,  6 users,  load average: 0.00, 0.00, 0.12

echo "$memory_used$disk_used$cpu_used"
sleep 5
done

# Sample output
# Memory          Disk                CPU 
# Usage           Usage            Utilization
# 1.11%           82%                0.06%
# 1.12%           82%                0.06%
# 1.11%           82%                0.05%
