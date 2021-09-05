{ config, pkg, lib, ... }:

# https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/lazygit/default.nix
{
  home-manager.users.thanatchaya = {
    programs.lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
        customCommands = [
          {
            key = "C";
            command = "git commit -v";
            context = "files";
            loadingText = "opening git commit verbose";
            subprocess = true;
          }
        ];
      };
    };
  };
}
