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
      "custom/ddcutil"
      "sway/language"
      "idle_inhibitor"
    ];
  };

  home-manager.users.thanatchaya = {
    wayland.windowManager.sway = {
      config = {
        workspaceOutputAssign = [
          { workspace = "1"; output = "DP-1"; }
          { workspace = "2"; output = "DP-1"; }
          { workspace = "3"; output = "DP-1"; }
          { workspace = "4"; output = "DP-1"; }
          { workspace = "5"; output = "DP-4"; }
          { workspace = "6"; output = "DP-4"; }
          { workspace = "7"; output = "DP-4"; }
          { workspace = "8"; output = "DP-4"; }
          { workspace = "9"; output = "DP-4"; }
          { workspace = "10"; output = "DP-4"; }
        ];
        output = {
          "*".bg = "~/.dotfiles/wallpapers/gruvbox-dark-rainbow.png fill";
          DP-1 = {
            resolution = "3840x1600";
            position = "0 150";
          };
          DP-4 = {
            resolution = "2560x1440";
            position = "3840 0";
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
