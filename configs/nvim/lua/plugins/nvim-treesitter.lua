require'nvim-treesitter.configs'.setup {
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

    match_up = {enable = true},

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
vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.o.fillchars = "fold: "
vim.wo.foldnestmax = 20
vim.wo.foldminlines = 1
-- TODO: AutoSaveFolds not working not sure why, might have to dig into various Augroup something might mess with fold
-- vim.api.nvim_command([[
--   augroup AutoSaveFolds
--     autocmd!
--     autocmd BufWinLeave * mkview
--     autocmd BufWinEnter * silent loadview
--   augroup END
-- ]])

require('ts_context_commentstring').setup {
  enable_autocmd = false,
  languages = {
    nix = '# %s',
  },
}
