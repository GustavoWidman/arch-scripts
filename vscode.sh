#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# Install snapd
su -c 'yes | yay -Sy snapd' $(logname)

# Turn on and enable snapd and snapd.apparmor services
systemctl enable snapd --now
systemctl enable snapd.apparmor --now

# Fix snap
ln -s /var/lib/snapd/snap /snap

# Install insiders
su -c 'snap install code-insiders --classic' $(logname)

echo "Visual Studio Code Insiders installed successfully!"