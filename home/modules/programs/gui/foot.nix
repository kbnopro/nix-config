{
  config,
  lib,
  ...
}:

with lib;
let
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
          font = "SpaceMono Nerd Font:size=10";
          dpi-aware = "no";
          pad = "25x25 center";
        };

        colors = {
          background = color.withoutHash.surface;
          foreground = color.withoutHash.onSurface;
          regular0 = color.withoutHash.term0;
          regular1 = color.withoutHash.term1;
          regular2 = color.withoutHash.term2;
          regular3 = color.withoutHash.term3;
          regular4 = color.withoutHash.term4;
          regular5 = color.withoutHash.term5;
          regular6 = color.withoutHash.term6;
          regular7 = color.withoutHash.term7;
          bright0 = color.withoutHash.term8;
          bright1 = color.withoutHash.term9;
          bright2 = color.withoutHash.term10;
          bright3 = color.withoutHash.term11;
          bright4 = color.withoutHash.term12;
          bright5 = color.withoutHash.term13;
          bright6 = color.withoutHash.term14;
          bright7 = color.withoutHash.term15;
          alpha = 0.90;
        };
      };
    };
  };
}
