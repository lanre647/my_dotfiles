#!/usr/bin/env bash
set -euo pipefail

echo "🔍 Detecting platform..."

# ... [Keep your existing install_packages function here] ...

backup_if_exists() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        echo "📦 Backing up $file -> $file.bak"
        mv "$file" "$file.bak"
    fi
}

main() {
    # Ensure we are in the dotfiles directory
    cd "$(dirname "$0")"

    install_packages

    echo "🧹 Preparing environment..."

    # CRITICAL: Create .config as a real folder so Stow doesn't 
    # try to replace it with a symlink.
    mkdir -p ~/.config

    # Backup existing files to avoid stow conflicts
    backup_if_exists ~/.zshrc
    backup_if_exists ~/.bashrc
    backup_if_exists ~/.tmux.conf
    backup_if_exists ~/.vimrc
    backup_if_exists ~/.gitconfig

    echo "🔗 Stowing configs..."
    
    # Packages to link. Added 'nvim' so it works as soon as you create the folder.
    PACKAGES=(git tmux vim zsh starship nvim)

    for pkg in "${PACKAGES[@]}"; do
        if [ -d "$pkg" ]; then
            echo "Linking $pkg..."
            # -R: Restow (updates existing links)
            # --no-folding: Never replace a directory with a symlink
            stow -v -R --no-folding "$pkg"
        else
            echo "⚠️  Skipping $pkg: Folder not found."
        fi
    done

    echo "✨ Everything is linked and ready!"
}

main "$@"

