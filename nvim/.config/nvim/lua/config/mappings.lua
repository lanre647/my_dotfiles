-- keymaps.lua
-- All keybindings, organized by category.

local function map(m, k, v, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(m, k, v, options)
end

map("", "<Space>", "<Nop>", { desc = "Leader (no-op)" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ─────────────────────────────────────────────
-- Easy excape mapping
-- ─────────────────────────────────────────────
map("i", "jj", "<Esc>", { desc = "Better excape" })

-- ─────────────────────────────────────────────
-- Buffers
-- ─────────────────────────────────────────────
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<C-PageUp>", ":bprevious<CR>", { desc = "Previous open file" })
map("n", "<C-PageDown>", ":bnext<CR>", { desc = "Next open file" })
map("n", "<leader>bd", ":BufferClose<CR>", { desc = "Delete buffer" })
map("n", "<leader>bD", ":BufferClose!<CR>", { desc = "Force delete buffer" })
map("n", "<leader>ba", ":bufdo bd<CR>", { desc = "Delete all buffers" })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all buffers except current" })
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
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
-- centered scrolling and search
-- ─────────────────────────────────────────────
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search match centered" })
map("n", "N", "Nzzzv", { desc = "Previous search match centered" })

-- ─────────────────────────────────────────────
-- Quickfix Navigation
-- ─────────────────────────────────────────────
-- Fast jumping through quickfix entries
map("n", "]q", ":cnext<CR>zz", { silent = true })
map("n", "[q", ":cprev<CR>zz", { silent = true })

-- Populate Quickfix with LSP Diagnostics
map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Workspace diagnostics to Quickfix" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Buffer diagnostics to Location List" })

-- Filter to ERRORS only (ignore warnings/hints)
map("n", "<leader>de", function()
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Workspace errors to Quickfix" })

-- ─────────────────────────────────────────────
-- Splits
-- ─────────────────────────────────────────────
-- map("n", "<C-\\>", ":vsplit<CR>", { desc = "Split editor vertically" })
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
map("n", "<leader>fh", ":lua require('fzf-lua').files({ cwd = '~/' })<CR>", { desc = "Find files (home)" })
map("n", "<leader>fb", ":lua require('fzf-lua').buffers()<CR>", { desc = "Find buffers" })
map("n", "<leader>fc", ":lua require('fzf-lua').files({ cwd = '~/.config' })<CR>", { desc = "Find files (~/.config)" })
map(
	"n",
	"<leader>fl",
	":lua require('fzf-lua').files({ cwd = '~/.local/src' })<CR>",
	{ desc = "Find files (~/.local/src)" }
)
map("n", "<leader>fa", ":lua require('fzf-lua').files({ cwd = '..' })<CR>", { desc = "Find files (parent dir)" })
map("n", "<leader>fr", ":lua require('fzf-lua').resume()<CR>", { desc = "Resume last search" })
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
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map("n", "<leader>sr", ":%s//g<Left><Left>", { desc = "Replace all (in file)" })
map("n", "<leader>pc", switch_theme, { desc = "Cycle themes" })
map("n", "<leader>pt", select_theme, { desc = "Select theme" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable" })
map("n", "<leader>mv", ":!mv % ", { desc = "Move file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit neovim" })
map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Hot reload Neovim config" })
map("n", "<leader>u", "<cmd>Undotree<cr>", { desc = "Toggle undo tree" })
map("n", "<leader>W", ":set wrap!<CR>", { desc = "Toggle line wrap" })
map("n", "<leader>lc", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "z=", function()
	require("fzf-lua").spell_suggest({
		winopts = {
			height = 0.33,
			width = 0.40,
			row = 0.40,
		},
	})
end, { desc = "FzfLua spell suggestions (compact)" })
map("v", "<leader>i", "=gv", { desc = "Auto-indent selection" })

-- ─────────────────────────────────────────────
-- UI Toggle (zen mode)
-- ─────────────────────────────────────────────
local zen_mode_active = false
local original_settings = {}

local function toggle_zen_mode()
	local in_tmux = os.getenv("TMUX") ~= nil

	if not zen_mode_active then
		-- 1. Save original options (using vim.opt_local for window options)
		original_settings = {
			number = vim.opt_local.number,
			relativenumber = vim.opt_local.relativenumber,
			signcolumn = vim.opt_local.signcolumn,
			foldcolumn = vim.opt_local.foldcolumn,
			laststatus = vim.opt.laststatus,
			showtabline = vim.opt.showtabline,
		}

		-- 2. Hide Neovim UI elements
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.foldcolumn = "0"
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0

		-- 3. Enable Twilight if loaded
		if pcall(vim.cmd, "TwilightEnable") then
		-- Uses TwilightEnable if available, or falls back to :Twilight
		else
			pcall(vim.cmd, "Twilight")
		end

		-- 4. Hide Tmux status line
		if in_tmux then
			vim.fn.system("tmux set status off")
		end

		zen_mode_active = true
		vim.notify("Zen Mode: ON", vim.log.levels.INFO)
	else
		-- 1. Restore window/global options
		vim.opt_local.number = original_settings.number
		vim.opt_local.relativenumber = original_settings.relativenumber
		vim.opt_local.signcolumn = original_settings.signcolumn
		vim.opt_local.foldcolumn = original_settings.foldcolumn
		vim.opt.laststatus = original_settings.laststatus
		vim.opt.showtabline = original_settings.showtabline

		-- 2. Disable Twilight
		if pcall(vim.cmd, "TwilightDisable") then
		else
			pcall(vim.cmd, "Twilight")
		end

		-- 3. Restore Tmux status line
		if in_tmux then
			vim.fn.system("tmux set status on")
		end

		zen_mode_active = false
		vim.notify("Zen Mode: OFF", vim.log.levels.INFO)
	end
end

vim.keymap.set("n", "<leader>z", toggle_zen_mode, { desc = "Toggle Zen Mode" })

-- ─────────────────────────────────────────────
-- Line Numbers
-- ─────────────────────────────────────────────
map("n", "<leader>n", function()
	if vim.wo.relativenumber then
		vim.wo.relativenumber = false
		vim.wo.number = true
	else
		vim.wo.relativenumber = true
	end
end, { desc = "Toggle relative/absolute line numbers" })

-- ─────────────────────────────────────────────
-- Custom floating terminal (generic, reusable)
-- ─────────────────────────────────────────────
local all_floats = {} -- track every instance for VimResized

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	local win = vim.api.nvim_open_win(buf, true, win_config)
	return { buf = buf, win = win }
end

-- Factory: returns { toggle = fn, state = table } bound to its own state + shell command
local function make_terminal_toggler(cmd)
	local state = { buf = -1, win = -1 }
	table.insert(all_floats, state)

	local function toggle()
		if not vim.api.nvim_win_is_valid(state.win) then
			local reused = state.buf ~= -1 and vim.api.nvim_buf_is_valid(state.buf)
			local win_state = create_floating_window({ buf = state.buf })
			state.buf, state.win = win_state.buf, win_state.win

			if not reused then
				vim.fn.termopen(cmd, {
					on_exit = function()
						if vim.api.nvim_win_is_valid(state.win) then
							vim.api.nvim_win_hide(state.win)
						end
						state.buf = -1
					end,
				})
			end
			vim.cmd("startinsert")
		else
			vim.api.nvim_win_hide(state.win)
		end
	end

	return { toggle = toggle, state = state }
end

local term_instance = make_terminal_toggler(vim.o.shell)
local lazygit_instance = make_terminal_toggler("lazygit")
local htop_instance = make_terminal_toggler("htop")

map({ "n", "t" }, "<C-\\>", term_instance.toggle, { desc = "Toggle Float Terminal" })
vim.keymap.set("n", "<leader>gg", lazygit_instance.toggle, { desc = "Toggle LazyGit" })
vim.keymap.set("n", "<leader>ht", htop_instance.toggle, { desc = "Toggle Htop" })

-- Resize all floats together when the editor window resizes
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		for _, state in ipairs(all_floats) do
			if vim.api.nvim_win_is_valid(state.win) then
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)
				vim.api.nvim_win_set_config(state.win, {
					relative = "editor",
					width = width,
					height = height,
					row = math.floor((vim.o.lines - height) / 2),
					col = math.floor((vim.o.columns - width) / 2),
				})
			end
		end
	end,
})

-- ─────────────────────────────────────────────
-- Run Button
-- ─────────────────────────────────────────────
local function run_current_file_with_args()
	local filetype = vim.bo.filetype
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

		local file_dir = vim.fn.expand("%:p:h")
		local cd_and_run = "cd " .. vim.fn.shellescape(file_dir) .. " && " .. final_cmd

		local state = term_instance.state
		if vim.api.nvim_win_is_valid(state.win) then
			vim.api.nvim_win_close(state.win, true)
		end
		local win_state = create_floating_window({})
		state.buf, state.win = win_state.buf, win_state.win

		vim.fn.termopen(cd_and_run, {
			on_exit = function()
				if vim.api.nvim_win_is_valid(state.win) then
					vim.api.nvim_win_hide(state.win)
				end
				state.buf = -1
			end,
		})
		vim.cmd("startinsert")
	end)
