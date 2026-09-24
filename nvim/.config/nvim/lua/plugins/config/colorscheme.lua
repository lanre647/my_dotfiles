-- require("catppuccin").setup({
-- 	flavour = "mocha",
-- 	background = {
-- 		light = "latte",
-- 		dark = "mocha",
-- 	},
-- 	term_colors = true,
-- 	integrations = {
-- 		treesitter = true,
-- 		native_lsp = {
-- 			enabled = true,
-- 		},
-- 		telescope = { enabled = true },
-- 		nvimtree = true,
-- 		gitsigns = true,
-- 		cmp = true,
-- 		indent_blankline = { enabled = true },
-- 		mini = { enabled = true },
-- 	},
-- })
--
-- require("gruvbox").setup({
-- 	terminal_colors = true,
-- 	undercurl = true,
-- 	underline = true,
-- 	bold = true,
-- 	italic = {
-- 		strings = true,
-- 		emphasis = true,
-- 		comments = true,
-- 		operators = false,
-- 		folds = true,
-- 	},
-- 	strikethrough = true,
-- 	invert_selection = false,
-- 	invert_signs = false,
-- 	invert_tabline = false,
-- 	inverse = true,
-- 	contrast = "",
-- 	palette_overrides = {},
-- 	overrides = {},
-- 	dim_inactive = false,
-- })
--
-- require("tokyonight").setup({
-- 	style = "storm",
-- })

-- lua/plugins/config/colorscheme.lua
require("catppuccin").setup({
	compile = {
		enabled = true,
		path = vim.fn.stdpath("cache") .. "/catppuccin",
	},
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
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		telescope = { enabled = true },
		nvimtree = false,
		gitsigns = true,
		cmp = true,
		indent_blankline = { enabled = true },
		mini = { enabled = true },
	},
})

-- Sets the active colorscheme and uses the compiled cache directly
vim.cmd.colorscheme("catppuccin-mocha")
