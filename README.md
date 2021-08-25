# name-server-checker
Bash script that scans a list of domain names for a desired DNS record and outputs the results in a sorted/grouped order.

# FEATURES:
* Scans a list of domain names (provided in "domains.txt") for their desired DNS records and outputs the results in a sorted order.
* Checks for duplicate domain names in the "domains.txt" file
* Checks total number of domain names provided.
* Checks whether the domain names are less than 4 characters long as they are likely invalid and/or spaces.
* Results will also output automatically to a csv file in the same directory (this has the name servers ordered alphabetically, in effect grouping domains that are using similar name servers)

# VERSION 1.1 IMPOVEMENTS:
* Added numbering next to each domain/output on the terminal
* Better formatting/output for larger domain lists
* Red/color text for warning messages
* Results are now automatically outputed to a csv file and grouped alphabelically by name servers

# VERSION 1.2 IMPROVEMENTS:
* Help menu
* Added support for further ns record gathering/sorting (A, MX, TXT, NS, SOA, AAAA, SRV records are now support for bulk scanning and sorting)

# USAGE:

* Update the "domains.txt" file with your list of domain names
* Each domain must be on its own line
* Only the apex domain should be supplied. Supplying a domain with the prefixed "www" will simply not work.

# Make the file executable
chmod +x nschecker.sh

# Run script, specifying which DNS record you'd like to gather
./nschecker.sh -a mx

# Check stdout and results.csv for the results.
cat results.csv

# Use Cases:
* When migrating domains you may also be tasked with migrating their DNS zones and updating their name servers. This script will return a list of domains sorted by their name servers, (or any other DNS record) which should help you quickly identify which group of domain names have name servers residing where. E.g. ./nschecker.sh -a ns
* You may be auditing a server and want to know which sites are still resolving to it. Scanning a list of domains for their A record and having these results returned in a sorted order should help you with this. E.g. ./nschecker.sh -a A

