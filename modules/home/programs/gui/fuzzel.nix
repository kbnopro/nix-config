{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.programs.fuzzel;
  colors = config.background.colors;
  opacity = lib.toHexString (builtins.ceil (colors.opacity * 255));
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + SPACE"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('pkill fuzzel || fuzzel')")
          ];
        }
      ];
    };
    programs.fuzzel.settings.colors = with colors; {
      background = "${surfaceContainerHigh}${opacity}";
      text = "${onSurface}ff";
      placeholder = "${term3}ff";
      prompt = "${onSurface}ff";
      input = "${onSurface}ff";
      match = "${term10}ff";
      selection = "${primary}ff";
      selection-text = "${onPrimary}ff";
      selection-match = "${onPrimary}ff";
      counter = "${term6}ff";
      border = "${primary}ff";
    };
  };
}
