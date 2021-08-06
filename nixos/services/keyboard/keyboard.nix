{ config, pkgs, lib, ... }:

{
  services.xserver.extraLayouts.colemak_dh_matrix = {
    description = "Colemak Layout matrix variant";
    languages   = [ "eng" ];
    symbolsFile = ./colemak_dh_matrix;
  };

  services.xserver.extraLayouts.pat_modern = {
    description = "TH layout with aerobic numbers";
    languages   = [ "th" ];
    symbolsFile = ./pat_modern;
  };

  services.xserver.extraLayouts.manoonchai = {
    description = "TH layout generated using Algorithm and AI";
    languages   = [ "th" ];
    symbolsFile = ./manoonchai;
  };
}
