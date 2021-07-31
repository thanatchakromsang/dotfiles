vim.cmd('colorscheme gruvbox')
vim.cmd('syntax enable')
vim.cmd('syntax on')

vim.o.termguicolors=true

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

-- vim.cmd('hi link QuickScopePrimary IncSearch')
-- vim.cmd('hi link QuickScopeSecondary Search')
-- lightspeed
-- vim.api.nvim_exec([[
--     hi link LightspeedOneCharMatch IncSearch
-- ]], false)

-- WhichKey
vim.api.nvim_exec([[
    hi link WhichKey GruvboxYellow
    hi link WhichKeyGroup GruvboxRedBold
    hi link WhichKeyDesc GruvboxGreen
]], false)

-- Lsp
vim.api.nvim_exec([[
    hi link LspDiagnosticsSignError GruvboxRedSign
    hi link LspDiagnosticsSignWarning GruvboxYellowSign
    hi link LspDiagnosticsSignInformation GruvboxGreenSign
    hi link LspDiagnosticsSignHint GruvboxBlueSign
]], false)

-- Indent Blankline
vim.cmd('hi link IndentBlanklineContextChar GruvboxGray')

-- folke/lsp-trouble.nvim
vim.api.nvim_exec([[
    hi link LspTroubleSignWarning LspDiagnosticsDefaultWarning
    hi link LspTroubleSignError LspDiagnosticsDefaultError
    hi link LspTroubleSignHint LspDiagnosticsDefaultHint
    hi link LspTroubleSignInformation LspDiagnosticsDefaultInformation
    hi link LspTroubleFoldIcon LspDiagnosticsDefaultWarning
]], false)

-- NvimTree
vim.cmd('hi link NvimTreeIndentMarker GruvboxBg4')
vim.cmd('hi link NvimTreeFolderIcon GruvboxFg4')
vim.cmd('hi link NvimTreeRootFolder GruvboxPurpleBold')

-- WhichKey
vim.cmd('hi link WhichKeyFloat Normal')

-- symbols-outline.nvim
vim.cmd('hi link FocusedSymbol IncSearch')
