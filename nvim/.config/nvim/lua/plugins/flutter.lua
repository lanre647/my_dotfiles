-- Flutter Support

return {
	-- Flutter Tools
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = true,
		ft = "dart",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			require("plugins.config.flutter")
		end,
	},

	-- Dressing (for better UI)
	{
		"stevearc/dressing.nvim",
		lazy = true,
		event = "VimEnter",
	},
}
