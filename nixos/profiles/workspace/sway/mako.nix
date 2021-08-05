{ config, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/services/mako.nix
let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.mako = {
      enable = true;
      font = "${fonts.sansSerif.family} ${toString fonts.sansSerif.size}";
      backgroundColor = "${colors.yellow}";
      textColor = "${colors.bg}";
      width = 300;
      height = 100;
      padding = "10";
      borderSize = 0;
      borderRadius = 5;
    };
  };
}
