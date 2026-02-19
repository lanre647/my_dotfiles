# 🚀 The "Hyper-Productive" Tmux Configuration

This is a professional-grade `tmux` environment designed for developers who value speed, aesthetics, and session persistence. It features the **Catppuccin Mocha** color palette, **Nerd Font** icons, and **Vim-style** navigation.

---

## 📋 Prerequisites

To ensure the icons and features work correctly, you need:

1.  **Nerd Font:** Install a [Nerd Font](https://www.nerdfonts.com/) and set it as your terminal's font (e.g., *JetBrainsMono Nerd Font*).
2.  **TPM (Tmux Plugin Manager):**
    ```bash
    git clone [https://github.com/tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) ~/.tmux/plugins/tpm
    ```
3.  **FZF:** Required for the fuzzy session switcher.
    * `brew install fzf` (macOS) or `sudo apt install fzf` (Linux).

---

## 🛠️ Installation

1.  Backup your existing config: `mv ~/.tmux.conf ~/.tmux.conf.bak` (if applicable).
2.  Create your new config: `nano ~/.tmux.conf` and paste the configuration code.
3.  **Install Plugins:** Open tmux and press `Ctrl-a` followed by `I` (capital I).
4.  **Reload:** Press `Ctrl-a` followed by `r` to refresh the UI.

---

## ✨ Key Features

* **🎨 Pro Aesthetics:** Uses the Catppuccin Mocha theme with Powerline separators (``, ``).
* **⌨️ Ergonomic Prefix:** Uses `Ctrl-a` instead of the default `Ctrl-b`.
* **⚡ Visual Feedback:** A lightning bolt icon appears in the status bar when the prefix is active.
* **📂 FZF Switcher:** `Prefix + s` allows you to fuzzy-search and jump between sessions instantly.
* **🔋 Cross-Platform:** Battery and system status work on both macOS and Linux via `tmux-battery`.
* **💾 Auto-Persistence:** Sessions are auto-saved every 15 minutes and restored on startup.

---

## 📖 Cheat Sheet

### 󱂬 Session & System
| Key | Action |
| :--- | :--- |
| `Prefix + r` | 󰑓 Reload Config |
| `Prefix + s` |  FZF Session Switcher |
| `Prefix + d` | 󱊄 Detach Session |
| `Prefix + I / U` | 󰚰 Install / Update Plugins |

###  Window & Pane Management
| Key | Action |
| :--- | :--- |
| `Prefix + |` | 󰤼 Split Vertical |
| `Prefix + -` | 󰤼 Split Horizontal |
| `Prefix + h/j/k/l` | 󰜶 Move Pane (Vim Style) |
| `Prefix + H/J/K/L` | 󰜴 Resize Pane (Step 5) |
| `Prefix + S` | 󰓦 Toggle Pane Synchronization |
| `Prefix + z` | 󰊓 Zoom/Unzoom Pane |

### 󰇚 Copy Mode (Vim Style)
| Key | Action |
| :--- | :--- |
| `Prefix + [` | Enter Copy Mode |
| `v` | Start Selection |
| `y` | Copy Selection |
| `Prefix + ]` | Paste Buffer |

---

## 🚀 Automation Script
To launch a pre-configured workspace, use a shell script alias:

```bash
# Example alias in your .zshrc or .bashrc
alias dev="~/.tmux-start.sh"

