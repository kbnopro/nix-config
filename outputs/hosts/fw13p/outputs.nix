{
  nixos-hardware,
  ...
}@inputs:
let
  utils = import ../utils.nix inputs;
  inherit (utils) mkNixOSSystem;
in
{

  nixosConfigurations = mkNixOSSystem {
    configuration = ./configuration.nix;
    homeManagerUsers = {
      khanhbui.imports = [
        ./home.nix
        ./easy-effects.nix
      ];
    };
    extraModules = [
      nixos-hardware.nixosModules.framework-intel-core-ultra-series3
    ];
  };
}
