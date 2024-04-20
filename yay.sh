#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

yes | pacman -Sy --needed git base-devel

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si --noconfirm

cd ..

rm -rf yay

echo "Yay installed successfully!"