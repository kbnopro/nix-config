{
  inputs,
  lib,
  ...
}:
{
  options.homeManager = {
    modules = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        apply = module: {
          key = "base";
          imports = [ module ];
        };
        default = { };
      };
      gui = lib.mkOption {
        type = lib.types.deferredModule;
        apply = module: {
          key = "gui";
          imports = [ module ];
        };
        default = { };
      };
    };
  };

  config = {
    _module.args.homeManager = import "${inputs.home-manager}/lib" { inherit lib; };

    homeManager.modules.base = {
      programs.home-manager.enable = true;
    };

    nixos.modules.base = { pkgs, ... }: {
      home-manager = {
        sharedModules = [
          ({ osConfig, ... }: {
            home = {
              stateVersion = osConfig.system.stateVersion;
            };
          })
        ];
        backupCommand = lib.getExe' pkgs.trash-cli "trash-put";
      };
    };
  };
}
