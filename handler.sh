#!/bin/bash
# handler.sh: Handles requests from netcat and passes them to the correct script

source config.sh

#read -r METHOD PATH PROTOCOL
read -r _ PATH _

CONTENT_LENGTH=0
while read -r HEADER && [[ $HEADER != $'\r' ]]; do
    [[ $HEADER == Content-Length:* ]] && CONTENT_LENGTH=${HEADER#Content-Length: }
    CONTENT_LENGTH=${CONTENT_LENGTH//[[:space:]]/}
done

BODY=""
if [[ "$CONTENT_LENGTH" -gt 0 ]]; then
    read -r -n "$CONTENT_LENGTH" BODY
fi

# really thought I could get away with shorthanding this, but nope, absolute paths it gotta be
SCRIPT=$(echo "$PATH" | $cut -d "?" -f1 | $sed 's|^/||; s|\.php$|.sh|; s|/|\/|g') # piece of shit sed pattern
echo -e "Request: ${CY}$PATH${CW}, Script: ${CY}$SCRIPT${C0}" >&2
[[ $_DEBUG -eq 1 ]] && echo -e "Request Body: ${CG}$BODY${C0}" >&2

if [[ -n "$SCRIPT" && -x "./endpoints/$SCRIPT" ]]; then
    ENCODED=$(echo -n "$BODY" | $b64)
    OUTPUT=$(./endpoints/"$SCRIPT" "$ENCODED")
    [[ $_DEBUG -eq 1 ]] && echo -e "Response: ${CM}$OUTPUT${C0}" >&2
else
    echo -e "${CY}$SCRIPT ${CR}not found or not executable in the endpoints folder${C0}" >&2
    OUTPUT="-1"
fi

LEN=${#OUTPUT}

# that's all needed for gd to realize "yep, that's a response"
echo -e "HTTP/1.1 200 OK\r"
echo -e "\r"
echo -n "$OUTPUT"
