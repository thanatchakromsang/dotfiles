-- lightspeed
require'lightspeed'.setup {
    jump_to_unique_chars = {safety_timeout = 400},
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 10,
}

-- Lightspeed
vim.api.nvim_exec([[
  hi! LightspeedGreyWash guifg=none guibg=none
]], false)
