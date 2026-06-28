{
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
        {
          _args = [
            "HYPRCURSOR_THEME"
            "rose-pine-hyprcursor"
          ];
        }
      ];
    };
  };
}
