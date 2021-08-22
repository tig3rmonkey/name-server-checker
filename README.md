# name-server-checker
Bash script that scans a list of domain names (provided in "domains.txt") for the attached name servers and outputs the results in a sorted order.

# FEATURES:
* Scans a list of domain names (provided in "domains.txt") for the attached name servers and outputs the results in a sorted order.
* Checks for duplicate domain names supplied in the "domains.txt" file
* Checks total number of domain names provided.
* Checks whether the domain names are less than 4 characters long as they are likely invalid and/or spaces.


# USAGE:

# Make the file executable
chmod +x dnschecker.sh

# Run script:
./dnschecker.sh 

# Output result to a file:
./dnschecker.sh > result.txt


