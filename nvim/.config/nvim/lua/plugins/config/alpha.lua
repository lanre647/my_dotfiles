-- Alpha Dashboard Configuration
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- dashboard.section.header.val = {
-- 	[[      /\             ]],
-- 	[[     /  \   /\       ]],
-- 	[[    / /\ \ /  \      ]],
-- 	[[   / /  \ \/\  \     ]],
-- 	[[  /_/    \__/\__\    ]],
-- }
dashboard.section.header.opts.hl = {}
for index, line in ipairs(dashboard.section.header.val) do
	table.insert(dashboard.section.header.opts.hl, {
		{ index == 1 and "WarningMsg" or index == 4 and "ErrorMsg" or "Comment", 0, #line },
	})
end

dashboard.section.buttons.val = {
	dashboard.button("f", "find files", "<cmd>FzfLua files<CR>"),
	dashboard.button("r", "recent files", "<cmd>FzfLua oldfiles<CR>"),
	dashboard.button("s", "saved sessions", "<cmd>AutoSession search<CR>"),
	dashboard.button("p", "projects", "<cmd>FzfLua files<CR>"),
	dashboard.button("t", "TODO comments", "<cmd>TodoQuickFix<CR>"),
	dashboard.button("a", "AI companion", "<cmd>CodeCompanionChat Toggle<CR>"),
	dashboard.button("F", "Flutter tools", "<cmd>FlutterDevices<CR>"),
	dashboard.button("h", "help tags", "<cmd>FzfLua help_tags<CR>"),
	dashboard.button("R", "reload Neovim", "<cmd>restart<CR>"),
	dashboard.button("q", "quit Neovim", "<cmd>qa!<CR>"),
}

dashboard.section.footer.val = function()
	local version = vim.version()
	local ver = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
	local scheme = vim.g.colors_name or "default"
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
	branch = branch and branch ~= "" and branch or "no git branch"
	return {
		"",
		"────────────────────────────────────────",
		"  " .. cwd .. "  ·  " .. branch,
		"  " .. ver .. "  ·  " .. scheme .. "  ·  startup " .. (vim.g.startup_time_ms or "measuring..."),
		"  make something worth keeping",
	}
end

dashboard.opts.layout = {
	{ type = "padding", val = 4 },
	dashboard.section.header,
	{ type = "padding", val = 1 },
	dashboard.section.buttons,
	{ type = "padding", val = 2 },
	dashboard.section.footer,
}

dashboard.section.buttons.opts.hl = "String"
dashboard.section.buttons.opts.spacing = 0
dashboard.section.footer.opts.hl = "Comment"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
