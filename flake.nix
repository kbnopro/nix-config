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
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:numtide/flake-utils";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      spicetify-nix,
      nix-darwin,
      mac-app-util,
      nixos-hardware,
      flake-utils,
      disko,
      deploy-rs,
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

      commonNix =
        {
          ...
        }:
        {
          imports = [ applyOverlays ];
          nixpkgs.config.allowUnfree = true;
          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          # temporary workaround for electron 38.8.4, which is required by rstudio
          nixpkgs.config.permittedInsecurePackages = [
            "electron-38.8.4"
          ];
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
            commonNix
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
            commonNix
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
        extraModules = [
          nixos-hardware.nixosModules.dell-xps-15-9510
          # nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
        ];
      };

      nixosConfigurations."hetzner" = mkNixOSSystem {
        configuration = ./hetzner/configuration.nix;
        extraModules = [
          disko.nixosModules.disko
        ];
      };

      deploy.nodes."hetzner" = {
        hostname = "hetzner";
        sshUser = "root";
        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations."hetzner";
        };
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        lib = pkgs.lib;

        colors =
          (import ./modules/background/_color.nix {
            inherit lib pkgs;
            bgPath = ./background-images/blue-sunset.jpg;
          }).colorAttrs;

        nvf = inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./modules/nvf
          ];
          extraSpecialArgs = {
            inherit mylib colors;
          };
        };
      in
      {
        apps.nvim = {
          type = "app";
          program = "${nvf.neovim}/bin/nvim";
        };
      }
    )

  ;
}
