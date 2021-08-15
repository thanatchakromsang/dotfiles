-- Neogit
require("neogit").setup {
    disable_signs = false,
    disable_context_highlighting = true,
    disable_commit_confirmation = false,
    -- customize displayed signs
    signs = {section = {"", ""}, item = {"", ""}},
    integrations = {
        -- Requires you to have `sindrets/diffview.nvim` installed.
        -- use {
        --   'TimUntersberger/neogit',
        --   requires = {
        --     'nvim-lua/plenary.nvim',
        --     'sindrets/diffview.nvim'
        --   }
        -- }
        --
        diffview = true
    },
    -- override/add mappings
    mappings = {
        -- modify status buffer mappings
        status = {
            -- Adds a mapping with "B" as key that does the "BranchPopup" command
            ["B"] = "BranchPopup",
            ["b"] = "",
            ["za"] = "Toggle"
        }
    }
}
