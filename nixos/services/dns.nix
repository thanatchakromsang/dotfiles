{ config, lib, ... }:

{
  services.resolved.enable = lib.mkDefault true;
  services.resolved.settings = {
    Resolve = {
      Domains = [ "local" ];
      DNSSEC = "false";
    };
  };
}
