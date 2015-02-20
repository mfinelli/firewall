#!/bin/bash

# Get include path. (http://stackoverflow.com/a/12694189)
dir="${BASH_SOURCE%/*}"
if [[ ! -d "$dir" ]]; then
    dir="$PWD"
fi

# Include functions.
source "$dir"/include.sh

# Make sure that we have permission.
check_root

# Make sure that iptables is actually installed.
check_software "iptables"

# Now we can actually change the iptables rules. We don't need "filter" here
# because that's the default table and is taken care of first, below.
tables=('nat' 'mangle' 'raw' 'security')

iptables -F
iptables -X

for table in "${tables[@]}"
do
    iptables -t "$table" -F
    iptables -t "$table" -X
done

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
