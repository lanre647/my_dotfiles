require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

local ts_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

require("Comment").setup({
	padding = true,
	sticky = true,
	mappings = { basic = true, extra = true },
	pre_hook = function(ctx)
		local ft = vim.bo.filetype
		if ft == "sh" or ft == "bash" then
			return nil
		end
		return ts_hook(ctx)
	end,
})

-- Original context-aware setup, kept here as a reference:
-- require("Comment").setup({
-- 	padding = true,
-- 	sticky = true,
-- 	mappings = {
-- 		basic = true,
-- 		extra = true,
-- 	},
-- 	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- })
