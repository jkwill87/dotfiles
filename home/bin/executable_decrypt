#!/bin/sh

# decrypt: decrypts a file using openssl
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# validate parameters
if [ -z "$1" ]; then
    echo 'extract: invalid parameters'
    echo 'usage: decrypt source_file [destination]'
    exit 1
elif [ ! -e "$1" ]; then
    echo 'extract: source file not found'
    echo 'usage: decrypt source_file [destination]'
    exit 1
fi

# determine source and destination paths
source=$(realpath "$1")
if [ -n "$2" ]; then
    dest="$2"
else
    dest="$(echo "$1" | sed "s/\\.encrypted$//").decrypted"
fi

# perform decryption
printf 'decrypt password > '
cmd="openssl enc -aes-256-cbc -pass stdin -in $source -out $dest -d"
if err=$($cmd 2>&1); then
    echo 'ok'
    exit 0
else
    echo "$err"
    exit 1
fi
