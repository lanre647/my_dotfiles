local fterm = require("FTerm")

fterm.setup({
	border = "double", -- Available: 'double', 'rounded', 'single', 'shadow', 'none'
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

_G.htop = fterm:new({
	ft = "fterm_htop",
	cmd = "htop",
})

_G.lazygit = fterm:new({
	ft = "fterm_lazygit",
	cmd = "lazygit",
})
