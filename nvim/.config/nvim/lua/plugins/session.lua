require("auto-session").setup({
	auto_restore = true,
	auto_save = true,

	auto_session_suppress_dirs = {
		"~/",
		"~/Downloads",
		"/",
	},

	session_lens = {
		load_on_setup = false,
	},
})
