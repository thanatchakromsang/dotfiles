{ config, lib, pkgs, inputs, ... }:

with lib;
let
in
{
  options = {
    themes = {
      waybar = {
        height = mkOption { type = types.int; };
        modules-right = mkOption { type = types.listOf types.str; };
      };
    };
  };
}
