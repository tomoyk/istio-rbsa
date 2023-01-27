#!/bin/bash

case "$1" in
    "proposal")
        filter_file="template-envoy-filter-proposal.yml"
        ;;
    "normal")
        filter_file="template-envoy-filter.yml"
        ;;
    *)
        exit 1
        ;;
esac

echo "filter_file=$filter_file"

list="front paper author fulltext thumbnail stats"
for x in $list
do
    sed "s/REPLACE_ME/$x/g" $filter_file | kubectl apply -f -
done
