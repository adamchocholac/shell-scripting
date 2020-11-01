#!/bin/bash

# Count the number of failed logins by IP address
# If there are any IPs with over LIMIT failures, display the count

LIMIT='10'
LOG_FILE="${1}"

# Check if the file exists
if [[ ! -e "${LOG_FILE}" ]]
then
  echo "Cannot open log file: ${LOG_FILE}" >&2
  exit 1
fi

#Display the CSV header.
echo 'Count,IP,Location'

# Loop through the list of failed attempts and corresponding IP addresses.
grep Failed syslog-sample | awk '{print $(NF-3)}' | sort | uniq -c | sort -rn | \
while read COUNT IP
do
  # If the number of failed attempts is greater than the limit, display coun, IP and location
  if [[ "${COUNT}" -gt "${LIMIT}" ]]
  then
    LOCATION=$(geoiplookup ${IP} | awk -F ', ' '{print $2}')
    echo "${COUNT},${IP},${LOCATION}"
  fi
done
exit 0

