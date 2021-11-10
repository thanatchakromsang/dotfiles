{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    /* nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; */
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # # TODO: use sops-nix for secrets
    # sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    # , nixpkgs-unstable
    , home-manager
    , nur
    , nixos-hardware
      # , sops-nix
    }@inputs:
      let
        inherit (nixpkgs) lib;
        # unstable-overlay = final: prev: {
        #   unstable = (
        #     import nixpkgs-unstable {
        #       system = "x86_64-linux";
        #       config.allowUnfree = true;
        #     }
        #   );
        # };
        overlays = [
          # TODO: Refactor custom overlay
          (
            self: super: {
              rofi-bluetooth = super.callPackage ./packages/rofi-bluetooth {};
              # Override to create `kubectl-ctx`, `kubectl-ns` as kubectl plugins
              kubectx = super.kubectx.overrideAttrs (
                old: {
                  postInstall = ''
                    ${old.postInstall}

                    mkdir -p $out/bin
                    cp kubectx $out/bin/kubectl-ctx
                    cp kubens $out/bin/kubectl-ns
                  '';
                }
              );
            }
          )
          /* unstable-overlay */
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
