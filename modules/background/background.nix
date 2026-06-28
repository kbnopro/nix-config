{
  lib,
  pkgs,
  config,
  options,
  ...
}:
let
  bgPath = config.background.path;

  inherit
    (import ./_color.nix {
      inherit
        lib
        pkgs
        bgPath
        ;
    })
    colorAttrs
    ;
in
{
  options.background = {
    path = lib.mkOption {
      type = lib.types.path;
      default = ../../background-images/blue-sunset.jpg;
    };
    colors = lib.mkOption {
      type = lib.types.attrs;
    };
  };

  config = lib.mkMerge [
    {
      background.colors = colorAttrs;
    }
    (lib.optionalAttrs (options ? home-manager) {
      home-manager.sharedModules = [
        (
          { ... }:
          {
            # Options are inherited from the top-level, so should only be read only
            options.background = {
              path = lib.mkOption {
                type = lib.types.path;
                readOnly = true;
              };
              colors = lib.mkOption {
                type = lib.types.attrs;
                readOnly = true;
              };
            };

            config.background = {
              path = bgPath;
              colors = colorAttrs;
            };
          }
        )
      ];
    })
  ];
}
