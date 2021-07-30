{ config, pkgs, lib, ... }:

{
  imports =
    [
      <home-manager/nixos>
    ];

  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
        enable    = true;
        userName  = "Thanatchaya Kromsaeng";
        userEmail = "thanatchakromsang@gmail.com";
    };
  };
}
