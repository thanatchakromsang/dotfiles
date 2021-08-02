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

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    # Workaround for firefox pkgs error ref: https://github.com/nix-community/home-manager/issues/2010
    # FIXME: Find a way to do global import of home.stateVersion
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
      "nvim" = { source = "${configsDir}/nvim"; recursive = true; };
      "kitty" = { source = "${configsDir}/kitty"; recursive = true; };
      "lazygit/config.yml" = { source = "${configsDir}/lazygit/config.yml"; force = true; };
      "ranger" = { source = "${configsDir}/ranger"; recursive = true; };
      "zathurarc".source = "${configsDir}/zathura/zathurarc";
      "networkmanager-dmenu".source = "${configsDir}/networkmanager-dmenu";
      "sway" = { source = "${configsDir}/sway"; recursive = true; };
      "waybar" = { source = "${configsDir}/waybar"; recursive = true; };
      "mako" = { source = "${configsDir}/mako"; recursive = true; };
      "rofi" = { source = "${configsDir}/rofi"; recursive = true; };
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
