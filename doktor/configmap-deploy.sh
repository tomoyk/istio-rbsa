#!/bin/bash

list="front paper author fulltext thumbnail stats"
for x in $list
do
    sed "s/REPLACE_ME/$x/g" template-json-lua-configmap.yml | kubectl apply -f -
done
