{
  inputs,
  lib,
  config,
  ...
}:
{
  options = {
    users = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          userArgs@{ name, ... }:
          {
            options = {
              username = lib.mkOption {
                type = lib.types.singleLineStr;
                default = name;
              };
              name = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
              };
              email = lib.mkOption {
                type = lib.types.nullOr lib.types.singleLineStr;
                default = null;
              };
              # Not auto importing the shared modules to avoid collisions when multiple users are defined.
              nixos = {
                base = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      {
                        users.users.${name} = {
                          name = userArgs.config.username;
                          isNormalUser = true;
                          useDefaultShell = lib.mkDefault true;
                          initialPassword = "psswd";
                        };
                        home-manager.users.${name} = userArgs.config.home.base;
                      }
                    ];
                  };
                  apply = module: {
                    key = "${name}-base";
                    imports = [ module ];
                  };
                  default = { };
                };
                pc = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      {
                        imports = [ userArgs.config.nixos.base ];
                        home-manager.users.${name} = userArgs.config.home.gui;
                      }
                    ];
                  };
                  apply = module: {
                    key = "${name}-pc";
                    imports = [ module ];
                  };
                  default = { };
                };
              };
              home = {
                base = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      {
                        imports = [ config.homeManager.modules.base ];
                        home.username = lib.mkDefault userArgs.config.username;
                      }
                    ];
                  };
                  apply = module: {
                    key = "${name}-base";
                    imports = [ module ];
                  };
                  default = { };
                };
                gui = lib.mkOption {
                  type = lib.types.deferredModuleWith {
                    staticModules = [
                      userArgs.config.home.base
                      config.homeManager.modules.gui
                    ];
                  };
                  apply = module: {
                    key = "${name}-gui";
                    imports = [ module ];
                  };
                  default = { };
                };
              };
            };
          }
        )
      );
    };
  };
  config.nixos.modules.base = { pkgs, ... }: {
    imports = [ "${inputs.home-manager}/nixos" ];
    users.defaultUserShell = pkgs.fish;
  };
}
