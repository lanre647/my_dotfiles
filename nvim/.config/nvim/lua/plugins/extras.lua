-- Extras: Notifications, Sessions, etc.

return {
	-- Notifications
	{
		"rcarriga/nvim-notify",
		lazy = false,
		config = function()
			require("plugins.config.notify")
		end,
	},

	-- Auto-session
	{
		"rmagatti/auto-session",
		lazy = false,
		config = function()
			require("plugins.config.session")
		end,
	},
}
