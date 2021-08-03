{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "Thanatchaya Kromsaeng";
      userEmail = "thanatchakromsang@gmail.com";
      signing = {
        signByDefault = true;
        key = "5254D8A1FBCE25D519C7E3D8E405CB1740495F06";
      };
    };
  };
}
