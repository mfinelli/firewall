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

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -t raw -F
iptables -t raw -X
iptables -t security -F
iptables -t security -X
iptables -P INPUT ACCEPT
iptables -P FOREWARD ACCEPT
iptables -P OUTPUT ACCEPT

