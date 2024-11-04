-- Gitsigns
require("gitsigns").setup({
	signs = {
		add = { text = "▌" },
		change = { text = "▌" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "▌" },
	},
	numhl = false,
	linehl = false,
	watch_gitdir = { interval = 100 },
	update_debounce = 100,
	sign_priority = 5,
	status_formatter = nil, -- Use default
})
