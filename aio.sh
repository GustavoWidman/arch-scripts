#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# Set permissions to all scripts
chmod +x *.sh

# Start by running the pacman fixes script
sudo ./pacman.sh
# Then run the yay.sh script (download yay and set it up)
./yay.sh

# Download programming languages, runtime environments and version managers
./coding.sh
# GNOME extensions and configurations
./gnome.sh
# ZSH, oh-my-zsh, custom theme and other terminal-related stuff
sudo ./zsh.sh

# Visual Studio Code Insiders and SnapD
./vscode.sh
# Discord and vencord
./discord.sh
# Miscellaneous configurations
sudo ./misc.sh

# docker install
sudo ./docker.sh

echo "All scripts have been run successfully!"
echo "It is suggested to reboot your system now."