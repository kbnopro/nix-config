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
      ];
    };
    home.packages = with pkgs; [
      rose-pine-hyprcursor
    ];
  };
}
