#!/bin/bash

reset=$(tput sgr0)

touch /tmp/live_interfaces.txt; ip link show | grep UP > /tmp/live_interfaces.txt

touch /tmp/interface_in_use.txt; cat /tmp/live_interfaces.txt | sed '2!d' | awk '{print $2}' > /tmp/interface_in_use.txt

interface_in_use=$(sed 's/://' /tmp/interface_in_use.txt)
						
dns_server=$(nmcli device show $interface_in_use | grep IP4.DNS)

echo -e '\033[0;31m'"DNS Server/s:" 
echo -e $reset $dns_server




