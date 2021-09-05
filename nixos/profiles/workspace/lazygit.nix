{ config, pkg, lib, ... }:

# https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/lazygit/default.nix
{
  home-manager.users.thanatchaya = {
    programs.lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
      };
    };
  };
}
