#!/bin/bash

# 1. Detect OS and install missing packages
install_packages() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu/Debian/Linux Mint
        PM="sudo apt install -y"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        PM="brew install"
    elif [[ "$OSTYPE" == "linux-android"* ]]; then
        # Termux (Android)
        PM="pkg install"
    else
        echo "Unknown OS. Please install packages manually."
        return
    fi

    echo "📦 Checking for missing babies (packages)..."
    # List the actual software packages here
    APPS=(stow git tmux vim zsh)
    
    for app in "${APPS[@]}"; do
        if ! command -v "$app" &> /dev/null; then
            echo "Installing $app..."
            $PM "$app"
        fi
    done
}

# 2. Run the logic
cd "$(dirname "$0")"
install_packages

echo "🧹 Cleaning and Stowing..."
rm -f ~/.zshrc ~/.bashrc ~/.tmux.conf ~/.vimrc

# Stow everything in the current directory
stow -v -R git tmux vim zsh config scripts

echo "✨ Everything is linked and software is installed!"

