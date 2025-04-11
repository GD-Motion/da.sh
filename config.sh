#!/bin/bash
# config.sh: Holds all configuration

# debug printing
_DEBUG=1

# colors, robtop like (just for >&2 printing)
CR="\e[31m" # red
CG="\e[32m" # green
CY="\e[33m" # yellow
CB="\e[34m" # blue
CM="\e[35m" # magenta
CC="\e[36m" # cyan
CW="\e[37m" # white
C0="\e[0m"  # reset (</c>)

# absolute path shorthands
cut=/usr/bin/cut
sed=/usr/bin/sed
b64=/usr/bin/base64
cat=/usr/bin/cat
openssl=/usr/bin/openssl