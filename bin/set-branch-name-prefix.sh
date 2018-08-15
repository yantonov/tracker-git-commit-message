#!/bin/sh

PREFIX="$1"

if [ $# -ne 1 ]; then
    echo "Usage: $0 <branch_name_prefix>"
    exit 0
fi

KEY="tracker.branchprefix"

if [ -z "$PREFIX" ]; then
    git config --unset $KEY
else
    git config $KEY $1
fi
