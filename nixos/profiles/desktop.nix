{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../services/keyboard/keyboard.nix

      ../profiles/workspace/sway/default.nix
      ../profiles/workspace/fonts.nix
      ../profiles/workspace/kitty.nix
      # ../profiles/workspace/alacritty.nix
      ../profiles/workspace/zathura.nix

      # ../profiles/applications/chromium.nix
      ../profiles/applications/firefox.nix
      ../profiles/applications/slack.nix
    ];

  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    anki
    tdesktop # telegram
    bluez
    pavucontrol
    wdisplays
    wf-recorder
    mpv
    xdg-utils # for xdg-open
  ];

  # Sound / Screen sharing
  security.rtkit.enable = true;

  services.blueman.enable = true;

  # TODO: refactor to audio services
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # https://nixos.wiki/wiki/PipeWire
    media-session.config.bluez-monitor.rules = [
      {
        matches = [{ "device.name" = "~bluez_card.*"; }];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            "bluez5.msbc-support" = true;
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          { "node.name" = "~bluez_input.*"; }
          { "node.name" = "~bluez_output.*"; }
        ];
        actions = {
          "node.pause-on-idle" = false;
        };
      }
    ];
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };
}
