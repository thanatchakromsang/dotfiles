{ config, lib, ... }:

{
  services.ntp.enable = false;

  services.timesyncd = {
    enable = lib.mkDefault true;
    servers = [
      "0.th.pool.ntp.org"
      "1.th.pool.ntp.org"
      "2.th.pool.ntp.org"
      "3.th.pool.ntp.org"
    ];
  };
}
