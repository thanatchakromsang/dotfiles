{ config, pkgs, lib, ... }:

let
  inherit (lib) optionals;
in
{
  imports =
    [
      ./common.nix
      ../users/thanatchaya/base.nix
      ../services/avahi.nix
    ];

  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
  services.gnome.gnome-keyring.enable = true;

  networking = {
    networkmanager.enable = true;
    networkmanager.insertNameservers = 
      [
        "1.1.1.1"
        "8.8.8.8"
      ];
    firewall.enable = true;
    firewall.allowPing = true;
  };
}
