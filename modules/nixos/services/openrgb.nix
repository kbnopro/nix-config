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
      pkgs.xvfb-run
    ];
    environment = {
      QT_QPA_PLATFORM = "offscreen";
    };
    serviceConfig.ExecStart = lib.mkForce (
      lib.escapeShellArgs ([
        (lib.getExe cfg.package)
        "--server"
        "--startminimized"
      ])
    );

  };
}
