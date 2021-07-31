{ config, pkgs, lib, ... }:

let
  inherit (lib) optionals;
in
{
  imports =
    [
      ./common.nix
      ../users/thanatchaya/base.nix
    ];

  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true;

  networking = {
    networkmanager.enable = true;

    firewall.enable = true;
    firewall.allowPing = true;
  };
}
