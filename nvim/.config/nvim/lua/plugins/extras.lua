-- Extras: Notifications, Sessions, etc.

return {
	-- Notifications
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("plugins.config.notify")
		end,
	},

	-- Auto-session
	{
		"rmagatti/auto-session",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("plugins.config.session")
		end,
	},
}
