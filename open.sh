#!/bin/bash

# Open an individual port. You must specify port number and protocol.
function open_port () {
    echo "Opening port $1 over $(uc "$2")."
    iptables -A $(uc "$2") -p $(lc "$2") --dport "$1" -j ACCEPT
}

# Check for defined rules first. If we don't hit any of these we'll fall
# through and open individual ports.
function open_port_entry () {
    case "$1" in
        SSH|Ssh|ssh)
            open_port 22 tcp
            ;;
        WEB|Web|web)
            open_port 80 tcp
            open_port 442 tcp
            ;;
        HTTP|Http|http)
            open_port 80 tcp
            ;;
        HTTPS|Https|https)
            open_port 443 tcp
            ;;
        DNS|Dns|dns)
            open_port 53 tcp
            open_port 53 udp
            ;;
        NTP|Ntp|ntp)
            open_port 123 udp
            ;;
        MYSQL|MySQL|Mysql|mysql)
            open_port 3306 tcp
            ;;
        *)
            open_port "$1" "$2"
            ;;
    esac
}
