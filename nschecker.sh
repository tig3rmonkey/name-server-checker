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

# Define Vars
uniqcount=`uniq -d domains.txt | wc -l`
intvar=1
tmpcsv="tmp.csv"
results="grouped_ns_results.csv"

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
	
	# Hack because numbering throws out formating when moving from single digits
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
		IFS=" " read -a myarray <<< `dig ns $x +short | xargs`
		myarray=($(for each in ${myarray[@]}; do echo $each; done | sort))
		echo ${myarray[@]}
		echo ${myarray[@]} >> $tmpcsv
	
	else
		echo -e "\033[41m!! WARNING: THE DOMAIN IS LESS THAN 4 CHARACTERS LONG - PLEASE CHECK THE \"domains.txt\" FILE\033[m"
		echo -e "!! WARNING: THE DOMAIN IS LESS THAN 4 CHARACTERS LONG - PLEASE CHECK THE \"domains.txt\" FILE" >> $tmpcsv
	fi
	
	intvar=$((intvar+1))
	#You MAY need to enable sleep if the results become a little skewed. 	
	#sleep 1
done < domains.txt

sort -b -k 2 $tmpcsv > $results

# Lazy formatting
cat << "EOF"


EOF

