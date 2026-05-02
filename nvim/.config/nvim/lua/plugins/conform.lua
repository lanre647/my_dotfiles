local is_termux = vim.env.PREFIX and vim.env.PREFIX:match("termux")

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
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

	format_on_save = function(bufnr)
		if vim.g.disable_autoformat then
			return
		end

		return {
			timeout_ms = is_termux and 1000 or 500,
			lsp_fallback = not vim.tbl_contains({ "c" }, vim.bo.filetype),
		}
	end,
})
