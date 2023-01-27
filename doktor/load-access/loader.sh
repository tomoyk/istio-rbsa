#!/bin/bash

cd `dirname $0`

timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
filename="load-${timestamp}.log"
touch $filename

counter=0
cat url-patterns.txt | while read line
do
	# echo $line
	method=$(echo $line | awk '{print $1}')
	path=$(echo $line | awk '{print $2}')
	echo -n -e "${counter}\t${method}\thttp://localhost${path}\t"
	curl -I -s -w "%{http_code}\t%{time_total}\n" -X $method -o /dev/null "http://localhost${path}" # | head -n 1 | cut -d' ' -f2-
	# sleep 0.1
	counter=$((counter + 1))
done | tee -a $filename
