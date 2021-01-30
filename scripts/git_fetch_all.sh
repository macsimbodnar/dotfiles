#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "ERROR: Provide a dir"
    exit 1
fi

MY_DIR=$1

find $MY_DIR -name .git -type d -prune | while read d; do
    cd $d/..
    echo "Fetching repo: $PWD"
    #    echo "$PWD >" git pull
    git fetch origin
    cd $OLDPWD
done
