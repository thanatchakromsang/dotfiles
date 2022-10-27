{ stdenv, fetchFromGitHub, pkgs, lib, rustPlatform }:

rustPlatform.buildRustPackage rec {
  name = "win32yank";
  pname = "win32yank";

  src = fetchFromGitHub {
    owner = "equalsraf";
    repo = "win32yank";
    rev = "4669e6249acc7b8ec9f502b9fafc7252186eea55";
    sha256 = "15cznv7xsz750f4nkjxxicpnx04hmgrjy8h21ss89rxg4nv8dcnd";
  };

  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp win32yank.exe $out/bin/win32yank.exe
  # '';

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  # cargoLock =
  #   let
  #     fixupLockFile = path: f (builtins.readFile path);
  #   in
  #   {
  #     lockFileContents = fixupLockFile ./Cargo.lock;
  #   };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  cargoSha256 = lib.fakeSha256;

  meta = with lib; {
    license = licenses.unlicense;
    maintainers = with maintainers; [ thanatchaya ];
  };
}
