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
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
}
