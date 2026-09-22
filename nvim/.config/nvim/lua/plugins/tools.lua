-- Navigation & Tools: FZF, NvimTree, Terminal

return {
	-- FZF-Lua (fuzzy finder)
	{
		"ibhagwan/fzf-lua",
		lazy = true,
		cmd = "FzfLua",
		keys = {
			-- File finding shortcuts
			{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>fh", "<cmd>FzfLua files cwd=~/<cr>", desc = "Find files (home)" },
			{ "<leader>fc", "<cmd>FzfLua files cwd=~/.config<cr>", desc = "Find files (~/.config)" },
			{ "<leader>fl", "<cmd>FzfLua files cwd=~/.local/src<cr>", desc = "Find files (~/.local/src)" },
			{ "<leader>fa", "<cmd>FzfLua files cwd=..<cr>", desc = "Find files (parent dir)" },
			{ "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },

			-- Search & Grep
			{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fG", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
			{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },

			-- LSP & Help
			{ "<leader>fs", "<cmd>FzfLua lsp_workspace_symbols<cr>", desc = "LSP workspace symbols" },
			{ "<leader>fS", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "LSP document symbols" },
			{ "<leader>fH", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
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
