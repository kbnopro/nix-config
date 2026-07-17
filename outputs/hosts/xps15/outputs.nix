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
      khanhbui.imports = [ ./home.nix ];
    };
    extraModules = [
      nixos-hardware.nixosModules.dell-xps-15-9510
      nixos-hardware.nixosModules.dell-xps-15-9510-nvidia
    ];
  };
}
