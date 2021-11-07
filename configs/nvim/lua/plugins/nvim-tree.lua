vim.g.nvim_tree_gitignore = 0 -- 0 by default
vim.g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
vim.g.nvim_tree_indent_markers = 0 -- 0 by default, this option shows indent markers when folders are open
vim.g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
vim.g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
vim.g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
vim.g.nvim_tree_group_empty = 0 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
-- vim.g.nvim_tree_disable_window_picker = 1 -- 0 by default, will disable the window picker. -- FIXME: When disable window picker. unable to 'o' to open file after go to file or nvim . (https://github.com/kyazdani42/nvim-tree.lua/issues/684)

vim.api.nvim_exec([[
    augroup NvimTreeOptions
        autocmd BufEnter NvimTree set cursorline
    augroup END
    ]], false)

vim.g.nvim_tree_icons = {
    git = {ignored = "#"},
}

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require'nvim-tree'.setup {
  disable_netrw       = false,
  hijack_netrw        = true,
  update_cwd          = false,
  auto_close          = true,
  ignore_ft_on_setup  = {'startify', 'dashboard'},
  open_on_setup       = true,
  update_focused_file = {
    -- enables the feature
    enable      = true,
  },
  view = {
    width = 30,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {
        { key = "v", cb = tree_cb "vsplit" },
      }
    }
  },
  diagnostics = {
    enable = true
  },
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.cache' }
  }
}
