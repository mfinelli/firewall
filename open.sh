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

# Check for defined rules first. If we don't hit any of these we'll fall
# through and open individual ports.
case "$1" in
    SSH|Ssh|ssh)
        iptables -A TCP -p tcp --dport 22 -j ACCEPT
        ;;
    WEB|Web|web)
        iptables -A TCP -p tcp --dport 80 -j ACCEPT
        iptables -A TCP -p tcp --dport 443 -j ACCEPT
        ;;
    HTTP|Http|http)
        iptables -A TCP -p tcp --dport 80 -j ACCEPT
        ;;
    HTTPS|Https|https)
        iptables -A TCP -p tcp --dport 443 -j ACCEPT
        ;;
    DNS|Dns|dns)
        iptables -A UDP -p udp --dport 53 -j ACCEPT
        ;;
    *)
        iptables -A $(uc "$2") -p $(lc "$2") --dport "$1" -j ACCEPT
        ;;
esac

