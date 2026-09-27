{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.services.hardware.openrgb;

  hasNvidia = builtins.elem "nvidia" config.services.xserver.videoDrivers;

  nvidiaPkg = if hasNvidia then config.hardware.nvidia.package else null;
in
{
  services.hardware.openrgb = {
    package = pkgs.openrgb-with-all-plugins;
  };
  systemd.services.openrgb = {
    path = [
      nvidiaPkg
    ];
    environment = {
      QT_QPA_PLATFORM = "offscreen";
    };
    serviceConfig.ExecStart = lib.mkForce (
      lib.escapeShellArgs ([
        (lib.getExe cfg.package)
        # TODO: figure out a way to load plugins
        "--startminimized"
        "--server"
        "--profile"
        "profile"
      ])
    );
  };
}
