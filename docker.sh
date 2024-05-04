#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# install docker and docker-compose
pacman -Sy --noconfirm docker docker-compose

# enable and start docker socket (we enable socket and not service because service will start docker on boot, but we want to start docker on demand)
systemctl enable docker.socket --now

# add user to docker group
usermod -aG docker $(logname)