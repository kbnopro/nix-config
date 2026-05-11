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
      enable = true;
      pinentry = {
        package = pkgs.pinentry-qt;
        program = "pinentry-qt";
      };
    };
  };
}
