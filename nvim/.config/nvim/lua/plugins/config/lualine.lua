-- Refactored for execution efficiency & fast VeryLazy loading

-- Localize frequent API calls
local fn = vim.fn
local api = vim.api
local bo = vim.bo

-- Fast global state for autosave (no autocommand block overhead at parse time)
_G.autosave_status = _G.autosave_status or ""

-- Setup Auto-Save autocmd ONLY once
local save_group = api.nvim_create_augroup("LualineAutoSave", { clear = true })
api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
	group = save_group,
	callback = function()
		if bo.modified and bo.buftype == "" and fn.expand("%") ~= "" then
			api.nvim_command("silent! update")
			_G.autosave_status = "󰄬 SAVED"
			vim.defer_fn(function()
				_G.autosave_status = ""
			end, 800)
		end
	end,
})

-- Inline lightweight functions to eliminate closure creation overhead
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto", -- Uses compiled highlights if Catppuccin compile is enabled
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "alpha", "dashboard", "NvimTree", "toggleterm", "qf", "help", "lazy", "mason", "oil" },
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return " " .. str
				end,
			},
		},
		lualine_b = {
			{
				"branch",
				icon = "󰘬",
				fmt = function(str)
					return #str > 15 and (string.sub(str, 1, 12) .. "...") or str
				end,
			},
			{
				"diff",
				colored = true,
				symbols = { added = " ", modified = "󰝤 ", removed = " " },
			},
		},
		lualine_c = {
			{
				"filename",
				path = 1,
				file_status = true,
				symbols = { modified = " 󰏫", readonly = " 🔒" },
			},
			{
				function()
					local reg = fn.reg_recording()
					return reg ~= "" and ("󰑋 REC @" .. reg) or ""
				end,
				color = { gui = "bold" },
			},
		},
		lualine_x = {
			{
				function()
					return _G.autosave_status
				end,
				color = { gui = "bold" },
			},
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, c in ipairs(clients) do
						table.insert(names, c.name)
					end
					return "󰒋 " .. table.concat(names, ", ")
				end,
			},
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				symbols = { error = "󰅚 ", warn = "󰀦 " },
				colored = true,
				update_in_insert = true,
				always_visible = false,
				cond = function()
					return bo.filetype ~= "markdown"
				end,
			},
			{
				function()
					local file = fn.expand("%:p")
					if file == "" then
						return ""
					end
					local size = fn.getfsize(file)
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
				end,
			},
			"filetype",
		},
		lualine_y = {
			{
				function()
					local curr = fn.line(".")
					local total = fn.line("$")
					if total == 0 then
						return "0%%"
					end
					local chars = { " ", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
					local ratio = curr / total
					local idx = math.max(1, math.min(#chars, math.ceil(ratio * #chars)))
					return chars[idx] .. " " .. math.floor(ratio * 100) .. "%%"
				end,
			},
		},
		lualine_z = {
			{
				"location",
				icon = "󰍎",
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
})
-- 
