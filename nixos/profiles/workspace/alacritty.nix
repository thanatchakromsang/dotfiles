{ config, lib, pkgs, ... }:

let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal = {
            family = fonts.monospace.family;
          };
          size = fonts.monospace.size;
        };
      };
    };
  };
}
