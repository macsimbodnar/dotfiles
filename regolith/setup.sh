#!/bin/bash -e

# Backup
sudo cp -r /etc/regolith /etc/regolith.backup

# Set the theme
sudo cp -r etc/regolith/styles/maxtron /etc/regolith/styles/
regolith-look set maxtron
regolith-look refresh
