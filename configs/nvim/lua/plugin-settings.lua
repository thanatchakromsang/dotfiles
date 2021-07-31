-- vista
vim.g.vista_default_executive = 'nvim_lsp'

-- vsnip
vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'

-- vim-rooter
vim.g.rooter_silent_chdir = 1

-- floaterm
vim.g.floaterm_keymap_new = '<F7>'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F12>'
vim.g.floaterm_title = ''

vim.g.floaterm_shell = 'zsh'
vim.g.floaterm_autoclose = 1
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_height = 13
vim.g.floaterm_width = 0.7
vim.g.floaterm_wintype = 'split'

-- nvim-comment
require('nvim_comment').setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true
})

-- -- quickscope
-- -- Trigger a highlight in the appropriate direction when pressing these keys:
-- vim.g.qs_highlight_on_keys = {'f', 'F', 't', 'T'}
-- vim.g.qs_max_chars = 150
-- vim.g.qs_buftype_blacklist = {'terminal', 'nofile'}

-- lightspeed
require'lightspeed'.setup {
    jump_to_first_match = false,
    jump_on_partial_input_safety_timeout = 400,
    highlight_unique_chars = false,
    grey_out_search_area = false,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 10,
    full_inclusive_prefix_key = '<c-x>'
}

function repeat_ft(reverse)
    local ls = require 'lightspeed'
    ls.ft['instant-repeat?'] = true
    ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua repeat_ft(false)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ',', '<cmd>lua repeat_ft(true)<cr>', {noremap = true, silent = true})

-- Match up
vim.g.matchup_matchparen_offscreen = {method = 'popup'}

-- Gitsigns
require("gitsigns").setup {
    signs = {
        add = {hl = 'GitGutterAdd', text = '▌', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
        change = {hl = 'GitGutterChange', text = '▌', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
        delete = {hl = 'GitGutterDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        topdelete = {hl = 'GitGutterDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        changedelete = {hl = 'GitGutterChangeDelete', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
    },
    keymaps = {
        buffer = true,
        noremap = true,

        -- Text objects
        ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
    },
    numhl = false,
    linehl = false,
    watch_index = {interval = 100},
    update_debounce = 100,
    sign_priority = 5,
    status_formatter = nil -- Use default
}

-- -- Sneak
-- vim.g['sneak#prompt'] = '  '

-- Indent blank line
vim.g.indent_blankline_buftype_exclude = {'terminal'}
vim.g.indent_blankline_filetype_exclude = {
    'help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'man', 'sagasignature', 'sagahover', 'lspsagafinder', 'LspSagaCodeAction',
    'TelescopePrompt', 'NvimTree', 'LspTrouble'
}
vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
    'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block', 'arguments', 'if_statement',
    'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement', 'operation_type'
}

-- Startify
vim.g.startify_custom_header = {
    '                                                  ',
    '    ████████╗██╗  ██╗██████╗  ██████╗ ███╗   ███╗ ',
    '    ╚══██╔══╝██║ ██╔╝██╔══██╗██╔═══██╗████╗ ████║ ',
    '       ██║   █████╔╝ ██████╔╝██║   ██║██╔████╔██║ ',
    '       ██║   ██╔═██╗ ██╔══██╗██║   ██║██║╚██╔╝██║ ',
    '       ██║██╗██║  ██╗██║  ██║╚██████╔╝██║ ╚═╝ ██║ ',
    '       ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝ ',
    '                                                  '
}

vim.g.webdevicons_enable_startify = 1
vim.g.startify_session_dir = os.getenv('HOME') .. '/.config/nvim/sessions'
vim.g.startify_session_delete_buffers = 1

-- folke/lsp-trouble.nvim
require("trouble").setup {
    height = 10, -- height of the trouble list
    icons = true, -- use devicons for filenames
    mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    action_keys = { -- key mappings for actions in the trouble list
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<tab>"}, -- jump to the diagnostic or open / close folds
        jump_close = {}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small poup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za", 'o'}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = ""
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

-- symbols-outline.nvim
vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false, -- experimental
    position = 'right',
    keymaps = {close = "<Esc>", goto_location = "<Cr>", focus_location = "o", hover_symbol = "<C-space>", rename_symbol = "r", code_actions = "a"},
    lsp_blacklist = {}
}
