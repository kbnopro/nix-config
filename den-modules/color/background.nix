{ lib, ... }:
{
  nixos.modules.base =
    nixosArgs@{ pkgs, ... }:
    let
      colors = pkgs.callPackage ./color.pkg.nix {
        backgroundPath = nixosArgs.config.backgroundPath;
      };
    in
    {
      options = {
        backgroundPath = lib.mkOption {
          type = lib.types.path;
          default = ../../background-images/cute-anime-thingy.png;
        };
        colors = lib.mkOption {
          type = lib.types.attrs;
          default = colors;
          readOnly = true;
        };
      };
      config = {
        home-manager.sharedModules = [
          (
            { ... }:
            {
              # Options are inherited from the top-level, so should only be read only
              options = {
                colors = lib.mkOption {
                  type = lib.types.attrs;
                  default = colors;
                  readOnly = true;
                };
              };
            }
          )
        ];
      };
    };
}
