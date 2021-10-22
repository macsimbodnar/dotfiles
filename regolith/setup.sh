#!/bin/bash -e

# Backup
sudo cp -r /etc/regolith /etc/regolith.backup

# Set the theme
sudo cp -r etc/regolith/styles/maxtron /etc/regolith/styles/
regolith-look set maxtron

# Install bar deps
sudo apt-get install -y i3xrocks-rofication i3xrocks-cpu-usage i3xrocks-memory i3xrocks-disk-capacity i3xrocks-battery i3xrocks-todo i3xrocks-time

# Set the bar order
pushd /etc/regolith/i3xrocks/conf.d
sudo mv *_setup 01_setup
sudo mv *_rofication 40_rofication
sudo mv *_cpu-usage 50_cpu-usage
sudo mv *_memory 60_memory
sudo mv *_disk-capacity 70_disk-capacity
sudo mv *_battery 80_battery
sudo mv *_todo 85_todo
sudo mv *_time 90_time
popd
