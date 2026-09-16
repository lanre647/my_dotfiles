-- Navigation & Tools: FZF, NvimTree, Terminal

return {
	-- FZF-Lua (fuzzy finder)
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		cmd = "FzfLua",
		keys = {
			{ "<leader>ff", ":lua require('fzf-lua').files()<CR>", desc = "Find files" },
			{ "<C-p>", ":lua require('fzf-lua').files()<CR>", desc = "Find files" },
			{ "<leader>fg", ":lua require('fzf-lua').grep()<CR>", desc = "Grep" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.config.fzf-lua")
		end,
	},

	-- NvimTree (file explorer)
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
		},
		config = function()
			require("plugins.config.nvim-tree")
		end,
	},

	-- Plenary (dependency for many plugins)
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	},

	-- Fuzzy dependencies
	{
		"romgrk/fzy-lua-native",
		lazy = true,
		build = "make",
	},
}
