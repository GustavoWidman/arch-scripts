#!/bin/bash

# Check if the script is run as root (sudo)
# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# Install discord
sudo pacman -Syu --noconfirm discord

# Install Vencord
sudo killall /opt/discord/Discord
curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh > install-vencord.sh
chmod +x install-vencord.sh
yes | ./install-vencord.sh
rm install-vencord.sh