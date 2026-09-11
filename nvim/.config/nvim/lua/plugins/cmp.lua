-- Completion (cmp) Configuration

return {
	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- Sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{
				"hrsh7th/cmp-nvim-lsp",
				lazy = true, -- Force lazy loading so after/plugin/ isn't sourced eagerly
			},
		},
		config = function()
			require("plugins.config.cmp")
		end,
	},

	-- LuaSnip
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		dependencies = {
			-- If you use VSCode-style snippet collections like friendly-snippets
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- Lazy load VS Code snippets only when LuaSnip actually activates
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	-- cmp sources
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},

	{
		"hrsh7th/cmp-path",
		lazy = true,
	},

	{
		"hrsh7th/cmp-buffer",
		lazy = true,
	},

	{
		"hrsh7th/cmp-cmdline",
		lazy = true,
	},

	{
		"saadparwaiz1/cmp_luasnip",
		lazy = true,
	},
}
