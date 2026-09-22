-- Conform (Code Formatter) Configuration
local conform = require("conform")
local is_termux = vim.env.PREFIX and vim.env.PREFIX:match("termux")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        ["_"] = { "trim_whitespace" },
    },

    format_on_save = function(bufnr)
        -- Disable via global or buffer-local variables
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end

        return {
            timeout_ms = is_termux and 3000 or 500,
            lsp_format = vim.bo[bufnr].filetype == "c" and "never" or "fallback",
        }
    end,
})

-- Custom commands to toggle format-on-save
vim.api.nvim_create_user_command("FormatToggle", function(args)
    if args.bang then
        -- FormatToggle! toggles formatting for current buffer only
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print("Buffer autoformatting: " .. (vim.b.disable_autoformat and "OFF" or "ON"))
    else
        -- FormatToggle toggles formatting globally
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print("Global autoformatting: " .. (vim.g.disable_autoformat and "OFF" or "ON"))
    end
end, {
    desc = "Toggle autoformat-on-save (use ! for current buffer)",
    bang = true,
})
