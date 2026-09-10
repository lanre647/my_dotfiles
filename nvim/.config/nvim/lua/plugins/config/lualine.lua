-- Lualine Configuration
local lualine = require("lualine")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "E ", warn = "W " },
	colored = true,
	update_in_insert = true,
	always_visible = true,
	cond = function()
		return vim.bo.filetype ~= "markdown"
	end,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = "+ ", modified = "~ ", removed = "- " },
}

local mode = {
	"mode",
	fmt = function(str)
		return str
	end,
}

local branch = {
	"branch",
	icon = "",
}

local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "", "", "" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index] .. " " .. math.floor(line_ratio * 100) .. "%%"
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = nil, -- let theme.lua handle it
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diff },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { diagnostics, "encoding", "fileformat", "filetype" },
		lualine_y = { progress },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
