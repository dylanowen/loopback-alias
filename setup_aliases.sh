#!/bin/bash

BASEDIR=$(cd $(dirname $0); pwd)
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

plist_name=com.dylowen.loopbackalias.plist
install_location="/Library/LaunchDaemons/${plist_name}"

sed 's?{install_location}?'${BASEDIR}'?g' ${BASEDIR}/${plist_name} > ${install_location}

echo -e "${GREEN}Installed a Launch Daemon at ${install_location}${NC}"