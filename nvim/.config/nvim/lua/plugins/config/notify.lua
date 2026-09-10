require("notify").setup({
	background_colour = "#000000",
	fps = 60,
	level = 2,
	minimum_width = 50,
	render = "compact",
	stages = "fade",
	timeout = 3000,
	top_down = true,
})

vim.notify = require("notify")
