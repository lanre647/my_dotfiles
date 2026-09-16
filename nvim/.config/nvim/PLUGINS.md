# Plugin Specs Guide

This file explains how each plugin spec file is organized and how to add new plugins.

## Plugin Spec Files

### 1. **ui.lua** - User Interface
- Lualine (statusline)
- Barbar (bufferline)
- Alpha (dashboard)
- Which-key (keybinding hints)
- Twilight (focus dimming)
- Icons & Colorschemes

**When to edit**: Adding/removing UI elements

### 2. **editing.lua** - Code Editing
- Treesitter (syntax highlighting)
- Autopairs (auto-closing brackets)
- Comment.nvim (easy commenting)
- nvim-ts-context-commentstring (language-aware comments)
- Neogen (JSDoc/TSDoc and documentation comments)
- todo-comments.nvim (TODO/FIXME/BUG tracking)
- Indent-blankline (indent guides)
- Colorizer (color highlighting)
- Render-markdown (markdown rendering)

**When to edit**: Adding text editing features

### 3. **lsp.lua** - Language Server Protocol
- nvim-lspconfig (LSP client setup)
- Mason (server installer)
- Mason-lspconfig (Mason integration)

**Real config**: `lua/plugins/config/lsp.lua`
**When to edit**: Adding new language servers

### 4. **completion.lua** - Code Completion
- nvim-cmp (completion engine)
- LuaSnip (snippets)
- cmp sources (nvim-lsp, path, buffer, cmdline)

**Real config**: `lua/plugins/config/cmp.lua`
**When to edit**: Changing completion behavior

### 5. **debugging.lua** - Debugger
- nvim-dap (debugger protocol)
- DAP-UI (debugger interface)
- DAP-Python (Python debugger)
- DAP Virtual Text (inline variable display)

**Real config**: `lua/plugins/config/dap.lua`
**When to edit**: Adding debuggers for new languages

### 6. **formatting.lua** - Code Formatting & Linting
- conform.nvim (formatter)
- nvim-lint (linter)

**Real configs**:
- `lua/plugins/config/conform.lua`
- `lua/plugins/config/nvim-lint.lua`

**When to edit**: Adding formatters or linters

### 7. **git.lua** - Git Integration
- gitsigns (git diff markers and inline blame)

**Real config**: `lua/plugins/config/gitsigns.lua`
**When to edit**: Changing git display

### 8. **tools.lua** - Navigation & Tools
- fzf-lua (fuzzy finder)
- nvim-tree (file explorer and directory hijacking)
- FTerm (floating terminal)
- Plenary (dependency lib)

**Real config**: `lua/plugins/config/fzf-lua.lua` (others are minimal)
**When to edit**: Adding navigation features

### 9. **extras.lua** - Extra Features
- nvim-notify (notifications)
- auto-session (session management)

**Real configs**:
- `lua/plugins/config/notify.lua`
- `lua/plugins/config/session.lua`

**When to edit**: Adding session or notification features

### 10. **flutter.lua** - Framework Support
- flutter-tools (Flutter/Dart support)
- dressing.nvim (UI improvements)

**Real config**: `lua/plugins/config/flutter.lua`
**When to edit**: Customizing Flutter development

### 11. **ai.lua** - AI Assistance
- CodeCompanion (AI actions, chat, and inline prompts)
- Supports OpenAI through `OPENAI_API_KEY` or local Ollama

**When to edit**: Changing AI providers or AI behavior

### UI additions

- `mini.icons` provides icons for which-key and other UI plugins.
- Inline diagnostics are configured in `lua/config/options.lua`.

---

## How Specs Work

Each plugin spec file returns a table of plugin specifications:

```lua
-- lua/plugins/example.lua
return {
  {
    "plugin-author/plugin-name",
    lazy = true,                    -- Don't load on startup
    event = "BufRead",              -- Load when file is read
    cmd = "PluginCommand",          -- Load when command is run
    keys = { "<leader>x" },         -- Load when keybind is pressed
    ft = { "python", "lua" },       -- Load for these filetypes
    dependencies = { "other/plugin" }, -- Load these first
    config = function()
      require("plugin-name").setup({ ... })
    end,
  },
}
```

## Lazy Loading Triggers

- **`lazy = false`** – Load immediately on startup
- **`lazy = true`** (default) – Load only when needed
- **`event`** – Load on event (VimEnter, BufRead, BufNewFile, InsertEnter, etc.)
- **`cmd`** – Load when command is executed
- **`keys`** – Load when keybind is pressed
- **`ft`** – Load for specific filetypes
- **`dependencies`** – Load these plugins first

## Adding a New Plugin

### Example: Adding Telescope (if you wanted it)

1. Create `lua/plugins/telescope.lua`:
```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({ ... })
    end,
  },
}
```

2. Lazy.nvim will automatically discover and load it

3. That's it! Restart Neovim or run `:Lazy install`

## Modifying Existing Plugins

### Change lazy loading behavior:
```lua
-- This was event = "BufReadPre"
-- Change to load even faster:
lazy = false,  -- Load on startup instead
```

### Add dependencies:
```lua
dependencies = { "other/required-plugin", "another/plugin" },
```

### Change configuration:
Edit the corresponding file in `lua/plugins/config/` (e.g., `lualine.lua`, `lsp.lua`, etc.)

---

## Common Patterns

### Plugin that needs early loading (UI elements)
```lua
{
  "plugin-name",
  lazy = false,  -- Load immediately
}
```

### Plugin for specific filetype
```lua
{
  "plugin-name",
  ft = { "python", "lua" },  -- Load only for these types
  config = function() ... end,
}
```

### Plugin triggered by command
```lua
{
  "plugin-name",
  cmd = "SomeCommand",  -- Load when :SomeCommand is run
}
```

### Plugin with keybinding trigger
```lua
{
  "plugin-name",
  keys = { "<leader>x" },  -- Load when this keybind is pressed
}
```

---

**That's it!** Lazy.nvim handles the rest automatically. 🚀
