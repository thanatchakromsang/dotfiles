{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { config, ... }: {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;

      plugins = with pkgs.vimPlugins; [
        # LSP
        nvim-lspconfig
        vim-illuminate
        todo-comments-nvim
        trouble-nvim
        null-ls-nvim
        symbols-outline-nvim

        # Debugging
        nvim-dap
        nvim-dap-ui

        # Test
        vim-test

        # Autocomplete
        nvim-cmp
        cmp-buffer
        cmp-nvim-lsp
        cmp-path
        cmp-cmdline
        cmp-treesitter
        luasnip
        cmp_luasnip
        friendly-snippets

        # Treesitter
        nvim-treesitter.withAllGrammars
        playground
        rainbow-delimiters-nvim
        nvim-ts-context-commentstring
        nvim-treesitter-refactor
        nvim-treesitter-textobjects
        refactoring-nvim

        # Syntax without Treesitter support
        vim-jsonnet
        vim-terraform
        vim-helm

        # Icons
        vim-devicons
        nvim-web-devicons

        # Appearance, Status Line and Bufferline
        gruvbox-material
        lualine-nvim
        bufferline-nvim

        # Indentation
        indent-blankline-nvim

        # Telescope
        plenary-nvim
        telescope-nvim
        popup-nvim
        telescope-media-files-nvim

        # Explorer
        neo-tree-nvim
        nui-nvim

        # Git
        neogit
        gitsigns-nvim
        diffview-nvim
        vim-fugitive
        vim-rhubarb
        fugitive-gitlab-vim

        # General Plugins
        editorconfig-vim
        lightspeed-nvim
        lualine-nvim
        vim-rooter
        vim-startify
        vim-bbye
        nvim-comment
        which-key-nvim # I can't remember hotkey
        nvim-autopairs
        vim-matchup
        vim-floaterm
        vim-repeat
        vim-surround
        targets-vim # vim text object on steroid
        vim-tmux-navigator # tmux integration

        impatient-nvim
      ];
    };

    # ~/.config symlinks
    xdg.configFile.nvim = {
      source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/configs/nvim");
      recursive = true;
    };
  };
}
