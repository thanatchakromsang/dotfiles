-- Gitsigns
require("gitsigns").setup({
	signs = {
		add = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▌", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = {
			hl = "GitSignsChangeDelete",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		untracked = { hl = "GitSignsAdd", text = "▌", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	},
	keymaps = {
		buffer = true,
		noremap = true,

		-- Text objects
		["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
		["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
	},
	numhl = false,
	linehl = false,
	watch_gitdir = { interval = 100 },
	update_debounce = 100,
	sign_priority = 5,
	status_formatter = nil, -- Use default
})
