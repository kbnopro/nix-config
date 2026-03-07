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

    in
    {
      darwinConfigurations."naki" = nix-darwin.lib.darwinSystem {
        inherit specialArgs;

        modules = [
          ./naki/configuration.nix
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
          {
            home-manager = {
              sharedModules = [
                mac-app-util.homeManagerModules.default
                spicetify-nix.homeManagerModules.spicetify
              ];
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.theatran.imports = [ ./home/naki.nix ];
            };
          }
        ];
      };

      nixosConfigurations."xps15" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        system = "x86_64-linux";
        modules = [
          applyOverlays
          ./xps15/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              sharedModules = [
                spicetify-nix.homeManagerModules.spicetify
              ];
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.khanhbui.imports = [ ./home/xps15.nix ];
            };
          }
        ];
      };
    };
}
