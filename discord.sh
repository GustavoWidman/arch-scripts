#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# Install discord
yes | pacman -Sy discord

# Install Vencord
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"