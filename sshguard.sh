function add_sshguard_rules () {
    # Add the sshguard chain if it doesn't already exist. (Some
    # distributions e.g., Debian automatically create the chain when
    # installing sshguard.)
    if ! chain_exists "sshguard"; then
        iptables -N sshguard
    fi

    # Add the sshguard rule for port 22. N.B. that it still needs to be
    # accepted through the firewall.
    iptables -A TCP -p tcp --dport 22 -j sshguard
}
