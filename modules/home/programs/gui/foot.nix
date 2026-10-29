{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.programs.foot;
  colors = config.background.colors;
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + T"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('${cfg.package}/bin/footclient')")
          ];
        }
      ];
    };
    programs.foot = {
      server.enable = true;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:size=10";
          dpi-aware = "no";
          pad = "16x16 center";
        };

        colors-dark = with colors; {
          background = surface;
          foreground = onSurface;
          regular0 = term0;
          regular1 = term1;
          regular2 = term2;
          regular3 = term3;
          regular4 = term4;
          regular5 = term5;
          regular6 = term6;
          regular7 = term7;
          bright0 = term8;
          bright1 = term9;
          bright2 = term10;
          bright3 = term11;
          bright4 = term12;
          bright5 = term13;
          bright6 = term14;
          bright7 = term15;
          alpha = 0.90;
        };

      };
    };
  };
}
