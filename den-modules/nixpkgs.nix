{
  inputs,
  lib,
  withSystem,
  ...
}:
{
  perSystem =
    {
      system,
      pkgs,
      ...
    }:
    {
      imports = [ "${inputs.nixpkgs}/nixos/modules/misc/nixpkgs.nix" ];
      nixpkgs.hostPlatform = { inherit system; };
      legacyPackages = pkgs;
      # TODO: move this to corresponding module after migrating nvf to dendritic
      nixpkgs.config.allowUnfreePackages = [
        "copilot-language-server"
        "spotify"
        "discord"
        "discord-unwrapped"
      ];
    };

  nixos.modules.base =
    _nixosArgs@{ pkgs, config, ... }:
    {
      # TODO: This hardcode system can be solved by facters, so ig todo facter
      nixpkgs.pkgs = withSystem "x86_64-linux" (lib.getAttr "pkgs");
      home-manager.useGlobalPkgs = true;
    };
}
