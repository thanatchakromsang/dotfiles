# https://nixos.wiki/wiki/Sway
{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./sway.nix
      ./waybar.nix
      ./mako.nix
      ./fuzzel.nix
    ];
}
