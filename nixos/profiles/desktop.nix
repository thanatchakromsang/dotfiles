{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../services/sway.nix
      ../services/keyboard/keyboard.nix

      ../profiles/applications/firefox.nix
    ];

  boot.plymouth.enable = true;

  # TODO: refactor to fonts services
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fonts = with pkgs; [
      fira-mono
      ubuntu_font_family
      font-awesome
      twemoji-color-font
      tlwg
      font-awesome
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      defaultFonts = {
        monospace = [ "Hack Nerd Font Mono" ];
        serif = [ "Tlwg" "Ubuntu" ];
        sansSerif = [ "Tlwg" "Ubuntu" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    anki
    zathura
    tdesktop # telegram
    bluez
    pavucontrol
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
}
