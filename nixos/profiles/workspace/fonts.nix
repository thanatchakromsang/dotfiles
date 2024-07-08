{ config, lib, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = with pkgs; [
      ubuntu_font_family
      twemoji-color-font
      tlwg
      (nerdfonts.override { fonts = [ "Hack" "FiraCode" "JetBrainsMono" ]; })
    ];

    fontconfig =
      let
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
  # kitty +list-fonts --psnames
  themes.fonts = {
    sansSerif = {
      family = "Ubuntu";
      size = 13;
    };
    serif = {
      family = "Ubuntu";
      size = 13;
    };
    monospace = {
      family = "JetbrainsMono Nerd Font";
      size = 13;
    };
  };
}
