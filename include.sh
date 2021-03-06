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
function check_software () {
    if ! hash "$1" 2>/dev/null; then
        error "${1^} not found. Do you need to install it?"
        exit 2
    fi
}

# Check to see if a named chain already exists.
# http://stackoverflow.com/a/10784612
function chain_exists () {
    if [[ $# -lt 1 || $# -gt 2 ]]; then
        error "Chain_exists usage: chain_exists <chain_name> [table]"
        exit 3
    fi
    local chain_name="$1"; shift
    if [[ $# -eq 1 ]]; then
        local table=" --table $1"
    fi
    iptables"$table" -n --list "$chain_name" > /dev/null 2>&1
}

# Uppercase and lowercase a string.
# http://stackoverflow.com/a/2264537
function uc () {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}
function lc () {
    echo "$1" | tr '[:upper:]' '[:lower:]'
}
