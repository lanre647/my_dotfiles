local options = {
	laststatus = 3,
	-- cmdheight = 0,
	ruler = false,
	showmode = false,
	showcmd = false,
	mouse = "a",
	clipboard = "unnamedplus",
	history = 100,
	swapfile = false,
	spell = true,
	backup = false,
	undofile = true,
	cursorline = true,
	ttyfast = true,
	smoothscroll = true,
	title = true,

	breakindent = true,
	number = true,
	relativenumber = true,
	numberwidth = 4,

	smarttab = true,
	cindent = true,
	autoindent = false,
	tabstop = 4,

	foldmethod = "manual", -- Default to manual at startup; Treesitter sets foldexpr per-buffer
	foldlevel = 99,

	termguicolors = true,

	ignorecase = true,
	smartcase = true,

	conceallevel = 2,
	concealcursor = "nc",

	splitkeep = "screen",
	confirm = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.sessionoptions:append("localoptions")

vim.diagnostic.config({
	signs = true,
	virtual_text = {
		prefix = "●",
		spacing = 2,
		source = "if_many",
	},
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		focused = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
