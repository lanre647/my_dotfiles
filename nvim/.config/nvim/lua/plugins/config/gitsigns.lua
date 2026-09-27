-- Gitsigns Configuration
require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged_enable = true,
	signcolumn = true,
	numhl = false,
	linehl = false,

	-- 1. Enable word-level inline diffing (highlights exact character changes inside a line)
	word_diff = true,

	-- 2. Modern diff options & better algorithms
	diff_opts = {
		internal = true,
		algorithm = "histogram", -- "patience" or "histogram" produce cleaner diffs than default
		indent_heuristic = true,
		linematch = 60, -- Pairs modified lines accurately across shifts/reindentation
	},

	watch_gitdir = { follow_files = true },
	auto_attach = true,
	attach_to_untracked = false,

	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,
	max_file_length = 40000,

	-- 3. Enhanced floating window preview
	preview_config = {
		border = "rounded", -- Cleaner border for hunk previews
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})
-- Actions
-- visual mode
vim.keymap.set("v", "<leader>hs", function()
	require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "git [s]tage hunk" })
vim.keymap.set("v", "<leader>hr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "git [r]eset hunk" })
-- normal mode
vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Git: Toggle inline [b]lame" })
vim.keymap.set("n", "<leader>gd", require("gitsigns").diffthis, { desc = "git [d]iff against index" })
vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "git [p]review hunk" })
vim.keymap.set("n", "<leader>gs", require("gitsigns").stage_hunk, { desc = "git [s]tage hunk" })
vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "git [r]eset hunk" })
vim.keymap.set("n", "<leader>gS", require("gitsigns").stage_buffer, { desc = "git [S]tage buffer" })
vim.keymap.set("n", "<leader>gu", require("gitsigns").stage_hunk, { desc = "git [u]ndo stage hunk" })
vim.keymap.set("n", "<leader>gR", require("gitsigns").reset_buffer, { desc = "git [R]eset buffer" })
-- Toggle word diff directly in the buffer (highlights inserted/deleted words inside modified lines)
vim.keymap.set("n", "<leader>gw", require("gitsigns").toggle_word_diff, { desc = "Git: Toggle [w]ord diff" })
-- Toggle inline diff lines directly inside the current buffer (no split window needed)
vim.keymap.set("n", "<leader>gi", require("gitsigns").toggle_linehl, { desc = "Git: Toggle [i]nline line highlight" })
-- Enhanced preview hunk (shows inline diff inside a clean popup)
vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk_inline, { desc = "Git: Inline [p]review hunk" })
vim.keymap.set("n", "<leader>gD", function()
	require("gitsigns").diffthis("@")
end, { desc = "git [D]iff against last commit" })
