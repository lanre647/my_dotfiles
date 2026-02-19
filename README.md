---

📦 Dotfiles

My personal configuration "babies," managed with GNU Stow.

🚀 Quick Start
To set up a new machine, clone this repo and run the install script:

`bash
git clone https://github.com/lanre647/my_dotfiles.git dotfiles
cd dotfiles
./install.sh
`

This will symlink configs into your home directory using GNU Stow.

---

🛠 Included Configs
* Zsh: Custom prompt and aliases.
* Vim/Nvim: Editing environment.
* Tmux: Terminal multiplexer settings with plugin support.
* Scripts: Personal automation tools in ~/bin.

---

🏗 Structure
The repo uses a mirror-style structure for Stow:
- zsh/ → ~/.zshrc
- config/ → ~/.config/
- scripts/ → ~/bin/
- tmux/ → ~/.tmux.conf and ~/.tmux/

---

⚠️ Requirements
- GNU Stow
- Git
- Tmux

---

🔌 Tmux Plugins

This setup uses TPM (Tmux Plugin Manager) to handle plugins.

Installation
1. Initialize submodules (to fetch TPM):
   `bash
   git submodule update --init --recursive
   `
2. Start tmux:
   `bash
   tmux
   `
3. Install plugins:
   - Press prefix + I (default prefix is Ctrl-b).
   - TPM will clone and install all plugins listed in .tmux.conf.

Current Plugins
- tpm – Tmux Plugin Manager
- tmux-resurrect – Restore tmux sessions after restart
- tmux-continuum – Continuous saving of tmux environment
- tmux-sensible – Default sensible settings
- tmux-yank – Copy text to system clipboard
- tmux-prefix-highlight – Highlight when prefix is pressed

Plugin Management
- Update plugins: prefix + U
- Remove unused plugins: delete from .tmux.conf then prefix + alt + u

---

🔄 Workflow
- Dotfiles repo tracks only TPM as a submodule.
- All other plugins are installed by TPM based on .tmux.conf.
- This keeps the repo clean and ensures anyone cloning it can set up tmux with a single prefix + I.

---
