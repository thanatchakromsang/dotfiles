local colors = {
    light_red = "#ea6962",
    light_green = "#a9b665",
    light_yellow = "#d8a657",
    light_blue = "#7daea3",
    light_purple = "#d3869b",
    light_aqua = "#89b482",
    light_orange = "#e78a4e"
}

require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = {left = '', right = '|'},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {'packer', 'neo-tree', 'dbui', 'Trouble'},
        always_divide_middle = true,
        globalstatus = true
    },
    sections = {
        lualine_a = {{'mode', fmt = function(str) return str:sub(1, 1) end}},
        lualine_b = {{'branch'}, {'buffer'}},
        lualine_c = {
            {'filename', path = 1}, {
                'diff',
                diff_color = {
                    added = {fg = colors.light_green}, -- changes diff's added color
                    modified = {fg = colors.light_aqua}, -- changes diff's modified color
                    removed = {fg = colors.light_red} -- changes diff's removed color
                }
            }
        },
        lualine_x = {
            {
                'diagnostics',
                diagnostics_color = {
                    error = {fg = colors.light_red}, -- changes diagnostic's error color
                    warn = {fg = colors.light_yellow}, -- changes diagnostic's warn color
                    info = {fg = colors.light_green}, -- Changes diagnostic's info color
                    hint = {fg = colors.light_blue} -- Changes diagnostic's hint color
                },
                symbols = {error = '  ', warn = '  ', info = '  ', hint = '  '},
                sources = {'nvim_lsp'}
            }, {'filetype'}, {'fileformat'}
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    extensions = {'symbols-outline', 'quickfix', 'neo-tree'}
}
