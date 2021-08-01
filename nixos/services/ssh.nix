{ config, pkgs, lib, ... }:

let
  pubkey = import ./pubkey.nix;
in
{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = lib.mkDefault false;
  };

  programs.ssh.extraConfig = "
Host gitlab.com
  HostName gitlab.com
  Preferredauthentications publickey
  AddKeysToAgent yes
  IdentityFile ~/.ssh/personal

Host github.com
  Hostname github.com
  Preferredauthentications publickey
  AddKeysToAgent yes
  IdentityFile ~/.ssh/personal
  ";

  users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];

  users.extraUsers.thanatchaya.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];
}
