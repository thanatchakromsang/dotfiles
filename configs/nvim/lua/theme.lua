vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_enable_italic = 0
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_better_performance = 1
vim.o.termguicolors = true
vim.cmd('colorscheme gruvbox-material')
vim.cmd('set background=dark')

vim.cmd('hi TelescopeBorder         guifg=#665c54')
vim.cmd('hi TelescopePromptBorder   guifg=#665c54')
vim.cmd('hi TelescopeResultsBorder  guifg=#665c54')
vim.cmd('hi TelescopePreviewBorder  guifg=#665c54')

-- Highlight yank
vim.api.nvim_exec([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='Search', timeout=500 }
    augroup END
]], false)

-- WhichKey
vim.api.nvim_exec([[
    hi link WhichKey Yellow
    hi link WhichKeyGroup RedBold
    hi link WhichKeyDesc Green
]], false)

-- Lsp
vim.api.nvim_exec([[
    hi link LspDiagnosticsSignError RedSign
    hi link LspDiagnosticsSignWarning YellowSign
    hi link LspDiagnosticsSignInformation GreenSign
    hi link LspDiagnosticsSignHint BlueSign
]], false)

-- Indent Blankline
vim.cmd('hi link IndentBlanklineContextChar Yellow')

-- folke/lsp-trouble.nvim
vim.api.nvim_exec([[
    hi link LspTroubleSignWarning LspDiagnosticsDefaultWarning
    hi link LspTroubleSignError LspDiagnosticsDefaultError
    hi link LspTroubleSignHint LspDiagnosticsDefaultHint
    hi link LspTroubleSignInformation LspDiagnosticsDefaultInformation
    hi link LspTroubleFoldIcon LspDiagnosticsDefaultWarning
]], false)

-- WhichKey
vim.cmd('hi link WhichKeyFloat Normal')

-- symbols-outline.nvim
vim.cmd('hi link FocusedSymbol IncSearch')

-- Neogit
vim.api.nvim_exec([[
    hi link NeogitHunkHeader TabLine
    hi link NeogitHunkHeaderHighlight TabLine
    sign define NeogitOpen:section texthl=StatusLine
    sign define NeogitClosed:section texthl=StatusLine
    sign define NeogitOpen:item texthl=StatusLine
    sign define NeogitClosed:item texthl=StatusLine
]], false)