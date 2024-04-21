#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please use sudo."
	echo "Tip: sudo !!"
    exit 1
fi

# Rust
su -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh' $(logname)
# Rust (root)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Bun
su -c 'curl -fsSL https://bun.sh/install | bash' $(logname)

# Nvm
su -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash' $(logname)
# Nvm (root)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Pyenv
su -c 'curl https://pyenv.run | bash' $(logname)

# Uv
su -c 'curl -LsSf https://astral.sh/uv/install.sh | sh' $(logname)

# Croc
curl https://getcroc.schollz.com | bash