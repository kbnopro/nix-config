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
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:

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
      nixosConfigurations."xps15" = nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        system = "x86_64-linux";
        modules = [
          applyOverlays
          ./xps15/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
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
