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
  home-manager.users.thanatchaya = {
    wayland.windowManager.sway = {
      config = {
        workspaceOutputAssign = [
          { workspace = "1"; output = "eDP-1"; }
          { workspace = "2"; output = "eDP-1"; }
          { workspace = "3"; output = "eDP-1"; }
          { workspace = "4"; output = "eDP-1"; }
          { workspace = "5"; output = "HDMI-A-1"; }
          { workspace = "6"; output = "HDMI-A-1"; }
          { workspace = "7"; output = "HDMI-A-1"; }
          { workspace = "8"; output = "HDMI-A-1"; }
          { workspace = "9"; output = "HDMI-A-1"; }
          { workspace = "10"; output = "HDMI-A-1"; }
        ];
      };
      extraConfig = ''
        bindswitch --reload --locked lid:on output ${monitor} disable
        bindswitch --reload --locked lid:off output ${monitor} enable

        exec_always ${clamshell-mode-reset}/bin/clamshell-mode-reset
      '';
    };
  };
}
