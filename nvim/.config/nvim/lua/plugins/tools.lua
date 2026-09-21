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
		config = function()
			require("plugins.config.fzf-lua")
		end,
	},

	-- NvimTree (file explorer)
	--[[ {
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
		},
		config = function()
			require("plugins.config.nvim-tree")
		end,
	}, ]]

	-- Oil.nvim (Edit filesystem like a standard Neovim buffer)
	{
		"stevearc/oil.nvim",
		opts = {
			-- Keep the view minimal
			columns = {
				"icon",
			},
			-- Optional: set keymaps or UI settings inside opts
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.cd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
			},
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		},
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
