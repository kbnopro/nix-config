{ lib, ... }: {
  options.nixos = {
    modules.power-management = lib.mkOption {
      type = lib.types.deferredModule;
      apply = module: {
        key = "power-management";
        imports = [ module ];
      };
    };
  };

  config.nixos.modules.power-management = {
    services = {
      tlp = {
        enable = true;
        settings = {
          TLP_AUTO_SWITCH = 1;
          TLP_PROFILE_BAT = "SAV";
        };
      };
      upower.enable = true;
      logind.settings.Login.HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
    };

    systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";
  };
}
