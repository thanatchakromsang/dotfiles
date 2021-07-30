{ config, pkgs, lib, ... }:

let
  configsDir = ../../../configs;
in
{
  imports =
    [
      <home-manager/nixos>
    ];

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
    programs = {
      zsh = {
        enable = true;
        initExtraFirst = ''
          if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
            source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
          fi

          [[ ! -f ~/.config/p10k.zsh ]] || source ~/.config/p10k.zsh
        '';
      };

      ssh = {
        enable = true;
        serverAliveInterval = 60;
      };

      git = {
        enable = true;
        extraConfig = {
          push = { default = "current"; };
          pull = { rebase = true; };
        };
      };
    };

    xdg.configFile."p10k.zsh".source = "${configsDir}/p10k.zsh";


    manual.html.enable = false;
    manual.json.enable = false;
    manual.manpages.enable = false;
  };
}
