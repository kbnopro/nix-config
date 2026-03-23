{
  description = "kb's systems";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      spicetify-nix,
      nix-darwin,
      mac-app-util,
      ...
    }:

    let
      mylib = import ./lib { inherit (nixpkgs) lib; };

      specialArgs = {
        inherit inputs mylib;
      };

      applyOverlays =
        let
          overlays = import ./overlay.nix inputs;
        in
        { ... }:
        {
          nixpkgs.overlays = nixpkgs.lib.mkAfter overlays;
        };

      mkDarwinSystem =
        {
          configuration,
          homeManagerUsers ? { },
          extraModules ? [ ],
        }:
        nix-darwin.lib.darwinSystem {
          inherit specialArgs;

          system = "aarch64-darwin";
          modules = [
            applyOverlays
            ./modules/background
            ./modules/darwin
            configuration
            mac-app-util.darwinModules.default

            # home-manager
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                sharedModules = [
                  mac-app-util.homeManagerModules.default
                  spicetify-nix.homeManagerModules.spicetify
                ];
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users = homeManagerUsers;
              };
            }
          ]
          ++ extraModules;
        };

      mkNixOSSystem =
        {
          configuration,
          homeManagerUsers ? { },
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          system = "x86_64-linux";
          modules = [
            applyOverlays
            ./modules/background
            ./modules/nixos
            configuration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                sharedModules = [
                  spicetify-nix.homeManagerModules.spicetify
                ];
                extraSpecialArgs = specialArgs;
                useGlobalPkgs = true;
                useUserPackages = true;
                users = homeManagerUsers;
              };
            }
          ]
          ++ extraModules;
        };

    in
    {
      darwinConfigurations."naki" = mkDarwinSystem {
        configuration = ./naki/configuration.nix;
        homeManagerUsers = {
          theatran.imports = [ ./modules/home/naki.nix ];
        };
      };

      darwinConfigurations."m4-air" = mkDarwinSystem {
        configuration = ./m4-air/configuration.nix;
        homeManagerUsers = {
          khanhbui.imports = [ ./modules/home/m4-air.nix ];
        };
      };

      nixosConfigurations."xps15" = mkNixOSSystem {
        configuration = ./xps15/configuration.nix;
        homeManagerUsers = {
          khanhbui.imports = [ ./modules/home/xps15.nix ];
        };
      };
    };
}
