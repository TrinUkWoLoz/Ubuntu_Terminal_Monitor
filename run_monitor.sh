#!/bin/bash

unset reset os architecture kernelrelease internalip externalip nameserver loadaverage

reset=$(tput sgr0)

  echo
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
	echo " "
	echo " "
	echo -e "\033[0;36m""   #################################################################################################### " $reset
  echo -e "\033[0;36m""   #                Ubuntu System and Network Monitor Tool ( W1z4R|)ofL0Z )                           # " $reset                                                                                                                                         #
  echo -e "\033[0;36m""   #################################################################################################### " $reset
	echo " "
	echo " "
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo

while getopts iv name
do
        case $name in
          i)iopt=1;;
          v)vopt=1;;
          *)echo "Invalid arg";;
        esac
done

if [[ ! -z $iopt ]]
then
{
wd=$(pwd)
basename "$(test -L "$0" && readlink "$0" || echo "$0")" > /tmp/scriptname
scriptname=$(echo -e -n $wd/ && cat /tmp/scriptname)
su -c "cp $scriptname /usr/bin/monitor" root && echo "Congratulations! Script Installed, now run monitor Command" || echo "Installation failed"
}
fi

if [[ ! -z $vopt ]]
then
{
echo -e "Ubuntu System and Network Monitor Tool ,\nWritten by W1z4r|)0fL0z_TnT!"
}
fi

