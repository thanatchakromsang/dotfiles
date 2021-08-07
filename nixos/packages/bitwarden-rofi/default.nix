{ stdenv, fetchFromGitHub, pkgs, lib }:

# Exameple Nixpkgs https://github.com/NixOS/nixpkgs/blob/nixos-21.05/pkgs/applications/misc/rofi-power-menu/default.nix
# Get updated src info using following command
# nix-shell -p nix-prefetch-git
# nix-prefetch-git --url https://github.com/nickclyde/rofi-bluetooth.git
stdenv.mkDerivation rec {
  name = "bitwarden-rofi";
  pname = "bitwarden-rofi";

  src = fetchFromGitHub {
    owner = "mattydebie";
    repo = "bitwarden-rofi";
    rev = "62c95afd5634234bac75855dc705d4da5f4fab69";
    sha256 = "1shdfzwscic179n10pkkbjpkisji64vjva4afzx399knw8gprzc2";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp bwmenu $out/bin/bwmenu
    cp lib-bwmenu $out/bin/lib-bwmenu
  '';

  meta = with lib; {
    maintainers = with maintainers; [ thanatchaya ];
    license = licenses.gpl3;
    description =
      "Wrapper for Bitwarden https://github.com/bitwarden/cli and Rofi";
    platforms = platforms.linux;
  };
}
