# ⚡ Vim Configuration — Fast, Minimal, Productive

![Vim](https://img.shields.io/badge/Vim-Config-green?logo=vim)
![Plugin Manager](https://img.shields.io/badge/Plugin%20Manager-vim--plug-blue)
![Status](https://img.shields.io/badge/Status-Actively%20Maintained-brightgreen)
![License](https://img.shields.io/badge/License-MIT-yellow)

A **modern, performance-focused Vim setup** designed for speed, clean UI, and strong JavaScript/TypeScript workflow.

Built for developers who want:

* ⚡ Fast startup
* 🎯 Minimal but powerful plugins
* 🧠 Smart defaults
* 🎨 Beautiful UI
* 🔍 Excellent search/navigation
* 🧩 Prettier + ALE formatting

---

## ✨ Features

### 🎨 UI & Appearance

* PaperColor theme (default)
* Airline status line with tabline
* Relative line numbers
* Cursorline highlight
* True color support
* Optional distraction-free mode

### 🔍 Navigation & Search

* FZF fuzzy finder
* Ripgrep integration
* Dirvish sidebar file explorer
* Fast buffer switching
* Smart window navigation

### 💻 Language Support

* JavaScript
* TypeScript
* HTML via Emmet
* Prettier auto-format on save
* ALE async linting

### 🔧 Git Integration

* GitGutter live diff signs
* Fugitive git commands
* Git blame shortcut

### 🧠 Productivity Boosters

* Auto pairs
* Surround editing
* Persistent undo
* Snippet support (UltiSnips)
* Smart yank highlighting
* Terminal integration

---

## 📦 Plugin Manager

This config uses **vim-plug** with automatic bootstrap.

If vim-plug is missing, it installs itself on first run.

---

## 🚀 Installation

```bash
git clone <your-repo-url> ~/.vim
```

Or copy your `.vimrc`:

```bash
cp .vimrc ~/.vimrc
```

Then open Vim and run:

```vim
:PlugInstall
```

---

## 🎯 Leader Key

```
Leader = <Space>
```

---

## ⌨️ Key Mappings

### 🔍 Search & Files

| Key         | Action          |
| ----------- | --------------- |
| `<leader>p` | FZF Files       |
| `<leader>s` | Ripgrep search  |
| `<C-n>`     | Dirvish sidebar |

### 🧭 Buffer Navigation

| Key         | Action          |
| ----------- | --------------- |
| `Shift+l`   | Next buffer     |
| `Shift+h`   | Previous buffer |
| `<leader>x` | Close buffer    |

### 🪟 Window Movement

| Key     | Action     |
| ------- | ---------- |
| `<C-h>` | Move left  |
| `<C-j>` | Move down  |
| `<C-k>` | Move up    |
| `<C-l>` | Move right |

### ⚡ Utilities

| Key               | Action          |
| ----------------- | --------------- |
| `<leader>w`       | Save file       |
| `<leader>u`       | Toggle UndoTree |
| `<leader>g`       | Git blame       |
| `<leader><space>` | Clear search    |

### 🖥️ Terminal

| Key              | Action             |
| ---------------- | ------------------ |
| `<leader>t`      | Open terminal      |
| `Esc` (terminal) | Exit terminal mode |

### 🎯 Distraction-Free Mode

| Key         | Action     |
| ----------- | ---------- |
| `<leader>z` | Minimal UI |
| `<leader>Z` | Restore UI |

---

## 🧹 Formatting (ALE + Prettier)

Auto-formats on save for:

* JavaScript
* TypeScript
* JSON
* HTML

Requires global prettier:

```bash
npm install -g prettier
```

---

## 📁 Persistent Undo

Undo history is saved to:

```
~/.vim/undodir
```

---

## 🧪 Performance Tweaks

This config is tuned for speed:

* lazyredraw enabled
* swapfile disabled
* optimized updatetime
* GitGutter manual refresh
* hidden buffers enabled

---

## 🔮 Recommended External Tools

For best experience install:

```bash
# search
sudo apt install ripgrep

# fuzzy finder (optional if not auto-built)
sudo apt install fzf

# live server (used by <leader>a)
npm install -g live-server
```

---

## 🛠️ Customization Tips

Want to tweak it?

* Change theme → edit `colorscheme`
* Change leader → edit `mapleader`
* Add plugins → inside `plug#begin`
* Adjust tabs → modify `shiftwidth`, `tabstop`

---

## 📜 License

MIT — use it, fork it, improve it.

---

## 🤝 Contributing

PRs and ideas are welcome. If you improve performance or UX, open a pull request.

---

**Enjoy fast Vim.**

