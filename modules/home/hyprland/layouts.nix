{
  lib,
  ...
}:
let
  utils = import ./_utils.nix { inherit lib; };
  inherit (utils) mkBind;
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      general.layout = "scrolling"; # default layout
      scrolling = {

      };
      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
      };
    };
    bind = [
      # Resizing
      (mkBind "SUPER + APOSTROPHE" "layout" "colresize +conf")
      (mkBind "SUPER + SEMICOLON" "layout" "colresize -conf")
      # Expel, promote, consume
      (mkBind "SUPER + EQUAL" "layout" "expel")
      (mkBind "SUPER + MINUS" "layout" "consume")
    ];
  };
}
