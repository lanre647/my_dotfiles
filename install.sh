#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Detecting platform..."

install_packages() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update -y
            PM="sudo apt-get install -y"
        else
            echo "Unsupported Linux distro. Install packages manually."
            exit 1
        fi

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v brew >/dev/null 2>&1; then
            echo "❌ Homebrew not found."
            echo "👉 Install from: https://brew.sh"
            exit 1
        fi
        PM="brew install"

    elif [[ "$OSTYPE" == "linux-android"* ]]; then
        pkg update -y
        PM="pkg install -y"

    else
        echo "Unknown OS. Please install packages manually."
        exit 1
    fi

    echo "📦 Checking required packages..."
    APPS=(stow git tmux vim zsh)

    for app in "${APPS[@]}"; do
        if ! command -v "$app" >/dev/null 2>&1; then
            echo "Installing $app..."
            $PM "$app"
        else
            echo "$app already installed"
        fi
    done
}

backup_if_exists() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        echo "📦 Backing up $file -> $file.bak"
        mv "$file" "$file.bak"
    fi
}

main() {
    cd "$(dirname "$0")"

    install_packages

    echo "🧹 Preparing dotfiles..."

    backup_if_exists ~/.zshrc
    backup_if_exists ~/.bashrc
    backup_if_exists ~/.tmux.conf
    backup_if_exists ~/.vimrc

    echo "🔗 Stowing configs..."
    stow -v -R git tmux vim zsh starship 

    echo "✨ Everything is linked and ready!"
}

main "$@"
