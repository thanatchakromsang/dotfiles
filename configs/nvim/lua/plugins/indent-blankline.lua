-- Indent blank line
require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true, -- underline first line
    use_treesitter = true,
    char = '▏',
    filetype_exclude = {
        'help', 'startify', 'dashboard', 'packer', 'neogitstatus', 'man', 'sagasignature', 'sagahover', 'lspsagafinder', 'LspSagaCodeAction',
        'TelescopePrompt', 'NvimTree', 'LspTrouble'
    },
    buftype_exclude = {'terminal'},
    context_patterns = {
        'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block', 'arguments', 'if_statement',
        'else_clause', 'jsx_element', 'jsx_self_closing_element', 'try_statement', 'catch_clause', 'import_statement', 'operation_type'
    },
    show_trailing_blankline_indent = false,
}
