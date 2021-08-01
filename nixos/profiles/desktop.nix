{ config, pkgs, lib, ... }:

{
  imports =
    [
      <home-manager/nixos>
      ../services/sway.nix
    ];

  boot.plymouth.enable = true;

  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fonts = with pkgs; [
      fira-mono
      nerdfonts
      ubuntu_font_family
      font-awesome
      twemoji-color-font
      tlwg
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Fira Mono" ];
        serif = [ "Tlwg" "Ubuntu" ];
        sansSerif = [ "Tlwg" "Ubuntu" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    anki
    zathura
    firefox-wayland
    tdesktop # telegram
    bluez
    pavucontrol
  ];

  # Sound / Screen sharing
  security.rtkit.enable = true;

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # https://nixos.wiki/wiki/PipeWire
    media-session.config.bluez-monitor.rules = [
      {
        matches = [ { "device.name" = "~bluez_card.*"; } ];
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

  environment.sessionVariables = {
     MOZ_ENABLE_WAYLAND = "1";
     XDG_CURRENT_DESKTOP = "sway";
  };
}