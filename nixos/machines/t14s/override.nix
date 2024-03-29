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
          { workspace = "1"; output = "eDP-1"; }
          { workspace = "2"; output = "eDP-1"; }
          { workspace = "3"; output = "eDP-1"; }
          { workspace = "4"; output = "eDP-1"; }
          { workspace = "5"; output = "DP-2"; }
          { workspace = "6"; output = "DP-2"; }
          { workspace = "7"; output = "DP-2"; }
          { workspace = "8"; output = "DP-2"; }
          { workspace = "9"; output = "DP-2"; }
          { workspace = "10"; output = "DP-2"; }
        ];
        output = {
          "*".bg = "~/.dotfiles/wallpapers/gruvbox-dark-rainbow.png fill";
          DP-1 = {
            resolution = "3840x1600";
            position = "0 160";
          };
          DP-2 = {
            resolution = "1920x1080";
            position = "3840 0";
            transform = "90";
          };
          # Center Below Main Monitor
          eDP-1 = {
            resolution = "1920x1080";
            position = "960 1760";
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
