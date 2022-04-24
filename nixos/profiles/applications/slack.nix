{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = {
    home.sessionVariables = {
      # FIXME: Enable native wayland when electron upsteam fix issues follow up in https://github.com/NixOS/nixpkgs/issues/161402
      # NIXOS_OZONE_WL = "1";
    };
  };

  environment.systemPackages = with pkgs; [
    slack
  ];
}
