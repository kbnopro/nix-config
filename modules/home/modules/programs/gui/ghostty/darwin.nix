{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.programs.ghostty;
in
{
  config = mkIf (cfg.enable && pkgs.stdenv.isDarwin) {
    programs.ghostty.package = pkgs.ghostty-bin;
  };
}
