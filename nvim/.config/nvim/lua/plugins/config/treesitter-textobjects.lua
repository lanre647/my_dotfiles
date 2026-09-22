-- lua/plugins/config/treesitter-textobjects.lua

local ok_select, select = pcall(require, "nvim-treesitter-textobjects.select")
local ok_move, move = pcall(require, "nvim-treesitter-textobjects.move")
local ok_swap, swap = pcall(require, "nvim-treesitter-textobjects.swap")

if not (ok_select and ok_move and ok_swap) then
    return
end

local select_maps = {
    { "af", "@function.outer", "Select function" },
    { "if", "@function.inner", "Select inner function" },
    { "ac", "@class.outer", "Select class" },
    { "ic", "@class.inner", "Select inner class" },
    { "aa", "@parameter.outer", "Select parameter" },
    { "ia", "@parameter.inner", "Select inner parameter" },
    { "ai", "@conditional.outer", "Select conditional" },
    { "ii", "@conditional.inner", "Select inner conditional" },
    { "al", "@loop.outer", "Select loop" },
    { "il", "@loop.inner", "Select inner loop" },
}

for _, mapping in ipairs(select_maps) do
    vim.keymap.set({ "x", "o" }, mapping[1], function()
        select.select_textobject(mapping[2], "textobjects")
    end, { desc = mapping[3] })
end

-- Motions
vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function" })

vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Previous function" })

vim.keymap.set({ "n", "x", "o" }, "]c", function()
    move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class" })

vim.keymap.set({ "n", "x", "o" }, "[c", function()
    move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Previous class" })

-- Parameter swapping
vim.keymap.set("n", "<leader>ma", function()
    swap.swap_next("@parameter.inner", "textobjects")
end, { desc = "Swap parameter forward" })

vim.keymap.set("n", "<leader>mA", function()
    swap.swap_previous("@parameter.inner", "textobjects")
end, { desc = "Swap parameter backward" })

-- Which-key group registration
local has_wk, which_key = pcall(require, "which-key")
if has_wk then
    which_key.add({
        { "<leader>m", group = "Textobject / line movement" },
    })
end
