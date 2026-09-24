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
local default_theme = "catppuccin-mocha"

local function find_theme_index(name)
	for index, theme in ipairs(themes) do
		if theme[1] == name then
			return index
		end
	end
	return nil
end

local function save_theme(colorscheme, lualine)
	local file = io.open(theme_file, "w")
	if file then
		file:write(colorscheme .. "\n" .. (lualine or "auto"))
		file:close()
	end
end

local function apply_theme(colorscheme, lualine)
    -- 1. Set background mode
    if colorscheme:find("latte") or colorscheme == "gruvbox-light" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end

    -- 2. Apply target colorscheme
    if colorscheme:sub(1, 10) == "catppuccin" then
        local flavour = colorscheme:sub(12) -- mocha, macchiato, frappe, latte
        if flavour == "" then flavour = "mocha" end

        -- Fast path: load compiled cache directly from ~/.cache/nvim/catppuccin/<flavour>
        local cache_path = vim.fn.stdpath("cache") .. "/catppuccin/" .. flavour
        if vim.loop.fs_stat(cache_path) or vim.uv.fs_stat(cache_path) then
            vim.g.catppuccin_flavour = flavour
            dofile(cache_path)
        else
            local ok, catppuccin = pcall(require, "catppuccin")
            if ok then
                catppuccin.load(flavour)
            else
                vim.cmd("colorscheme " .. colorscheme)
            end
        end
    elseif colorscheme == "gruvbox-light" then
        vim.cmd("colorscheme gruvbox")
    else
        vim.cmd("colorscheme " .. colorscheme)
    end

    -- 3. Highlight overrides
    vim.api.nvim_set_hl(0, "CmpBorder", {
        fg = vim.o.background == "light" and "#8c8fa1" or "#585b70",
        bg = "NONE",
    })

    -- 4. Reload Lualine with auto
    local ok, lualine_mod = pcall(require, "lualine")
    if ok then
        lualine_mod.setup({
            options = { theme = "auto" },
        })
    end
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
			return
		end
	end

	-- Fallback to default theme
	current_theme_index = find_theme_index(default_theme) or 1
	apply_theme(default_theme, "auto")
end

_G.switch_theme = function()
	current_theme_index = (current_theme_index % #themes) + 1
	local theme = themes[current_theme_index]
	local colorscheme, lualine = theme[1], theme[2]

	apply_theme(colorscheme, lualine)
	save_theme(colorscheme, lualine)
end

_G.select_theme = function()
	local ok, fzf = pcall(require, "fzf-lua")
	if not ok then
		vim.notify("fzf-lua not found!", vim.log.levels.WARN)
		return
	end

	local theme_names = {}
	for _, theme in ipairs(themes) do
		table.insert(theme_names, theme[1])
	end

	fzf.fzf_exec(theme_names, {
		prompt = "Select theme> ",
		winopts = {
			height = 0.4,
			width = 0.5,
			preview = { hidden = true },
		},
		actions = {
			["default"] = function(selected)
				if not selected or not selected[1] then
					return
				end

				local selected_theme = selected[1]
				local index = find_theme_index(selected_theme)

				if index then
					local theme = themes[index]
					current_theme_index = index
					apply_theme(theme[1], theme[2])
					save_theme(theme[1], theme[2])
				end
			end,
		},
	})
end

-- Create Neovim user commands
vim.api.nvim_create_user_command("SelectTheme", function()
	_G.select_theme()
end, {})

vim.api.nvim_create_user_command("SwitchTheme", function()
	_G.switch_theme()
end, {})
