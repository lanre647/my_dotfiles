# 📦 Dotfiles

[![CI](https://img.shields.io/github/actions/workflow/status/lanre647/my_dotfiles/dotfiles.yml?label=CI&logo=github)](#)
[![Shell](https://img.shields.io/badge/shell-zsh-blue)](#)
[![Manager](https://img.shields.io/badge/managed%20with-stow-green)](#)
[![Platform](https://img.shields.io/badge/platform-linux%20%7C%20macOS-informational)](#)
[![License](https://img.shields.io/badge/license-MIT-lightgrey)](#)

Personal configuration “babies,” managed with **:contentReference[oaicite:0]{index=0}** for fast, reproducible environments.

---

## 🚀 Quick Start (Recommended)

One-liner bootstrap:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lanre647/my_dotfiles/main/bootstrap.sh)
```

This will:

* clone the repo
* install required packages
* stow configs
* bootstrap tmux plugins
* optionally set zsh as default shell

---

## 🧰 Manual Install

```bash
git clone https://github.com/lanre647/my_dotfiles.git dotfiles
cd dotfiles
./install.sh
```

### Non-interactive mode

```bash
./install.sh --yes
```

### Dry run

```bash
./install.sh --dry-run
```

---

## 🛠 Included Configs

* **Zsh** — prompt, aliases, QoL tweaks
* **Vim / Neovim** — editing environment
* **git** — config settings
* **Tmux** — multiplexer config + plugins
* **Scripts** — personal tools in `~/bin`

---

## 🏗 Repository Layout

Mirror structure for Stow:

```
zsh/     → ~/.zshrc
config/  → ~/.config/
git/     → ~/.git.config
scripts/ → ~/bin/
tmux/    → ~/.tmux.conf and ~/.tmux/
```

---

## ⚠️ Requirements

The install script will automatically install:

* **GNU Stow**
* **Git**
* **Tmux**
* **Zsh**
* **Vim**

Supported platforms:

* Ubuntu / Debian
* Arch Linux
* Fedora / RHEL
* macOS (with **Homebrew**)
* Termux

---

## 🔌 Tmux Plugins

Plugins are managed with **Tmux Plugin Manager (TPM)**.

✅ TPM auto-installs on first run
✅ Plugins auto-installed
✅ No manual prefix dance required

---

## 🧪 CI

This repo includes GitHub Actions to verify Stow integrity and catch broken symlinks early.

---

## 🔄 Philosophy

* minimal but powerful
* reproducible setups
* safe to re-run
* automation first
* zero manual steps on fresh machines

---

## 📜 License

MIT — use it, fork it, improve it.

