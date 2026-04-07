{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.hyprland;
in

{
  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "AQ_NO_MODIFIERS,1"
        # "AQ_DRM_DEVICES, /dev/dri/nvidia-dgpu:/dev/dri/intel-igpu"
      ];
    };
    home.packages = with pkgs; [
      rose-pine-hyprcursor
    ];
  };
}
