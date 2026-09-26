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
  config = mkIf (cfg.enable && pkgs.stdenv.hostPlatform.isDarwin) {
    programs.ghostty.package = pkgs.ghostty-bin;
    programs.ghostty.settings.font-size = lib.mkForce 13;
    programs.ghostty.settings.macos-option-as-alt = true;
  };
}
