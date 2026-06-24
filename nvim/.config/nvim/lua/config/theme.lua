local theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme"

-- 🟡 handle PaperColor properly
local function apply_theme(colorscheme, lualine)
	if colorscheme == "PaperColor" then
		vim.cmd.colorscheme("PaperColor")
		local set_hl = vim.api.nvim_set_hl
		set_hl(0, "Normal", { bg = "none" })
		set_hl(0, "NormalFloat", { bg = "none" })
		set_hl(0, "SignColumn", { bg = "none" })
	elseif colorscheme == "gruvbox-light" then -- 👈 intercept before cmd
		vim.cmd("colorscheme gruvbox")
	else
		vim.cmd("colorscheme " .. colorscheme)
	end

	if colorscheme:find("latte") or colorscheme == "gruvbox-light" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end

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

		apply_theme(colorscheme, lualine)
	else
		apply_theme("catppuccin", "catppuccin")
	end
end

--[[ local themes = {
	{ "catppuccin", "catppuccin" },
	{ "gruvbox", "gruvbox" },
	-- { "pywal16", "pywal16-nvim" },
	{ "PaperColor", "auto" }, -- ✅ important fix
	{ "tokyonight", "tokyonight" },
} ]]

local themes = {
	{ "catppuccin-mocha", "catppuccin-mocha" }, -- dark
	{ "catppuccin-latte", "catppuccin-latte" }, -- light
	{ "gruvbox", "gruvbox" },
	-- { "gruvbox-light", "gruvbox" },
	{ "PaperColor", "auto" },
	{ "tokyonight", "tokyonight" },
}

local current_theme_index = 1

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
