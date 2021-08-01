{ config, pkgs, lib, ... }:

let
  # Docs / Example
  # https://nixos.wiki/wiki/Keyboard_Layout_Customization
  # https://github.com/dmarcoux/dotfiles-nixos/commit/272eb7e9b97957d542cf78fe5f73b16043dbf4c4
  customColemakLayout = pkgs.writeText "custom-keyboard-layout" ''
    xkb_keymap {
      xkb_keycodes  { include "evdev+aliases(qwerty)"	};
      xkb_types     { include "complete"	};
      xkb_compat    { include "complete"	};
      partial
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

  customPattachoteLayout = pkgs.writeText "custom-th-keyboard-layout" ''
    xkb_keymap {
      xkb_keycodes  { include "evdev+aliases(qwerty)"	};
      xkb_types     { include "complete"	};
      xkb_compat    { include "complete"	};
      partial
      xkb_symbols "pat_modern" {
          include "th(pat)"
          name[Group1] = "Thai (Pattachote)";

          key <TLDE> { [ Thai_chochoe, Thai_lu	] };
          key <AE01> { [ 1,	exclam		] };
          key <AE02> { [ 2,	at	] };
          key <AE03> { [ 3,	numbersign		] };
          key <AE04> { [ 4,	dollar		] };
          key <AE05> { [ 5,	percent	] };
          key <AE06> { [ 6,	asciicircum	] };
          key <AE07> { [ 7,	ampersand	] };
          key <AE08> { [ 8,	asterisk		] };
          key <AE09> { [ 9,	parenleft	] };
          key <AE10> { [ 0,	parenright	] };
          key <AE11> { [ minus,	underscore		] };
          key <AE12> { [ equal,		plus		] };

          key <AD11> { [ Thai_saraaimaimuan,	Thai_paiyannoi	] };
          key <AD12> { [ Thai_sarauu,	Thai_sarau		] };

          key <BKSL> { [ Thai_lakkhangyao,	Thai_baht	] };
        };
      xkb_geometry  { include "pc(pc105)"	};
    };
  '';
  
  environment.systemPackages = with pkgs; [ pkgs.xorg.xkbcomp ];

  compiledLayout = pkgs.runCommand "keyboard-layout-us" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customColemakLayout} $out
  '';

  pattachoteLayout = pkgs.runCommand "keyboard-layout-th" {} ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${customPattachoteLayout} $out
  '';
in
{
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout}";
  programs.sway.extraSessionCommands = ''
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${compiledLayout}
    ${pkgs.xorg.xkbcomp}/bin/xkbcomp ${pattachoteLayout}
  '';
}
