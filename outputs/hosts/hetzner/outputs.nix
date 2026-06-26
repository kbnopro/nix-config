{
  self,
  deploy-rs,
  disko,
  ...
}@inputs:
let
  utils = import ../utils.nix inputs;
  inherit (utils) mkNixOSSystem;
in
{

  nixosConfigurations = mkNixOSSystem {
    configuration = ./configuration.nix;
    extraModules = [
      disko.nixosModules.disko
    ];
  };

  nodes = {
    hostname = "hetzner";
    sshUser = "root";
    profiles.system = {
      user = "root";
      path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations."hetzner";
    };
  };

}
