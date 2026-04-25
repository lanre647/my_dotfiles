-- =========================
-- Autocommands (cleaned up)
-- =========================

-- Create reusable augroups
local general = vim.api.nvim_create_augroup("general", { clear = true })
local number_toggle = vim.api.nvim_create_augroup("number_toggle", { clear = true })
local alpha_group = vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })

-- -------------------------
-- Close NvimTree if it's the last window
-- -------------------------
vim.api.nvim_create_autocmd("BufEnter", {
  group = general,
  callback = function()
    local wins = vim.api.nvim_list_wins()
    if #wins == 1 then
      local buf = vim.api.nvim_win_get_buf(wins[1])
      if vim.bo[buf].filetype == "NvimTree" then
        vim.cmd("quit")
      end
    end
  end,
})

-- -------------------------
-- Auto-create missing dirs on save
-- -------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  group = general,
  callback = function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then return end

    local dir = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- -------------------------
-- Lint on save
-- -------------------------
vim.api.nvim_create_autocmd("BufWritePost", {
  group = general,
  callback = function()
    local ok, lint = pcall(require, "lint")
    if ok then
      lint.try_lint()
    end
  end,
})

-- -------------------------
-- Markdown settings
-- -------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = general,
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- -------------------------
-- Disable auto comment on newline
-- -------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = general,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- -------------------------
-- Highlight on yank
-- -------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- -------------------------
-- Reload file if changed externally
-- -------------------------
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = general,
  callback = function()
    vim.cmd("checktime")
  end,
})

-- -------------------------
-- Restore cursor position
-- -------------------------
vim.api.nvim_create_autocmd("BufReadPost", {
  group = general,
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- -------------------------
-- Startup time tracking
-- -------------------------
vim.api.nvim_create_autocmd("VimEnter", {
  group = general,
  callback = function()
    if vim.g.start_time then
      local startuptime = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
      vim.g.startup_time_ms = string.format("%.2f ms", startuptime * 1000)
    end
  end,
})

-- -------------------------
-- Alpha dashboard reopen logic
-- -------------------------
vim.api.nvim_create_autocmd("User", {
  group = alpha_group,
  pattern = "BDeletePre *",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
      vim.cmd([[:Alpha | bd#]])
    end
  end,
})

-- -------------------------
-- Relative number toggle (smart)
-- -------------------------
vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  {
    group = number_toggle,
    callback = function()
      if vim.o.number and vim.api.nvim_get_mode().mode ~= "i" then
        vim.opt.relativenumber = true
      end
    end,
  }
)

vim.api.nvim_create_autocmd(
  { "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  {
    group = number_toggle,
    callback = function()
      if vim.o.number then
        vim.opt.relativenumber = false
      end
    end,
  }
)
