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
	{ "<leader>mA", desc = "Swap parameter backward" },
	{ "<leader>ma", desc = "Swap parameter forward" },
	{ "<leader>p", group = "Project / theme" },
	{ "<leader>s", group = "Search / TODO" },
	{ "<leader>st", desc = "Search TODO comments" },
	{ "<leader>sq", desc = "TODO location list" },
	{ "<leader>sr", desc = "Search and replace" },
	{ "<leader>v", desc = "Custom inline visual hints" },
})
