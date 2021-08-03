{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # # TODO: use sops-nix for secrets
    # sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , home-manager
    , nur
    , nixos-hardware
      # , sops-nix
    }@inputs:
      let
        inherit (nixpkgs) lib;
        overlays = {
          unstable = final: prev: {
            unstable = (
              import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              }
            );
          };
        };
      in
        {
          nixosConfigurations.t14s = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = [
                  nur.overlay
                  overlays.unstable
                ];
                nixpkgs.config.allowUnfree = true;

                home-manager.useUserPackages = true;

                system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
              }
              nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
              nixpkgs.nixosModules.notDetected
              home-manager.nixosModules.home-manager
              # sops-nix.nixosModules.sops
              ./machines/t14s/configuration.nix
            ];
            # extraArgs = { inputs = inputs; };
            specialArgs = { inherit inputs; };
          };
        };
}
