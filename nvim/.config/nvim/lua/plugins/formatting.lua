-- Code Formatting & Linting

return {
	-- Conform (formatter)
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufWritePre" },
		config = function()
			require("plugins.config.conform")
		end,
	},

	-- NvimLint (linter)
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.config.nvim-lint")
		end,
	},
}
