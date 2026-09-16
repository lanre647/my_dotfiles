## Bread 's guide to **Neovim** configuration

#### Build off of mine, or start your own!

<br>

> Before starting, ensure you have:
> - **neovim** (duh)
> - a [patched font](https://www.nerdfonts.com/) and a terminal that supports glyphs

<br>

### Quickstart with my config:
```
cd ~/.config/ && git clone https://github.com/BreadOnPenguins/nvim
```
- On first boot, lazy.nvim automatically installs the plugins declared in `lua/plugins/`; use `:Lazy` to inspect them.
- Key maps are in `lua/config/mappings.lua`
    * **Leader is bound to space**, you can press space by itself for which-key to pop up with bindings info
- Neovim options are set in `lua/config/options.lua` with some comments for info
- Plugin specifications are located in `lua/plugins/`, with setup modules in `lua/plugins/config/`.
    * Add or remove plugins in a spec file that returns a lazy.nvim table.
    * Use `:Lazy install`, `:Lazy update`, or `:Lazy clean` to manage them.

<br>

### Starting your own config:

Yes, there are a lot of choices! But don't worry, you can easily change your mind later.

**1. Do you want:**
* Minimal?
* Power User?
* Full IDE?

An example directory structure and plugin configuration for each of those is included below.

**2. Choose directory structure**
- If you prefer vimscript, use an `init.vim`
- Otherwise, use an `init.lua`
- If you intend to have a lot of plugins or want a neater structure, split into separate files
    * You can always expand to more files later

**3. Pick plugin manager**
- [vim-plug](https://github.com/junegunn/vim-plug) is a minimal option
- [lazy.nvim](https://github.com/folke/lazy.nvim) is more feature-rich
- or [several other choices](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#plugin-manager)

**4. Pick plugins**
- [Awesome neovim plugins list](https://github.com/rockerBOO/awesome-neovim)
- See below for a rough guide on types of plugins

**5. Set mappings, options, and plugin config**
- Use `:help options` or browse [here](https://neovim.io/doc/user/options.html)
- You don't *always* need to configure plugins: most have sensible defaults, and you can set as few or as many opts as you wish.

### Current IDE workflows

- LSP: `gd`, `gr`, `K`, `<leader>lr`, `<leader>la`, and inline diagnostics
- Git: gutter signs plus inline blame toggled with `<leader>gb`
- TODO comments: `<leader>st` for quickfix and `<leader>sq` for the location list
- Flutter/Dart: buffer-local `<leader>F` actions for run, debug, reload, devices, pub, and DevTools
- AI: `<leader>aa` actions, `<leader>ac` chat, and `<leader>ai` inline prompts
- NvimTree opens automatically when Neovim is launched with a directory
<br><br>
### the Minimalist (better text editor)
```
~/.config/nvim/
└── init.vim
```

Plugins might include:
- File tree
- Fuzzy finder
- Comment quick toggle
- Surround editing
- Better syntax highlighting
- Probably a color scheme and status line
<br><br>
### the Power User
```
~/.config/nvim/
├── init.lua
└── lua
    ├── core
    │   ├── keymaps.lua
    │   └── options.lua
    └── plugins
        └── plugin.lua
        └── configs.lua
```

Plugins might include:
- Everything above, AND
- LSP & autocompletion
- Snippets
- Git integration
- Faster motions, window management
- Terminal integration
- Project and session management
- Tabline and cursorline
<br><br>
### full IDE (do you even need this guide?)
```
~/.config/nvim/
├── init.lua
├── lazy-lock.json
└── lua
    ├── core
    │   ├── keymaps.lua
    │   ├── options.lua
    │   └── plugins.lua
    ├── plugins
    │   └── lots.lua
    │   └── of.lua
    │   └── plugin.lua
    │   └── configs.lua
    └── UltiSnips
        └── tex.snippets
```

Plugins might include:
- Everything above, AND
- Debugging
- Code runners
- Remote development
- Refactoring
