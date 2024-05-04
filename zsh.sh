#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# Install zsh, bat and fzf
pacman -Syu --noconfirm zsh bat fzf

# Install oh-my-zsh (root)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Install oh-my-zsh (user running the command)
su -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended' $(logname)

# Install zsh-autosuggestions (root)
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# Install zsh-autosuggestions (user running the command)
su -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions' $(logname)

# Install custom theme
curl -Lo /home/$(logname)/.oh-my-zsh/custom/themes/r3dlust.zsh-theme https://links.r3dlust.com/zsh-theme
curl -Lo /root/.oh-my-zsh/custom/themes/r3dlust.zsh-theme https://links.r3dlust.com/zsh-theme

chown $(logname) /home/$(logname)/.oh-my-zsh/custom/themes/r3dlust.zsh-theme

# Install custom zshrc
curl -Lo /home/$(logname)/.zshrc https://links.r3dlust.com/zshrc
curl -Lo /root/.zshrc https://links.r3dlust.com/zshrc

# Change root and user shell
chsh -s /usr/bin/zsh $(logname)
chsh -s /usr/bin/zsh root

# Custom nanorc
curl -Lo /etc/nanorc https://links.r3dlust.com/nanorc
# Make opening nano as root have red titlebar
echo "set titlecolor lightwhite,red" >> /root/.nanorc

# source /home/$(logname)/.zshrc

echo "Zsh installed successfully!"
