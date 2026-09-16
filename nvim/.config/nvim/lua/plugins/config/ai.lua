local adapters = require("codecompanion.adapters")

local function openai_adapter()
	return adapters.extend("openai", {
		env = {
			api_key = "OPENAI_API_KEY",
		},
	})
end

local function ollama_adapter()
	return adapters.extend("ollama", {
		env = {
			url = "OLLAMA_HOST",
		},
	})
end

require("codecompanion").setup({
	adapters = {
		http = {
			openai = openai_adapter,
			ollama = ollama_adapter,
		},
	},
	strategies = {
		chat = {
			adapter = vim.env.OPENAI_API_KEY and "openai" or "ollama",
		},
		inline = {
			adapter = vim.env.OPENAI_API_KEY and "openai" or "ollama",
		},
		cmd = {
			adapter = vim.env.OPENAI_API_KEY and "openai" or "ollama",
		},
	},
	display = {
		action_palette = {
			provider = "default",
		},
		chat = {
			auto_scroll = true,
			show_header_separator = true,
		},
	},
})

