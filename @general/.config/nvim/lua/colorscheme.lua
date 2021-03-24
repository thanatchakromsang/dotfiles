vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')
vim.cmd('syntax on')

vim.o.termguicolors=true

vim.g.gruvbox_sign_column='bg0' -- disable highlight sign column

vim.cmd('hi TelescopeBorder         guifg=#665c54')
vim.cmd('hi TelescopePromptBorder   guifg=#665c54')
vim.cmd('hi TelescopeResultsBorder  guifg=#665c54')
vim.cmd('hi TelescopePreviewBorder  guifg=#665c54')

-- Highlight yank
vim.api.nvim_exec([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=500 }
    augroup END
]], false)

vim.cmd('hi link NvimTreeIndentMarker GruvboxBg4')
vim.cmd('hi link NvimTreeFolderIcon GruvboxFg4')
vim.cmd('hi link NvimTreeRootFolder GruvboxPurpleBold')

-- TODO: Update Quickscope Highligts to be more obvious and match with Hops
vim.cmd('hi link QuickScopePrimary IncSearch')
vim.cmd('hi link QuickScopeSecondary Search')
