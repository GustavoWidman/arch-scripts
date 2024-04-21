#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# install gnome-extensions-cli
su -c 'yes | yay -Sy gnome-extensions-cli' $(logname)

# Install all gnome extensions i have
su -c 'gnome-shell-extension-installer 6385 3193 779 1460 --yes' $(logname)

# install flatpak and fira code
yes | pacman -Sy flatpak ttf-fira-code

# install com.raggesilver.BlackBox (flatpak) with no confirm
flatpak install flathub com.raggesilver.BlackBox -y

# copy config from ./confs/blackbox-settings.ini to ~/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile (make a keyfile or overwrite the existing one and make directories recursively if needed)
mkdir -p /home/$(logname)/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings
cp ./confs/blackbox-settings.ini /home/$(logname)/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile

# load gnome keybindings
dconf load /org/gnome/desktop/wm/keybindings/ < ./confs/gnome-keybindings.ini
dconf load /org/gnome/settings-daemon/ < ./confs/gnome-settings-daemon.ini

# set wallpaper and stuff
dconf load /org/gnome/desktop/background/ < ./confs/gnome-desktop-background.ini
dconf load /org/gnome/desktop/interface/ < ./confs/gnome-desktop-interface.ini

# privacy settings
dconf load /org/gnome/desktop/privacy/ < ./confs/gnome-desktop-privacy.ini

# misc settings
dconf write /org/gnome/desktop/peripherals/mouse/accel-profile "'flat'"
dconf write /org/gnome/mutter/workspaces-only-on-primary false
dconf write /org/gnome/desktop/datetime/automatic-timezone true

# load shell config
dconf load /org/gnome/shell/ < ./confs/gnome-shell.ini

# "Open in blackbox" nautilus package
su -c 'yes | yay -Sy nautilus-open-in-blackbox' $(logname)
su -c 'nautilus -q' $(logname)