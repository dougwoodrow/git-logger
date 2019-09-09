#!/bin/bash

number_days_back=1

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -n | --number )
	shift;
    number_days_back=$1
    ;;
  -w | --weekend )
    number_days_back=3
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

number_days_back=${number_days_back}d
after=`date -v-$number_days_back "+%F"`
after="$after 00:00"
before=`date -v-$number_days_back "+%F"`
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

