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

function Repeat_ft(reverse)
    local ls = require 'lightspeed'
    ls.ft['instant-repeat?'] = true
    ls.ft:to(reverse, ls.ft['prev-t-like?'])
end
vim.api.nvim_set_keymap('n', ';', '<cmd>lua Repeat_ft(false)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ';', '<cmd>lua Repeat_ft(false)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', ',', '<cmd>lua Repeat_ft(true)<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', ',', '<cmd>lua Repeat_ft(true)<cr>', {noremap = true, silent = true})
