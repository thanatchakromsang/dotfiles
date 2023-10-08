{ config, pkgs, lib, ... }:

let
  pubkey = import ./pubkey.nix;
in
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = lib.mkDefault false;
    };
  };

  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Include ~/.ssh/cloudflared.conf
      '';
      matchBlocks = {
        "gitlab.com" = {
          hostname = "gitlab.com";
          identityFile = "~/.ssh/personal.pri";
          extraOptions = {
            Preferredauthentications = "publickey";
            AddKeysToAgent = "yes";
          };
        };
        "github.com" = {
          hostname = "github.com";
          identityFile = "~/.ssh/personal.pri";
          extraOptions = {
            Preferredauthentications = "publickey";
            AddKeysToAgent = "yes";
          };
        };
      };
    };
  };

  # users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];

  users.extraUsers.thanatchaya.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];
}
