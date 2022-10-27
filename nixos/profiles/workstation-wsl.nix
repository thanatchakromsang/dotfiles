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

  environment.systemPackages = with pkgs;
    [
      # win32yank
    ];



  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
  services.gnome.gnome-keyring.enable = true;
}

