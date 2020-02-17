#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get variables from the config file
if [ -z "${IPV6_CONFIG:-}" ]; then
    case "${1:-}" in
	4.4*)
	    CONFIG_FILE="config-4.4.sh"
	    ;;
	*)
	    CONFIG_FILE="config.sh"
	    ;;
    esac

    # See if there's a config.sh in the SCRIPTDIR
    if [ -f "${SCRIPTDIR}/${CONFIG_FILE}" ]; then
        echo "Using IPV6_CONFIG ${SCRIPTDIR}/${CONFIG_FILE}"
        IPV6_CONFIG="${SCRIPTDIR}/${CONFIG_FILE}"
    else
        echo "Please run with a configuration environment set." >&2
        echo "eg IPV6_CONFIG=config.sh $0" >&2
        exit 1
    fi
fi
source $IPV6_CONFIG
