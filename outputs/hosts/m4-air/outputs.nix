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
      khanhbui.imports = [ ./home.nix ];
    };
  };
}
