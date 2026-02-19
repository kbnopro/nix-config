{
  config,
  ...
}:
let
  color = config.background.color;
in
{
  wayland.windowManager.hyprland.settings = {
    general = {
      "col.active_border" = "rgba(${color.withoutHash.onSurface}39)";
      "col.inactive_border" = "rgba(${color.withoutHash.outline}30)";
    };
  };
}
