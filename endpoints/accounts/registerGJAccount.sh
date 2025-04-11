#!/bin/bash

source config.sh
source constants.sh
source form.sh "$1"

# check if account exists (,, = tolower)
# maybe change from name to id ... that'd mean I would have to iterate through every file but whatever
if [[ -f "database/accounts/${data[userName],,}" ]]; then
    echo -e "$ACCOUNT_USERNAME_TAKEN"
    exit 0
fi

# technically we should check against emails as well, but we don't even make use of them, so whatever

gjp=$(./gjp.sh "${data[password]}")

# update id
new_id=$(($($cat database/accounts/.id) + 1))
echo -e "$new_id" > database/accounts/.id
# create account
echo -e "$new_id:${data[userName]}:$gjp" > "database/accounts/${data[userName],,}" #:${data[email]}

echo -e "1"