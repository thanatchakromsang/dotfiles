vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_visual = 'green background'
vim.g.gruvbox_material_menu_selection_background = 'green'
vim.g.gruvbox_material_disable_italic_comment = 1
-- vim.g.gruvbox_material_current_word = 'bold'
vim.o.termguicolors = true
vim.cmd('colorscheme gruvbox-material')
vim.cmd('set background=dark')

-- Telescope
vim.api.nvim_exec2([[
    hi! TelescopeBorder         guifg=#665c54
    hi! TelescopePromptBorder   guifg=#665c54
    hi! TelescopeResultsBorder  guifg=#665c54
    hi! TelescopePreviewBorder  guifg=#665c54
]], {})

-- Highlight yank
vim.api.nvim_exec2([[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({ higroup='PmenuSel', timeout=500})
    augroup END
]], {})

-- WhichKey
vim.api.nvim_exec2([[
    hi! link WhichKey Yellow
    hi! link WhichKeyGroup RedBold
    hi! link WhichKeyDesc Green
]], {})

-- Lsp
vim.api.nvim_exec2([[
    hi! link DiagnosticSignError RedSign
    hi! link DiagnosticSignWarn YellowSign
    hi! link DiagnosticSignInfo GreenSign
    hi! link DiagnosticSignHint BlueSign
]], {})

-- Indent Blankline
vim.cmd('hi! link IndentBlanklineContextChar Yellow')

-- folke/lsp-trouble.nvim
vim.api.nvim_exec2([[
    hi! link LspTroubleSignWarning DiagnosticDefaultWarn
    hi! link LspTroubleSignError DiagnosticDefaultError
    hi! link LspTroubleSignHint DiagnosticDefaultHint
    hi! link LspTroubleSignInformation DiagnosticDefaultInfo
    hi! link LspTroubleFoldIcon DiagnosticDefaultWarn
]], {})

-- WhichKey
vim.cmd('hi! link WhichKeyFloat Normal')

-- symbols-outline.nvim
vim.cmd('hi! link FocusedSymbol IncSearch')

-- -- Neogit
-- vim.api.nvim_exec2([[
--     hi! link NeogitHunkHeader TabLine
--     hi! link NeogitHunkHeaderHighlight TabLine
--     sign define NeogitOpen:section texthl=StatusLine
--     sign define NeogitClosed:section texthl=StatusLine
--     sign define NeogitOpen:item texthl=StatusLine
--     sign define NeogitClosed:item texthl=StatusLine
-- ]], {})

-- nvim-cmp
vim.api.nvim_exec2([[
    hi! link CmpItemMenu CmpItemAbbrDeprecatedDefault
    hi! link CmpItemKind Aqua
    hi! link CmpPmenu Pmenu
    hi! link CmpPmenuBorder Pmenu
    hi! CmpPmenu guibg=#282828
    hi! CmpPmenuBorder guifg=#615750
]], {})

