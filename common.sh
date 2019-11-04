#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
USER=`whoami`

# Get variables from the config file
if [ -z "${IPV6_CONFIG:-}" ]; then
    # See if there's a config_$USER.sh in the SCRIPTDIR
    if [ -f "${SCRIPTDIR}/config_${USER}.sh" ]; then
        echo "Using IPV6_CONFIG ${SCRIPTDIR}/config_${USER}.sh"
        IPV6_CONFIG="${SCRIPTDIR}/config_${USER}.sh"
    else
        echo "Please run with a configuration environment set." >&2
        echo "eg IPV6_CONFIG=config_example.sh $0" >&2
        exit 1
    fi
fi
source $IPV6_CONFIG

