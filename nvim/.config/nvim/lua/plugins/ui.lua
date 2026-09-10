-- UI Plugins: Lualine, Barbar, Alpha, Which-Key, Twilight

return {
	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.config.lualine")
		end,
	},

	-- Bufferline
	{
		"romgrk/barbar.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.config.barbar")
		end,
	},

	-- Startup dashboard
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			require("plugins.config.alpha")
		end,
	},

	-- Which-key (keybinding hints)
	{
		"folke/which-key.nvim",
		lazy = false,
		config = function()
			require("plugins.config.which-key")
		end,
	},

	-- Focus dimming
	{
		"folke/twilight.nvim",
		event = { "VimEnter" },
		config = function()
			require("plugins.config.twilight")
		end,
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
	},

	{
		"echasnovski/mini.icons",
		lazy = false,
		config = function()
			require("mini.icons").setup()
		end,
	},

	-- Colorschemes
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},

	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			require("plugins.config.colorscheme")
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
	},

	{
		"NLKNguyen/papercolor-theme",
		lazy = false,
	},

	-- Cellular automaton (fun!)
	{
		"eandrju/cellular-automaton.nvim",
		lazy = true,
	},
}
