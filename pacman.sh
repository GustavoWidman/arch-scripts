#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi


# Use sed to uncomment the "ParallelDownloads" line
sed -i 's/^#ParallelDownloads\s*=\s*5/ParallelDownloads = 5/' /etc/pacman.conf

# Use sed to uncomment the "Color" line
sed -i 's/^#Color$/Color/' /etc/pacman.conf

echo "Parallel downloads and colored output enabled in pacman.conf."
echo "Ready to speed up your downloads!"