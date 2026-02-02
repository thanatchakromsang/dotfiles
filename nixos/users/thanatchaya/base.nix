{ config, pkgs, lib, ... }:

{
  users.extraUsers.thanatchaya = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "i2c" ];
    shell = pkgs.zsh;
  };

  programs.git = {
    enable = true;
  };

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    home.stateVersion = "25.11";

    nixpkgs.config.allowUnfree = true;

    # config.allowUnfree = true;

    programs.zsh = {
      enable = true;
      history = {
        save = 1000000000;
        size = 1000000000;
      };
      initContent = lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # Add powerlevel10k themes
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        bindkey '^[[1;5A' history-substring-search-up
        bindkey '^[[1;5B' history-substring-search-down

        bindkey '^ ' autosuggest-accept
        bindkey '^p' up-line-or-beginning-search
        bindkey '^n' down-line-or-beginning-search
        bindkey '^H' backward-kill-word

        # Ctrl movement
        bindkey "^[[1;5D" backward-word
        bindkey "^[[1;5C" forward-word

        # Alt movement
        bindkey '^[[1;3D' backward-word
        bindkey '^[[1;3C' forward-word
        bindkey '^[[1;3A' up-line-or-beginning-search
        bindkey '^[[1;3B' down-line-or-beginning-search

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        cat = "${pkgs.bat}/bin/bat";
        grep = "${pkgs.ripgrep}/bin/rg";
        ls = "${pkgs.eza}/bin/eza";
        l = "ls -ln";
        la = "ls -lAn";
        lt = "ls -lth";
        ll = "ls -l";
        ldot = "ls -ld .*";
        k = "${pkgs.kubectl}/bin/kubectl";
        tmp = "vim ~/.tmp.md";
        g = "${pkgs.lazygit}/bin/lazygit";
        r = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd $LASTDIR";
        c = "clear";
        ssh = "TERM=xterm-256color ssh";
        tf = "${pkgs.terraform}/bin/terraform";
      };

      "oh-my-zsh" = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "yarn"
          "node"
          "npm"
          "kubectl"
          "wd"
          "fzf"
          "helm"
          "rust"
          "aws"
          "history-substring-search"
        ];
      };

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.4.0";
            sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
          };
        }
        {
          name = "fzf-tab";
          file = "fzf-tab.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "c7fb028ec0bbc1056c51508602dbd61b0f475ac3";
            sha256 = "061jjpgghn8d5q2m2cd2qdjwbz38qrcarldj16xvxbid4c137zs2";
          };
        }
      ];
    };

    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        serverAliveInterval = 60;
      };
    };

    home.packages = with pkgs; [
      git
      rsync
      htop
      wget
      curl
      inetutils
      unzip
      p7zip
      jq
      yq-go
      vim
      eza
      bat
      stow
      fzf
      fd
      gnupg
      ripgrep
      ranger
      bitwarden-cli
      bitwarden-desktop
      zsh-powerlevel10k
      kubectl

      age
      sops
      ssh-to-age
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      FZF_BASE = "${pkgs.fzf}/share/fzf";
      FZF_DEFAULT_OPTS = "--height 40% --border --reverse";
      FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
      SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.ssh/personal.pri.age.txt";
    };

    # ~/.config symlinks
    xdg.configFile = {
      "ranger" = { source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/configs/ranger"); recursive = true; };
    };

    # ~ symlinks
    home.file = {
      ".editorconfig".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/home/editorconfig");
      ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/home/p10k.zsh");
    };

    # disable keyboard management using home-manager
    home.keyboard = null;

    manual.html.enable = false;
    manual.json.enable = false;
    manual.manpages.enable = false;
  };
}
