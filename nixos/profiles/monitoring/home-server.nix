{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [
    80
    443
    13100
    13000
    19090
    19093
  ];

  networking.extraHosts =
    ''
      127.0.0.1 grafana.canyon.local
      127.0.0.1 prometheus.canyon.local
    '';

  services.nginx = {
    enable = true;
    virtualHosts = {
      "grafana.canyon.local" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:13000";
        };
      };
      "prometheus.canyon.local" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:19090";
        };
      };
    };
  };

  services.grafana = {
    enable = true;
    port = 13000;
    dataDir = "/var/lib/grafana";

    provision = {
      enable = true;
      datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          access = "proxy";
          url = "http://127.0.0.1:19090";
          isDefault = true;
        }
        {
          name = "Loki";
          type = "loki";
          access = "proxy";
          url = "http://127.0.0.1:13100";
        }
      ];
    };
  };

  /* TODO: Add Alertmanager support with predefined rules */
  services.prometheus = {
    enable = true;
    port = 19090;
    /* alertmanagerURL = [ "http://127.0.0.1:19093" ]; */
    retentionTime = "2d";
    scrapeConfigs = [
      {
        job_name = "node-exporter";
        static_configs = [
          {
            targets = [ "canyon.local:19100" ];
            labels = {
              instance = "canyon";
            };
          }
          {
            targets = [ "t14s.local:19100" ];
            labels = {
              instance = "t14s";
            };
          }
        ];
      }
    ];
    /* alertmanager = { */
    /*   enable = true; */
    /*   port = 19093; */
    /* }; */
  };

  services.loki = {
    enable = true;
    dataDir = "/var/lib/loki";
    configFile = ./loki-home-server-config.yaml;
  };
}
