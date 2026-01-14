-- -- lightspeed
-- require'lightspeed'.setup {
--     jump_to_unique_chars = {safety_timeout = 400},
--     match_only_the_start_of_same_char_seqs = true,
--     limit_ft_matches = 10,
-- }

local leap = require('leap')

-- Set up sneak-style mappings (replacing deprecated create_default_mappings)
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')

leap.opts.safe_labels = {}

