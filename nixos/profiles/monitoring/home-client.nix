{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    19100
    13101
  ];

  services.prometheus = {
    exporters = {
      node = {
        enable = true;
        extraFlags = [
          "--no-collector.rapl"
        ];
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
          relabel_configs = [
            {
              source_labels = [ "__journal__systemd_unit" ];
              target_label = "unit";
            }
          ];
        }
      ];
    };
    extraFlags = [
      "--server.http-listen-port=13101"
    ];
  };
}
