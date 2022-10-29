{ stdenv, fetchurl, pkgs, lib }:

# nix-prefetch-url https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
stdenv.mkDerivation rec {
  name = "win32yank";
  # pname = "win32yank";

  src = fetchurl {
    url = "https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip";
    sha256 = "081a2k6ww8w6q2fzwifml88j941x3mkggnwfcrgbc3x65nllg9rk";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  unpackPhase = ''
    ${pkgs.unzip}/bin/unzip -j -o $src -d $out
  '';

  installPhase = ''
    mkdir -p $out/bin
    chmod +x $out/win32yank.exe
    mv $out/win32yank.exe $out/bin/win32yank
  '';

  meta = with lib; {
    license = licenses.unlicense;
    maintainers = with maintainers; [ thanatchaya ];
  };
}
