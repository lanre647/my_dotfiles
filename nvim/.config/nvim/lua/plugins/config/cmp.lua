-- blink.cmp setup options

return {
	-- Keymap configuration for Insert and Cmdline modes
	keymap = {
		preset = "none",

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = {
			function(cmp)
				if cmp.is_visible() then
					return cmp.select_next()
				end
			end,
			"snippet_forward",
			"fallback",
		},
		["<S-Tab>"] = {
			function(cmp)
				if cmp.is_visible() then
					return cmp.select_prev()
				end
			end,
			"snippet_backward",
			"fallback",
		},

		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
	},

	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "mono",
	},

	completion = {
		menu = {
			border = "rounded",
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		ghost_text = {
			enabled = true,
		},
	},

	-- Enable and configure Cmdline completions as-you-type
	cmdline = {
		enabled = true,
		completion = {
			menu = {
				auto_show = true,
			},
			list = {
				selection = {
					-- Don't preselect item 1 automatically so Tab targets item 1 on first press
					preselect = false,
					auto_insert = true,
				},
			},
		},
		sources = function()
			local type = vim.fn.getcmdtype()
			if type == "/" or type == "?" then
				return { "buffer" }
			end
			if type == ":" then
				return { "cmdline", "path" }
			end
			return {}
		end,
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	signature = { enabled = true },
}
