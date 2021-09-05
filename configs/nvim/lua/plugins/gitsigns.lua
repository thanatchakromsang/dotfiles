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
