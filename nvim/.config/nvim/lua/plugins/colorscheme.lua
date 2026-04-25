-- colorscheme plugin setup ONLY (no theme loading here)
require("gruvbox").setup({
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true,
  contrast = "",
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})

-- PaperColor config ONLY (no colorscheme call here)
vim.g.PaperColor_Theme_Options = {
  theme = {
    default = {
      transparent_background = 1
    }
  }
}

-- tokyonight
require("tokyonight").setup({
  style = "storm",
  transparent = true,
})

-- kanagawa
require("kanagawa").setup({
  transparent = true,
  theme = "wave", -- "wave", "dragon", or "lotus"
})
