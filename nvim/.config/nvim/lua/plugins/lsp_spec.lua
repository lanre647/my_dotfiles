-- LSP Plugin Specs (loads configs from config files)

return {
	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("plugins.config.lsp")
		end,
	},

	-- Mason (language server installer)
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason LSP Config
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
	},
}
