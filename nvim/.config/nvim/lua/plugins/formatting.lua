-- Code Formatting & Linting

return {
-- Conform (formatter)
{
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>fM",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer / selection",
        },
    },
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
