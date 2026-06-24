-- local wk = require("which-key")
-- wk.add({
-- { "<leader>d", desc = "duplicate file" },
-- { "<leader>p", desc = "toggle theme" },
-- { "<leader>u", desc = "open url" },
-- { "<leader>z", desc = "floating terminal" },
-- { "<leader>f", desc = "fzf" },
-- { "<leader>g", desc = "grep" },
-- { "<leader>G", desc = "grep under cursor" },
-- { "<leader>x", desc = "chmod +x" },
-- { "<leader>t", desc = "view files" },
-- { "<leader>R", desc = "reload config" },
-- { "<leader>vs", desc = "vsplit next buf" },
-- { "<leader>w", desc = "write" },
-- { "<leader>W", desc = "toggle wrap" },
-- { "<leader>q", desc = "close buf" },
-- { "<leader>Q", desc = "close buf!" },
-- { "<leader>U", desc = "close ALL buf" },
-- { "<leader>nn", desc = "toggle relative nums" },
-- { "<leader>H", desc = "htop terminal" },
-- { "<leader>T", desc = "git status" },
-- { "<leader>F", desc = "fzf opts" },
-- })

local wk = require("which-key")

wk.add({
	{ "<leader>p", desc = "Switch theme" },
	{ "<leader>u", desc = "Open URL under cursor" },
	{ "<leader>t", desc = "Toggle terminal" },

	-- FZF
	{ "<leader>ff", desc = "Find files" },
	{ "<leader>fh", desc = "Find files (home)" },
	{ "<leader>fc", desc = "Find files (.config)" },
	{ "<leader>fl", desc = "Find files (.local/src)" },
	{ "<leader>ff", desc = "Find files (parent dir)" },
	{ "<leader>fr", desc = "Resume last search" },
	{ "<leader>fs", desc = "Workspace symbols" },
	{ "<leader>fS", desc = "Document symbols" },

	-- Search
	{ "<leader>fg", desc = "Live grep" },
	{ "<leader>G", desc = "Grep word under cursor" },

	-- Files
	{ "<leader>x", desc = "Make executable" },
	{ "<leader>mv", desc = "Move file" },
	{ "<leader>W", desc = "Toggle wrap" },

	-- Tree / UI
	{ "ctrl-b", desc = "Toggle file explorer" },
	{ "<leader>l", desc = "Toggle Twilight" },
	{ "<leader>R", desc = "Reload current config" },

	-- Buffers
	{ "<leader>q", desc = "Close buffer" },
	{ "<leader>Q", desc = "Force close buffer" },
	{ "<leader>U", desc = "Close all buffers" },
	{ "<leader>vs", desc = "Vertical split next buffer" },

	-- Utilities
	{ "<leader>nn", desc = "Toggle relative numbers" },
	{ "<leader>H", desc = "Toggle htop" },

	-- Git
	{ "<leader>gg", desc = "LazyGit" },

	-- CSV
	{ "<leader>csa", desc = "Align CSV" },
	{ "<leader>csA", desc = "Clear CSV alignment" },

	-- LSP
	{ "<leader>rn", desc = "Rename symbol" },
	{ "<leader>ca", desc = "Code action" },
	{ "<leader>e", desc = "Diagnostics" },

	{ "<leader>f", group = "Find" },
	{ "<leader>g", group = "Grep" },
	{ "<leader>c", group = "CSV" },
	{ "<leader>g", group = "Git" },
	{ "<leader>d", group = "Debug" },
})
