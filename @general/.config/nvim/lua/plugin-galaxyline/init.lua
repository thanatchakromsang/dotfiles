local gl = require("galaxyline")
local gls = gl.section
local condition = require('galaxyline.condition')

gl.short_line_list = {'nerdtree', 'vista', 'packer', 'NvimTree', 'dbui'}

local colors = {
    bg = "#282828",
    bg1 = "#3c3836",
    bg3 = "#665c54",
    fg = "#ebdbb2",
    fg3 = "#bdae93",
    yellow = "#d79921",
    green = "#98971a",
    orange = "#d65d0e",
    purple = "#b16286",
    blue = "#458588",
    aqua = "#689d6a",
    red = "#cc241d",
    gray = "#a89984",
    light_red = "#fb4934",
    light_green = "#b8bb26",
    light_yellow = "#fabd2f",
    light_blue = "#83a598",
    light_purple = "#d3869b",
    light_aqua = "#8ec07c",
    light_orange = "#fe8019",
}

gls.left[1] = {
    ViMode = {
        provider = function()
            local mode_color = {
                n      = colors.fg3,
                i      = colors.light_blue,
                c      = colors.light_purple,
                V      = colors.light_orange,
                [""] = colors.light_orange,
                v      = colors.light_orange,
                R      = colors.light_aqua,
                Rv     = colors.light_aqua,
                t      = colors.green,
                no     = colors.blue,
                s      = colors.orange,
                S      = colors.orange,
                ic     = colors.yellow,
                cv     = colors.blue,
                ce     = colors.blue,
                r      = colors.fg3,
                rm     = colors.fg3,
                ['!']  = colors.red,
                ['r?'] = colors.fg3,
            }
            local alias = {
                n      = "  N ",
                i      = "  I ",
                c      = "  C ",
                V      = "  V ",
                [""] = "  V ",
                v      = "  V ",
                R      = "  R ",
                Rv     = "  R ",
                t      = "  T ",
                ['!']  = "  S ",
                no     = "  N ",
                s      = "  S ",
                S      = "  S ",
                [''] = "  S ",
                ic     = "  I ",
                cv     = "  C ",
                ce     = "  C ",
                r      = "  R ",
                rm     = "  R ",
                ['r?'] = "  R "
            }
            vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.bg, colors.fg},
    }
}

gls.left[2] = {
    Space = {
        provider = function()
            return ' '
        end,
        condition = condition.buffer_not_empty,
        highlight = {'NONE', colors.bg3},
    }
}

gls.left[3] ={
  FileIcon = {
    provider = {'FileIcon'},
    condition = condition.buffer_not_empty,
    -- highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg3 },
    highlight = { colors.fg, colors.bg3 },
  }
}

gls.left[4] = {
  FileName = {
    provider = {'FileName'},
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.bg3 },
    separator = '',
    separator_highlight = {colors.bg3, colors.bg1},
  }
}

gls.left[5] = {
    SpaceGit = {
        provider = function()
            return ' '
        end,
        highlight = {'NONE', colors.bg1},
    }
}

gls.left[6] = {
    GitIcon = {
        provider = function()
            return ''
        end,
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {'NONE', colors.bg1},
        highlight = {colors.light_red, colors.bg1}
    }
}

gls.left[7] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = condition.check_git_workspace,
        separator = ' ',
        separator_highlight = {colors.bg, colors.bg1},
        highlight = {colors.fg, colors.bg1}
    }
}


gls.left[8] = {
    DiffAdd = {
        provider = {'DiffAdd'},
        condition = condition.hide_in_width,
        icon = '+',
        highlight = {colors.light_green, colors.bg1}
    }
}

gls.left[9] = {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = '~',
        highlight = {colors.light_aqua, colors.bg1}
    }
}

gls.left[10] = {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '-',
        highlight = {colors.light_red, colors.bg1}
    }
}

gls.left[11] = {
    LeftBackgroundHighlight = {
        provider = function()
            return ''
        end,
        separator = '',
        separator_highlight = {'NONE', colors.bg1}
    }
}

---------------------------------------------------------------------------------------------

gls.right[1] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.light_red, colors.bg1}
    }
}
gls.right[2] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.light_yellow, colors.bg1}
    }
}

gls.right[3] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = {colors.light_blue, colors.bg1}
    }
}

gls.right[4] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = {colors.light_green, colors.bg1},
    }
}

gls.right[6] = {
    LineInfo = {
        provider = 'LineColumn',
        highlight = {colors.fg, colors.bg1}
    }
}

gls.right[7] = {
    Percent = {
        provider = 'LinePercent',
        highlight = {colors.bg, colors.fg3},
        separator = ' ',
        separator_highlight = {colors.bg3, colors.bg1}
    }
}

-------------------------------------------------------

gls.short_line_left[1] = {
    SpaceShort = {
        provider = function()
            return ' '
        end,
        condition = function()
          if vim.fn.empty(vim.bo.filetype) ~= 1 then
            return true
          end
          return false
        end,
        highlight = {'NONE', colors.fg3},
    }
}

gls.short_line_left[2] = {
  BufferType = {
    provider = 'FileTypeName',
    condition = function()
      if vim.fn.empty(vim.bo.filetype) ~= 1 then
        return true
      end
      return false
    end,
    highlight = {colors.bg,colors.fg3},
    separator = ' ',
    separator_highlight = {'NONE', colors.fg3},
  }
}

gls.short_line_left[3] = {
    ShortLeftBackgroundHighlight = {
        provider = function()
            return ''
        end,
        separator = '',
        separator_highlight = {'NONE', colors.bg1}
    }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    condition = condition.buffer_not_empty,
    highlight = {colors.bg, colors.fg3}
  }
}
