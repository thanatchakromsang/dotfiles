{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    home.file = {
      ".xkb/symbols/en".source = ./colemak_dh_matrix;
      ".xkb/symbols/th".source = ./manoonchai;
    };
  };
}
