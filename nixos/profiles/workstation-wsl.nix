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

  # XXX: Fix using workaround Ref: https://github.com/NixOS/nixpkgs/issues/102137
  # environment.noXlibs = lib.mkForce false;

  # programs.ssh.startAgent = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  services.gnome.gnome-keyring.enable = true;
}

