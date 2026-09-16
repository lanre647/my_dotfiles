-- NvimLint Configuration
require('lint').linters_by_ft = {
	lua = { 'luac' },
	python = { 'ruff' },
	sh = { 'bash' },
	c = { 'cppcheck' },
	rust = { 'clippy' },
	css = { 'stylelint' },
	html = { 'htmlhint' },
}
