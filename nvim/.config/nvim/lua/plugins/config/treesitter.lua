require("nvim-treesitter").setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
	pattern = {
		"bash",
		"c",
		"cpp",
		"css",
		"dart",
		"go",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"tsx",
		"typescript",
	},
	callback = function()
		local ok = pcall(vim.treesitter.start)
		if ok then
			vim.wo.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		end
	end,
})
