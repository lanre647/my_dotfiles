return {
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("plugins.config.lsp")
		end,
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
	},
}
