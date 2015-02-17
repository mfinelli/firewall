# Colors: (http://stackoverflow.com/a/20983251)
red=$(tput setaf 1)
reset=$(tput sgr0)

# Prints message in red to standard error unless not a terminal.
function error () {
    if [[ -t 2 ]]; then
        echo "${red}$@${reset}" >&2
    else
        echo "$@" >&2
    fi
}

# Check to make sure we're running as root.
function check_root () {
    if [[ $EUID -ne 0 ]]; then
        error "You must run this script as root."
        exit 1
    fi
}

# Check to make sure iptables is actually installed!
# http://stackoverflow.com/a/677212
function check_iptables () {
    if ! hash iptables 2>/dev/null; then
        error "Iptables not found. Do you need to install it?"
        exit 2
    fi
}
