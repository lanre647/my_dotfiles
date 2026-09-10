require("catppuccin").setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	term_colors = true,
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
})

require("tokyonight").setup({
	style = "storm",
})
