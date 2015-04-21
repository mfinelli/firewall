# This function removes all of the rules and resets the firewall to a
# default state.
function reset_firewall () {
    # We don't need "filter" here because that's the default table and is
    # cleared first by calling the commands with no table argument.
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
}
