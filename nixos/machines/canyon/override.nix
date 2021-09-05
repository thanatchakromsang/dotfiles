{ config, pkgs, lib, ... }:

{
  themes.fonts = {
    sansSerif.size = lib.mkForce 11;
    serif.size = lib.mkForce 11;
    monospace.size = lib.mkForce 11;
  };

  themes.waybar = {
    height = lib.mkForce 20;
    modules-right = lib.mkForce [
      "pulseaudio"
      "network"
      "sway/language"
      "idle_inhibitor"
    ];
  };

  home-manager.users.thanatchaya = {
    wayland.windowManager.sway = {
      config = {
        workspaceOutputAssign = [
          { workspace = "1"; output = "HDMI-A-2"; }
          { workspace = "2"; output = "HDMI-A-2"; }
          { workspace = "3"; output = "HDMI-A-2"; }
          { workspace = "4"; output = "HDMI-A-2"; }
          { workspace = "5"; output = "HDMI-A-1"; }
          { workspace = "6"; output = "HDMI-A-1"; }
          { workspace = "7"; output = "HDMI-A-1"; }
          { workspace = "8"; output = "HDMI-A-1"; }
          { workspace = "9"; output = "HDMI-A-1"; }
          { workspace = "10"; output = "HDMI-A-1"; }
        ];
      };
    };
  };
}
