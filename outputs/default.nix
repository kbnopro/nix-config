{
  self,
  deploy-rs,
  nixpkgs,
  ...
}@inputs:
let
  lib = nixpkgs.lib;

  hosts = {
    xps15 = import ./hosts/xps15/outputs.nix inputs;
    hetzner = import ./hosts/hetzner/outputs.nix inputs;
    m4-air = import ./hosts/m4-air/outputs.nix inputs;
    naki = import ./hosts/naki/outputs.nix inputs;
  };

  loadOutputs =
    name: hosts |> lib.filterAttrs (_: lib.hasAttr name) |> lib.mapAttrs (_: v: v.${name});
in
{
  nixosConfigurations = loadOutputs "nixosConfigurations";
  darwinConfigurations = loadOutputs "darwinConfigurations";
  deploy.nodes = loadOutputs "nodes";

  checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
}
// (import ./apps/nvim.nix inputs)
