-- Editing & Code Improvements

return {
	-- Treesitter (syntax highlighting and text objects)
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("plugins.config.treesitter")
		end,
	},

	-- Auto-pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- Comment toggle
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("plugins.config.comment")
		end,
	},

	-- JSDoc/TSDoc and documentation comments
	{
		"danymat/neogen",
		cmd = "Neogen",
		keys = {
			{ "<leader>cd", "<cmd>Neogen<CR>", mode = "n", desc = "Comments: Generate documentation" },
			{ "<leader>cf", "<cmd>Neogen<CR>", mode = "n", desc = "Comments: Document function" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("plugins.config.neogen")
		end,
	},

	-- TODO, FIXME, HACK, BUG, and NOTE tracking
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "TodoQuickFix", "TodoLocList" },
		keys = {
			{ "<leader>st", "<cmd>TodoQuickFix<CR>", desc = "Search TODO comments" },
			{ "<leader>sq", "<cmd>TodoLocList<CR>", desc = "TODO comments in location list" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.config.todo-comments")
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.config.ibl")
		end,
	},

	-- Color highlighter
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.config.colorizer")
		end,
	},

	-- Markdown rendering
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VimEnter",
		config = function()
			require("plugins.config.render-markdown")
		end,
	},

	-- CSV viewer
	{
		"emmanueltouzery/decisive.nvim",
		ft = { "csv", "tsv" },
	},

	-- Ron syntax highlighting
	{
		"ron-rs/ron.vim",
		ft = "ron",
	},
}
