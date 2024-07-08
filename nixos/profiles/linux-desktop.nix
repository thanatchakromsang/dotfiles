{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../services/keyboard/keyboard.nix

      ../profiles/workspace/sway/default.nix
      ../profiles/workspace/fonts.nix
      # ../profiles/workspace/kitty.nix
      ../profiles/workspace/alacritty.nix
      ../profiles/workspace/zathura.nix

      ../profiles/applications/chromium.nix
      ../profiles/applications/firefox.nix
      # ../profiles/applications/slack.nix
    ];

  boot.plymouth.enable = true;

  environment.systemPackages = with pkgs; [
    # anki
    tdesktop # telegram
    bluez
    pavucontrol
    wdisplays
    wf-recorder
    mpv
    xdg-utils # for xdg-open
  ];

  home-manager.users.thanatchaya = {
    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = 48;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };
  };

  # Sound / Screen sharing
  security.rtkit.enable = true;

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.pipewire.wireplumber.enable = true;

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };
}
