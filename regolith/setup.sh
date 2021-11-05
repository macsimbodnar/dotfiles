#!/bin/bash -e

# Backup
sudo cp -r /etc/regolith /etc/regolith.backup

# Set the theme
sudo cp -r etc/regolith/styles/maxtron /etc/regolith/styles/
regolith-look set maxtron

# Install bar deps
sudo apt-get install -y -qq i3xrocks-rofication i3xrocks-cpu-usage i3xrocks-memory i3xrocks-disk-capacity i3xrocks-battery i3xrocks-time 1> /dev/null
# i3xrocks-todo

# Remove the unused one
sudo apt-get autoremove -y -qq i3xrocks-next-workspace i3xrocks-net-traffic 1> /dev/null

# Set the bar order
pushd /etc/regolith/i3xrocks/conf.d

# Remove the unwanted
rm -f *_next-workspace *_net-traffic

# sudo mv *_setup 01_setup
sudo mv -n *_rofication 40_rofication
sudo mv -n *_cpu-usage 50_cpu-usage
sudo mv -n *_memory 60_memory
sudo mv -n *_disk-capacity 70_disk-capacity
sudo mv -n *_battery 80_battery
# sudo mv -n *_todo 85_todo
sudo mv -n *_time 90_time
popd
