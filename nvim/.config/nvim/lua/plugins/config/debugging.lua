-- Debugging Setup

--[[ return {
	-- DAP UI
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		event = "VimEnter",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("plugins.config.dap")
		end,
	},

	-- DAP
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "VimEnter",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
	},

	-- DAP Virtual Text
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		event = "VimEnter",
	},

	-- DAP Python
	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
		event = "VimEnter",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
	},

	-- Neotest (for running tests)
	{
		"nvim-neotest/nvim-nio",
		lazy = true,
	},
} ]]
