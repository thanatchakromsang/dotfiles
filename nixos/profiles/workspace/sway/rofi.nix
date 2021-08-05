{ config, pkgs, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix
let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.rofi = {
      enable = true;
      width = 30;
      lines = 10;
      padding = 20;
      font = "${fonts.sansSerif.family} ${toString fonts.sansSerif.size}";
      borderWidth = 3;
      rowHeight = 1;
      # FIXME(rofi): using terminal variable from config
      terminal = "kitty";
      separator = "none";
      scrollbar = false;
      theme = "gruvbox-dark";
      extraConfig = {
        columns = 1;
        modi = "run,drun";
      };
    };

    home.packages = with pkgs; [
      networkmanager_dmenu
    ];

    # FIXME(networkmanager-dmenu): using terminal variables from config
    xdg.configFile."networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi
      rofi_highlight = True

      [editor]
      terminal = kitty
      gui_if_available = true
    '';
  };
}
