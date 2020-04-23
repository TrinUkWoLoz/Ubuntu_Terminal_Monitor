#!/bin/bash

scriptbc=$(which scriptbc)


#Function to format sizes in KB to KB, MB, or GB for more readable output
readablesize()
{

	if [ $1 -ge 1048576 ] ; then
		echo "$($scriptbc -p 2 $1 / 1048576)GB"
	elif [ $1 -ge 1024 ] ; then
		echo "$($scriptbc -p 2 $1 / 1024)MB"
	else
		echo "${1}KB"
	fi
}

#################
##  MAIN CODE  ##
#################

if [ $# -gt 1 ] ; then
	echo "Usage: $0 [dirname]" >&2
	exit 1
elif [ $# -eq 1 ] ; then
	cd "$@"
	if [ $? -ne 0 ]	; then
		exit 1
	fi
fi

for file in *
do
	if [ -d "$file" ] ; then
		size=$(ls "$file" | wc -l | sed 's/[^[:digit:]]//g')
		if [ $size -eq 1 ] ; then
			echo "$file ($size entry)|"
		else
			echo "$file ($size entries)|"
		fi
	else
		size="$(ls -sk "$file" | awk '{print $1}')"
		echo "$file ($(readablesize $size))|"
	fi
done | \
	sed 's/ /^^^/g'  | \
	xargs -n 2     | \
	sed 's/\^\^\^/ /g' | \
	awk -F\| '{ printf "%-39s %-39s\n", $1, $2 }'

exit 0
