-- Lualine Configurationnn
local lualine = require("lualine")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "E ", warn = "W " },
	colored = true,
	update_in_insert = true,
	always_visible = false,
	cond = function()
		return vim.bo.filetype ~= "markdown"
	end,
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = "+", modified = "~", removed = "-" },
}

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str .. " "
	end,
}

local branch = {
	"branch",
	icon = " ",
}

-- File Size Indicator Function
local file_size = function()
	local file = vim.fn.expand("%:p")
	if file == "" or file == nil then
		return ""
	end

	local size = vim.fn.getfsize(file)
	if size <= 0 then
		return ""
	end

	local suffixes = { "B", "KB", "MB", "GB" }
	local i = 1
	while size >= 1024 and i < #suffixes do
		size = size / 1024
		i = i + 1
	end

	return string.format("%.1f%s", size, suffixes[i])
end

-- Macro Recording Indicator
local macro_recording = function()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "REC @" .. reg
end

-- Temporary Auto-Save Feedback Loop
_G.autosave_status = ""

local save_group = vim.api.nvim_create_augroup("LualineAutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
	group = save_group,
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.api.nvim_command("silent! update")

			_G.autosave_status = "SAVED"

			vim.defer_fn(function()
				_G.autosave_status = ""
			end, 800)
		end
	end,
})

local save_indicator = function()
	return _G.autosave_status or ""
end

-- Custom Visual Progress
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	if total_lines == 0 then
		return "0%%"
	end

	local chars = { " ", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)

	if index < 1 then
		index = 1
	end
	if index > #chars then
		index = #chars
	end

	return chars[index] .. " " .. math.floor(line_ratio * 100) .. "%%"
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = nil, -- let theme.lua handle mode colors
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diff },
		lualine_c = {
			{
				"filename",
				path = 1,
				file_status = true,
				symbols = { modified = " ●", readonly = " 🔒" },
			},
			{
				macro_recording,
				color = { fg = "#ff5555", gui = "bold" },
			},
		},
		lualine_x = {
			{
				save_indicator,
				color = { fg = "#50fa7b", gui = "bold" },
			},
			diagnostics,
			file_size,
			"encoding",
			"filetype",
		},
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
