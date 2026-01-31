{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { config, ... }: {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;

      extraPackages = with pkgs; [
        # Typescript
        nodePackages.typescript-language-server

        # Kubernetes
        helm-ls

        # Shell
        shellcheck
        shfmt
        nodePackages.bash-language-server

        # Lua
        lua-language-server
        stylua

        # Docker
        dockerfile-language-server

        # Vim
        nodePackages.vim-language-server

        # YAML
        nodePackages.yaml-language-server

        # Terraform
        terraform-ls
      ];

      plugins = with pkgs.vimPlugins; [
        # LSP
        nvim-lspconfig
        vim-illuminate
        todo-comments-nvim
        trouble-nvim
        none-ls-nvim
        symbols-outline-nvim
        conform-nvim
        nvim-lint

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
        rainbow-delimiters-nvim
        nvim-ts-context-commentstring
        refactoring-nvim

        # OpenCode
        opencode-nvim
        snacks-nvim
        dressing-nvim
        render-markdown-nvim

        # Syntax without Treesitter support
        vim-jsonnet
        vim-terraform
        vim-helm

        # Icons
        vim-devicons
        nvim-web-devicons
        mini-nvim # provides mini.icons and other mini modules

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
        nvim-tree-lua
        nui-nvim

        # Git
        gitsigns-nvim
        diffview-nvim
        vim-fugitive
        vim-rhubarb
        fugitive-gitlab-vim

        # General Plugins
        editorconfig-vim
        leap-nvim
        lualine-nvim
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
      ];
    };

    # ~/.config symlinks
    xdg.configFile.nvim = {
      source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/configs/nvim");
      recursive = true;
    };
  };
}
