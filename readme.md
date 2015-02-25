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

### Open

You can open individual ports in the firewall with this script. There are two ways to call this script. You can pass one of the predefined rules or an individual port number along with the protocol. To open with a predefined rule (e.g., SSH through port 22):

    $ ./open.sh ssh

The complete list of supported rules is:
* SSH: port 22
* Web: ports 80 and 443
* HTTP: port 80
* HTTPS: port 443
* DNS: port 53 (UDP)

To open an arbitrary port:

    $ ./open.sh 22 tcp

Or:

    $ ./open.sh 53 udp
