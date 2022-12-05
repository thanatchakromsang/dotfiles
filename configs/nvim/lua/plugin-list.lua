vim.cmd("packadd packer.nvim")

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end

return require("packer").startup(function(use)
	-- Packer can manage itself as an optional plugin
	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})

	-- Information
	use("nanotee/nvim-lua-guide")

	-- Quality of life improvements
	use("norcalli/nvim_utils")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = "RRethy/vim-illuminate",
		config = function()
			require("lsp.lspconfig")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		-- config = function()
		--     require 'lsp.null-ls'
		-- end,
	})
	use({
		"folke/trouble.nvim",
		config = function()
			require("lsp.trouble")
		end,
	})
	use({
		"folke/todo-comments.nvim",
		branch = "main",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("plugins.todo-comments")
		end,
	})
	-- use 'kosayoda/nvim-lightbulb'
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins.symbols-outline")
		end,
	})

	-- Debugging
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("lsp.dap")
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		after = "nvim-dap",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("lsp.dap-ui")
		end,
	})

	-- Test
	use("vim-test/vim-test")

	-- Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- 'ray-x/cmp-treesitter',
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			"nvim-treesitter/playground",
			"p00f/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		run = ":TSUpdate",
		config = function()
			require("plugins.nvim-treesitter")
		end,
	})
	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({})
		end,
	})

	-- Individual Syntax highlights without Treesitter support
	use("google/vim-jsonnet")
	use("hashivim/vim-terraform")

	-- Icons
	use("ryanoasis/vim-devicons")
	use("kyazdani42/nvim-web-devicons")

	-- Appearance, Status Line and Bufferline
	use({
		"sainnhe/gruvbox-material",
		config = function()
			require("theme")
		end,
	})
	use({
		"nvim-lualine/lualine.nvim",
		after = "gruvbox-material",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- Indentation
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.indent-blankline")
		end,
	})

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	use("nvim-lua/popup.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Explorer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				-- only needed if you want to use the "open_window_picker" command
				"s1n7ax/nvim-window-picker",
				tag = "1.*",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
		config = function()
			require("plugins.neo-tree")
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"TimUntersberger/neogit",
		cmd = { "Neogit", "Neogit kind=vsplit" },
		requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
		config = function()
			require("plugins.neogit")
		end,
	})
	use({
		"tpope/vim-fugitive",
		requires = { "shumphrey/fugitive-gitlab.vim", "tpope/vim-rhubarb" },
	})

	-- General Plugins
	use("editorconfig/editorconfig-vim")
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.nvim-autopairs")
		end,
	})
	use({
		"ggandor/lightspeed.nvim", -- quickscope, sneak replacement
		config = function()
			require("plugins.lightspeed")
		end,
	})
	use({
		"airblade/vim-rooter",
		config = function()
			require("plugins.vim-rooter")
		end,
	})
	use({
		"mhinz/vim-startify",
		config = function()
			require("plugins.startify")
		end,
	})
	-- use 'psliwka/vim-smoothie' -- smooth scrolling
	use("moll/vim-bbye")
	use({
		"terrortylor/nvim-comment",
		config = function()
			require("plugins.misc").comment()
		end,
	})
	use({
		"folke/which-key.nvim", -- i can't remember hotkey
		config = function()
			require("plugins.which-key")
		end,
	})
	use({
		"voldikss/vim-floaterm", -- floating terminal
		config = function()
			require("plugins.vim-floaterm")
		end,
	})
	use({
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			require("plugins.misc").matchup()
		end,
	})
	use("tpope/vim-repeat")
	use("tpope/vim-surround")
	use("wellle/targets.vim") -- vim text object on steroid
	use({
		"christoomey/vim-tmux-navigator",
		config = function()
			require("plugins.misc").tmux()
		end,
	})
end)
