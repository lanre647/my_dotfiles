local theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme"

local themes = {
	{ "catppuccin-latte", "auto" },
	{ "catppuccin-frappe", "auto" },
	{ "catppuccin-macchiato", "auto" },
	{ "catppuccin-mocha", "auto" },

	{ "gruvbox", "gruvbox" },
	{ "gruvbox-light", "gruvbox" },
}

local current_theme_index = 1

local function find_theme_index(name)
	for index, theme in ipairs(themes) do
		if theme[1] == name then
			return index
		end
	end

	return nil
end

local default_theme = "catppuccin-mocha"

local function apply_theme(colorscheme, lualine)
	if colorscheme == "gruvbox-light" then -- 👈 intercept before cmd
		vim.cmd("colorscheme gruvbox")
	else
		vim.cmd("colorscheme " .. colorscheme)
	end

	if colorscheme:find("latte") or colorscheme == "gruvbox-light" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end

	vim.api.nvim_set_hl(0, "CmpBorder", {
		fg = vim.o.background == "light" and "#8c8fa1" or "#585b70",
		bg = "NONE",
	})

	require("lualine").setup({
		options = { theme = lualine or "auto" },
	})
end

_G.load_theme = function()
	local file = io.open(theme_file, "r")

	if file then
		local colorscheme = file:read("*l")
		local lualine = file:read("*l")
		file:close()

		local theme_index = colorscheme and find_theme_index(colorscheme)

		if colorscheme and theme_index then
			current_theme_index = theme_index
			apply_theme(colorscheme, lualine)
		else
			current_theme_index = find_theme_index(default_theme)
			apply_theme(default_theme, "auto")
		end
	else
		current_theme_index = find_theme_index(default_theme)
		apply_theme(default_theme, "auto")
	end
end

_G.switch_theme = function()
	current_theme_index = current_theme_index % #themes + 1
	local colorscheme, lualine = unpack(themes[current_theme_index])

	apply_theme(colorscheme, lualine)

	local file = io.open(theme_file, "w")
	if file then
		file:write(colorscheme .. "\n" .. (lualine or "auto"))
		file:close()
	end
end

_G.select_theme = function()
	local fzf = require("fzf-lua")
	local theme_names = {}

	for _, theme in ipairs(themes) do
		table.insert(theme_names, theme[1])
	end

	fzf.fzf_exec(theme_names, {
		prompt = "Select theme> ",
		winopts = {
			height = 0.4,
			width = 0.5,
			preview = {
				hidden = true,
			},
		},
		actions = {
			["default"] = function(selected)
				if not selected or not selected[1] then
					return
				end

				local selected_theme = selected[1]

				for index, theme in ipairs(themes) do
					if theme[1] == selected_theme then
						current_theme_index = index
						apply_theme(theme[1], theme[2])

						local file = io.open(theme_file, "w")
						if file then
							file:write(theme[1] .. "\n" .. (theme[2] or "auto"))
							file:close()
						end

						break
					end
				end
			end,
		},
	})
end

-- Creating Commands
--[[ vim.api.nvim_create_user_command("SelectTheme", function()
	select_theme()
end, {})
]]
