-- keymaps.lua
-- All keybindings, organized by category.
-- Ctrl-prefixed binds are registered with which-key for discoverability.

local function map(m, k, v, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(m, k, v, options)
end

-- ─────────────────────────────────────────────
-- Leader
-- ─────────────────────────────────────────────
map("", "<Space>", "<Nop>", { desc = "Leader (no-op)" })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─────────────────────────────────────────────
-- Buffers
-- ─────────────────────────────────────────────
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-PageUp>", ":bprevious<CR>", { desc = "Previous open file" })
map("n", "<C-PageDown>", ":bnext<CR>", { desc = "Next open file" })
map("n", "<leader>q", ":BufferClose<CR>", { desc = "Close buffer" })
map("n", "<leader>Q", ":BufferClose!<CR>", { desc = "Force close buffer" })
map("n", "<leader>U", ":bufdo bd<CR>", { desc = "Close all buffers" })
map("n", "<leader>vs", ":vsplit<CR>:bnext<CR>", { desc = "Vertical split + open next buffer" })

-- Buffer goto
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" })
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" })
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" })
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" })
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" })
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" })
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" })
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" })
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" })
map("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Go to last buffer" })
map("n", "<AS-p>", "<Cmd>BufferPin<CR>", { desc = "Pin buffer" })

-- Buffer reorder
map("n", "<AS-h>", "<Cmd>BufferMovePrevious<CR>", { desc = "Move buffer left" })
map("n", "<AS-l>", "<Cmd>BufferMoveNext<CR>", { desc = "Move buffer right" })

-- ─────────────────────────────────────────────
-- Moving Lines
-- ─────────────────────────────────────────────
map("n", "<leader>mj", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<leader>mk", ":m .-2<CR>==", { desc = "Move line up" })
--[[ map("i", "<leader>mj", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<leader>mk", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" }) ]]
map("v", "<leader>mj", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<leader>mk", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ─────────────────────────────────────────────
-- Copying Lines
-- ─────────────────────────────────────────────
map("n", "<A-J>", ":t.<CR>", { desc = "Copy line down" })
map("n", "<A-K>", ":t.-1<CR>", { desc = "Copy line up" })
map("i", "<A-J>", "<Esc>:t.<CR>gi", { desc = "Copy line down" })
map("i", "<A-K>", "<Esc>:t.-1<CR>gi", { desc = "Copy line up" })
map("v", "<A-J>", ":co '><CR>gv=gv", { desc = "Copy selection down" })
map("v", "<A-K>", ":co '<-1<CR>gv=gv", { desc = "Copy selection up" })

-- ─────────────────────────────────────────────
-- Scrolling
-- ─────────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })

-- ─────────────────────────────────────────────
-- Splits
-- ─────────────────────────────────────────────
map("n", "<C-\\>", ":vsplit<CR>", { desc = "Split editor vertically" })
-- map("n", "<CS-\\>", ":split<CR>", { desc = "Split editor horizontally" })

-- Navigate splits
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to split below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to split above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })

-- Resize splits
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- ─────────────────────────────────────────────
-- FZF / Fuzzy Find / Grep
-- ─────────────────────────────────────────────
map("n", "<leader>ff", ":lua require('fzf-lua').files()<CR>", { desc = "Find files (cwd)" })
map("n", "<C-p>", ":lua require('fzf-lua').files()<CR>", { desc = "Find files (cwd)" })
map("n", "<leader>fh", ":lua require('fzf-lua').files({ cwd = '~/' })<CR>", { desc = "Find files (home)" })
map("n", "<leader>fc", ":lua require('fzf-lua').files({ cwd = '~/.config' })<CR>", { desc = "Find files (~/.config)" })
map(
	"n",
	"<leader>fl",
	":lua require('fzf-lua').files({ cwd = '~/.local/src' })<CR>",
	{ desc = "Find files (~/.local/src)" }
)
map("n", "<leader>fa", ":lua require('fzf-lua').files({ cwd = '..' })<CR>", { desc = "Find files (parent dir)" })
map("n", "<leader>fr", ":lua require('fzf-lua').resume()<CR>", { desc = "Resume last search" })
map("n", "<leader>fg", ":lua require('fzf-lua').grep()<CR>", { desc = "Grep" })
map("n", "<C-F>", ":lua require('fzf-lua').grep()<CR>", { desc = "Grep" })
map("n", "<leader>G", ":lua require('fzf-lua').grep_cword()<CR>", { desc = "Grep word under cursor" })

