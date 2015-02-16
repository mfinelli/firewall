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

# Now we can actually change the iptables rules.
arr=('nat' 'mangle' 'raw' 'security')

iptables -F
iptables -X

for item in "${arr[@]}"
do
    iptables -t "$item" -F
    iptables -t "$item" -X
done

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
