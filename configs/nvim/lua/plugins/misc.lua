vim.g.matchup_matchparen_offscreen = {method = 'popup'}

-- NVIM Comment
require('nvim_comment').setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true,
    hook = function() require("ts_context_commentstring.internal").update_commentstring() end
})

-- TMUX
vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_disable_when_zoomed = 1
