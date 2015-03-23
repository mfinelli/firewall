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

Once you've installed sshguard you can add rules to your iptables. This will also automatically setup sshguard to work on port 22. You will still need to open port 22 in order to connect via ssh. (See below)

    $ ./sshguard.sh

### Open

You can open individual ports in the firewall with this script. There are two ways to call this script. You can pass one of the predefined rules or an individual port number along with the protocol. To open with a predefined rule (e.g., SSH through port 22):

    $ ./open.sh ssh

The complete list of supported rules is:
* SSH: port 22
* Web: ports 80 and 443
* HTTP: port 80
* HTTPS: port 443
* DNS: port 53

To open an arbitrary port:

    $ ./open.sh 22 tcp

Or:

    $ ./open.sh 53 udp

## What next?

After running the scripts and opening your desired ports you should save the rules and make sure the iptables service is enabled with e.g., systemd:

    # iptables-save > /etc/iptables/iptables.rules
    # systemctl [start|enable] iptables
    # systemctl [start|enable] sshguard

Obviously, setting up your firewall is only a start. You should take every effort to lock your machine down by disabling root login through SSH, for example.

## Disclaimer

I don't claim to know anything about security. These scripts were created by basically following the guide at the Arch Linux wiki for my own personal use. It's great if you want to use them as well, but I am not liable if your machine gets owned. For more information see the license.
