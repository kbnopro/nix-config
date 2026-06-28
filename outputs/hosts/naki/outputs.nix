{
  ...
}@inputs:
let
  utils = import ../utils.nix inputs;
  inherit (utils) mkDarwinSystem;
in
{

  darwinConfigurations = mkDarwinSystem {
    configuration = ./configuration.nix;
    homeManagerUsers = {
      theatran.imports = [ ./home.nix ];
    };
  };
}
