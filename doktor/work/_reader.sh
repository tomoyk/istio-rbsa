#!/bin/bash

echo $1

while read line < $1
do
    echo $1 | tr '\t' '\\\t' | jq '._source.message' 
done
