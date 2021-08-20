-- lightspeed
require'lightspeed'.setup {
    jump_to_first_match = false,
    jump_on_partial_input_safety_timeout = 400,
    highlight_unique_chars = false,
    grey_out_search_area = false,
    match_only_the_start_of_same_char_seqs = true,
    limit_ft_matches = 10,
    full_inclusive_prefix_key = '<c-x>'
}

-- use native f,t for navigation after load
vim.cmd('unmap f')
vim.cmd('unmap F')
vim.cmd('unmap t')
vim.cmd('unmap T')
