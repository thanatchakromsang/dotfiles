# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  nixos-hardware = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz";
  };
in
{
  imports =
    [
      "${nixos-hardware}/lenovo/thinkpad/t14s/amd/gen1"
      /etc/nixos/hardware-configuration.nix

      ../../channel.nix

      ../../profiles/workstation.nix
      ../../profiles/desktop.nix
      ../../profiles/notebook.nix
      ../../profiles/development.nix

      ../../users/thanatchaya/personal.nix
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

