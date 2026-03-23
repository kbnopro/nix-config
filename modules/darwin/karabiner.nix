{
  config,
  lib,
  ...
}:
let
  cfg = config.services.my-karabiner;

in
{
  # services.karabiner-elements = {
  #   package = pkgs.karabiner-elements.overrideAttrs (old: {
  #     version = "14.13.0";
  #
  #     src = pkgs.fetchurl {
  #       inherit (old.src) url;
  #       hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
  #     };
  #
  #     dontFixup = true;
  #   });
  # };

  options = {
    services.my-karabiner = {
      enable = lib.mkEnableOption "Karabiner Elements";
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "karabiner-elements" ];
  };
}
