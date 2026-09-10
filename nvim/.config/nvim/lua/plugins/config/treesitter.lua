require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"css",
		"dart",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"rust",
		"tsx",
		"typescript",
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-backspace>",
		},
	},
	indent = {
		enable = true,
	},
})
