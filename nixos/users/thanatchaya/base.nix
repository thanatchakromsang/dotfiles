{ config, pkgs, lib, ... }:

let
  configsDir = ../../../configs;
  homeDir = ../../../home;
in
{
  users.extraUsers.thanatchaya = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = lib.mkDefault [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    # Workaround for firefox pkgs error ref: https://github.com/nix-community/home-manager/issues/2010
    home.stateVersion = "21.05";

    programs.zsh = {
      enable = true;
      initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        # Add powerlevel10k themes
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        # Completion
        source ${pkgs.google-cloud-sdk}/google-cloud-sdk/completion.zsh.inc

        bindkey '^ ' autosuggest-accept
        bindkey '^p' up-line-or-beginning-search
        bindkey '^n' down-line-or-beginning-search
        bindkey '^H' backward-kill-word

        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';
      # TODO(sshconfig): Remove this when `ssh -V` is > 8.7 and use sshconfig to control TERM instead following https://wiki.archlinux.org/title/kitty under `Terminal issues with SSH` section
      sessionVariables = {
        TERM = "xterm-256color";
      };
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
      # "nvim" = { source = "${configsDir}/nvim"; recursive = true; };
      "ranger" = { source = "${configsDir}/ranger"; recursive = true; };
    };

    # ~ symlinks
    home.file = {
      ".editorconfig".source = "${homeDir}/editorconfig";
      ".p10k.zsh".source = "${homeDir}/p10k.zsh";
    };

    # disable keyboard management using home-manager
    home.keyboard = null;

    manual.html.enable = false;
    manual.json.enable = false;
    manual.manpages.enable = false;
  };
}
