local wk = require("which-key")

wk.add({
	{ "<leader>a", group = "AI" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>c", group = "Code / comments" },
	{ "<leader>cs", group = "CSV" },
	{ "<leader>d", group = "Debug" },
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>m", group = "Move lines" },
	{ "<leader>p", group = "Project / theme" },
	{ "<leader>s", group = "Search / TODO" },
	{ "<leader>st", desc = "Search TODO comments" },
	{ "<leader>sq", desc = "TODO location list" },
	{ "<leader>sr", desc = "Search and replace" },
})
