#!/bin/bash

BASEDIR=$(cd $(dirname $0); pwd)

. ${BASEDIR}/config.sh

for entry in "${aliases[@]}" ; do
   entry=($entry)
   ip_address=${entry[0]}

   ifconfig lo0 alias ${ip_address}
done