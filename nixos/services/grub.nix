{ config, lib, ... }:

{
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.timeout = 2;
}
