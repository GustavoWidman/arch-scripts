#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# Install plymouth
yes | yay -S plymouth-git

# use sed to add the "plymouth" hook right after the "udev" hook (but before all else) in /etc/mkinitcpio.conf by replacing the "udev" in the line where there is ^HOOKS=\(.* udev .*) with "udev plymouth"
sudo sed -i '/^HOOKS=\(.* udev .*\)/ s/udev/udev plymouth/' /etc/mkinitcpio.conf
# add i915 to the MODULES=(.*) line in /etc/mkinitcpio.conf
sudo sed -i '/^MODULES=()/ s/)/i915)/' /etc/mkinitcpio.conf

# now use sed again to add the "quiet splash" kernel parameters to the end of the line where there is ^GRUB_CMDLINE_LINUX_DEFAULT=.*$ (but dont forget that there is a closing quote at the end of the line)
# first remove quiet splash if it is already there
sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/ s/ quiet splash"/"/' /etc/default/grub
# then add it
sudo sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=.*$/ s/"$/ quiet splash"/' /etc/default/grub

# download monarch theme
sudo git clone https://github.com/farsil/monoarch.git /usr/share/plymouth/themes/monoarch
sudo plymouth-set-default-theme -R monoarch

# add ShowDelay of 0
sudo sed -i '/^ShowDelay=.*$/d' /etc/plymouth/plymouthd.conf
sudo sh -c 'echo "ShowDelay=0" >> /etc/plymouth/plymouthd.conf'

# set the DeviceScale
sudo pacman -S xorg-xrandr --noconfirm
SCREEN_RES=$(xrandr | grep 'primary' | sed "s/\+.*//" | awk '{ print $4 }' | sed "s/.*x//")
DEVICE_SCALE=$((($SCREEN_RES / 1080) + ($SCREEN_RES % 1080 > 0)))
sudo sed -i '/^DeviceScale=.*$/d' /etc/plymouth/plymouthd.conf
sudo sh -c 'echo "DeviceScale='$DEVICE_SCALE'" >> /etc/plymouth/plymouthd.conf'

# run mkinitcpio to apply all changes
sudo mkinitcpio -p linux

# rebuild grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg
# clean up the grub config by any echo commands
sudo sed -i 's/echo/#echo/g' /boot/grub/grub.cfg