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

  programs.ssh.extraConfig = ''
    Host *.local
      StrictHostKeyChecking no

    Host gitlab.com
      HostName gitlab.com
      Preferredauthentications publickey
      AddKeysToAgent yes
      IdentityFile ~/.ssh/personal.pri

    Host gitlab.com-work
      HostName gitlab.com
      Preferredauthentications publickey
      AddKeysToAgent yes
      IdentityFile ~/.ssh/work.pri

    Host github.com
      Hostname github.com
      Preferredauthentications publickey
      AddKeysToAgent yes
      IdentityFile ~/.ssh/personal.pri
  '';

  # users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];

  users.extraUsers.thanatchaya.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];
}
