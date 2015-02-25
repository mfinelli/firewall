# firewall

A set of scripts to manage the firewall on Linux using iptables.

## Standard Usage

There are various scripts that perform various functions to manage the firewall. They should generally be run in this order.

### Reset rules

This script resets the iptables to an empty state, allowing all traffic.

    $ ./reset.sh

### Stateful firewall

This sets the firewall to be like the Arch Linux guide. No ports are open so you shouldn't run this from an SSH session.

    $ ./stateful.sh

### Port scanner

Attempt to mitigate port scanner attacks.

    $ ./portscanner.sh

### Sshguard

Once you've installed sshguard you can add rules to your iptables. This will also open port 22.

    $ ./sshguard.sh
