#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME"
DRY_RUN=0
ASSUME_YES=0
SKIP_PACKAGES=0
PACKAGE_SELECTION=0
declare -a REQUESTED_PACKAGES=()
declare -a AVAILABLE_PACKAGES=(
    bin clipmenu dunst fastfetch fuzzel git kitty lazygit mako niri nvim
    picom scripts starship swaylock tmux vim waybar x11 zsh
)
declare -a SELECTED_PACKAGES=()

usage() {
    cat <<'EOF'
Usage: ./install.sh [options]

Stow all available configuration packages by default. Existing conflicting
files are left untouched; GNU Stow reports conflicts instead of overwriting.

Options:
  -n, --dry-run          Show the Stow plan without changing files
  -y, --yes              Install missing base tools without prompting
      --no-packages      Do not install base tools (Stow must already exist)
  -p, --package NAME     Stow only NAME (may be used more than once)
      --list             List available packages and exit
  -t, --target DIR       Stow into DIR instead of HOME
  -h, --help             Show this help

Base tools: GNU Stow, Git, tmux, zsh, and Vim. Configuration-specific
applications are not installed automatically.
EOF
}

error() {
    printf 'install.sh: %s\n' "$*" >&2
    exit 1
}

parse_args() {
    while (($#)); do
        case "$1" in
            -n|--dry-run) DRY_RUN=1 ;;
            -y|--yes) ASSUME_YES=1 ;;
            --no-packages) SKIP_PACKAGES=1 ;;
            -p|--package)
                (($# >= 2)) || error "missing name after $1"
                REQUESTED_PACKAGES+=("$2")
                PACKAGE_SELECTION=1
                shift
                ;;
            --list)
                printf '%s\n' "${AVAILABLE_PACKAGES[@]}"
                exit 0
                ;;
            -t|--target)
                (($# >= 2)) || error "missing directory after $1"
                TARGET="$2"
                shift
                ;;
            -h|--help) usage; exit 0 ;;
            *) error "unknown option: $1 (try --help)" ;;
        esac
        shift
    done
}

missing_base_tools() {
    local command
    for command in stow git tmux zsh vim; do
        command -v "$command" >/dev/null 2>&1 || printf '%s ' "$command"
    done
}

run_as_root() {
    if (( EUID == 0 )); then
        "$@"
    elif command -v sudo >/dev/null 2>&1; then
        sudo "$@"
    else
        error "installing system packages requires root or sudo"
    fi
}

install_base_tools() {
    local manager
    if [[ -n ${PREFIX:-} ]] && command -v pkg >/dev/null 2>&1; then
        manager=termux
    elif command -v apt-get >/dev/null 2>&1; then
        manager=apt
    elif command -v pacman >/dev/null 2>&1; then
        manager=pacman
    elif command -v dnf >/dev/null 2>&1; then
        manager=dnf
    elif command -v brew >/dev/null 2>&1; then
        manager=brew
    else
        error "unsupported package manager; install GNU Stow, Git, tmux, zsh, and Vim manually"
    fi

    printf 'Installing base tools with %s...\n' "$manager"
    case "$manager" in
        apt)
            run_as_root apt-get update
            run_as_root apt-get install -y stow git tmux zsh vim
            ;;
        pacman) run_as_root pacman -S --needed --noconfirm stow git tmux zsh vim ;;
        dnf) run_as_root dnf install -y stow git tmux zsh vim-enhanced ;;
        brew) brew install stow git tmux zsh vim ;;
        termux) pkg install -y stow git tmux zsh vim ;;
    esac
}

choose_packages() {
    local package candidate available duplicate
    if (( PACKAGE_SELECTION )); then
        for package in "${REQUESTED_PACKAGES[@]}"; do
            available=0
            for candidate in "${AVAILABLE_PACKAGES[@]}"; do
                [[ "$package" == "$candidate" ]] && available=1
            done
            (( available )) || error "unknown package '$package' (use --list)"
            [[ -d "$SCRIPT_DIR/$package" ]] || error "package directory not found: $package"
            duplicate=0
            for candidate in "${SELECTED_PACKAGES[@]}"; do
                [[ "$candidate" == "$package" ]] && duplicate=1
            done
            (( duplicate )) || SELECTED_PACKAGES+=("$package")
        done
    else
        for package in "${AVAILABLE_PACKAGES[@]}"; do
            [[ -d "$SCRIPT_DIR/$package" ]] && SELECTED_PACKAGES+=("$package")
        done
    fi
    ((${#SELECTED_PACKAGES[@]})) || error "no Stow packages selected"
}

main() {
    local missing
    declare -a HOME_TARGET_PACKAGES=() BIN_TARGET_PACKAGES=()
    local package

    parse_args "$@"

    if [[ "$TARGET" != /* ]]; then
        TARGET="$PWD/$TARGET"
    fi

    choose_packages

    missing="$(missing_base_tools)"
    if [[ -n "$missing" ]]; then
        if (( DRY_RUN || SKIP_PACKAGES )); then
            [[ "$missing" == *stow* ]] && error "GNU Stow is required; missing: $missing"
            printf 'Skipping missing base tools: %s\n' "$missing"
        elif (( ASSUME_YES )); then
            install_base_tools
        elif [[ -t 0 ]]; then
            printf 'Missing base tools: %s\nInstall them now? [y/N] ' "$missing"
            read -r answer
            [[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]] || error "install cancelled; install dependencies or use --no-packages"
            install_base_tools
        else
            error "missing base tools: $missing; use --yes to install or --no-packages to skip"
        fi
    fi
    command -v stow >/dev/null 2>&1 || error "GNU Stow is not installed"

    for package in "${SELECTED_PACKAGES[@]}"; do
        if [[ "$package" == scripts ]]; then
            BIN_TARGET_PACKAGES+=("$package")
        else
            HOME_TARGET_PACKAGES+=("$package")
        fi
    done

    local -a stow_options=(--dir="$SCRIPT_DIR" --no-folding --restow --verbose)
    (( DRY_RUN )) && stow_options+=(--simulate)

    if (( ! DRY_RUN )); then
        mkdir -p "$TARGET"
        ((${#BIN_TARGET_PACKAGES[@]} == 0)) || mkdir -p "$TARGET/bin"
    fi

    if ((${#HOME_TARGET_PACKAGES[@]})); then
        printf 'Stowing into %s: %s\n' "$TARGET" "${HOME_TARGET_PACKAGES[*]}"
        stow "${stow_options[@]}" --target="$TARGET" "${HOME_TARGET_PACKAGES[@]}"
    fi
    if ((${#BIN_TARGET_PACKAGES[@]})); then
        printf 'Stowing scripts into %s/bin: %s\n' "$TARGET" "${BIN_TARGET_PACKAGES[*]}"
        stow "${stow_options[@]}" --target="$TARGET/bin" "${BIN_TARGET_PACKAGES[@]}"
    fi

    if (( DRY_RUN )); then
        printf 'Dry run complete; no links were changed.\n'
    else
        printf 'Dotfiles linked. Conflicts, if any, were not overwritten.\n'
    fi
}

main "$@"

