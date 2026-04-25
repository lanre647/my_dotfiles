local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
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
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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

-- Only let Mason manage lua_ls if we are NOT on Termux
-- (On Termux, we use 'pkg install lua-language-server' instead)
if not is_termux then
  table.insert(mason_ensure, "lua_ls")
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
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}

-- If on Termux, inject the custom command to use the native pkg binary
if is_termux then
  servers.lua_ls.cmd = { "lua-language-server" }
end

for server, config in pairs(servers) do
  -- Merge capabilities into the server config
  config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
  
  -- Use the built-in Neovim 0.11+ configuration and activation
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
