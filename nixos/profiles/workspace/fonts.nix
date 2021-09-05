{ config, lib, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;

    fonts = with pkgs; [
      fira-mono
      ubuntu_font_family
      twemoji-color-font
      tlwg
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    fontconfig = let
      fonts = config.themes.fonts;
    in
      {
        enable = true;
        antialias = true;
        defaultFonts = {
          monospace = [ "${fonts.monospace.family}" ];
          serif = [ "Tlwg" "Ubuntu" "${fonts.serif.family}" ];
          sansSerif = [ "Tlwg" "Ubuntu" "${fonts.sansSerif.family}" ];
          emoji = [ "Twitter Color Emoji" ];
        };
      };
  };
  # Use in various place
  themes.fonts = {
    sansSerif = {
      family = "Hack Nerd Font";
      size = 13;
    };
    serif = {
      family = "Hack Nerd Font";
      size = 13;
    };
    monospace = {
      family = "Hack Nerd Font Mono";
      size = 13;
    };
  };
}
