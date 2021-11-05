#!/bin/bash -e

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
        "INF") COLOR="${BOLD}\e[1;36m"
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

backup() {
    FILE=$1
    cp $FILE $FILE.backup
}




###############################################################################
if [[ $(id -u) -eq 0 ]]; then
  msg ERR "Don't execute this script as root"
  exit
fi




###############################################################################
TO_INSTALL="build-essential clang-13 vim ninja-build clang-format git tig fish regolith-desktop-mobile firefox python3-pip"
ME=$USER




###############################################################################
msg INF "Updating the system"
sudo apt-get -qq update 1> /dev/null
sudo apt-get -qq upgrade 1> /dev/null




###############################################################################
msg INF "Configuring additional repositories"
sudo add-apt-repository -y ppa:regolith-linux/release 1> /dev/null




###############################################################################
msg INF "Installing programs"
sudo apt-get install -qq -y $TO_INSTALL 1> /dev/null

msg INF "Replacing snap garbage"
sudo snap remove firefox 1> /dev/null




###############################################################################
msg INF "Configuring git and ws dir"

git config --global init.defaultBranch master
git config --global user.email "macsimbodnar@gmail.com"
git config --global user.name "Max"

mkdir ~/ws
pushd ~/ws 1> /dev/null

# Pull on HTTPS because we don't have ssh key yet
git clone --quiet https://github.com/macsimbodnar/dotfiles.git 1> /dev/null

# Set the remote url to ssh from https
pushd ~/ws/dotfiles 1> /dev/null
git remote set-url origin git@github.com:macsimbodnar/dotfiles.git
popd 1> /dev/null

popd 1> /dev/null




###############################################################################
msg INF "Configuring fish"

sudo usermod -s /usr/bin/fish $ME 1> /dev/null

pushd ~/ws/dotfiles/fish 1> /dev/null
chmod +x setup.sh 1> /dev/null
./setup.sh 1> /dev/null
popd 1> /dev/null




###############################################################################
msg INF "Configuring regolith"

pushd ~/ws/dotfiles/regolith 1> /dev/null
chmod +x setup.sh 1> /dev/null
./setup.sh 1> /dev/null
popd 1> /dev/null






