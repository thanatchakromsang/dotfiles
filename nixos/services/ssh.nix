{ config, pkgs, lib, ... }:

let
  pubkey = import ./pubkey.nix;
in
{
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = lib.mkDefault true;
  };

  users.extraUsers.root.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];

  users.extraUsers.thanatchaya.openssh.authorizedKeys.keys = lib.mkDefault [ pubkey.thanatchaya ];
}
