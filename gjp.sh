#!/bin/bash
# gjp.sh: Password encoder
# Usage: gjp.sh <string>

STRING="$1"

source config.sh

password="${STRING}mI29fmAnxgTs" # salt
hashed_password=$(echo -n "$password" | $openssl dgst -sha1 -hex | $cut -d ' ' -f2) # heh, who needs xxd

echo "$hashed_password"
