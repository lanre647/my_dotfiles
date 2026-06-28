-- dashboard.section.header.val = {
-- 	[[                                                    ]],
-- 	[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
-- 	[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
-- 	[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
-- 	[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
-- 	[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
-- 	[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
-- 	[[                                                    ]],
-- }

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- local lines = {
-- 	[[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ]],
-- 	[[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ]],
-- 	[[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ]],
-- 	[[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]],
-- 	[[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ]],
-- 	[[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ]],
-- 	[[                                                        ]],
-- 	[[  ╭────────────────────────────────────────────────╮   ]],
-- 	[[  │            the editor you deserve              │   ]],
-- 	[[  ╰────────────────────────────────────────────────╯   ]],
-- }

local lines = {

	[[  ^  ^  ^   ^☆ ★ ☆ ___I_☆ ★ ☆ ^  ^   ^  ^  ^   ^  ^ ]],
	[[ /|\/|\/|\ /|\ ★☆ /\-_--\ ☆ ★/|\/|\ /|\/|\/|\ /|\/|\ ]],
	[[ /|\/|\/|\ /|\ ★ /  \_-__\☆ ★/|\/|\ /|\/|\/|\ /|\/|\ ]],
	[[ /|\/|\/|\ /|\ 󰻀 |[]| [] | 󰻀 /|\/|\ /|\/|\/|\ /|\/|\ ]],
}
dashboard.section.header.val = lines
dashboard.section.header.opts.hl = {}

for i = 1, #lines do
	local hl_group
	if i <= 2 then
		hl_group = "DiagnosticOk" -- bright green
	elseif i <= 4 then
		hl_group = "String" -- mid green
	elseif i <= 6 then
		hl_group = "Character" -- softer green
	elseif i == 7 then
		hl_group = "NonText"
	else
		hl_group = "Comment" -- dim floor
	end
	table.insert(dashboard.section.header.opts.hl, { { hl_group, 0, #lines[i] } })
end

dashboard.section.buttons.val = {
	dashboard.button("c", "󰘳 Show All Commands", "<cmd>FzfLua commands<CR>"),
	dashboard.button("f", "󱏒 Open Folder", "<cmd>FzfLua files<CR>"),
	dashboard.button("r", "󱋡 Open Recent", "<cmd>FzfLua oldfiles<CR>"),
	dashboard.button("s", "󰋚 Find Recent Sessions", "<cmd>AutoSession search<CR>"),
	dashboard.button("h", "󰋖 Help Documents", "<cmd>FzfLua help_tags<CR>"),
	dashboard.button("R", "󰑓 Reload Neovim", "<cmd>restart<CR>"),
	dashboard.button("q", "󰅙 Quit Neovim", "<cmd>qa!<CR>"),
}

dashboard.section.footer.val = function()
	local version = vim.version()
	local ver = string.format("v%d.%d.%d", version.major, version.minor, version.patch)
	local scheme = vim.g.colors_name or "default"
	return ver .. "  ·  " .. scheme
end

dashboard.opts.layout = {
	{ type = "padding", val = 2 },
	dashboard.section.header,
	{ type = "padding", val = 1 },
	dashboard.section.buttons,
	{ type = "padding", val = 2 },
	dashboard.section.footer,
}

dashboard.section.buttons.opts.hl = "NonText"
dashboard.section.footer.opts.hl = "Comment"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
