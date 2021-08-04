# https://nixos.wiki/wiki/Sway
{ config, pkgs, lib, ... }:

let
  configsDir = ../../../configs;
in
{
  imports =
    [
      ./waybar.nix
      ./mako.nix
    ];

  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    xdg.configFile = {
      "networkmanager-dmenu".source = "${configsDir}/networkmanager-dmenu";
      "sway" = { source = "${configsDir}/sway"; recursive = true; };
      "rofi" = { source = "${configsDir}/rofi"; recursive = true; };
    };

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

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true; # so that gtk works properly
      extraPackages = with pkgs; [
        swaylock
        swayidle
        wl-clipboard
        kitty
        grim
        slurp
        rofi
        alacritty
        light
        kanshi
        networkmanager_dmenu
      ];
    };
    light.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   (
  #     pkgs.writeTextFile {
  #       name = "startsway";
  #       destination = "/bin/startsway";
  #       executable = true;
  #       text = ''
  #         #! ${pkgs.bash}/bin/bash
  #         systemctl --user import-environment
  #         exec systemctl --user start sway.service
  #       '';
  #     }
  #   )
  # ];


  # systemd.user.targets.sway-session = {
  #   description = "Sway compositor session";
  #   documentation = [ "man:systemd.special(7)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  # };

  # systemd.user.services.sway = {
  #   description = "Sway - Wayland window manager";
  #   documentation = [ "man:sway(5)" ];
  #   bindsTo = [ "graphical-session.target" ];
  #   wants = [ "graphical-session-pre.target" ];
  #   after = [ "graphical-session-pre.target" ];
  #   # We explicitly unset PATH here, as we want it to be set by
  #   # systemctl --user import-environment in startsway
  #   environment.PATH = lib.mkForce null;
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''
  #       ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
  #     '';
  #     Restart = "on-failure";
  #     RestartSec = 1;
  #     TimeoutStopSec = 10;
  #   };
  # };
}
