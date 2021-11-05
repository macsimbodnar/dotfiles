#!/bin/sh -e

FISH_RELATIVE_PATH=~/.config/fish

# Create a directory if not exists
mkdir -p $FISH_RELATIVE_PATH

FISH_CONF_DIR=$(realpath $FISH_RELATIVE_PATH)

# Backup the dir
cp -r $FISH_CONF_DIR $FISH_CONF_DIR.backup

# Cleanup the files
rm -rf $FISH_CONF_DIR/config.fish $FISH_CONF_DIR/fish_variables $FISH_CONF_DIR/functions

ln -s $(pwd)/functions $FISH_CONF_DIR/functions
ln -s $(pwd)/config.fish $FISH_CONF_DIR/config.fish
ln -s $(pwd)/fish_variables $FISH_CONF_DIR/fish_variables
