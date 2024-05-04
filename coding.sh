#!/bin/bash

# Check if the script is run as root (sudo)
if [ "$(id -u)" == "0" ]; then
    echo "This script musn't be run as root. Please run as your normal user."
    exit 1
fi

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Rust (root)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo sh

# Bun
curl -fsSL https://bun.sh/install | bash

# Nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# Nvm (root)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | sudo bash

# Pyenv
curl https://pyenv.run | bash

# Uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Croc
curl https://getcroc.schollz.com | sudo bash