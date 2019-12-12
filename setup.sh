#!/bin/bash

BASEDIR=$(cd $(dirname $0); pwd)

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

${BASEDIR}/setup_aliases.sh
${BASEDIR}/setup_hosts.sh
${BASEDIR}/loopback_alias.sh