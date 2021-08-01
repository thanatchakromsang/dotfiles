{ config, ... }:

{
  # discover/publish *.local hostname on local network
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };
}

