{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, config, ... }: {
    home.file = {
      ".xkb/symbols/colemak_dh_matrix".source = ./colemak_dh_matrix;
      ".xkb/symbols/manoonchai".source = ./manoonchai;
    };
  };
}
