{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.programs.fuzzel;
  color = config.background.color;
  opacity = lib.toHexString (builtins.ceil (color.opacity * 255));
in
{
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "Super, Space, exec, pkill fuzzel || fuzzel"
      ];
    };
    programs.fuzzel.settings.colors = with color.withoutHash; {
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
