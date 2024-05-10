#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# install flatpak and some fonts
sudo pacman -Sy --noconfirm flatpak ttf-fira-code noto-fonts-emoji noto-fonts-cjk ttf-firacode-nerd

# install com.raggesilver.BlackBox (flatpak) with no confirm
# flatpak install flathub com.raggesilver.BlackBox -y

# install ptyxis
flatpak install --from https://nightly.gnome.org/repo/appstream/org.gnome.Ptyxis.Devel.flatpakref -y

# copy config from ./confs/blackbox-settings.ini to ~/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile (make a keyfile or overwrite the existing one and make directories recursively if needed)
# sudo mkdir -p /home/$(logname)/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings
# sudo cp ./confs/blackbox-settings.ini /home/$(logname)/.var/app/com.raggesilver.BlackBox/config/glib-2.0/settings/keyfile

# copy config from ./confs/ptyxis-settings.ini to ~/.var/app/org.gnome.Ptyxis/config/glib-2.0/settings/keyfile (make a keyfile or overwrite the existing one and make directories recursively if needed)
sudo mkdir -p /home/$(logname)/.var/app/org.gnome.Ptyxis/config/glib-2.0/settings
sudo cp ./confs/ptyxis-settings.ini /home/$(logname)/.var/app/org.gnome.Ptyxis/config/glib-2.0/settings/keyfile

# fix permissions since we copied files as root
# sudo chown -R $(logname) /home/$(logname)/.var/app/com.raggesilver.BlackBox
sudo chown -R $(logname) /home/$(logname)/.var/app/org.gnome.Ptyxis

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
# yes | yay -Sy nautilus-open-in-blackbox

# "Open in ptyxis" my custom package (clone from my repo and makepkg)
git clone https://github.com/GustavoWidman/nautilus-open-in-ptyxis.git
cd nautilus-open-in-ptyxis
yes | makepkg -si
cd ..
rm -rf nautilus-open-in-ptyxis

# restart nautilus
nautilus -q

# install gext
yes | yay -Sy gnome-extensions-cli
sudo pacman -Sy python-tqdm

# Install all gnome extensions i have
gext install 6385 3193 779 1460