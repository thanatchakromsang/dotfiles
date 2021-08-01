{ config, pkgs, lib, ... }:

let
  # Docs / Example
  # https://nixos.wiki/wiki/Keyboard_Layout_Customization
  # https://github.com/dmarcoux/dotfiles-nixos/commit/272eb7e9b97957d542cf78fe5f73b16043dbf4c4
  customKeyboardLayout = pkgs.writeText "custom-keyboard-layout" ''
    xkb_keymap {
      xkb_keycodes  { include "evdev+aliases(qwerty)"	};
      xkb_types     { include "complete"	};
      xkb_compat    { include "complete"	};
      xkb_symbols   { include "pc+us+inet(evdev)"	};
      default partial alphanumeric_keys
      xkb_symbols "colemak_dh_matrix" {
        include "us(colemak_dh)"
        name[Group1] = "English (Colemak DH)";

        key <AB01> { [            z,            Z,              ae,               AE ] };
        key <AB02> { [            x,            X, dead_circumflex,       asciitilde ] };
        key <AB03> { [            c,            C,        ccedilla,         Ccedilla ] };
        key <AB04> { [            d,            D,  dead_diaeresis,       asciitilde ] };
        key <AB05> { [            v,            V,              oe,               OE ] };
      };
      xkb_geometry  { include "pc(pc105)"	};
    };
  '';
  
  environment.systemPackages = with pkgs; [ pkgs.xorg.xkbcomp ];

  compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customColemakLayout} $out
    # ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customPattachoteLayout} $out
  '';
in
{
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout}";
  programs.sway.extraSessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout}";
}
