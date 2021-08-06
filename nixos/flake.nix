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
    # rofi-bluetooth = {
    #   url = "github:nickclyde/rofi-bluetooth";
    #   flake = false;
    # };
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
        unstable-overlay = final: prev: {
          unstable = (
            import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            }
          );
        };
        overlays = [
          (
            self: super: {
              rofi = super.fetchFromGitHub {
                owner = "ibonn";
                repo = "rofi";
                rev = "ab1ce4a4ca3ea236af1cbf13ec60ecc27b7e8fb8";
                sha256 = "0925ki783hf1bil52s6adwm3c4j15c38p4m5243i0imh8hzcc1f6";
              };
            }
          )
          # (
          #   self: super: {
          #     bitwarden-rofi = super.callPackage ./packages/bitwarden-rofi;
          #   }
          # )
          unstable-overlay
          nur.overlay
        ];
      in
        {
          nixosConfigurations.t14s = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = overlays;
                nixpkgs.config.allowUnfree = true;
                home-manager.useUserPackages = true;
                system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
              }
              nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
              nixpkgs.nixosModules.notDetected
              home-manager.nixosModules.home-manager
              # sops-nix.nixosModules.sops
              ./modules
              ./machines/t14s/configuration.nix
            ];
            # extraArgs = { inputs = inputs; };
            specialArgs = { inherit inputs; };
          };
          nixosConfigurations.canyon = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              {
                nixpkgs.overlays = overlays;
                nixpkgs.config.allowUnfree = true;
                home-manager.useUserPackages = true;
                system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
              }
              nixpkgs.nixosModules.notDetected
              home-manager.nixosModules.home-manager
              ./modules
              ./machines/canyon/configuration.nix
            ];
            specialArgs = { inherit inputs; };
          };
        };
}
