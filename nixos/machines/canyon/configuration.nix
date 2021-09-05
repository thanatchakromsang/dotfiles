# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./override.nix

      ../../profiles/workstation.nix
      ../../profiles/desktop.nix
      ../../profiles/notebook.nix
      ../../profiles/development.nix
      /* ../../profiles/streaming.nix */
      /* ../../profiles/gaming.nix */
      ../../profiles/keyboard.nix

      ../../users/thanatchaya/personal.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
    };
  };

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "canyon";
    domain = "local";
  };

  system.stateVersion = "21.05";
}
