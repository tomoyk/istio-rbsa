#!/bin/bash -xe

cat url-patterns.txt | while read line
do
	# echo $line
	method=$(echo $line | awk '{print $1}')
	path=$(echo $line | awk '{print $2}')
	echo -n -e "${method}\thttp://localhost${path}\t"
	curl -I -s -X $method "http://localhost${path}" | head -n 1 | cut -d' ' -f2-
	sleep 0.1
done