if [[ $# -eq 0 ]]
then
{

if [ $(dpkg-query -W -f='${Status}' lm-sensors 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo
  apt-get install lm-sensors;
else
  echo
  echo -e '\033[0;31m'"Sensors application already installed, Ok to proceed!" $reset
fi


if [ $(dpkg-query -W -f='${Status}' finger 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo
  apt-get install finger;
else
  echo
  echo -e '\033[0;31m'"Finger application already installed, Ok to proceed!" $reset
fi

if [ $(dpkg-query -W -f='${Status}' traceroute 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo
  apt-get install traceroute;
else
  echo
  echo -e '\033[0;31m'"Traceroute application already installed, Ok to proceed!" $reset
fi

if [ $(dpkg-query -W -f='${Status}' dmidecode 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo
  apt-get install dmidecode;
else
  echo
  echo -e '\033[0;31m'"Dmidecode application already installed, Ok to proceed!" $reset
fi

if [ $(dpkg-query -W -f='${Status}' ufw 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo
  apt-get install ufw;
  echo
else
  echo
  echo -e '\033[0;31m'"UFW application already installed, Ok to proceed!" $reset
  echo
fi

# Define Variable reset
reset=$(tput sgr0)
externalip=$(curl -s ipecho.net/plain;echo)

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e '\033[0;31m'"OS Name:" $reset  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"

#echo

echo -n -e '\033[0;31m'"OS Version:" $reset && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

#echo

# Check Architecture
architecture=$(uname -m)
echo -e '\033[0;31m'"Architecture:" $reset $architecture

#echo

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e '\033[0;31m'"Kernel Release:" $reset $kernelrelease

#echo

# Shell Type
#shelltype=$(finger -l | sed '2!d' | awk '{print $4}')
shelltype=$(echo $SHELL)
echo -e '\033[0;31m'"Shell Type:" $reset $shelltype

#echo

# Check hostname
echo -e '\033[0;31m'"Hostname:" $reset $HOSTNAME

#echo

# Check Packages Installed
packages=$(dpkg --list | wc --lines)
echo -e '\033[0;31m'"Packages Installed:" $reset "$packages"

#echo

# All users
usersall=$(lslogins -u | sed '1d' | awk '{print $2}')
echo -e '\033[0;31m'"All Users:" $reset $usersall
#echo $reset"$usersall"

#echo

# Check Logged In Users
who>/tmp/who
echo -e '\033[0;31m'"Logged In Users:" $reset && cat /tmp/who

#echo

# ID of 1st Logged in User
iduser1=$(users | awk '{print $1}')
echo -e '\033[0;31m'"ID of 1st Logged in User:" $reset
echo $reset | id "$iduser1"

#echo

# Check System Uptime
tecuptime=$(uptime | awk '{print $3}' | cut -f1 -d,)
echo -e '\033[0;31m'"System Uptime Days/(HH:MM):" $reset $tecuptime

#echo

# Check Tasks results from top command
tasktop=$(top -n 1 -b | sed '2!d' | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}')
echo -e '\033[0;31m'"Tasks:" $reset $tasktop

#echo

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\033[0;31m'"Load Average:" $reset $loadaverage

# Number of executable commands
excount=$(./executable_scan.sh)
echo -e '\033[0;31m'"Number of executable commands:" $reset"$excount"

# Log Directry Size
logsize=$(du -h -s /var/log | awk '{print $1}')
echo -e '\033[0;31m'"Log Directory Size (/var/log/):" $reset"$logsize"

#echo

# Number of Items In Log
itemslog=$(ls -l /var/log | wc -l)
echo -e '\033[0;31m'"Number of Items in Log:" $reset"$itemslog"

#echo

# Motherboard Manufacturer
mboardman=$(dmidecode -s baseboard-manufacturer)
echo -e '\033[0;31m'"Motherboard Manufacturer:" $reset "$mboardman"

#echo

# CPU Model Name
cpumodel=$(lscpu | grep "Model name:" | awk '{print $3, $4, $5, $6, $7, $8, $9}')
echo -e '\033[0;31m'"CPU Model:" $reset "$cpumodel"

#echo

# CPU Family
cpufamily=$(dmidecode -s processor-family)
echo -e '\033[0;31m'"CPU Family:" $reset "$cpufamily"

#echo

# CPU Current Clcok Speed
cpufreq=$(dmidecode -s processor-frequency)
echo -e '\033[0;31m'"CPU Current Clock Speed:" $reset "$cpufreq"

#echo

# CPU Max Clock Speed
cpumcspeed=$(dmidecode -t 4 | grep "Max Speed:" | awk '{print $3 $4}')
echo -e '\033[0;31m'"CPU Max Clock Speed:" $reset "$cpumcspeed"

#echo

# Maximum RAM Slotage
ramslot=$(dmidecode -t 16 | sed '10!d' | awk '{print $3,$4}')
echo -e '\033[0;31m'"Maximium RAM Slotage:" $reset "$ramslot"

#echo

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e '\033[0;31m'"Internet: $reset Connected" || echo -e '\033[0;31m'"Internet: $reset Disconnected"

#echo

# Network Interface Cards
nic=$(cat /proc/net/dev | sed '1 d' | awk '{print $1}')
echo -e '\033[0;31m'"Available Network Interfaces:" $reset $nic

#echo

# IPv4 Address
#ipv4add=$(ifconfig | sed '2!d' | awk '{print $2}')
#ipv4add=$(hostname -I)
ipv4add=$(ip -c -4 addr)
echo -e '\033[0;31m'"IPv4:" $reset $ipv4add

#echo

# IPv6 Address
#ipv6add=$(ifconfig | sed '3!d' | awk '{print $2 $3}')
ipv6add=$(ip -c -6 addr)
echo -e '\033[0;31m'"IPv6:" $reset $ipv6add

#echo

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\033[0;31m'"External IP: $reset "$externalip

#echo

# CPU Threads & Cores
cputhreadcore=$(lscpu | egrep '^Thread|^Core|^Socket|^CPU\(')
echo -e '\033[0;31m'"CPU Thread & Core:"
echo $reset"$cputhreadcore"

echo

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\033[0;31m'"Ram Usage:" $reset
cat /tmp/ramcache | grep -v "Swap"
echo
echo -e '\033[0;31m'"Swap Usage:" $reset
cat /tmp/ramcache | grep -v "Mem"

echo

## contents of comp directory
compdir=$(./directory_scan.sh /)
echo -e '\033[0;31m'"Computer directory contents:"
echo $reset "$compdir"

echo

# Top Processes in order of CPU Usage
pscpu=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head)
echo -e '\033[0;31m'"Top Processes in Order of CPU Usage:"
echo $reset"$pscpu"

echo

# Top Processes in order of RAM Usage
psram=$(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head)
echo -e '\033[0;31m'"Top Processes in Order of RAM Usage:"
echo $reset"$psram"

echo

# Check Disk Usage / Partition report
lsblk > /tmp/diskusage
echo -e '\033[0;31m'"Disk usage / Partition report:" $reset
cat /tmp/diskusage

echo

# Last 10 lines on journalctl
journal=$(journalctl | tail -n 10)
echo -e '\033[0;31m'"Recent (last 10 lines) Journalctl:"
echo $reset"$journal"

echo

# Iptables List Rules
iptablesrules=$(iptables --list-rules)
echo -e '\033[0;31m'"Iptables List Rules:"
echo $reset"$iptablesrules"

echo

# UFW Status
ufwstatus=$(ufw status verbose)
echo -e '\033[0;31m'"UFW Status:"
echo $reset"$ufwstatus"

echo

# Devices Connected by USB
usbdev=$(lsusb)
echo -e '\033[0;31m'"Devices Connected by USB:"
echo $reset"$usbdev"

# PCI Connected Devices
#pcidev=$(lspci)
#echo -e '\033[0;31m'"P:" $reset "$pcidev"

echo

# Sesors Information
sensors=$(sensors)
echo -e '\033[0;31m'"Sensors:"
echo $reset"$sensors"

echo

# Audio Controller
lspciaudio=$(lspci -v | grep -A7 -i "audio" | sed '3,10d' | sed '5,11d')
echo -e '\033[0;31m'"Audio Controllers:"
echo $reset"$lspciaudio"

echo

# Graphics Card Info
lspcigraph=$(lspci -nnk | grep VGA -A1)
echo -e '\033[0;31m'"Graphics Card:"
echo $reset"$lspcigraph"

echo

# Check Network Adapter Details
nadapter=$(lspci -nnk | grep net -A2)
echo -e '\033[0;31m'"Network Adapter Details:"
echo $reset"$nadapter"

echo

# ARP Table
arptable=$(arp -vn)
echo -e '\033[0;31m'"ARP Table:"
echo $reset"$arptable"

echo

# Kernel IP Routing Table
routetable=$(netstat -r)
echo -e '\033[0;31m'"IP Routing Table:"
echo $reset"$routetable"

echo

# Check DNS
#nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
#echo -e '\033[0;31m'"Name Servers:" $reset $nameservers
./dns_result_fix.sh

echo

# NSLOOKUP Localhost
nslookup=$(nslookup localhost)
echo -e '\033[0;31m'"Nslookup Localhost:"
echo $reset"$nslookup"

echo

# LSOF Listening & Established Connections
lsofle=$(lsof -i)
echo -e '\033[0;31m'"All Listening & Established Connections:"
echo $reset"$lsofle"

echo

# Netstat (Connections)
netstatcon=$(netstat -ant)
echo -e '\033[0;31m'"Netstat TCP Connections:"
echo $reset"$netstatcon"

echo

# Netstat (UDP)
netstatudp=$(netstat -au)
echo -e '\033[0;31m'"Netstat UDP Connections:"
echo $reset"$netstatudp"

echo

# Find Listening SSH Connections
listenssh=$(netstat -ap | grep ssh)
echo -e '\033[0;31m'"Listening SSH Connections:"
echo $reset"$listenssh"

echo

# Check Connection Speed to Google (http)
connectspeed=$(curl -s -w 'Testing Website Response Time for :%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null http://www.google.com)
echo -e '\033[0;31m'"Connection Speed to Google (http):"
echo $reset"$connectspeed"

echo

# Check Connection Speed to Google (https)
connectspeed=$(curl -s -w 'Testing Website Response Time for :%{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nAppCon Time:\t\t%{time_appconnect}\nRedirect Time:\t\t%{time_redirect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null https://www.google.com)
echo -e '\033[0;31m'"Connection Speed to Google (https):"
echo $reset"$connectspeed"

echo

echo -e '\033[0;31m'"Would you like to whois external IP? (y/n): "
echo $reset
read user_input
if [ ${user_input} = "y" ]
then
    echo
	echo -e '\033[0;31m'"Whois On External IP: $reset "
	echo -e '\033[0;31m'"Whois On External IP: $reset "| whois $externalip
else
	echo
fi

# Packet Statistics
packetstats=$(netstat -s)
echo -e '\033[0;31m'"Would you like to see packet statistics? (y/n): "
echo $reset
read user_input
if [ ${user_input} = "y" ]
then
	echo -e '\033[0;31m'"Packet Statistics: $reset "
	echo "$packetstats"
	echo
else
	echo
fi

# Tracreroute on External IP
traceroute=$(traceroute $externalip)
echo -e '\033[0;31m'"Would you like to run traceroute on external IP? (y/n): "
echo $reset
read user_input
if [ ${user_input} = "y" ]
then
    echo
	echo -e '\033[0;31m'"Traceroute on External IP: $reset "
	echo "$traceroute"
else
	echo
fi

echo

# CPU average
echo -e '\033[0;31m'"Would you like to see CPU utilisation % over 30 seconds? (y/n): "
#echo -e '\033[0;31m'"(selecting yes deletes results,variables and temp files)"
echo $reset
read user_input
if [ ${user_input} = "y" ]
then
    echo
	average=$(./cpu_average.sh)
	echo -e '\033[0;31m'"CPU utilisation % over 30 seconds:"
	echo $reset"$average"
	echo
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
	echo " "
	echo " "
	echo -e "\033[0;36m""   #################################################################################################### " $reset
  echo -e "\033[0;36m""   #                           End of script. Written by W1z4R|)ofL0Z                                 # " $reset                                                                                                                                         #
  echo -e "\033[0;36m""   #################################################################################################### " $reset
	echo " "
	echo " "
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo
else
  echo
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
	echo " "
	echo " "
	echo -e "\033[0;36m""   #################################################################################################### " $reset
  echo -e "\033[0;36m""   #                           End of script. Written by W1z4R|)ofL0Z                                 # " $reset                                                                                                                                         #
  echo -e "\033[0;36m""   #################################################################################################### " $reset
	echo " "
	echo " "
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo "$(tput setaf 3)==========================================================================================================$(tput setab 0)$(tput sgr 0)" $reset
  echo
fi

echo "$(tput setaf 4)More programs in progress. Please donate to this hungry broke hippo:"
echo
echo "$(tput setaf 1)18t1qnVmnNhCPrC5u2c72HSHGdYHwdsrjd"
echo
echo "$(tput setaf 4)""Yours truly:"
echo
echo "$(tput setaf 2)W1z4R|)ofL0Z"
echo

# Unset Variables
unset reset os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache
}
fi
shift $(($OPTIND -1))
