#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi


# Install code insiders from AUR
yes | yay -S visual-studio-code-insiders-bin

echo "Visual Studio Code Insiders installed successfully!"

# DataGrip
flatpak install flathub com.jetbrains.DataGrip
echo "DataGrip installed successfully!"

# Postman
yes | yay -Sy postman-bin
echo "Postman installed successfully!"
