#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO_URL:-https://github.com/lanre647/my_dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
declare -a INSTALL_ARGS=()

usage() {
    cat <<'EOF'
Usage: bootstrap.sh [--repo URL] [--dir DIR] [install options...]

Clone/update this repository and run install.sh. By default, missing base
packages are installed without prompting. Pass --no-packages to skip that.
Other options (for example --dry-run or --package niri) are passed to install.sh.
EOF
}

while (($#)); do
    case "$1" in
        --repo)
            (($# >= 2)) || { echo "bootstrap.sh: --repo requires a URL" >&2; exit 2; }
            REPO_URL="$2"
            shift 2
            ;;
        --dir)
            (($# >= 2)) || { echo "bootstrap.sh: --dir requires a path" >&2; exit 2; }
            DOTFILES_DIR="$2"
            shift 2
            ;;
        -h|--help) usage; exit 0 ;;
        *) INSTALL_ARGS+=("$1"); shift ;;
    esac
done

if [[ ! -d "$DOTFILES_DIR/.git" ]]; then
    if [[ -e "$DOTFILES_DIR" ]]; then
        printf 'bootstrap.sh: %s exists but is not a Git checkout\n' "$DOTFILES_DIR" >&2
        exit 1
    fi
    echo "Cloning dotfiles into $DOTFILES_DIR..."
    git clone --recurse-submodules "$REPO_URL" "$DOTFILES_DIR"
else
    echo "Updating dotfiles in $DOTFILES_DIR..."
    git -C "$DOTFILES_DIR" pull --ff-only
    git -C "$DOTFILES_DIR" submodule update --init --recursive
fi

exec "$DOTFILES_DIR/install.sh" --yes "${INSTALL_ARGS[@]}"
