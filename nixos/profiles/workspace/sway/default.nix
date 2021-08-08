# https://nixos.wiki/wiki/Sway
{ config, pkgs, lib, ... }:

let
  configsDir = ../../../../configs;
in
{
  imports =
    [
      ./sway.nix
      ./waybar.nix
      ./mako.nix
      ./rofi.nix
    ];

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    programs.zsh.loginExtra = ''
      [[ "$(tty)" == /dev/tty1 ]] && sway
    '';

    home.sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };

  programs.light.enable = true;
}
