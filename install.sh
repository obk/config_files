#!/bin/bash

# Install dependencies
echo "Installing dependencies..."
if command -v dnf >/dev/null; then
    sudo dnf update -y
    sudo dnf install -y git curl
else
    echo "Please install git and curl manually."
    exit 1
fi

# Install Oh My Posh if not installed
if ! command -v oh-my-posh >/dev/null; then
    echo "Installing Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash
fi

# Create backup of existing .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    echo "Backing up existing .bashrc to .bashrc.bak"
    cp "$HOME/.bashrc" "$HOME/.bashrc.bak"
fi

# Copy the .bashrc file
echo "Copying .bashrc to $HOME"
cp .bashrc "$HOME/.bashrc"

# Set up Oh My Posh theme
echo "Setting up Oh My Posh theme..."
mkdir -p "$HOME/.poshthemes"
cp obk.omp.json "$HOME/.poshthemes/obk.omp.json"

# Update Oh My Posh to use the new theme in .bashrc
if ! grep -q "oh-my-posh init bash --config ~/.poshthemes/obk.omp.json" "$HOME/.bashrc"; then
    echo 'eval "$(oh-my-posh init bash --config ~/.poshthemes/obk.omp.json)"' >> "$HOME/.bashrc"
fi

echo "Installation complete! Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
