-- Lualine Configuration (Catppuccin Mocha Bubble Style)
local lualine = require("lualine")

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = "󰅚 ", warn = "󰀦 " },
	colored = true,
	update_in_insert = true,
	always_visible = false,
	cond = function()
		return vim.bo.filetype ~= "markdown"
	end,
}

local lsp_client = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		return ""
	end

	local client_names = {}
	for _, client in ipairs(clients) do
		table.insert(client_names, client.name)
	end

	return "󰒋 " .. table.concat(client_names, ", ")
end

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
}

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str
	end,
	separator = { left = "", right = "" },
}

local branch = {
	"branch",
	icon = "󰘬",
	fmt = function(str)
		if #str > 15 then
			return string.sub(str, 1, 12) .. "..."
		end
		return str
	end,
}

-- File Size Indicator
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
	return "󰑋 REC @" .. reg
end

-- Temporary Auto-Save Feedback Loop
_G.autosave_status = ""
local save_group = vim.api.nvim_create_augroup("LualineAutoSave", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
	group = save_group,
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.api.nvim_command("silent! update")
			_G.autosave_status = "󰄬 SAVED"
			vim.defer_fn(function()
				_G.autosave_status = ""
			end, 800)
		end
	end,
})

local save_indicator = function()
	return _G.autosave_status or ""
end

-- Custom Visual Progress Bar
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
		theme = "catppuccin",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "alpha", "dashboard", "NvimTree", "toggleterm", "qf", "help", "lazy", "mason" },
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			mode,
		},
		lualine_b = {
			branch,
			diff,
		},
		lualine_c = {
			{
				"filename",
				path = 1,
				file_status = true,
				symbols = { modified = " 󰏫", readonly = " 🔒" },
			},
			{
				macro_recording,
				color = { gui = "bold" },
			},
		},
		lualine_x = {
			{
				save_indicator,
				color = { gui = "bold" },
			},
			lsp_client,
			diagnostics,
			file_size,
			"filetype",
		},
		lualine_y = {
			progress,
		},
		lualine_z = {
			{
				"location",
				icon = "󰍎",
				separator = { left = "", right = "" },
			},
		},
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
