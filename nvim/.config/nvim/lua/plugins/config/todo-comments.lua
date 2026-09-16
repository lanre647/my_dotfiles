require("todo-comments").setup({
	signs = true,
	sign_priority = 8,
	merge_keywords = true,
	keywords = {
		FIX = { icon = "!", color = "error", alt = { "FIXME", "BUG", "FIXIT" } },
		TODO = { icon = "T", color = "info" },
		HACK = { icon = "H", color = "warning" },
		WARN = { icon = "W", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = "P", color = "hint", alt = { "OPTIM", "OPTIMIZE" } },
		NOTE = { icon = "N", color = "hint", alt = { "INFO" } },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
	},
})
