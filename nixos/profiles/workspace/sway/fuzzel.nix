{ config, pkgs, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix
let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${pkgs.alacritty}/bin/alacritty -e";
          layer = "overlay";
          font = "${fonts.monospace.family}";
        };
        # colors = {
        #   background = "282828";
        #   text = "ebdbb2";
        #   match = "cb4b16ff";
        #   selection=eee8d5dd
        #   selection-text=657b83ff
        #   selection-match=cb4b16ff
        #   border=002b36ff
        # };
      };
    };

    # home.packages = with pkgs; [
    #   networkmanager_dmenu
    #   rofi-bluetooth
    # ];

    # # FIXME(networkmanager-dmenu): using terminal variables from config
    # xdg.configFile."networkmanager-dmenu/config.ini".text = ''
    #   [dmenu]
    #   dmenu_command = ${pkgs.rofi}/bin/rofi
    #   rofi_highlight = True

    #   [editor]
    #   terminal = ${pkgs.alacritty}/bin/alacritty
    #   gui_if_available = true
    # '';
  };
}
