require("auto-session").setup({
	auto_restore = true,
	auto_save = true,
	suppressed_dirs = {
		"~/",
		"~/Downloads",
		"/",
	},
	session_lens = {
		load_on_setup = false,
	},
})
