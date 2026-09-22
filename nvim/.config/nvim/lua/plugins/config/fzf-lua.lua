local fzf = require("fzf-lua")

fzf.setup({
    file_icon_padding = " ",
    
    -- Visual and window layout enhancements
    winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
            border = "rounded",
            vertical = "down:45%",
            horizontal = "right:50%",
            layout = "flex",
        },
    },

    -- File display formatting
    files = {
        formatter = "path.filename_first", -- Displays: filename.ext (path/to/dir/)
    },

    -- Custom Keymaps
    keymap = {
        builtin = {
            ["<M-Esc>"] = "hide",
            ["<F1>"] = "toggle-help",
            ["<F2>"] = "toggle-fullscreen",
            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            ["<F5>"] = "toggle-preview-ccw",
            ["<F6>"] = "toggle-preview-cw",
            ["<F7>"] = "toggle-preview-ts-ctx",
            ["<F8>"] = "preview-ts-ctx-dec",
            ["<F9>"] = "preview-ts-ctx-inc",
            ["<S-Left>"] = "preview-reset",
            ["<S-down>"] = "preview-page-down",
            ["<S-up>"] = "preview-page-up",
            ["<M-S-down>"] = "preview-down",
            ["<M-S-up>"] = "preview-up",
        },
        fzf = {
            ["ctrl-z"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
            ["ctrl-a"] = "beginning-of-line",
            ["ctrl-e"] = "end-of-line",
            ["alt-a"] = "toggle-all",
            ["alt-g"] = "first",
            ["alt-G"] = "last",
        },
    },
})
