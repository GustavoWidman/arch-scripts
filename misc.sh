#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# add user to the uucp group for serial port access
usermod -aG uucp $(logname)

# add NO_POINTER_VIEWPORT=1 to /etc/environment to fix cursor size in some apps, use sed to make sure it's not already there or replace it if the value is anything except 1
if ! grep -q "NO_POINTER_VIEWPORT=1" /etc/environment; then
    echo "NO_POINTER_VIEWPORT=1" >> /etc/environment
else
    sed -i 's/NO_POINTER_VIEWPORT=.*/NO_POINTER_VIEWPORT=1/' /etc/environment
fi
