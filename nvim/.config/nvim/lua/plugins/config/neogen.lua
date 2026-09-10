require("neogen").setup({
	enabled = true,
	input_after_comment = true,
	snippet_engine = "luasnip",
	languages = {
		javascript = {
			templates = {
				annotation_convention = "jsdoc",
			},
		},
		typescript = {
			templates = {
				annotation_convention = "jsdoc",
			},
		},
		javascriptreact = {
			templates = {
				annotation_convention = "jsdoc",
			},
		},
		typescriptreact = {
			templates = {
				annotation_convention = "jsdoc",
			},
		},
		dart = {},
		lua = {},
		python = {},
	},
})
