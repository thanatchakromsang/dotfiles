{ config, pkgs, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix
let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.rofi = {
      enable = true;
      package = pkgs.nur.repos.c0deaddict.rofi-wayland;
      font = "${fonts.sansSerif.family} ${toString fonts.sansSerif.size}";
      terminal = "${pkgs.kitty}/bin/kitty";
      theme = "gruvbox-dark";
      extraConfig = {
        /* columns = 1; */
        modi = "run,drun";
      };
    };

    home.packages = with pkgs; [
      networkmanager_dmenu
      rofi-bluetooth
    ];

    # FIXME(networkmanager-dmenu): using terminal variables from config
    xdg.configFile."networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = ${pkgs.rofi}/bin/rofi
      rofi_highlight = True

      [editor]
      terminal = ${pkgs.kitty}/bin/kitty
      gui_if_available = true
    '';
  };
}
