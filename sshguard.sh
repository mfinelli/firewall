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

# Add the sshguard chain if it doesn't already exist. (Some distributions
# e.g., Debian automatically create the chain when installing sshguard.)
if ! chain_exists "sshguard"; then
    iptables -N sshguard
fi

# Add the sshguard rule for port 22. N.B. that it still needs to be
# accepted through the firewall.
iptables -A TCP -p tcp --dport 22 -j sshguard
