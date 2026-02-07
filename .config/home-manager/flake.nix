{
  description = "Home Manager NixOS configuration";

  inputs = {
    # Specify the source of Nixpkgs and Home Manager.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
        "aarch64-darwin"
      ];

      # allow unfree packages in the supported systems
      legacyPackages = supportedSystems (system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "python-2.7.18.6"
            ];
          };
          overlays = with inputs; [
            #HACK: temporary workaround for nix-functional-tests failing on aarch64-darwin. enable this when it starts to fail.
            #see https://github.com/NixOS/nix/issues/13106
            (self: super: {
              nix =
                if self.stdenv.isDarwin
                then
                  super.nix.overrideAttrs (oldAttrs: {
                    doCheck = false;
                    doInstallCheck = false;
                  })
                else super.nix;
            })
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

      	mbair = home-manager.lib.homeManagerConfiguration {
      	  pkgs = legacyPackages.aarch64-darwin;
      	  modules = [
      	    ./osx-mbair.nix
      	  ];
      	  extraSpecialArgs = {
      	    pkgs-unstable = unstablePackages.aarch64-darwin;
      	  };
      	};

        virmir = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.x86_64-linux;
          modules = [
            ./linux-virmir.nix
          ];
          extraSpecialArgs = {
            pkgs-unstable = unstablePackages.x86_64-linux;
          };
        };
	
      	mbwork = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages.aarch64-darwin;
          modules = [
            ./osx-mbwork.nix
          ];
          extraSpecialArgs = {
            pkgs-unstable = unstablePackages.aarch64-darwin;
          };
        };

      };
      defaultPackage.x86_64-linux = self.homeConfigurations.szwagier.activationPackage;
      defaultPackage.aarch64-darwin = self.homeConfigurations.mbair.activationPackage;
    };
}
