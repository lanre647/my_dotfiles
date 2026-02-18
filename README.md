# 📦 Dotfiles

My personal configuration "babies," managed with **GNU Stow**.

## 🚀 Quick Start
To set up a new machine, clone this repo and run the install script:

\`\`\`bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
\`\`\`

## 🛠 Included Configs
* **Zsh**: Custom prompt and aliases.
* **Vim/Nvim**: Editing environment.
* **Tmux**: Terminal multiplexer settings.
* **Scripts**: Personal automation tools in \`~/bin\`.

## 🏗 Structure
The repo uses a mirror-style structure for Stow:
- \`zsh/\`: Links to \`~/.zshrc\`
- \`config/\`: Links to \`~/.config/\`
- \`scripts/\`: Links to \`~/bin/\`

## ⚠️ Requirements
- GNU Stow
- Git
