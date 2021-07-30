# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/t14s/amd/gen1>
      /etc/nixos/hardware-configuration.nix

      ../../users/thanatchaya/personal.nix

      ../../profiles/workstation.nix
      ../../profiles/desktop.nix
      ../../profiles/notebook.nix
      ../../profiles/development.nix
    ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = ["nodev"];
      efiSupport = true;
    };
  };

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "t14s";
    domain = "local";
  };

  system.stateVersion = "21.05";
}

