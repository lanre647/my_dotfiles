-- Alpha Dashboard Configuration (Option B: Cyberpunk - Alignment Fixed)
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- 1. High-Tech Custom Colors
vim.api.nvim_set_hl(0, "AlphaHeaderBorder", { fg = "#3b4261" })
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#bb9af7" })
vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#f7768e", bold = true })
vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#565f89", italic = true })

-- Helper function to pad lines correctly taking unicode display width into account
local function fit_line(text, target_width)
	local width = vim.fn.strdisplaywidth(text)
	local pad = target_width - width
	if pad > 0 then
		return text .. string.rep(" ", pad)
	elseif pad < 0 then
		return string.sub(text, 1, target_width - 3) .. "..."
	end
	return text
end

-- 2. Fixed System Status Card Header
dashboard.section.header.val = function()
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
	local branch = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]
	branch = (branch and branch ~= "") and ("󰘬 " .. branch) or "󰘬 [no git]"
	local scheme = vim.g.colors_name or "default"
	local version = vim.version()
	local ver = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

	local box_width = 44

	local line1 = fit_line("  │  󰉋 CWD : " .. cwd, box_width + 5) .. "│"
	local line2 = fit_line("  │  " .. branch, box_width + 5) .. "│"
	local line3 = fit_line(string.format("  │  󰏔 SYS : %s   󰏘 THEME : %s", ver, scheme), box_width + 5) .. "│"

	return {
		"  ┌── SYSTEM STATUS ─────────────────────────────┐",
		line1,
		line2,
		line3,
		"  └──────────────────────────────────────────────┘",
	}
end
dashboard.section.header.opts.hl = "AlphaHeaderBorder"

-- 3. Custom Button Generator
local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("[%-]", "")
	local opts = {
		position = "center",
		text = txt,
		shortcut = "[" .. sc .. "]",
		cursor = 3,
		width = 40,
		align_shortcut = "right",
		hl = "AlphaButtons",
		hl_shortcut = "AlphaShortcut",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true, nowait = true } }
	end
	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

-- 4. Re-Organized Keybind Actions
dashboard.section.buttons.val = {
	button("f", "󰈞  SEARCH WORKSPACE", "<cmd>FzfLua files<CR>"),
	button("r", "󰋚  RECENT FILES", "<cmd>FzfLua oldfiles<CR>"),
	button("s", "󰆓  SAVED SESSIONS", "<cmd>AutoSession search<CR>"),
	button("p", "󱓞  PROJECT LIST", "<cmd>FzfLua files<CR>"),
	button("t", "󰃤  TODO COMMENTS", "<cmd>TodoQuickFix<CR>"),
	button("a", "󰧑  AI COMPANION", "<cmd>CodeCompanionChat Toggle<CR>"),
	button("c", "󱌣  NVIM CONFIG", "<cmd>FzfLua files cwd=~/.config/nvim<CR>"),
	button("h", "󰋖  HELP TAGS", "<cmd>FzfLua help_tags<CR>"),
	button("R", "󰑐  RELOAD NVIM", "<cmd>restart<CR>"),
	button("q", "󰅚  TERMINATE NVIM", "<cmd>qa!<CR>"),
}

-- 5. Terminal-Style Footer
dashboard.section.footer.val = function()
	local uptime_val = vim.g.startup_time_ms
	local uptime = "active"

	if type(uptime_val) == "number" then
		uptime = string.format("%.2fms", uptime_val)
	elseif type(uptime_val) == "string" and uptime_val ~= "" then
		uptime = uptime_val
	end

	return {
		"─── [ EXECUTION READY • STARTUP " .. uptime .. " ] ───",
		"",
		'"make something worth keeping"',
	}
end

-- 6. High-Density Layout Assembly
dashboard.opts.layout = {
	{ type = "padding", val = 2 },
	dashboard.section.header,
	{ type = "padding", val = 1 },
	dashboard.section.buttons,
	{ type = "padding", val = 2 },
	dashboard.section.footer,
}

dashboard.section.buttons.opts.spacing = 0
dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.opts.opts.noautocmd = true

alpha.setup(dashboard.opts)
