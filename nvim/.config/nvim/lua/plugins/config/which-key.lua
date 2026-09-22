local wk = require("which-key")

wk.add({
	{ "<leader>a", group = "AI" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>c", group = "Doc comments" },
	-- { "<leader>d", group = "Debug" },
	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>h", group = "htop" },
	{ "<leader>L", group = "Lazy" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>m", group = "Textobject+" },
	{ "<leader>mA", desc = "Swap parameter backward" },
	{ "<leader>ma", desc = "Swap parameter forward" },
	{ "<leader>p", group = "Project|theme" },
	{ "<leader>s", group = "TODOs" },
	{ "<leader>st", desc = "Search TODOs" },
	{ "<leader>sq", desc = "TODO location list" },
	{ "<leader>sr", desc = "Search and replace" },
	{ "<leader>v", desc = "Custom hints|spilt" },
	{ "<leader>x", group = "quickfix list" },
	{ "<leader>z", desc = "zen|folding" },
})
