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
    Host *.lan
      StrictHostKeyChecking no
  '';

  # users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];

  users.extraUsers.thanatchaya.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];
}