end

vim.keymap.set("n", "<F2>", run_current_file_with_args, { desc = "Run file with args" })

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
--[[ local ok, wk = pcall(require, "which-key")
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
end ]]
local ns_id = vim.api.nvim_create_namespace("custom_virtual_hints")

local function add_inline_annotation(text)
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-indexed line number

	-- Extmarks allow attaching metadata directly to byte positions
	vim.api.nvim_buf_set_extmark(0, ns_id, line, 0, {
		virt_text = { { "  //" .. text, "Comment" } },
		virt_text_pos = "eol", -- Render at end of line
	})
end

local function clear_inline_annotations()
	vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
end

vim.keymap.set("n", "<leader>va", function()
	vim.ui.input({ prompt = "Virtual Note: " }, function(input)
		if input then
			add_inline_annotation(input)
		end
	end)
end, { desc = "Add EOL Virtual Text Note" })

vim.keymap.set("n", "<leader>vc", clear_inline_annotations, { desc = "Clear Virtual Text Notes" })

-- ─────────────────────────────────────────────
-- Custom Harpoon
-- ─────────────────────────────────────────────
-- Slot Mappings (Leader + Number to jump, Leader + Shift + Number to mark)
local slots = { "A", "B", "C", "D" }

for i, mark in ipairs(slots) do
	-- Jump to slot N (e.g., <leader>1 jumps to mark A)
	vim.keymap.set("n", "<leader>" .. i, "'" .. mark .. "zz", { desc = "Harpoon slot " .. i })
	-- Set slot N (e.g., <leader>! or custom bind sets mark A)
	vim.keymap.set("n", "<leader>m" .. i, "m" .. mark, { desc = "Set Harpoon slot " .. i })
end

-- local fzf = require("fzf-lua")

-- Custom launcher that filters for our 4 global slot marks
vim.keymap.set("n", "<leader>hh", function()
	require("fzf-lua").marks({
		marks = "[A-D]", -- Only show our designated Harpoon marks
	})
end, { desc = "Harpoon Menu (FZF)" })
