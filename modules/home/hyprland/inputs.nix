{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    gesture = {
      fingers = 3;
      direction = "horizontal";
      action = "workspace";
    };

    config = {
      input = {
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
        };
        follow_mouse = 2;
        accel_profile = "flat";
      };
    };
  };
}
