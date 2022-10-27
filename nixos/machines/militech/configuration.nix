# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, ... }:

with lib;
let
  nixos-wsl = import /etc/nixos/nixos-wsl;
in
{
  imports =
    [
      "${modulesPath}/profiles/minimal.nix"
      nixos-wsl.nixosModules.wsl

      ../../profiles/workstation-wsl.nix
      ../../profiles/development.nix

      ../../users/thanatchaya/personal.nix
    ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "thanatchaya";
    startMenuLaunchers = true;

    docker-native = {
      enable = true;
      addToDockerGroup = true;
    };
  };

  nix = {
    package = pkgs.nixUnstable;
    gc =
      {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  networking = {
    hostName = "militech";
    domain = "local";
  };

  system.stateVersion = "22.05";
}
