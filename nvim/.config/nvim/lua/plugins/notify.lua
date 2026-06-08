require("notify").setup({
	background_colour = "#000000",
	fps = 60,
	level = 2,
	minimum_width = 50,
	render = "compact", -- "default" | "minimal" | "simple" | "compact"
	stages = "fade", -- "fade" | "slide" | "fade_in_slide_out" | "static"
	timeout = 3000,
	top_down = true,
})

vim.notify = require("notify")
