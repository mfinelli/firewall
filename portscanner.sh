function add_portscanner_rules () {
    # syn scans.
    iptables -I TCP -p tcp -m recent --update --seconds 60 --name \
        TCP-PORTSCAN -j REJECT --reject-with tcp-rst
    iptables -D INPUT -p tcp -j REJECT --reject-with tcp-rst
    iptables -A INPUT -p tcp -m recent --set --name TCP-PORTSCAN -j REJECT \
        --reject-with tcp-rst

    # udp scans.
    iptables -I UDP -p udp -m recent --update --seconds 60 --name \
        UDP-PORTSCAN -j REJECT --reject-with icmp-port-unreachable
    iptables -D INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
    iptables -A INPUT -p udp -m recent --set --name UDP-PORTSCAN -j REJECT \
        --reject-with icmp-port-unreachable

    # Restore final stateful rule.
    iptables -D INPUT -j REJECT --reject-with icmp-proto-unreachable
    iptables -A INPUT -j REJECT --reject-with icmp-proto-unreachable
}
