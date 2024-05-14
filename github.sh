#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# prompt the user if he wants to make a new SSH key
while true; do
	read -p "Do you want to generate a new SSH key? (y/n): " -n 1 GENERATE_SSH_KEY
	echo

	# Check if the input is valid
	if [[ $GENERATE_SSH_KEY =~ ^[YyNn]$ ]]; then
		echo
		break
	else
		echo "Invalid input. Please enter 'y' or 'n'"
	fi
done

if [[ $GENERATE_SSH_KEY =~ ^[Yy]$ ]]; then
	SSH_PUB_KEY=$(RUNNING_NESTED="true" ./ssh-generate.sh 2>&1 >/dev/tty)
else
	# prompt to select the SSH key from the list
	echo "Select the SSH public key to use for GitHub:"
	select SSH_PUB_KEY in $(find ~/.ssh -type f -name "*.pub"); do
		if [ -z "$SSH_PUB_KEY" ]; then
			echo "Invalid selection. Please try again."
			continue
		fi

		echo "Selected public key: $SSH_PUB_KEY"
		break
	done
fi

read -p "Enter the GitHub username: " GITHUB_USERNAME

if [ -z "${GITHUB_USERNAME}" ]; then
	echo "GitHub username cannot be empty."
	exit 1
fi

git config --global user.name "$GITHUB_USERNAME"

read -p "Enter the GitHub email: " GITHUB_EMAIL

if [ -z "${GITHUB_EMAIL}" ]; then
	echo "GitHub email cannot be empty."
	exit 1
fi

git config --global user.email "$GITHUB_EMAIL"