map("n", "<leader>fs", function()
	require("fzf-lua").lsp_workspace_symbols()
end, { desc = "LSP workspace symbols" })
map("n", "<leader>fS", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "LSP document symbols" })
--[[ map("n", "<C-P>", function()
	require("fzf-lua").commands()
-- end, { desc = "Command palette" }) ]]
map("n", "<leader>fH", function()
	require("fzf-lua").help_tags({
		actions = { ["default"] = require("fzf-lua").actions.help },
	})
end, { desc = "Help tags" })

-- ─────────────────────────────────────────────
-- Clipboard (system)
-- ─────────────────────────────────────────────
--[[ map("v", "<C-c>", '"+y', { desc = "Copy to system clipboard" })
map("v", "<C-x>", '"+x', { desc = "Cut to system clipboard" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })
map("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard (insert)" }) ]]

-- ─────────────────────────────────────────────
-- File / Editor Utilities
-- ─────────────────────────────────────────────
map({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Save file" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>t", "<cmd>lua require('FTerm').open()<CR>", { desc = "Open terminal" })
map("t", "<Esc>", '<C-\\><C-n><CMD>lua require("FTerm").close()<CR>', { desc = "Close terminal" })
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>s", ":%s//g<Left><Left>", { desc = "Replace all (in file)" })
map("n", "<leader>p", switch_theme, { desc = "Cycle themes" })
map("n", "<leader>P", ":PlugInstall<CR>", { desc = "Run PlugInstall" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })
map("n", "<leader>mv", ":!mv % ", { desc = "Move file" })
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Hot reload Neovim config" })
map("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Toggle undo tree" })
map("n", "<leader>W", ":set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>l", ":Twilight<CR>", { desc = "Toggle Twilight (focus dim)" })
map("v", "<leader>i", "=gv", { desc = "Auto-indent selection" })

-- ─────────────────────────────────────────────
-- UI Toggle (zen mode)
-- ─────────────────────────────────────────────
_G.zen_mode_active = false
local original_settings = {}

local function toggle_zen_mode()
	-- Check if we are actually inside a tmux session
	local in_tmux = os.getenv("TMUX") ~= nil

	if not _G.zen_mode_active then
		-- 1. Save original Neovim settings
		original_settings = {
			number = vim.wo.number,
			relativenumber = vim.wo.relativenumber,
			statusline = vim.o.statusline,
			laststatus = vim.o.laststatus,
			showtabline = vim.o.showtabline,
			signcolumn = vim.wo.signcolumn,
			foldcolumn = vim.wo.foldcolumn,
		}

		-- 2. Hide Neovim UI elements
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
		vim.wo.foldcolumn = "0"
		vim.o.laststatus = 0
		vim.o.showtabline = 0

		-- 3. Hide Tmux Status Line
		if in_tmux then
			vim.fn.system("tmux set status off")
		end

		_G.zen_mode_active = true
		print("Zen Mode: ON")
	else
		-- 4. Restore original Neovim settings
		vim.wo.number = original_settings.number
		vim.wo.relativenumber = original_settings.relativenumber
		vim.wo.signcolumn = original_settings.signcolumn
		vim.wo.foldcolumn = original_settings.foldcolumn
		vim.o.laststatus = original_settings.laststatus
		vim.o.showtabline = original_settings.showtabline

		-- 5. Restore Tmux Status Line
		if in_tmux then
			vim.fn.system("tmux set status on")
		end

		_G.zen_mode_active = false
		print("Zen Mode: OFF")
	end
end

vim.keymap.set("n", "<leader>z", toggle_zen_mode, { desc = "Toggle Zen Mode" })

-- ─────────────────────────────────────────────
-- Line Numbers
-- ─────────────────────────────────────────────
map("n", "<leader>nn", function()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
	end
end, { desc = "Toggle relative/absolute line numbers" })

-- ─────────────────────────────────────────────
-- LazyGit / Htop
-- ─────────────────────────────────────────────
vim.keymap.set("n", "<leader>gg", "<CMD>lua _G.lazygit:toggle()<CR>", { desc = "Toggle LazyGit" })
vim.keymap.set("n", "<leader>ht", "<CMD>lua _G.htop:toggle()<CR>", { desc = "Toggle Htop" })

