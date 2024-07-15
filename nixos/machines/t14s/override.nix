{ config, pkgs, lib, ... }:



let
  monitor = "eDP-1";
  clamshell-mode-reset = pkgs.writeScriptBin "clamshell-mode-reset" ''
    #!${pkgs.bash}/bin/bash
    if ${pkgs.gnugrep}/bin/grep -q open /proc/acpi/button/lid/LID*/state; then
        ${pkgs.sway}/bin/swaymsg output ${monitor} enable
    else
        ${pkgs.sway}/bin/swaymsg output ${monitor} disable
    fi
  '';
in
{
  themes.fonts = {
    sansSerif.size = lib.mkForce 15;
    serif.size = lib.mkForce 15;
    monospace.size = lib.mkForce 15;
  };

  home-manager.users.thanatchaya = {
    wayland.windowManager.sway = {
      config = {
        workspaceOutputAssign = [
          { workspace = "1"; output = "DP-1"; }
          { workspace = "2"; output = "DP-1"; }
          { workspace = "3"; output = "HDMI-A-1"; }
          { workspace = "4"; output = "DP-1"; }
          { workspace = "5"; output = "HDMI-A-1"; }
          { workspace = "6"; output = "HDMI-A-1"; }
          { workspace = "7"; output = "DP-2"; }
          { workspace = "8"; output = "DP-2"; }
          { workspace = "9"; output = "DP-2"; }
        ];
        output = {
          "*".bg = "~/.dotfiles/wallpapers/gruvbox-dark-rainbow.png fill";
          # NOTE: Calculated from wdisplays placement
          DP-1 = {
            resolution = "3840x1600";
            position = "1080 0";
          };
          DP-2 = {
            resolution = "1920x1080";
            position = "0 0";
            transform = "90";
          };
          HDMI-A-1 = {
            resolution = "2560x1440";
            position = "4920 160";
          };
          # Center Below Main Monitor
          eDP-1 = {
            resolution = "1920x1080";
            position = "2040 1600";
          };
        };
      };
      extraConfig = ''
        bindswitch --reload --locked lid:on output ${monitor} disable
        bindswitch --reload --locked lid:off output ${monitor} enable

        exec_always ${clamshell-mode-reset}/bin/clamshell-mode-reset
      '';
    };
  };
}
