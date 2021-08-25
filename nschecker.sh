#!/bin/bash

cat << "EOF"


 _______                            _________                                
 \      \ _____    _____   ____    /   _____/ ______________  __ ___________ 
 /   |   \\__  \  /     \_/ __ \   \_____  \_/ __ \_  __ \  \/ // __ \_  __ \
/    |    \/ __ \|  Y Y  \  ___/   /        \  ___/|  | \/\   /\  ___/|  | \/
\____|__  (____  /__|_|  /\___  > /_______  /\___  >__|    \_/  \___  >__|   
        \/     \/      \/     \/          \/     \/                 \/       
_________ .__                   __                 
\_   ___ \|  |__   ____   ____ |  | __ ___________ 
/    \  \/|  |  \_/ __ \_/ ___\|  |/ // __ \_  __ \
\     \___|   Y  \  ___/\  \___|    <\  ___/|  | \/
 \______  /___|  /\___  >\___  >__|_ \\___  >__|   
        \/     \/     \/     \/     \/    \/       
							      By: blackhat.nz




EOF

usage() {
    cat << EOF
    Usage: $(basename "${BASH_SOURCE[0]}") [-h|a] arg1
	   root@#: ./$(basename "${BASH_SOURCE[0]}") -a ns

    About:
    A simple bash script designed to scan a list of domain names (provided in a 
    "domains.txt" file) and output the results of the desired DNS records in 
    a sorted order, in effect grouping similar results.

    Available options:
    
    -h, --help      Print this help menu and exit
    -a, --arg       [Required] Name Server record you'd like bulk scanned and 
                    sorted. E.g. a|mx|ns|aaaa


EOF
    exit
}

#checking # of args provided
if [ "$#" -lt 2 ]; then
        usage
fi

# Flag so that -a etc align properly.
while getopts a:arg:h:help: flag
do
    case "${flag}" in
        a) arg=${OPTARG};;
        arg) arg=${OPTARG};;
        #h) help=${OPTARG};;
        #help) help=${OPTARG};;
    esac
done

# Define variables
uniqcount=`uniq -d domains.txt | wc -l`
intvar=1
tmpcsv="/tmp/tmp.csv"
results="results.csv"

echo -n "Domains Being Queried: " && wc -l domains.txt | awk '{print $1}'
echo -n "Duplicate Entries Found: "  && echo "$uniqcount" | awk '{print $1}'

if [ "$uniqcount" -ge 1 ]; then
	echo -e "\033[41m [+] " `uniq -d domains.txt` "\033[m"
fi

echo -e '\n'
cat /dev/null > $tmpcsv

while read x; do
	echo -n "$intvar. $x : "
	echo -n $x >> $tmpcsv       
        
	# length of maximum padding
	#padding="......................................"
	padding="                              "
	
	printf "%s %s ${padding:${#x}}"
	printf "%s %s ${padding:${#x}}" >> $tmpcsv
	
	# Hack because numbering throws out formatting when moving from single digits
	if [ "${#intvar}" == 2 ]; then
		echo -n "  "
	elif [ "${#intvar}" == 3 ]; then
		echo -n " "
	elif [ "${#intvar}" == 4 ]; then
		echo -n ""
	else
		echo -n "   "
	fi
	
	if [ ${#x} -ge 4 ]; then	
		#Sort the results before returning them as they can return in any order
		IFS=" " read -a myarray <<< `dig $x $arg +short | xargs`
		myarray=($(for each in ${myarray[@]}; do echo $each; done | sort))
		echo ${myarray[@]}
		echo ${myarray[@]} >> $tmpcsv
	else
		echo -e "\033[41m!! WARNING: THE DOMAIN IS LESS THAN 4 CHARACTERS LONG - PLEASE CHECK THE \"domains.txt\" FILE\033[m"
		echo -e "!! WARNING: THE DOMAIN IS LESS THAN 4 CHARACTERS LONG - PLEASE CHECK THE \"domains.txt\" FILE" >> $tmpcsv
	fi
	
	intvar=$((intvar+1))
	#sleep 1
done < domains.txt

sort -b -k 2 $tmpcsv > $results
rm $tmpcsv

# Lazy formatting
cat << "EOF"


EOF

echo -e "\033[44mResults will also output to $results (this has the name servers ordered alphabetically, in effect grouping similar name servers) \033[m"


# Lazy formatting
cat << "EOF"


EOF
