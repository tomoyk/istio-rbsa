#!/bin/bash -xe

while read line < url-patterns.txt
do
	# echo $line
	method=$(echo $line | awk '{print $1}')
	path=$(echo $line | awk '{print $2}')
	echo "http://localhost${path}"
	curl -s -X $method "http://localhost${path}" -o /dev/null
	sleep 0.1
done
