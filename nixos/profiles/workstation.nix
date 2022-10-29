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
      ../services/ddc-ci.nix
      ../services/grub.nix
      ../services/dns.nix
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
      [ ];
    firewall.enable = true;
    firewall.allowPing = true;
  };
}
