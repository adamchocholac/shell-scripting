#!/bin/bash

# This script shows the opent network ports on a system.
# Use -4 as an argument to limit to tcpv4 ports.

if [[ "${1}" = '-4' ||  "${1}" = '' ]]
then
  netstat -nutl ${1} | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'
else
  echo 'Your input parameter is wrong, use 4, to display only tcpv4 ports.' >&2
  exit 1
fi  

