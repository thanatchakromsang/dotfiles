{ config, pkgs, ... }:

{
  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        enabledCollectors = [
          "systemd"
        ];
        port = 19100;
      };
    };
  };

  services.promtail = {
    enable = true;
    configuration = {
      clients = [
        {
          url = "http://canyon.local:13100/loki/api/v1/push";
        }
      ];
      scrape_configs = [
        {
          job_name = "journal";
          journal = {
            max_age = "12h";
            labels = {
              job = "systemd-journal";
              host = config.networking.hostName;
            };
          };
        }
      ];
    };
    extraFlags = [
      "--server.http-listen-port=13101"
    ];
  };
}
