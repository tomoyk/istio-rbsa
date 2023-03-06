#!/bin/bash

# jsonbinpack
task_jbp() {
    # Encoding file create
    ./node_modules/.bin/jsonbinpack compile \
        jsonbinpack/fulltext-openapi.json \
        > result_jsonbinpack/_encoding.json

    # Binpacked file create
    for fname in $(ls response_collects)
    do
        newfname=$(echo $fname | sed 's/.txt$/.result/g')
        # echo $newfname
        ./node_modules/.bin/jsonbinpack serialize \
            result_jsonbinpack/_encoding.json \
            "response_collects/$fname" \
            > "result_jsonbinpack/bin.$newfname"
    done
}

# ubjson
task_ubj() {
    for fname in $(ls response_collects)
    do
        newfname=$(echo $fname | sed 's/.txt$/.result/g')
        json2bson "response_collects/$fname" "result_bson/ubj.$newfname"
    done
}
