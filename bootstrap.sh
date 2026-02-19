et -euo pipefail

REPO_URL="https://github.com/lanre647/my_dotfiles.git"
DOTFILES_DIR="${HOME}/.dotfiles"

echo "🚀 Bootstrapping dotfiles..."

if [[ ! -d "$DOTFILES_DIR"  ]]; then
    git clone "$REPO_URL" "$DOTFILES_DIR"
  else
      echo "Repo already exists, pulling latest..."
        git -C "$DOTFILES_DIR" pull --ff-only
fi

cd "$DOTFILES_DIR"
./install.sh --yes
