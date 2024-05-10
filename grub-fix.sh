#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
	echo "This script musn't be run as root. Please run as your normal user."
	exit 1
fi

# Enable os-prober and ntfs-3g
sudo pacman -S --noconfirm os-prober ntfs-3g
sudo sed -i 's/^#GRUB_DISABLE_OS_PROBER=false$/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub

# Fix grub size by adding GRUB_GFXMODE=1280x720 and GRUB_TERMINAL=gfxterm to /etc/default/grub
sudo sed -i '/^GRUB_GFXMODE=.*$/d' /etc/default/grub
sudo sh -c 'echo "GRUB_GFXMODE=1280x720" >> /etc/default/grub'

sudo sed -i '/^GRUB_TERMINAL=.*$/d' /etc/default/grub
sudo sh -c 'echo "GRUB_TERMINAL=gfxterm" >> /etc/default/grub'

# Set GRUB_TIMEOUT to 10 by replacing the line where GRUB_TIMEOUT=.* with GRUB_TIMEOUT=10
sudo sed -i '/^GRUB_TIMEOUT=.*$/d' /etc/default/grub
sudo sh -c 'echo "GRUB_TIMEOUT=10" >> /etc/default/grub'

# Prompt for extra menu entries
while true; do
	while true; do
		# get current existing entries from /etc/grub.d/40_custom
		EXISTING_ENTRIES=($(grep "menuentry" /etc/grub.d/40_custom | cut -d\" -f 2))
		EXISTING_ENTRY_PATHS=($(grep "chainloader" /etc/grub.d/40_custom | awk '{ print $2 }'))

		IFS=$'\n'

		# Print the existing entries (ENTRY: PATH)
		echo "Existing entries:"
		for i in "${!EXISTING_ENTRIES[@]}"; do
			echo "${EXISTING_ENTRIES[$i]}: ${EXISTING_ENTRY_PATHS[$i]}"
		done

		# Check if the input is valid
		if [[ $REPLY =~ ^[yYnN]$ ]]; then
			break
		else
			echo "Invalid input. Please enter \"y\" or \"n\"."
		fi
	done

	# If the user wants to add additional menu entries
	if [[ $REPLY =~ ^[yY]$ ]]; then
		# Prompt for the menu entry title
		read -p "Enter the title of the menu entry: " MENU_TITLE

		# Prompt for the menu entry command
		read -p "Enter the directory of the chainloader: " MENU_PATH

		# Add the menu entry to /etc/grub.d/40_custom
		echo "" | sudo tee -a /etc/grub.d/40_custom
		echo "menuentry \"$MENU_TITLE\" {" | sudo tee -a /etc/grub.d/40_custom
		echo "    insmod part_gpt" | sudo tee -a /etc/grub.d/40_custom
		echo "    insmod chain" | sudo tee -a /etc/grub.d/40_custom
		echo "" | sudo tee -a /etc/grub.d/40_custom
		echo "    set root=(hd0,gpt1)" | sudo tee -a /etc/grub.d/40_custom
		echo "    chainloader $MENU_PATH" | sudo tee -a /etc/grub.d/40_custom
		echo "}" | sudo tee -a /etc/grub.d/40_custom
	else
		break
	fi
done

# rebuild grub config
sudo grub-mkconfig -o /boot/grub/grub.cfg
# clean up the grub config by any echo commands
sudo sed -i 's/echo/#echo/g' /boot/grub/grub.cfg