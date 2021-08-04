{ stdenv, fetchFromGitHub, pkgs, lib }:

# { lib, pkgs }:

# Get updated src info using following command
# nix-shell -p nix-prefetch-git
# nix-prefetch-git --url https://github.com/nickclyde/rofi-bluetooth.git
stdenv.mkDerivation rec {
  pname = "bitwarden-rofi";

  src = fetchFromGitHub {
    owner = "mattydebie";
    repo = "bitwarden-rofi";
    rev = "62c95afd5634234bac75855dc705d4da5f4fab69";
    sha256 = "1shdfzwscic179n10pkkbjpkisji64vjva4afzx399knw8gprzc2";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D bwmenu $out/bin/bwmenu
    install -D lib-bwmenu $out/bin/lib-bwmenu
  '';

  doCheck = false;

  meta = with lib; {
    maintainers = with maintainers; [ thanatchaya ];
    license = licenses.gpl3;
    description =
      "A script that generates a rofi menu that uses bluetoothctl to connect to bluetooth devices and display status info.";
  };
}
