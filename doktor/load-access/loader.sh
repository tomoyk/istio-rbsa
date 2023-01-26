#!/bin/bash

counter=0
cat url-patterns.txt | while read line
do
	# echo $line
	method=$(echo $line | awk '{print $1}')
	path=$(echo $line | awk '{print $2}')
	echo -n -e "${counter}\t${method}\thttp://localhost${path}\t"
	curl -I -s -X $method "http://localhost${path}" | head -n 1 | cut -d' ' -f2-
	# sleep 0.1
	counter=$((counter + 1))
done
