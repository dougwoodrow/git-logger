#!/bin/bash

after=`date -v-1d "+%F"`
after="$after 00:00"
before=`date -v-1d +%F`
before="$before 23:59"

logs=`git --no-pager log --before="$before" --after="$after" --author="Doug Woodrow" --format=%B` 
echo "$logs" > logs.tmp

log_statement=""

while read line; do
	if [[ $line = *[!\ ]* ]]; then
		log_statement="$log_statement, $line"
	fi
done < logs.tmp
rm logs.tmp

echo "${log_statement:2}" | pbcopy

