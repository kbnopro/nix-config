{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.gpg;
in
{
  config = lib.mkIf cfg.enable {
    services.gpg-agent = {
      pinentry = {
        package = pkgs.pinentry-qt;
        program = "pinentry-qt";
      };
    };
  };
}
