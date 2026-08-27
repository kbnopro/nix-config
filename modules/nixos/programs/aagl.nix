{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.programs.anime-game-launcher;
  aagl = inputs.aagl;
in
{
  imports = [ aagl.nixosModules.default ];

  config = lib.mkIf cfg.enable {
    nix.settings = aagl.nixConfig;
  };
}
