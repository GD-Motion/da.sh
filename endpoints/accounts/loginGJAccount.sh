#!/bin/bash

source config.sh
source constants.sh
source form.sh "$1"

if [[ ! -f "database/accounts/${data[userName],,}" ]]; then
    echo -e "$ERROR"
    exit 0
fi

# read database, split into array
IFS=':' read -ra ACCOUNT <<< "$($cat "database/accounts/${data[userName],,}")"

# data[gjp2] is the hashed password
if [[ "${ACCOUNT[2]}" == "${data[gjp2]}" ]]; then
    echo -e "${ACCOUNT[0]},${ACCOUNT[0]}"
else
    echo -e "$ACCOUNT_LOGIN_FAILED"
fi

# -12 returns "Account has been disabled"