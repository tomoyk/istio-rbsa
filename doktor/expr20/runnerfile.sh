#!/bin/bash

task_default() {
    runner -l
}

# jsonbinpack
task_jbp() {
    # Encoding file create
    ./node_modules/.bin/jsonbinpack compile \
        jsonbinpack/fulltext-openapi.json \
        > result_jsonbinpack/_encoding.json

    # Binpacked file create
    for fname in $(ls response_collects | grep txt)
    do
        newfname=$(echo $fname | sed 's/.txt$/.result/g')
        # echo $newfname
        ./node_modules/.bin/jsonbinpack serialize \
            result_jsonbinpack/_encoding.json \
            "response_collects/$fname" \
            > "result_jsonbinpack/bin.$newfname"
    done
}

# bson
task_bson() {
    for fname in $(ls response_collects/ | grep txt)
    do
        newfname=$(echo $fname | sed 's/.txt$/.result/g')
        json2bson "response_collects/$fname" "result_bson/bson.$newfname"
    done
}

task_rbsi() {
    for i in $(ls response_collects/*.txt)
    do
        python rbsa.py $i
    done
}
