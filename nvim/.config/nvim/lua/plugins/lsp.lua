local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Note: 'require("lspconfig")' isn't strictly needed anymore with vim.lsp.config(),
-- but keeping it loaded ensures default server definitions are initialized.
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

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
	end,
})

-- =========================
-- Mason
-- =========================

mason.setup()

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
-- LSP setup (Modernized for Nvim 0.11/0.12)
-- =========================

local servers = {
	pyright = {},
	ts_ls = {},
	omnisharp = {},

	dartls = {
		cmd = { "dart", "language-server", "--protocol=lsp" },
		filetypes = { "dart" },
	},

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

-- Apply system-provided binary overrides directly into our configuration table
if is_termux then
	servers.lua_ls.cmd = { "lua-language-server" }
	servers.clangd.cmd = { "clangd", "--background-index" }
end

-- Proper configuration merging loop using Neovim's native lsp.config API
for server, config in pairs(servers) do
	-- Cleanly merge autocompletion capabilities
	config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

	-- Modern way: Feed settings into the existing native configuration skeleton
	-- without completely overriding filetype matching rules.
	vim.lsp.config(server, config)

	-- Auto-activate the language server dynamically
	vim.lsp.enable(server)
end
