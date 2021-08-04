{ config, pkg, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/services/mako.nix
{
  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    programs.mako = {
      enable = true;
      font = "Ubuntu 10";
      backgroundColor = "#d79921";
      textColor = "#333333";
      width = 300;
      height = 100;
      padding = "10";
      borderSize = 0;
      borderRadius = 5;
    };
  };
}
