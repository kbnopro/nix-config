{
  deploy-rs,
  nixpkgs,
  flake-parts,
  import-tree,
  ...
}@inputs:
let
  lib = nixpkgs.lib;

  hosts = {
    xps15 = import ./hosts/xps15/outputs.nix inputs;
    hetzner = import ./hosts/hetzner/outputs.nix inputs;
    m4-air = import ./hosts/m4-air/outputs.nix inputs;
    naki = import ./hosts/naki/outputs.nix inputs;
    meshy = import ./hosts/meshy/outputs.nix inputs;
    fw13p = import ./hosts/fw13p/outputs.nix inputs;
  };

  loadOutputs =
    name: hosts |> lib.filterAttrs (_: lib.hasAttr name) |> lib.mapAttrs (_: v: v.${name});

  # Define deploy configuration locally to avoid self-reference recursion
  deployConfig = {
    nodes = loadOutputs "nodes";
  };
in
(

  flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      (import-tree.filterNot (lib.hasSuffix ".pkg.nix") ../den-modules)
    ];

    flake = {
      nixosConfigurations = loadOutputs "nixosConfigurations";
      darwinConfigurations = loadOutputs "darwinConfigurations";
      deploy = deployConfig;

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks deployConfig) deploy-rs.lib;
    };
  }
)
// (import ./apps/nvim.nix inputs)
