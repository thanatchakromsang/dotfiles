{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  environment.systemPackages = with pkgs; [
    slack
  ];
}
