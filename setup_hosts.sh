#!/bin/bash

BASEDIR=$(cd $(dirname $0); pwd)

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

. ${BASEDIR}/config.sh

echo "Backing up /etc/hosts to ${BASEDIR}/hosts.backup"
cp /etc/hosts ${BASEDIR}/hosts.backup

hosts_file="/etc/hosts"

for entry in "${aliases[@]}" ; do
   entry_array=($entry)
   ip_address=${entry_array[0]}
   # check if we have a hostname
   if [ ${#entry_array[@]} -eq 2 ]; then
      host_name=${entry_array[1]}

      # check if we need to replace our old line
      if grep -Eq "^.*[[:space:]]+${host_name}[[:space:]]*$" ${hosts_file}; then
         echo -e "${YELLOW}${host_name} already, exists. Replacing it${NC}"
         sed -i '' "s/^.*\s+${host_name}\s*$/${entry}/" ${hosts_file}
      else
         echo -e "${GREEN}Adding ${host_name} to ${hosts_file}${NC}"
         echo ${entry} >> ${hosts_file}
      fi
   fi
done