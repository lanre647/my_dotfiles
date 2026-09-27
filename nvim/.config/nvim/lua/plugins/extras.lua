-- Extras: Notifications, Sessions, etc.

return {
	-- Notifications
	{
		"rcarriga/nvim-notify",
		lazy = true,
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Dismiss All Notifications",
			},
		},
		init = function()
			-- Only load 'notify' when a notification actually occurs
			vim.notify = function(...)
				require("notify")(...)
			end
		end,
		config = function()
			require("plugins.config.notify")
		end,
	},

	-- Auto-session
	--[[ {
		"rmagatti/auto-session",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("plugins.config.session")
		end,
	}, ]]

	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<c-h>", "<cmd>TmuxNavigateLeft<cr>", mode = { "n", "t" } },
			{ "<c-j>", "<cmd>TmuxNavigateDown<cr>", mode = { "n", "t" } },
			{ "<c-k>", "<cmd>TmuxNavigateUp<cr>", mode = { "n", "t" } },
			{ "<c-l>", "<cmd>TmuxNavigateRight<cr>", mode = { "n", "t" } },
			{ "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", mode = { "n", "t" } },
		},
	},
}
