{ config, pkgs, lib, ... }:
{
  home-manager.users.thanatchaya = {
    programs.chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=UseOzonePlatform --ozone-platform=wayland" ];
    };
  };
}
