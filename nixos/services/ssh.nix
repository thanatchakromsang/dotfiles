{ config, pkgs, lib, ... }:

let
  pubkey = import ./pubkey.nix;
in
{
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = lib.mkDefault false;
  };

  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "Thanatchaya Kromsaeng";
      userEmail = "thanatchakromsang@gmail.com";
      signing = {
        signByDefault = true;
        key = "5254D8A1FBCE25D519C7E3D8E405CB1740495F06";
      };
      includes = [
        {
          condition = "gitdir:~/Developers/sertis/";
          contents = {
            user = {
              email = "tkrom@sertiscorp.com";
              name = "Thanatchaya Kromsaeng";
              signingKey = "5C0E779514D3F8218A58E627844EE25B2216DCDB";
            };
            commit = {
              gpgSign = true;
            };
          };
        }
      ];
    };


    /*   programs.ssh.extraConfig = '' */
    /*     Include ~/.ssh/cloudflared */

    /*     Host gitlab.com */
    /*       HostName gitlab.com */
    /*       Preferredauthentications publickey */
    /*       AddKeysToAgent yes */
    /*       IdentityFile ~/.ssh/personal.pri */

    /*     Host gitlab.com-work */
    /*       HostName gitlab.com */
    /*       Preferredauthentications publickey */
    /*       AddKeysToAgent yes */
    /*       IdentityFile ~/.ssh/work.pri */

    /*     Host github.com */
    /*       Hostname github.com */
    /*       Preferredauthentications publickey */
    /*       AddKeysToAgent yes */
    /*       IdentityFile ~/.ssh/personal.pri */
    /*   ''; */


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
        "gitlab.com-work" = {
          hostname = "gitlab.com";
          identityFile = "~/.ssh/work.pri";
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
