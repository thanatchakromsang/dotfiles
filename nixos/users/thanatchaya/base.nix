{ config, pkgs, lib, ... }:

{
  users.extraUsers.thanatchaya = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = lib.mkDefault [ "wheel" "networkmanager" "audio" "video" "docker" "i2c"];
    shell = pkgs.zsh;
  };

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    # Workaround for firefox pkgs error ref: https://github.com/nix-community/home-manager/issues/2010
    home.stateVersion = "22.05";

    programs.zsh = {
      enable = true;
      history = {
        save = 1000000000;
        size = 1000000000;
      };
      initExtraFirst = ''
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

        # Alt movement
        bindkey '^[[1;3D' backward-word
        bindkey '^[[1;3C' forward-word
        bindkey '^[[1;3A' up-line-or-beginning-search
        bindkey '^[[1;3B' down-line-or-beginning-search

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
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
      ];
    };

    programs.ssh = {
      enable = true;
      serverAliveInterval = 60;
    };

    programs.git = {
      enable = true;
      extraConfig = {
        core = { hooksPath = "git-hooks"; };
        push = { default = "current"; };
        pull = { rebase = true; };
        init = { defaultBranch = "main"; };
      };
    };

    # ~/.config symlinks
    xdg.configFile = {
      "nvim" = { source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/configs/nvim"); recursive = true; };
      "ranger" = { source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/configs/ranger"); recursive = true; };
    };

    # ~ symlinks
    home.file = {
      ".editorconfig".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/home/editorconfig");
      ".p10k.zsh".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/home/p10k.zsh");
    };

    /* # TODO: XDG MIMEAPPS without conflict */
    /* xdg.mimeApps = { */
    /*   enable = true; */
    /*   defaultApplications = { */
    /*     "application/pdf" = [ "zathura" "firefox.desktop" ]; */
    /*     "video/H264" = [ "mpv.desktop" ]; */
    /*   }; */
    /* }; */

    # disable keyboard management using home-manager
    home.keyboard = null;

    manual.html.enable = false;
    manual.json.enable = false;
    manual.manpages.enable = false;
  };
}
