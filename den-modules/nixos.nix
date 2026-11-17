# Adapted from: https://github.com/mightyiam/infra/blob/master/modules/nixos.nix
{
  config,
  lib,
  evalModulesModule,
  inputs,
  ...
}:
{
  options.nixos = {
    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (
          { name, ... }: {
            imports = [ evalModulesModule ];
            options.name = lib.mkOption {
              readOnly = true;
              type = lib.types.str;
              default = name;
            };
            config = {
              fn = import "${inputs.nixpkgs}/nixos/lib/eval-config.nix";
              args = {
                # system = null;
              }
              // ((import ../outputs/hosts/${name}/outputs.nix inputs).configuration);
            };
          }
        )
      );
    };

    modules = {
      base = lib.mkOption {
        type = lib.types.deferredModule;
        apply = module: {
          key = "base";
          imports = [ module ];
        };
        default = { };
      };

      pc = lib.mkOption {
        type = lib.types.deferredModuleWith {
          staticModules = [ config.nixos.modules.base ];
        };
        apply = module: {
          key = "pc";
          imports = [ module ];
        };
        default = { };
      };
    };
  };

  config = {
    flake = {
      nixosConfigurations =
        config.nixos.configurations
        |> lib.mapAttrs' (
          name:
          { configuration, ... }:
          let
            # Modify your name here (e.g., adding a prefix, suffix, or mapping it)
            newName = "${name}-dendritic";

          in
          {
            name = newName;
            value = configuration;
          }
        );
    };
  };
}
