#!/bin/sh -e

FISH_CONF_DIR=$(realpath ~/.config/fish)

# Backup the dir
cp -r $FISH_CONF_DIR $FISH_CONF_DIR.backup

# Cleanup the files
rm -rf $FISH_CONF_DIR/config.fish $FISH_CONF_DIR/fish_variables $FISH_CONF_DIR/functions

ln -s $(pwd)/functions $FISH_CONF_DIR/functions
ln -s $(pwd)/config.fish $FISH_CONF_DIR/config.fish
ln -s $(pwd)/fish_variables $FISH_CONF_DIR/fish_variables
