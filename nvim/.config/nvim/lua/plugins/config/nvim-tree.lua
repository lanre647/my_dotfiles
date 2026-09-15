-- NvimTree Configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_directories = {
		enable = false,
		auto_open = false,
	},
	renderer = {
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "├",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
	view = {
		width = 25,
		side = "left",
	},
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_cwd = true,
		update_root = true,
	},
})

vim.g.nvim_tree_respect_buf_cwd = 1
