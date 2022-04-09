{ config, pkgs, lib, stable, ... }:

# https://github.com/nix-community/home-manager/blob/master/modules/programs/zathura.nix
let
  colors = config.themes.colors;
in
{
  home-manager.users.thanatchaya = {
    programs.zathura = {
      enable = true;
      package = pkgs.stable.zathura;
      options = {
        adjust-open = "best-fit";
        selection-clipboard = "clipboard";
        window-title-home-tilde = true;
        window-title-basename = true;
        statusbar-home-tilde = true;

        notification-error-bg = colors.bg;
        notification-error-fg = colors.light_red;
        notification-warning-bg = colors.bg;
        notification-warning-fg = colors.light_yellow;
        notification-bg = colors.bg;
        notification-fg = colors.light_green;

        completion-bg = colors.bg2;
        completion-fg = colors.fg;
        completion-group-bg = colors.bg1;
        completion-group-fg = colors.gray;
        completion-highlight-bg = colors.light_blue;
        completion-highlight-fg = colors.bg2;

        index-bg = colors.bg2; # bg2
        index-fg = colors.fg; # fg
        index-active-bg = colors.light_blue;
        index-active-fg = colors.bg2;

        inputbar-bg = colors.bg;
        inputbar-fg = colors.fg;

        statusbar-bg = colors.bg2;
        statusbar-fg = colors.fg;

        highlight-color = colors.light_yellow;
        highlight-active-color = colors.light_orange;

        default-bg = colors.bg;
        default-fg = colors.fg;
        render-loading = true;
        render-loading-bg = colors.bg;
        render-loading-fg = colors.fg;

        recolor-lightcolor = colors.bg;
        recolor-darkcolor = colors.fg;
        recolor = true;
      };
      extraConfig = ''
        map k scroll half-up
        map j scroll half-down
        map i recolor
      '';
    };
  };
}
