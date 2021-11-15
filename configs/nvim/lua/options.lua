local opt = vim.opt
local wo = vim.wo

-- don't write ShaDa on startup
opt.shadafile = "NONE"

-- Editor scoped options
opt.hidden = true -- Required to keep multiple buffers open multiple buffers
opt.pumheight = 10 -- Makes popup menu smaller
opt.fileencoding = "utf-8" -- The encoding written to file
opt.cmdheight = 1 -- Space for displaying messages
opt.mouse = "a" -- Enable mouse support
opt.splitright = true -- Vertical splits will automatically be to the right
opt.splitbelow = true -- Horizontal splits will automatically be below
opt.conceallevel = 0 -- So that I can see `` in markdown files
opt.showtabline = 2 -- Always show tabs
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.backup = false -- Disable backup
opt.writebackup = false -- Disable backup
opt.swapfile = false -- Disable because save time is huge
opt.updatetime = 50 -- Faster completion
opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
opt.autoread = true -- Detect and update file have been changed outside vim
opt.backspace = "indent,eol,start" -- Fix backsoace indentation
opt.completeopt = "menu,menuone,noselect" -- Enable completion
opt.scrolloff = 10 -- Cursor move offset
opt.sidescrolloff = 5 -- Cursor move sideway by 5
opt.showbreak = "↳"
opt.wildignorecase = true
opt.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**";
opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"
opt.expandtab = true -- Converts tabs to spaces
opt.smartindent = true -- Makes indenting smart
opt.ignorecase = true -- Lowercase will be insensitive when search
opt.smartcase = true -- Uppercase will be sensitive when search
opt.lazyredraw = true -- Improve load time on large files
-- opt.shell = "bash" -- enable this if zsh slow down vim

opt.tabstop = 2 -- Insert 2 spaces for a tab
opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
opt.colorcolumn = "80,120" -- add column lines to limit character to 80 and 120 respectively

opt.iskeyword:append("-") -- treat dash separated words as a word text object"
opt.shortmess:append("casI") -- Don't pass messages to |ins-completion-menu|.

-- Window scoped options
wo.wrap = true -- Word wrapping, but only line breaks inserted when explicitly press enter
wo.linebreak = true
wo.list = true
wo.numberwidth = 1 -- Width of gutter
wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
wo.cursorline = false -- Highlight current line
wo.number = true -- Show number line
wo.relativenumber = true -- Show relative to current line number instead

local disabled_built_ins = {
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

vim.api.nvim_command([[
    augroup TerminalOptions
        autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
    augroup END
]])
