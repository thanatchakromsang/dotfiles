require("which-key").setup {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    presets = {
        operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = false -- bindings for prefixed with g
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "double", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = {"<leader>", "<localleader>", "g", "\'", "\"", "<C-r>", "z"} -- automatically setup triggers
}

local wk = require("which-key")

-- Normal Leader
wk.register({
    ["<leader>"] = {
        name = "leader",
        [" "] = {"fold toggle"},
        e = "explorer toggle",
        r = {":FloatermNew --height=0.8 --width=0.8 --name=ranger --wintype=float ranger<CR>", "ranger"},
        o = {":SymbolsOutline<CR>", "outline"},
        p = {
            name = "+packer",
            u = {":PackerUpdate<CR>", "update"},
            i = {":PackerInstall<CR>", "install"},
            c = {":PackerCompile<CR>", "compile"},
            C = {":PackerClean<CR>", "clean"},
            s = {":PackerSync<CR>", "sync"}
        },
        f = {
            name = "+find",
            ['.'] = {":Telescope filetypes<CR>", "filetypes"},
            B = {":Telescope git_branches<CR>", "git branches"},
            s = {":Telescope lsp_document_symbols<CR>", "document diagnostics"},
            d = {":Telescope lsp_document_diagnostics<CR>", "document diagnostics"},
            D = {":Telescope lsp_workspace_diagnostics<CR>", "workspace diagnostics"},
            f = {":Telescope find_files<CR>", "find files"},
            g = {":Telescope git_files<CR>", "find git files"},
            h = {":Telescope command_history<CR>", "command history"},
            i = {":Telescope media_files<CR>", "media files"},
            m = {":Telescope marks<CR>", "marks"},
            o = {":Telescope vim_options<CR>", "vim options"},
            t = {":Telescope live_grep<CR>", "text"},
            b = {":Telescope buffers<CR>", "buffers"},
            q = {":Telescope quickfix<CR>", "quickfix"},
            l = {":Telescope loclist<CR>", "loclist"},
            c = {":Telescope git_commits<CR>", "git current file history"},
            C = {":Telescope git_commits<CR>", "git history"},
        },
        s = {
            name = "+startify",
            s = {":SSave<CR>", "save session"},
            l = {":SLoad<CR>", "load session"},
            d = {":SDelete<CR>", "delete session"},
            c = {":SClose<CR>", "close session"},
            h = {":Startify<CR>", "home"}
        },
        g = {
            name = "+git",
            d = {":Gdiffsplit<CR>", "git diff"},
            g = {":FloatermNew --height=0.9 --width=0.9 --name=git --wintype=float lazygit<CR>", "lazygit"},
            S = {":Telescope git_stash<CR>", "git stash"},
            c = {":Telescope git_bcommits<CR>", "git current file history"},
            C = {":Telescope git_commits<CR>", "git history"},
            p = {"go to prev hunk"},
            n = {"go to next hunk"},
            s = {"stage hunk"},
            u = {"undo stage hunk"},
            r = {"reset hunk"},
            R = {"reset buffer"},
            P = {"preview hunk"},
            B = {"browse git"},
            b = {name = "+blame", l = {"blame line"}, b = {":Git blame<CR>", "blame buffer"}}
        },
        t = {
            name = "+terminal",
            g = {":FloatermNew --height=0.9 --width=0.9 --wintype=float --name=git lazygit<CR>", "lazygit"},
            d = {":FloatermNew --height=0.8 --width=0.8 --wintype=float --name=docker lazydocker<CR>", "docker"},
            r = {":FloatermNew --height=0.8 --width=0.8 --wintype=float --name=ranger ranger<CR>", "ranger"},
            h = {":FloatermNew --height=0.8 --width=0.8 --wintype=float --name=htop htop<CR>", "htop"},
            t = {":FloatermToggle<CR>", "toggle"}
        },
        T = {
            name = "+trouble",
            t = "toggle",
            w = "workspace diagnostics",
            d = "document diagnostics",
            l = "local list",
            q = "quickfix list"
        }
    }
}, {
    mode = "n", -- NORMAL mode
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
})

wk.register({["<leader>"] = {name = "leader", g = {name = "+git", B = {"browse git visual line"}}}}, {
    mode = "v",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
})

-- Normal Local Leader
wk.register({
    ["<localleader>"] = {
        name = "localleader",
        ['.'] = "set working dir",
        a = "code action",
        b = "horizontal split",
        c = "close buffer",
        d = {name = "+dap", t = "toggle breakpoint", l = "log breakpoint", r = "repl open"},
        f = "code format",
        v = "vertical split",
        w = "close window",
        r = "rename"
    }
}, {
    mode = "n", -- NORMAL mode
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
})

wk.register({["<localleader>"] = {name = "localleader", a = "range code action", f = "range code format"}}, {
    mode = "v", -- NORMAL mode
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
})

-- Normal G
wk.register({
    g = {
        name = "goto",
        d = "definition",
        D = "declaration",
        n = "next diagnostic",
        p = "prev diagnostic",
        i = "implementation",
        r = "reference",
        t = "type definition",
        R = "references",
        s = "signature help"
    }
}, {
    mode = "n", -- NORMAL mode
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
})
