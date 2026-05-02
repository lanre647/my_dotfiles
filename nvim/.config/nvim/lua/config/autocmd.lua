-- =========================
-- Autocommands (refactored)
-- =========================

-- Helper to safely require modules
local function safe_require(module)
	local ok, mod = pcall(require, module)
	return ok and mod or nil
end

-- Helper to create augroup
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- =========================
-- Groups
-- =========================
local groups = {
	general = augroup("general"),
	number_toggle = augroup("number_toggle"),
	alpha = augroup("alpha_on_empty"),
}

-- =========================
-- General Autocommands
-- =========================

-- Close NvimTree if it's the last window
vim.api.nvim_create_autocmd("BufEnter", {
	group = groups.general,
	callback = function()
		local wins = vim.api.nvim_list_wins()
		if #wins ~= 1 then
			return
		end

		local buf = vim.api.nvim_win_get_buf(wins[1])
		if vim.bo[buf].filetype == "NvimTree" then
			vim.cmd("quitall")
		end
	end,
})

-- Auto-create missing dirs on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = groups.general,
	callback = function()
		local file = vim.api.nvim_buf_get_name(0)
		if file == "" then
			return
		end

		local dir = vim.fn.fnamemodify(file, ":p:h")
		if vim.fn.isdirectory(dir) == 0 then
			local ok, err = pcall(vim.fn.mkdir, dir, "p")
			if not ok then
				vim.notify("Failed to create directory: " .. err, vim.log.levels.ERROR)
			end
		end
	end,
})

-- Lint on save (only if available for filetype)
vim.api.nvim_create_autocmd("BufWritePost", {
	group = groups.general,
	callback = function()
		local lint = safe_require("lint")
		if not lint then
			return
		end

		if lint.linters_by_ft[vim.bo.filetype] then
			lint.try_lint()
		end
	end,
})

-- Markdown settings
vim.api.nvim_create_autocmd("FileType", {
	group = groups.general,
	pattern = "markdown",
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.wrap = true
	end,
})

-- Disable auto comment on newline
vim.api.nvim_create_autocmd("FileType", {
	group = groups.general,
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = groups.general,
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Reload file if changed externally (safe check)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	group = groups.general,
	callback = function()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = groups.general,
	callback = function()
		local line = vim.fn.line("'\"")
		if line > 1 and line <= vim.fn.line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})

-- Startup time tracking
vim.api.nvim_create_autocmd("VimEnter", {
	group = groups.general,
	callback = function()
		if vim.g.start_time then
			local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
			vim.g.startup_time_ms = string.format("%.2f ms", startuptime * 1000)
		end
	end,
})

-- =========================
-- Alpha Dashboard
-- =========================
vim.api.nvim_create_autocmd("User", {
	group = groups.alpha,
	pattern = "BDeletePre *",
	callback = function()
		if vim.fn.exists(":Alpha") ~= 2 then
			return
		end

		local name = vim.api.nvim_buf_get_name(0)
		if name == "" then
			vim.cmd("Alpha")
			vim.cmd("bd#")
		end
	end,
})

-- =========================
-- Relative Number Toggle
-- =========================

local function set_relative_number(enabled)
	if vim.o.number then
		vim.opt.relativenumber = enabled
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "InsertLeave" }, {
	group = groups.number_toggle,
	callback = function()
		if vim.api.nvim_get_mode().mode ~= "i" then
			set_relative_number(true)
		end
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = groups.number_toggle,
	callback = function()
		set_relative_number(false)
	end,
})

-- Quick scratch buffer (no file, no pressure)
vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd("enew")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
end, {})

-- Toggle line wrapping (huge for markdown vs code)
vim.api.nvim_create_user_command("WrapToggle", function()
	vim.wo.wrap = not vim.wo.wrap
	vim.notify("Wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, {})

-- Trim trailing whitespace (before save or manually)
vim.api.nvim_create_user_command("TrimWhitespace", function()
	local view = vim.fn.winsaveview()
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.winrestview(view)
end, {})

-- Toggle spellcheck (not just for markdown)
vim.api.nvim_create_user_command("SpellToggle", function()
	vim.wo.spell = not vim.wo.spell
	vim.notify("Spell: " .. (vim.wo.spell and "ON" or "OFF"))
end, {})

-- Toggle diagnostics (silence noise instantly)
vim.api.nvim_create_user_command("DiagToggle", function()
	vim.g.disable_diagnostics = not vim.g.disable_diagnostics

	if vim.g.disable_diagnostics then
		vim.diagnostic.disable()
		vim.notify("Diagnostics: OFF", vim.log.levels.WARN)
	else
		vim.diagnostic.enable()
		vim.notify("Diagnostics: ON", vim.log.levels.INFO)
	end
end, {})

-- Autoformat on save (respects toggle)
--[[ vim.api.nvim_create_autocmd("BufWritePre", {
  group = groups.general,
  callback = function()
    if vim.g.disable_autoformat then return end

    local conform = safe_require("conform")
    if not conform then return end

    conform.format({
      bufnr = 0,
      lsp_fallback = true,
      timeout_ms = 500,
    })
  end,
})
]]
-- =========================
-- Commands
-- =========================

vim.api.nvim_create_user_command("FormatToggle", function()
	vim.g.disable_autoformat = not vim.g.disable_autoformat

	vim.notify(
		"Autoformat: " .. (vim.g.disable_autoformat and "OFF" or "ON"),
		vim.g.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO
	)
end, {})

vim.api.nvim_create_user_command("Format", function()
	local conform = safe_require("conform")
	if not conform then
		vim.notify("Formatter not available", vim.log.levels.ERROR)
		return
	end

	conform.format({
		bufnr = 0,
		lsp_fallback = true,
		timeout_ms = 1000,
	})
end, {})
