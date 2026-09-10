-- Completion (cmp) Configuration

return {
	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("plugins.config.cmp")
		end,
	},

	-- LuaSnip
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		event = "InsertEnter",
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
