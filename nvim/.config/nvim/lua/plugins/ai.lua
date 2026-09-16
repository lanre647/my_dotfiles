-- AI assistance with CodeCompanion

return {
	{
		"olimorris/codecompanion.nvim",
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionActions",
		},
		keys = {
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "AI: Actions" },
			{ "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "AI: Toggle chat" },
			{ "<leader>ai", "<cmd>CodeCompanion<CR>", mode = { "n", "v" }, desc = "AI: Inline prompt" },
			{ "<leader>ae", "<cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "AI: Add selection to chat" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("plugins.config.ai")
		end,
	},
}
