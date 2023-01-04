{
  description = "Home Manager NixOS configuration";

  inputs = {
    # Specify the source of Nixpkgs and Home Manager.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
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
    in {
      homeConfigurations = {

        szwagier = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            ./linux.nix
          ];
        };

        virmir = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
            ./osx.nix
          ];
        };
	
	mbwork = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-darwin;
          modules = [
            ./osx-work.nix
	  ];
	};

      };
      defaultPackage.x86_64-linux = self.homeConfigurations.szwagier.activationPackage;
      defaultPackage.x86_64-darwin = self.homeConfigurations.virmir.activationPackage;
    };
}
