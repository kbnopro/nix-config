inputs@{
  nixpkgs,
  home-manager,
  spicetify-nix,
  nix-darwin,
  mac-app-util,
  ...
}:
let
  mylib = import ../../lib { inherit (nixpkgs) lib; };

  specialArgs = {
    inherit inputs mylib;
  };

  applyOverlays =
    let
      overlays = import ../../overlay.nix inputs;
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
      imports = [
        applyOverlays
        ../../modules/background
      ];
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

in
{
  inherit mylib specialArgs;

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
        ../../modules/darwin
        configuration
        mac-app-util.darwinModules.default

        # home-manager
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            sharedModules = [
              mac-app-util.homeManagerModules.default
              spicetify-nix.homeManagerModules.spicetify
              ../../modules/home
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
        ../../modules/nixos
        configuration
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            sharedModules = [
              spicetify-nix.homeManagerModules.spicetify
              ../../modules/home
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
}
