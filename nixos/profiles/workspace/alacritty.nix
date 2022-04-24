{ config, lib, pkgs, ... }:

let
  fonts = config.themes.fonts;
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          dynamic_title = true;
        };
        font = {
          normal = {
            family = fonts.monospace.family;
          };
          size = 13;
        };
        colors = {
          primary = {
            background = colors.bg;
            foreground = colors.fg;
          };
          normal = {
            black = colors.bg;
            red = colors.red;
            green = colors.green;
            yellow = colors.yellow;
            blue = colors.blue;
            magenta = colors.purple;
            cyan = colors.aqua;
            white = colors.fg4;
          };
          bright = {
            black = colors.light_gray;
            red = colors.light_red;
            green = colors.light_green;
            yellow = colors.light_yellow;
            blue = colors.light_blue;
            magenta = colors.light_purple;
            white = colors.fg1;
          };
          search = {
            matches = {
              background = "#a9b665";
              foreground = colors.bg;
            };
            focused_match = {
              background = "#ea6962";
              foreground = colors.bg;
            };
            bar = {
              background = colors.yellow;
              foreground = colors.bg;
            };
          };
          line_indicator = {
            background = colors.yellow;
            foreground = colors.bg;
          };
          mouse = {
            hide_when_typing = true;
          };
          selection = {
            save_to_clipboard = true;
          };
        };
        debug = {
          print_events = false;
        };
      };
    };
  };
}
