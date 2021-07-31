{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
        enable    = true;
        userName  = "Thanatchaya Kromsaeng";
        userEmail = "thanatchakromsang@gmail.com";
    };
  };
}
