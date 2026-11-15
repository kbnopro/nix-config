{ lib, ... }: {
  options.nixos = {
    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (configurationArgs: {
          module = {
            networking.hostName = lib.mkDefault "kb-${configurationArgs.config.name}";
          };
        })
      );
    };
  };
}
