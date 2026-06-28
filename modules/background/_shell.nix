# save this as shell.nix
{
  pkgs ? import <nixpkgs> { },
}:
let
  inherit (import ./_pythonEnv.nix { inherit pkgs; }) pythonEnv;
in
pkgs.mkShell {
  packages = [ pythonEnv ];
}
