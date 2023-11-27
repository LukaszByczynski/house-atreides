{
  description = "Home Manager NixOS configuration";

  inputs = {
    # Specify the source of Nixpkgs and Home Manager.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
    } @inputs: let
      # supported systems
      supportedSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
      ];

      # allow unfree packages in the supported systems
      legacyPackages = supportedSystems (system:
        import nixpkgs {
          inherit system;
          config = {allowUnfree = true;};
          overlays = with inputs; [
          ];
      });

      unstablePackages = supportedSystems (system:
        import nixpkgs-unstable {
          inherit system;
          config = {allowUnfree = true;};
          overlays = with inputs; [
          ];
      });
    in {
      homeConfigurations = {

        szwagier = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            ./linux.nix
          ];
          extraSpecialArgs = {
            pkgs-unstable = unstablePackages.x86_64-linux;
          };
        };

        virmir = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
            ./osx.nix
          ];
          extraSpecialArgs = {
            pkgs-unstable = unstablePackages.x86_64-darwin;
          };
        };
	
      	mbwork = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
            ./osx-work.nix
          ];
          extraSpecialArgs = {
            pkgs-unstable = unstablePackages.x86_64-darwin;
          };
        };

      };
      defaultPackage.x86_64-linux = self.homeConfigurations.szwagier.activationPackage;
      defaultPackage.x86_64-darwin = self.homeConfigurations.virmir.activationPackage;
    };
}
