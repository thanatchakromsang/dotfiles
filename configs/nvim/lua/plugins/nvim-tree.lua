vim.g.nvim_tree_gitignore = 0 -- 0 by default
vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 0 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
vim.g.nvim_tree_group_empty = 0 -- 0 by default, compact folders that only contain a single folder into one node in the file tree

vim.g.nvim_tree_icons = {
	git = { ignored = "#" },
}

-- local tree_cb = require("nvim-tree.api.config").nvim_tree_callback

require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		-- enables the feature
		enable = true,
		update_root = true,
	},
	view = {
		width = 30,
		side = "left",
	},
	diagnostics = {
		enable = true,
    show_on_dirs = false
	},
	filters = {
		dotfiles = false,
		custom = { "node_modules", ".cache" },
	},
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		-- Default mappings
		api.config.mappings.default_on_attach(bufnr)

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "R", api.fs.rename_full, opts("Rename: Full Path"))
		vim.keymap.set("n", "o", api.node.open.no_window_picker, opts("Open: No Window Picker"))

		vim.keymap.set("n", "O", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("CD"))
	end,
})

vim.cmd([[
    :hi      NvimTreeExecFile    guifg=#ffa0a0
    :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
    :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
    :hi link NvimTreeImageFile   Title
]])

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
	nested = false,
	callback = function(e)
		local tree = require("nvim-tree.api").tree

		-- Nothing to do if tree is not opened
		if not tree.is_visible() then
			return
		end

		-- How many focusable windows do we have? (excluding e.g. incline status window)
		local winCount = 0
		for _, winId in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(winId).focusable then
				winCount = winCount + 1
			end
		end

		-- We want to quit and only one window besides tree is left
		if e.event == "QuitPre" and winCount == 2 then
			vim.api.nvim_cmd({ cmd = "qall" }, {})
		end

		-- :bd was probably issued an only tree window is left
		-- Behave as if tree was closed (see `:h :bd`)
		if e.event == "BufEnter" and winCount == 1 then
			-- Required to avoid "Vim:E444: Cannot close last window"
			vim.defer_fn(function()
				-- close nvim-tree: will go to the last buffer used before closing
				tree.toggle({ find_file = true, focus = true })
				-- re-open nivm-tree
				tree.toggle({ find_file = true, focus = false })
			end, 10)
		end
	end,
})
