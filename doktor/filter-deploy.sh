#!/bin/bash

list="front paper author fulltext thumbnail stats"
for x in $list
do
    sed "s/REPLACE_ME/$x/g" template-envoy-filter.yml | kubectl apply -f -
done
