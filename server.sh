#!/bin/bash
# server.sh: The server. duh

# port, should make a -p flag somehow
PORT=8080

source config.sh

# make directories
mkdir -p database/accounts
mkdir -p database/profiles
mkdir -p database/levels
mkdir -p endpoints
mkdir -p tmp
mkdir -p levels
mkdir -p saves

# initialize database if not already
if [[ ! -f database/accounts/.id ]]; then
    echo -e "0" > database/accounts/.id
fi

# file in, file out. horrid
FIFO="tmp/nc_fifo"
rm -f $FIFO
mkfifo $FIFO

printf "${CC}GDPS listening on port $PORT${C0}\n"

# not parallelized but whatever
while true; do
    nc -l -p $PORT < $FIFO | ./handler.sh > $FIFO
done
