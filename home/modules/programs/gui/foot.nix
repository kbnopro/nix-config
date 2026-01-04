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
          font = "SpaceMono Nerd Font:size=10";
          dpi-aware = "no";
          pad = "25x25 center";
        };

        colors = {
          background = trimHash color.surface;
          foreground = trimHash color.onSurface;
          regular0 = trimHash color.term0;
          regular1 = trimHash color.term1;
          regular2 = trimHash color.term2;
          regular3 = trimHash color.term3;
          regular4 = trimHash color.term4;
          regular5 = trimHash color.term5;
          regular6 = trimHash color.term6;
          regular7 = trimHash color.term7;
          bright0 = trimHash color.term8;
          bright1 = trimHash color.term9;
          bright2 = trimHash color.term10;
          bright3 = trimHash color.term11;
          bright4 = trimHash color.term12;
          bright5 = trimHash color.term13;
          bright6 = trimHash color.term14;
          bright7 = trimHash color.term15;
          alpha = 0.90;
        };
      };
    };
  };
}
