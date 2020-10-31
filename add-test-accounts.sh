#!/bin/bash

if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

for i in adam marek martin dana petr
do
  useradd ${i}
  echo "password123" | passwd --stdin ${i}
done