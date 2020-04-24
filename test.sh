#!/bin/bash

# Packet Statistics
packetstats=$(netstat -s)
echo -e '\033[0;31m'"Would you like to see packet statistics? (y/n): "
echo $reset
read user_input
if [ ${user_input} = "y" ]
then
	echo -e '\033[0;31m'"Packet Statistics: $reset "
	echo "$packetstats"
else
	echo
fi