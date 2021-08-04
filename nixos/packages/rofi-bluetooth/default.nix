{ stdenv, fetchFromGitHub, pkgs, lib }:

# { lib, pkgs }:

# Get updated src info using following command
# nix-shell -p nix-prefetch-git
# nix-prefetch-git --url https://github.com/nickclyde/rofi-bluetooth.git
stdenv.mkDerivation rec {
  pname = "rofi-bluetooth";

  src = fetchFromGitHub {
    owner = "nickclyde";
    repo = "rofi-bluetooth";
    rev = "893db1f2b549e7bc0e9c62e7670314349a29cdf2";
    sha256 = "1jrjiv352awv838v3b6gjjc5rn3kjaagijgn5nky82hhl4j4x16y";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D rofi-bluetooth $out/bin/rofi-bluetooth
  '';

  doCheck = false;

  meta = with lib; {
    maintainers = with maintainers; [ thanatchaya ];
    license = licenses.gpl3;
    description =
      "A script that generates a rofi menu that uses bluetoothctl to connect to bluetooth devices and display status info.";
  };
}
