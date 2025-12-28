{
  config,
  mylib,
  ...
}:
let
  color = config.background.color;
  inherit (mylib) trimHash;
in
{
  wayland.windowManager.hyprland.settings = {
    general = {
      "col.active_border" = "rgba(${trimHash color.onSurface}39)";
      "col.inactive_border" = "rgba(${trimHash color.outline}30)";
    };
  };
}
