{
  config,
  lib,
  mylib,
  ...
}:

with lib;
let
  inherit (mylib) trimHash;
  cfg = config.programs.foot;
  color = config.background.color;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "SUPER, T, exec, foot"
      ];
    };
    programs.foot = {
      settings = {
        main = {
          term = "xterm-256color";
          font = "SpaceMono Nerd Font:size=7";
          dpi-aware = "yes";
          pad = "25x25 center";
        };

        colors = {
          background = trimHash color.surface;
          alpha = 0.90;
        };
      };
    };
  };
}
