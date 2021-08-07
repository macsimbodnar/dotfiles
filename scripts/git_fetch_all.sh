#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "ERROR: Provide a dir"
    echo "./git_fetch_all.sh /dir /path_to_key"
    exit 1
fi

MY_DIR=$1
PATH_TO_SSH_KEY=$2

eval `ssh-agent`
ssh-add $PATH_TO_SSH_KEY

find $MY_DIR -name .git -type d -prune | while read d; do
    cd $d/..
    echo "Fetching repo: $PWD"
    #    echo "$PWD >" git pull
    git fetch origin
    cd $OLDPWD
done
