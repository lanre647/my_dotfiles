return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter.setup()

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
					if not ok then
						vim.bo.indentexpr = ""
						return
					end

					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
	end,
}
