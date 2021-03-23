-- vim.cmd [[packadd packer.nvim]]

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end


vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- Information
    use 'nanotee/nvim-lua-guide'

    -- Quality of life improvements
    use 'norcalli/nvim_utils'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'mfussenegger/nvim-jdtls'

    -- Debugging
    use 'mfussenegger/nvim-dap'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'xabikos/vscode-javascript'
    use 'cstrap/python-snippets'
    use 'dsznajder/vscode-es7-javascript-react-snippets'
    use 'golang/vscode-go'
    use 'rust-lang/vscode-rust'
    -- use 'hrsh7th/vim-vsnip-integ'
    -- use 'honza/vim-snippets'
    -- use 'epilande/vim-react-snippets'
    -- use 'ylcnfrht/vscode-python-snippet-pack'
    -- use 'SirVer/ultisnips'
    -- use 'norcalli/snippets.nvim'

    -- Syntax Highlight
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use 'p00f/nvim-ts-rainbow'
    use 'sheerun/vim-polyglot'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Status Line and Bufferline
    use {
	'glepnir/galaxyline.nvim',
	branch = main,
	requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
    use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-media-files.nvim'

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Appearance
    use 'morhetz/gruvbox'
    -- use {'RRethy/vim-hexokinase', run = 'make hexokinase'} -- XXX: Enable when work more with colors
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'} -- TODO: Switch to master branch once neovim 0.5 officially release

    -- Git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Registers
    use 'gennaro-tedesco/nvim-peekup'

    -- General Plugins
    use 'windwp/nvim-autopairs'
    use 'kevinhwang91/nvim-bqf'
    use 'unblevable/quick-scope' -- find and to keyword on steroid
    use 'airblade/vim-rooter'
    use 'mhinz/vim-startify'
    use 'metakirby5/codi.vim' -- REPL support in vim
    -- use 'psliwka/vim-smoothie' -- smooth scrolling
    use 'moll/vim-bbye'
    use 'terrortylor/nvim-comment'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}
    use 'liuchengxu/vim-which-key' -- i can't remember hotkey
    use 'voldikss/vim-floaterm' -- floating terminal
    use 'liuchengxu/vista.vim'
    use 'svermeulen/vim-yoink' -- sane clipboard history
    use 'junegunn/goyo.vim' -- distraction free writing
    use 'andymass/vim-matchup'
    use 'phaazon/hop.nvim' -- easymotion written in lua
    use 'tpope/vim-sleuth'
    use 'sgur/vim-editorconfig'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim' -- vim text object on steroid

	-- TODO put this back when stable for indent lines
-- 	vim.g.indent_blankline_space_char = ' '
-- 	vim.g.indent_blankline_buftype_exclude = {'terminal'}
-- 	vim.g.indent_blankline_filetype_exclude = {'help', 'startify'}
-- 	vim.g.indent_blankline_char = '▏'
-- 	vim.g.indent_blankline_use_treesitter=true
    -- use 'alvan/vim-closetag'
    -- use 'RRethy/vim-illuminate'
    -- use 'b3nj5m1n/kommentary'
    -- use {
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](1)
    --     end
    -- }
end)