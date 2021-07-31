{ config, pkgs, lib, ... }:

let
  configsDir = ../../../configs;
in
{
  users.extraUsers.thanatchaya = {
    isNormalUser = true;
    createHome = true;
    uid = 1000;
    extraGroups = lib.mkDefault [ "wheel" "networkmanager" "audio" "video" "docker"];
    shell = pkgs.zsh;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi

        [[ ! -f ~/.config/p10k.zsh ]] || source ~/.config/p10k.zsh
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

    xdg.configFile."p10k.zsh".source = "${configsDir}/p10k.zsh";
    xdg.configFile."nvim" = {
      source = "${configsDir}/nvim";
      recursive = true;
    };

    manual.html.enable = false;
    manual.json.enable = false;
    manual.manpages.enable = false;
  };
}
