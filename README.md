# name-server-checker
Bash script that scans a list of domain names (provided in "domains.txt") for the attached name servers and outputs the results in a sorted order.

# FEATURES:
* Scans a list of domain names (provided in "domains.txt") for the attached name servers and outputs the results in a sorted order.
* Checks for duplicate domain names supplied in the "domains.txt" file
* Checks total number of domain names provided.
* Checks whether the domain names are less than 4 characters long as they are likely invalid and/or spaces.
* Results will also output to two files: tmp.csv (basic ns scan - no grouping) and grouped_ns_results.csv (this has the name servers ordered alphabetically, in effect grouping similar name servers)

VERSION 1.1 IMPOVEMENTS:
* Added numbering next to each domain/output
* Better formatting/output for larger domain lists
* Red/color text for warning messages
* Results are now automatically outputed to a csv file and grouped alphabelically by name servers


# USAGE:

# Update the "domains.txt file with your list of domain names to check.
# Each domain must be on its own line
# Only the apex domain should be supplied. Supplying a domain with the prefixed "www" will simply not work.

# Make the file executable
chmod +x nschecker.sh

# Run script:
./nschecker.sh 

# Check stdout, tmp.csv, and grouped_ns_results.csv for the results.
cat tmp.csv
cat grouped_ns_results.csv


