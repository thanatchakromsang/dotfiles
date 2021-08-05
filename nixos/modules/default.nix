{ config, lib, pkgs, inputs, ... }:

with lib;
let
  color = mkOption { type = types.str; };
  font = {
    family = mkOption { type = types.str; };
    size = mkOption { type = types.int; };
  };
in
{
  options = {
    themes = {
      colors = builtins.listToAttrs (
        map (
          name: {
            inherit name;
            value = color;
          }
        ) [
          "bg"
          "bg1"
          "bg2"
          "bg3"
          "bg4"
          "fg"
          "fg0"
          "fg1"
          "fg2"
          "fg3"
          "fg4"
          "yellow"
          "green"
          "orange"
          "purple"
          "blue"
          "aqua"
          "red"
          "gray"
          "light_red"
          "light_green"
          "light_yellow"
          "light_blue"
          "light_purple"
          "light_aqua"
          "light_orange"
          "light_gray"
        ]
      );
      fonts = {
        serif = font;
        sansSerif = font;
        monospace = font;
      };
    };
  };
  config = {
    themes.colors = {
      bg = "#282828";
      bg1 = "#3c3836";
      bg2 = "#504945";
      bg3 = "#665c54";
      bg4 = "#7c6f64";
      fg = "#ebdbb2";
      fg0 = "#fbf1c7";
      fg1 = "#ebdbb2";
      fg2 = "#d5c4a1";
      fg3 = "#bdae93";
      fg4 = "#a89984";
      yellow = "#d79921";
      green = "#98971a";
      orange = "#d65d0e";
      purple = "#b16286";
      blue = "#458588";
      aqua = "#689d6a";
      red = "#cc241d";
      gray = "#a89984";
      light_red = "#fb4934";
      light_green = "#b8bb26";
      light_yellow = "#fabd2f";
      light_blue = "#83a598";
      light_purple = "#d3869b";
      light_aqua = "#8ec07c";
      light_orange = "#fe8019";
      light_gray = "#928374";
    };
  };
}
