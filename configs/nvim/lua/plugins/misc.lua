local M = {}

M.matchup = function()
  vim.g.matchup_matchparen_offscreen = {method = 'popup'}
end

M.comment = function()
  require('nvim_comment').setup({
      -- Linters prefer comment and line to have a space in between markers
      marker_padding = true,
      -- should comment out empty or whitespace only lines
      comment_empty = false,
      -- Should key mappings be created
      create_mappings = true
  })
end

return M
