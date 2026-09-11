return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall", "TSBufEnable", "TSBufDisable" },
	build = ":TSUpdate",
	config = function()
		-- Enable standard treesitter features
		require("nvim-treesitter").setup({
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- Set up per-buffer tree-sitter highlighting and folding
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"bash",
				"c",
				"css",
				"cpp",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
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
	end,
}