-- ─────────────────────────────────────────────
-- Run Button
-- ─────────────────────────────────────────────
local function run_current_file_with_args()
	local filetype = vim.bo.filetype
	-- 'expand("%:t")' gets just the filename (e.g., TestMath.java)
	local filename = vim.fn.expand("%:t")
	local base_cmd = ""

	if filetype == "java" then
		base_cmd = "java " .. filename
	elseif filetype == "python" then
		base_cmd = "python3 " .. filename
	elseif filetype == "javascript" then
		base_cmd = "node " .. filename
	elseif filetype == "sh" then
		base_cmd = "bash " .. filename
	else
		print("Run command not configured for filetype: " .. filetype)
		return
	end

	vim.ui.input({ prompt = "Arguments: " }, function(input)
		if input == nil then
			return
		end

		local final_cmd = base_cmd
		if input ~= "" then
			final_cmd = base_cmd .. " " .. input
		end

		-- Automatically change directory to the file's folder before running the command
		-- 'expand("%:p:h")' gets the full absolute path of the file's directory
		local file_dir = vim.fn.expand("%:p:h")
		local cd_and_run = "cd " .. vim.fn.shellescape(file_dir) .. " && " .. final_cmd

		local fterm_loaded = package.loaded["FTerm"]
		if type(fterm_loaded) == "table" then
			fterm_loaded.run(cd_and_run)
		else
			local status_ok, FTerm = pcall(require, "FTerm")
			if status_ok then
				FTerm.run(cd_and_run)
			else
				print("Could not load FTerm plugin.")
			end
		end
	end)
end

vim.keymap.set("n", "<F2>", run_current_file_with_args, { desc = "Run file with args in FTerm" })

-- ─────────────────────────────────────────────
-- CSV (decisive)
-- ─────────────────────────────────────────────
map("n", "<leader>csa", ":lua require('decisive').align_csv({})<cr>", { desc = "Align CSV columns" })
map("n", "<leader>csA", ":lua require('decisive').align_csv_clear({})<cr>", { desc = "Clear CSV alignment" })
map("n", "[c", ":lua require('decisive').align_csv_prev_col()<cr>", { desc = "CSV: previous column" })
map("n", "]c", ":lua require('decisive').align_csv_next_col()<cr>", { desc = "CSV: next column" })

-- ─────────────────────────────────────────────
-- Which-key: register Ctrl groups for discoverability
-- ─────────────────────────────────────────────
local ok, wk = pcall(require, "which-key")
if ok then
	wk.add({
		-- Groups
		{ "<C-w>", group = "Window / splits" },
		{ "<C-f>", group = "Grep / find" },

		-- Ctrl binds with descriptions (shown in which-key popup)
		{ "<C-p>", desc = "Find files (cwd)" },
		{ "<C-P>", desc = "Command palette" },
		{ "<C-F>", desc = "Grep" },
		{ "<C-s>", desc = "Save file" },
		{ "<C-b>", desc = "Toggle file explorer" },
		{ "<C-t>", desc = "Open terminal" },
		{ "<C-\\>", desc = "Split vertically" },
		-- { "<C-S-\\>", desc = "Split horizontally" },
		{ "<C-h>", desc = "Move to left split" },
		{ "<C-j>", desc = "Move to split below" },
		{ "<C-k>", desc = "Move to split above" },
		{ "<C-l>", desc = "Move to right split" },
		{ "<C-Up>", desc = "Increase window height" },
		{ "<C-Down>", desc = "Decrease window height" },
		{ "<C-Left>", desc = "Decrease window width" },
		{ "<C-Right>", desc = "Increase window width" },
		{ "<C-d>", desc = "Scroll down (centered)" },
		{ "<C-u>", desc = "Scroll up (centered)" },
		{ "<C-PageUp>", desc = "Previous open file" },
		{ "<C-PageDown>", desc = "Next open file" },
		{ "<C-c>", mode = "v", desc = "Copy to system clipboard" },
		{ "<C-x>", mode = "v", desc = "Cut to system clipboard" },
		{ "<C-v>", desc = "Paste from system clipboard" },
	})
end
