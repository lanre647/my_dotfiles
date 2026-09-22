-- lua/plugins/config/treesitter.lua

local status_ok, main = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

-- Disable treesitter on files larger than 100 KB to avoid lag
local max_filesize = 100 * 1024

-- Ensure parsers are installed
main.setup({
	ensure_installed = {
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
		"markdown_inline",
		"python",
		"rust",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"query",
	},
})

-- Global fold settings (keep folds open by default)
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Modern Native Treesitter Folding
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterFolds", { clear = true }),
	callback = function(args)
		-- Skip large files
		local name = vim.api.nvim_buf_get_name(args.buf)
		if name ~= "" then
			local ok, stats = pcall(vim.uv.fs_stat, name)
			if ok and stats and stats.size > max_filesize then
				return
			end
		end

		-- Enable treesitter folding natively
		local win = vim.api.nvim_get_current_win()
		vim.wo[win].foldmethod = "expr"
		vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
})
