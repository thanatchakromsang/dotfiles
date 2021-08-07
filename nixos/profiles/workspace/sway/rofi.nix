{ config, pkgs, lib, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/rofi.nix
let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
  # https://discourse.nixos.org/t/install-shell-script-on-nixos/6849/10
  rofi-poweroff = pkgs.writeScriptBin "rofi-poweroff" ''
    #!${pkgs.bash}/bin/bash
    case $(${pkgs.rofi}/bin/rofi -dmenu << EOF | sed 's/^ *//'
    shutdown
    reboot
    logoff
    hibernate
    sleep
    lock
    console
    EOF
    ) in
        "shutdown")
            ${pkgs.systemd}/bin/systemctl poweroff
            ;;
        "reboot")
            ${pkgs.systemd}/bin/systemctl reboot
            ;;
        "hibernate")
            ${pkgs.systemd}/bin/systemctl hibernate
            ;;
        "sleep")
            ${pkgs.systemd}/bin/systemctl suspend
            ;;
        "lock")
            ${pkgs.swaylock}/bin/swaylock -f -c 000000
            ;;
        "logoff")
            ${pkgs.sway}/bin/swaymsg exit
            ;;
    esac
  '';
in
{
  home-manager.users.thanatchaya = {
    programs.rofi = {
      enable = true;
      width = 30;
      lines = 10;
      padding = 20;
      font = "${fonts.sansSerif.family} ${toString fonts.sansSerif.size}";
      borderWidth = 3;
      rowHeight = 1;
      # FIXME(rofi): using terminal variable from config
      terminal = "${pkgs.kitty}/bin/kitty";
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
      rofi-poweroff
      bitwarden-rofi
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
