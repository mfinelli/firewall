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

# Make sure that sshguard is installed.
check_software "sshguard"

# Add the sshguard chain and rule.
iptables -N sshguard
iptables -A TCP -p tcp --dport 22 -j sshguard
