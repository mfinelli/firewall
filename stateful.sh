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
check_iptables

# Create tcp and udp chains.
iptables -N TCP
iptables -N UDP

# Set the starting rules.
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP

# Allow established traffic as well as valid new traffic.
iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Allow traffic from the loopback device.
iptables -A INPUT -i lo -j ACCEPT

# Drop invalid packets.
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP

# Allow pings.
iptables -A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT

# Attach the tcp and udp chains to the input chain.
iptables -A INPUT -p udp -m conntrack --ctstate NEW -j UDP
iptables -A INPUT -p tcp --syn -m conntrack --ctstate NEW -j TCP

# Reject tcp connections with rst packets and udp streams with port
# unreachable messages.
iptables -A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -j REJECT --reject-with tcp-rst

# Reject all remaining incoming traffic.
iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
