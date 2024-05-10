#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi


# Install snapd
yes | yay -Sy snapd

# Turn on and enable snapd and snapd.apparmor services
sudo systemctl enable snapd --now
sudo systemctl enable snapd.apparmor --now

# Fix snap
sudo ln -s /var/lib/snapd/snap /snap

# Install insiders
snap install code-insiders --classic
echo "Visual Studio Code Insiders installed successfully!"

# DataGrip
snap install datagrip --classic
echo "DataGrip installed successfully!"

# Postman
yes | yay -Sy postman-bin
echo "Postman installed successfully!"
