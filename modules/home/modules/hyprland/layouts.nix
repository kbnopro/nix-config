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
      (mkBind "layout" "SUPER + APOSTROPHE" "colresize +conf")
      (mkBind "layout" "SUPER + SEMICOLON" "colresize -conf")
      # Expel, promote, consume
      (mkBind "layout" "SUPER + EQUAL" "expel")
      (mkBind "layout" "SUPER + MINUS" "consume")
    ];
  };
}
