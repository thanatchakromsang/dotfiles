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
      "disk"
      "pulseaudio"
      "network"
      /* "sway/language" /* XXX: waiting for fixes in waybar */
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
        output = {
          "*".bg = "~/.dotfiles/wallpapers/gruvbox-dark-rainbow.png fill";
          HDMI-A-1 = {
            resolution = "1920x1080";
            transform = "0";
            position = "1920 0";
          };
          HDMI-A-2 = {
            resolution = "1920x1080";
            position = "0 0";
          };
        };
      };
    };
  };

  systemd.services.disableUSB3WakeOnLan = {
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "multi-user.target" "post-resume.target" ];
    script = ''
      if ${pkgs.gnugrep}/bin/grep -q '\bXHC\b.*\benabled\b' /proc/acpi/wakeup; then
        echo XHC > /proc/acpi/wakeup
      fi
    '';
    serviceConfig.Type = "oneshot";
  };
}
