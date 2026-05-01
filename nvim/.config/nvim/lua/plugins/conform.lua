local is_termux = vim.env.PREFIX and vim.env.PREFIX:match("termux")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		-- Add C and C++ here
		c = { "clang-format" },
		cpp = { "clang-format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
	},

	format_on_save = {
		-- On Termux, you might want a slightly longer timeout
		-- as the CPU on the Itel can sometimes take a second to process
		timeout_ms = is_termux and 1000 or 500,
		lsp_fallback = true,
	},
})
