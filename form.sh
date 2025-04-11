#!/bin/bash
# form.sh: Decodes form (POST) data into an array
# todo: get array as an output instead of a global assignment (is that even possible?)

source config.sh

DECODED=$(echo "$1" | $b64 -d)

declare -g -A data

IFS='&' read -ra PAIRS <<< "$DECODED"

for pair in "${PAIRS[@]}"; do
    IFS='=' read -r key val <<< "$pair"
    key=$(printf '%b' "${key//%/\\x}")
    val=$(printf '%b' "${val//%/\\x}")
    data["$key"]="$val"
    [[ $_DEBUG -eq 1 ]] && echo -e "Key: ${CG}$key${C0}, Value: ${CG}$val${C0}" >&2
done
