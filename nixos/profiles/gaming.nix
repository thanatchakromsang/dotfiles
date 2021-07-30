{ config, lib, pkgs, ... }:

let
  unstable = import <nixos-unstable> {};
in
{
  # allow some unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    steam
    steam-original
    steam-runtime
  ];

  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
}
