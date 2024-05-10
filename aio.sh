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

# Download programming languages, runtime environments and version managers (Rust, Bun, Nvm, Pyenv, Uv, Croc, Tailscale)
./coding.sh
# GNOME extensions and configurations
./gnome.sh
# ZSH (pacman), oh-my-zsh (installer), custom theme and other terminal-related stuff
sudo ./zsh.sh

# Visual Studio Code Insiders (snap), also DataGrip (snap) and Postman (AUR)
./ides.sh
# Discord (pacman) and vencord (installer)
./discord.sh
# Miscellaneous configurations
sudo ./misc.sh

# docker install
sudo ./docker.sh

# clean up unused dependencies if there are any
sudo pacman -Rns $(pacman -Qtdq)

echo "All scripts have been run successfully!"
echo "It is suggested to reboot your system now."