local map = vim.api.nvim_set_keymap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- no one is really happy until have this shortcuts
vim.cmd([[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]])

map('n', '<space><space>', 'za', {silent = true})

-- better window movement
map('n', '<c-h>', '<c-w>h', {silent = true})
map('n', '<c-j>', '<c-w>j', {silent = true})
map('n', '<C-k>', '<C-w>k', {silent = true})
map('n', '<C-l>', '<C-w>l', {silent = true})

map('n', '<c-Left>', '<c-w>h', {silent = true})
map('n', '<c-Down>', '<c-w>j', {silent = true})
map('n', '<C-Up>', '<C-w>k', {silent = true})
map('n', '<C-Right>', '<C-w>l', {silent = true})

-- PageUp PageDown movement up/down 5 lines
map('', '<PageUp>', '10<C-U>', {silent = true})
map('', '<PageDown>', '10<C-D>', {silent = true})

-- Move text
map('x', 'K', ':move \'<-2<CR>gvgv', {noremap = true, silent = true})
map('x', 'J', ':move \'>+1<CR>gv-gv', {noremap = true, silent = true})
map('i', '<C-j>', '<esc>:m .+1<CR>==', {noremap = true, silent = true})
map('i', '<C-k>', '<esc>:m .-2<CR>==', {noremap = true, silent = true})

-- better indenting
map('v', '<', '<gv', {noremap = true, silent = true})
map('v', '>', '>gv', {noremap = true, silent = true})

-- ThePrimeagen recommended https://www.youtube.com/watch?v=hSHATqh8svM
map('n', 'Y', 'yg_', {noremap = true}) -- Yank to end of line
map('v', 'y', 'myy`y', {noremap = true}) -- Set mark after visual yanks
map('v', 'Y', 'myY`y', {noremap = true}) -- Set mark after visual yanks

-- keeping things centered
map('n', 'n', 'nzzzv', {noremap = true})
map('n', 'N', 'Nzzzv', {noremap = true})
map('n', 'J', 'mzJ`z', {noremap = true})

-- Undo break points
map('i', ',', ',<c-g>u', {noremap = true})
map('i', '.', '.<c-g>u', {noremap = true})
map('i', '!', '!<c-g>u', {noremap = true})
map('i', '?', '?<c-g>u', {noremap = true})

-- Change word
map('n', 'cn', '*``cgn', {noremap = true})
map('n', 'cN', '*``cgN', {noremap = true})

-- FIX: should not occur in Telescope -- Jumplist mutations
-- map('i', 'k', "(v:count > 5 ? \"m'\") . v:count : \"\") . 'k'", {noremap = true, expr = true})
-- map('i', 'j', "(v:count > 5 ? \"m'\") . v:count : \"\") . 'j'", {noremap = true, expr = true})

map('n', '<ESC>', ':noh<CR>', {noremap = true, silent = true}) -- Remove search highlight after esc

-- -- navigate between display lines
-- map('n', 'k', 'v:count == 0 ? "gk" : "k"', {noremap = true, expr = true})
-- map('n', 'j', 'v:count == 0 ? "gj" : "j"', {noremap = true, expr = true})
-- map('n', '<Up>', 'v:count == 0 ? "gk" : "k"', {noremap = true, expr = true})
-- map('n', '<Down>', 'v:count == 0 ? "gj" : "j"', {noremap = true, expr = true})

-- no need for ex mode
map('n', 'Q', '<nop>', {noremap = true, silent = true})

-- Bufferline
map('n', '<TAB>', '<cmd>BufferLineCycleNext<CR>', {noremap = true, silent = true})
map('n', '<S-TAB>', '<cmd>BufferLineCyclePrev<CR>', {noremap = true, silent = true})

-- Gitsigns
map('n', '<leader>gs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gP', '<cmd>lua require"gitsigns".preview_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gn', '<cmd>lua require"gitsigns".next_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gp', '<cmd>lua require"gitsigns".prev_hunk()<CR>', {noremap = true, silent = true})
map('n', '<leader>gb', '<cmd>lua require"gitsigns".blame_line()<CR>', {noremap = true, silent = true})
map('n', '<leader>gdd', '<cmd>Gitsigns diffthis<CR>', {noremap = true, silent = true})

-- Fugitive
map('', '<leader>gB', '<cmd>GBrowse!<CR>', {noremap = true, silent = true})

-- Diffview.nvim
map('n', '<leader>gdo', '<cmd>DiffviewOpen<CR>', {noremap = true, silent = true})
map('n', '<leader>gdc', '<cmd>DiffviewClose<CR>', {noremap = true, silent = true})
map('n', '<leader>gdr', '<cmd>DiffviewRefresh<CR>', {noremap = true, silent = true})

-- split
map('n', '<localleader>b', '<cmd>split<CR>', {noremap = true, silent = true})
map('n', '<localleader>v', '<cmd>vsplit<CR>', {noremap = true, silent = true})

-- local leader misc
map('n', '<localleader>c', '<cmd>Bdelete<CR>', {noremap = true, silent = true})
map('n', '<localleader>w', '<cmd>close<CR>', {noremap = true, silent = true})
map('n', '<localleader>.', '<cmd>lcd %:p:h<CR>', {noremap = true, silent = true}) -- set current working dir
map('n', '<localleader>R', '<cmd>Rooter<CR>', {noremap = true, silent = true}) -- set current working dir

-- Trouble
map("n", "<F11>", "<cmd>TroubleToggle<CR>", {silent = true, noremap = true})
map("n", "<leader>Tt", "<cmd>TroubleToggle<CR>", {silent = true, noremap = true})
map("n", "<leader>Tw", "<cmd>TroubleToggle workspace_diagnostics<CR>", {silent = true, noremap = true})
map("n", "<leader>Td", "<cmd>TroubleToggle document_diagnostics<CR>", {silent = true, noremap = true})
map("n", "<leader>Tl", "<cmd>TroubleToggle loclist<CR>", {silent = true, noremap = true})
map("n", "<leader>Tq", "<cmd>TroubleToggle quickfix<CR>", {silent = true, noremap = true})
map("n", "<leader>TT", "<cmd>TodoTrouble<CR>", {silent = true, noremap = true})
map("n", "gR", "<cmd>Trouble lsp_references<CR>", {silent = true, noremap = true})

-- Neotree
map("n", "<leader>e", "<cmd>NeoTreeFocusToggle<CR>", {silent = true, noremap = true})

-- Telescope
map('n', 'gb', '<cmd>Telescope buffers<CR>', {noremap = true, silent = true})

-- Test.vim
map('n', '<leader>tt', '<cmd>TestNearest -strategy=neovim<CR>', {noremap = true, silent = true})
map('n', '<leader>tf', '<cmd>TestFile -strategy=neovim<CR>', {noremap = true, silent = true})
map('n', '<leader>tl', '<cmd>TestLast -strategy=neovim<CR>', {noremap = true, silent = true})
map('n', '<leader>tv', '<cmd>TestVisit -strategy=neovim<CR>', {noremap = true, silent = true})
map('n', '<leader>ts', '<cmd>TestSuite -strategy=neovim<CR>', {noremap = true, silent = true})

-- Refactoring.nvim
map("v", "<leader>r", "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", { noremap = true })

-- Packer commands till because we are not loading it at startup
vim.cmd("silent! command PackerCompile lua require 'plugin-list' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'plugin-list' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'plugin-list' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'plugin-list' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'plugin-list' require('packer').update()")
