{ config, pkgs, lib, ... }:

let
  unstable = import <nixos-unstable> {};
  pubkey = import ../services/pubkey.nix;
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
