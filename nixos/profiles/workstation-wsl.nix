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
      win32yank
    ];

  environment.shellAliases = {
    pbcopy = "${pkgs.win32yank}/bin/win32yank -i --crlf";
    pbpaste = "${pkgs.win32yank}/bin/win32yank -o --lf";
  };

  programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };
  services.gnome.gnome-keyring.enable = true;
}

