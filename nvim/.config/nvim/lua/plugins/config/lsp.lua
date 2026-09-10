-- LSP Configuration Setup

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

-- Detect if we are running inside Termux
local is_termux = vim.env.PREFIX and vim.env.PREFIX:match("termux")

-- =========================
-- LSP keymaps
-- =========================

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { noremap = true, silent = true, buffer = bufnr }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP: Go to definition" }))
		vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "LSP: Hover documentation" }))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "LSP: Find references" }))
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "LSP: Rename" }))
		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "LSP: Code action" }))
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "LSP: Show diagnostics" }))
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnostic: Previous" }))
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Diagnostic: Next" }))
		vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "LSP: Signature help" }))
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "LSP: Go to implementation" }))
		vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, vim.tbl_extend("force", opts, { desc = "LSP: Workspace symbols" }))
	end,
})

-- =========================
-- Mason
-- =========================

-- Dynamically build the list of servers for Mason to manage
local mason_ensure = {
	"pyright",
	"ts_ls",
	"omnisharp",
}

-- Only let Mason manage lua_ls and clangd if we are NOT on Termux
if not is_termux then
	table.insert(mason_ensure, "lua_ls")
	table.insert(mason_ensure, "clangd")
end

mason_lspconfig.setup({
	ensure_installed = mason_ensure,
})

-- =========================
-- LSP setup (Modernized for Nvim 0.12)
-- =========================

local servers = {
	pyright = {},
	ts_ls = {},
	omnisharp = {},

	clangd = {
		capabilities = {
			offsetEncoding = { "utf-16" },
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = { checkThirdParty = false },
				telemetry = { enable = false },
			},
		},
	},
}

-- Apply system-provided binary overrides
if is_termux then
	servers.lua_ls = servers.lua_ls or {}
	servers.lua_ls.cmd = { "lua-language-server" }
	servers.clangd = servers.clangd or {}
	servers.clangd.cmd = { "clangd", "--background-index" }
end

-- Proper configuration merging loop
for server, config in pairs(servers) do
	config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
