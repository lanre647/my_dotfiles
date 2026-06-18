-- colorscheme plugin setup ONLY (no theme loading here)
require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	term_colors = true, -- makes terminal colors match the theme
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
		},
		telescope = { enabled = true },
		nvimtree = true,
		gitsigns = true,
		cmp = true,
		indent_blankline = { enabled = true },
		mini = { enabled = true },
	},
})

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
-- vim.o.background = "light"
-- PaperColor config ONLY (no colorscheme call here)
vim.g.PaperColor_Theme_Options = {
	theme = {
		default = {
			transparent_background = 1,
		},
	},
}

-- tokyonight
require("tokyonight").setup({
	style = "storm",
	transparent = true,
})
