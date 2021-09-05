{ config, lib, ... }:

{
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.version = 2;
  boot.loader.timeout = 2;
}
