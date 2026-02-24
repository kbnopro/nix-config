{
  config,
  ...
}:
let
  colors = config.background.colors;
in
{
  wayland.windowManager.hyprland.settings = {
    general = with colors; {
      "col.active_border" = "rgba(${onSurface}39)";
      "col.inactive_border" = "rgba(${outline}30)";
    };
  };
}
