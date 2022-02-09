#!/usr/bin/env bash

exit_code=0

for canonical_data_file in $(find exercises -name canonical-data.json); do
    for keys in $(jq -r '.. | objects | select(has ("uuid")) | keys_unsorted | join(",")' $canonical_data_file); do
        if [[ ! "${keys}" =~ ^uuid(,reimplements)?,description(,comments)?(,scenarios)?,property,input,expected$ ]]; then
            echo "$canonical_data_file: $keys is not good"
            exit_code=1
        fi
    done
done

exit $exit_code
