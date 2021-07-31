{ config, pkgs, ... }:

# TODO: migrate to Nix flakes?
let
  # Pin unstable version
  # To update unstable to newer version visit: https://nixos.org/channels/nixos-unstable
  nixos-unstable = builtins.fetchTarball {
    url = "https://releases.nixos.org/nixos/unstable/nixos-21.11pre304626.8ecc61c91a5/nixexprs.tar.xz";
    # url = "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz";
  };
  # https://github.com/nix-community/home-manager
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
  };
  # # https://github.com/nix-community/NUR
  # nur = builtins.fetchTarball {
  #   url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
  # };
in
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import nixos-unstable {
        config = config.nixpkgs.config;
        inherit pkgs;
      };
      home-manager = import home-manager {
        config = config.nixpkgs.config;
        inherit pkgs;
      };
      # nur = import nur {
      #   # config = config.nixpkgs.config;
      #   inherit pkgs;
      # };
    };
  };
}
