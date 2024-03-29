-- colors for active , inactive buffer tabs
require("bufferline").setup({
	options = {
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "󰅙",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15,
		tab_size = 18,
		enforce_regular_tabs = false,
		show_close_icon = false,
		show_buffer_close_icons = false,
		-- separator_style = "thin",
		separator_style = { "", "" },
		sort_by = "directory",
		diagnostic = false,
		always_show_bufferline = false,
	},
	highlights = {
		buffer_selected = {
			bg = "#3c3836",
			bold = true,
		},
		duplicate_selected = {
			italic = true,
			bg = "#3c3836",
		},
		separator_selected = {
			bg = "#3c3836",
		},
		separator = {
			bg = "#3c3836",
		},
		indicator_selected = {
			bg = "#3c3836",
		},
	},
})
