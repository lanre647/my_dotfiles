-- Flutter Tools Configuration

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("flutter-tools").setup({
	-- Force Linux as the default target device
	default_run_target = "linux",

	ui = {
		border = "rounded",
		notification_style = "native",
	},
	decorations = {
		status = {
			flutter_tools = true,
			app_version = true,
			device = true,
		},
	},
	widget_guides = {
		enabled = true,
	},
	dev_log = {
		enabled = true,
		filter = nil,
		open_cmd = "tabedit",
	},
	flutter_path = vim.fn.expand("$HOME/.local/share/flutter/bin/flutter"),
	flutter_lookup_cmd = nil,
	root_patterns = { ".git", "pubspec.yaml" },
	fzf_lua = {
		cmd = "FzfLua",
	},
	lsp = {
		color = {
			enabled = true,
			background = false,
			virtual_text = true,
		},
		capabilities = capabilities,
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			renameFilesWithClasses = "always",
			enableSnippets = true,
		},
	},
})

local function map_flutter(bufnr, key, command, description)
	vim.keymap.set("n", "<leader>F" .. key, "<cmd>" .. command .. "<CR>", {
		buffer = bufnr,
		silent = true,
		desc = description,
	})
end

local function setup_flutter_keymaps(bufnr)
	map_flutter(bufnr, "r", "FlutterRun", "Flutter: Run")
	map_flutter(bufnr, "d", "FlutterDebug", "Flutter: Debug")
	map_flutter(bufnr, "l", "FlutterReload", "Flutter: Hot reload")
	map_flutter(bufnr, "R", "FlutterRestart", "Flutter: Hot restart")
	map_flutter(bufnr, "q", "FlutterQuit", "Flutter: Stop")
	map_flutter(bufnr, "a", "FlutterAttach", "Flutter: Attach")
	map_flutter(bufnr, "x", "FlutterDetach", "Flutter: Detach")
	map_flutter(bufnr, "c", "FlutterDevices", "Flutter: Select device")
	map_flutter(bufnr, "e", "FlutterEmulators", "Flutter: Select emulator")
	map_flutter(bufnr, "o", "FlutterOutlineToggle", "Flutter: Toggle outline")
	map_flutter(bufnr, "p", "FlutterPubGet", "Flutter: Pub get")
	map_flutter(bufnr, "u", "FlutterPubUpgrade", "Flutter: Pub upgrade")
	map_flutter(bufnr, "s", "FlutterLspRestart", "Flutter: Restart Dart LSP")
	map_flutter(bufnr, "v", "FlutterVisualDebug", "Flutter: Visual debug")
	map_flutter(bufnr, "b", "FlutterToggleBrightness", "Flutter: Toggle brightness")
	map_flutter(bufnr, "t", "FlutterDevTools", "Flutter: Start DevTools")
	map_flutter(bufnr, "i", "FlutterInspectWidget", "Flutter: Inspect widget")
	map_flutter(bufnr, "g", "FlutterLogToggle", "Flutter: Toggle log")
	map_flutter(bufnr, "C", "FlutterLogClear", "Flutter: Clear log")

	local ok, which_key = pcall(require, "which-key")
	if ok then
		which_key.add({
			{ "<leader>F", group = "Flutter", buffer = bufnr },
		})
	end
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FlutterToolsKeymaps", { clear = true }),
	pattern = "dart",
	callback = function(args)
		setup_flutter_keymaps(args.buf)
	end,
})

if vim.bo.filetype == "dart" then
	setup_flutter_keymaps(vim.api.nvim_get_current_buf())
end
