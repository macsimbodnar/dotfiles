#!/bin/bash

# Give colorful messages
msg() {
    # $1 is type <INF|ERR|SUC|WAR>
    # $2 is message to print
    
    # Black        0;30     Dark Gray     1;30
    # Red          0;31     Light Red     1;31
    # Green        0;32     Light Green   1;32
    # Brown/Orange 0;33     Yellow        1;33
    # Blue         0;34     Light Blue    1;34
    # Purple       0;35     Light Purple  1;35
    # Cyan         0;36     Light Cyan    1;36
    # Light Gray   0;37     White         1;37
    TYPE=$1
    local mesg=$2; shift
    
    ALL_OFF="\e[1;0m"
    BOLD="\e[1;1m"
    
    case "$TYPE" in
        "INF") COLOR="${BOLD}\e[1;37m"
        ;;
        "ERR") COLOR="${BOLD}\e[1;31m"
        ;;
        "SUC") COLOR="${BOLD}\e[1;32m"
        ;;
        "WAR") COLOR="${BOLD}\e[1;33m"
        ;;
    esac
    
    printf "==>${COLOR} ${mesg}${ALL_OFF}\n" "$@" >&2
}

msg "INF" "Start configuration of VSCode"

HOME=$(realpath ~)
VSCODECONF=".config/Code"
VSUSER="User"

FULLPATH="$HOME/$VSCODECONF/$VSUSER"

PATH_FOUND=0
while [ "$PATH_FOUND" != 1 ]
do
    msg INF "Checking...  $FULLPATH"
    if [ -d "$FULLPATH" ]; then
        # Take action if $DIR exists. #
        msg SUC "Found!"
        PATH_FOUND=1
    else
        msg WAR "Directory $FULLPATH not found!"
        msg INF "Please insert VSCode config user directory..."
        read FULLPATH
    fi
done

msg INF "Configuring..."

# CHECK FILES
declare -a arr=("c_cpp_properties.json" "extensions.json" "keybindings.json" "launch.json" "settings.json" "tasks.json")

for i in "${arr[@]}"
do
    msg INF "Processing $i"
    tmp="$FULLPATH/$i"
    [ -f "$tmp" ] && mv "$tmp" "$tmp.backup"
    ln -s "$(pwd)/$i" "$tmp"
done

msg SUC "Done!"
