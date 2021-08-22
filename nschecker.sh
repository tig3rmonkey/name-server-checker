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

uniqcount=`uniq -d domains.txt | wc -l`

echo -n "Domains Being Queried: " && wc -l domains.txt | awk '{print $1}'
echo -n "Duplicate Entries Found: "  && echo "$uniqcount" | awk '{print $1}'

if [ "$uniqcount" -ge 1 ]; then
	echo -e " * " `uniq -d domains.txt` 
fi

echo -e '\n'

while read x; do
	echo -n $x":"

	if [ ${#x} -gt 15 ]; then
		printf "\t\t"
	else
		printf "\t\t\t"
	fi
	
	if [ ${#x} -ge 4 ]; then	
		#Sort the results before returning them to the screen
		IFS=" " read -a myarray <<< `dig ns $x +short | xargs`
		myarray=($(for each in ${myarray[@]}; do echo $each; done | sort))
		echo ${myarray[@]}
	else
		echo -e "-\t!! WARNING: THE DOMAIN IS LESS THAN 4 CHARACTERS LONG - PLEASE CHECK THE \"domains.txt\" FILE"
	fi
	
	#You MAY need to enable sleep if the results become a little skewed. 	
	#sleep 1
done < domains.txt

# Lazy formatting
cat << "EOF"


EOF
