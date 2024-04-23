#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# Check if yay is installed
if yay --version &> /dev/null; then
    echo "Yay is already installed. Skipping..."
    exit 0
fi

sudo pacman -Syu --noconfirm --needed git base-devel

git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si --noconfirm

cd ..

rm -rf yay

echo "Yay installed successfully!"