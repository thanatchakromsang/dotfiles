require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "c", "cpp", "css", "comment", "dockerfile", "go", "gomod", "javascript", "json", "jsdoc", "lua", "make", "python", "scala",
        "typescript", "tsx", "vim", "yaml", "zig", "nix", "graphql"
    },

    highlight = {
        enable = true -- false will disable the whole extension
    },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },

    autotag = {enable = true},
    rainbow = {enable = true},

    refactor = {
        -- smart_rename = {
        --     enable = true,
        -- },
    },

    context_commentstring = {enable = true, enable_autocmd = false, config = {nix = "# %s"}},

    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@class.outer", ["ic"] = "@class.inner"}
        }
    }
}

-- Fold
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99
