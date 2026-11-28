{ inputs, lib, ... }: {
  options.nixos = {
    modules.aagl = lib.mkOption {
      type = lib.types.deferredModule;
      apply = module: {
        key = "aagl";
        imports = [ module ];
      };
    };
  };
  config = {
    nixos.modules.aagl = {
      imports = [ inputs.aagl.nixosModules.default ];
      boot.kernelModules = [ "ntsync" ];
      programs.anime-game-launcher.enable = true;
      nix.settings = inputs.aagl.nixConfig;

      home-manager.sharedModules = [
        {
          wayland.windowManager.hyprland.settings = {
            window_rule = [
              {
                match.title = "Genshin Impact";
                idle_inhibit = "always";
              }
            ];
          };
        }
      ];
    };

    perSystem = {
      nixpkgs.config.allowUnfreePackages = [
        "steam-unwrapped"
      ];
    };
  };
}
