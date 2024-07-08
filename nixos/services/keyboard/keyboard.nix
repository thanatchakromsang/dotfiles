{ config, pkgs, lib, ... }:

{
  # home-manager.users.thanatchaya = { pkgs, config, ... }: {
  #   home.file = {
  #     ".xkb/symbols/colemak_dh_matrix".source = ./colemak_dh_matrix;
  #     ".xkb/symbols/manoonchai".source = ./manoonchai;
  #   };
  # };
  services.xserver.xkb.extraLayouts = {
    manoonchai = {
      description = "TH manoonchai";
      languages = ["thai"];
      symbolsFile = ./manoonchai.xkb;
    };
    colemak_dh_matrix = {
      description = "EN colemak_dh_matrix";
      languages = ["eng"];
      symbolsFile = ./colemak_dh_matrix.xkb;
    };
  };
}
