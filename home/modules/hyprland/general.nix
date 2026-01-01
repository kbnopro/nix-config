{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {

    general = {
      # Gaps and border
      gaps_in = 4;
      gaps_out = 5;
      gaps_workspaces = 50;
      border_size = 1;

      resize_on_border = true;
      no_focus_fallback = true;
      layout = "dwindle";

      # focus_to_other_workspaces = true # ahhhh i still haven't properly implemented this
      allow_tearing = true; # This just allows the `immediate` window rule to work

      animations = {
        bezier = [
          "linear, 0, 0, 1, 1"
          "md3_standard, 0.2, 0, 0, 1"
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
          "softAcDecel, 0.26, 0.26, 0.15, 1"
          "md2, 0.4, 0, 0.2, 1"
        ];

        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel, slide"
          "layersOut, 1, 1.6, menu_accel"
          "fadeLayersIn, 1, 2, menu_decel"
          "fadeLayersOut, 1, 4.5, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
    };

    misc = {
      vfr = 1;
      vrr = 1;
      animate_manual_resizes = false;
      animate_mouse_windowdragging = false;
      enable_swallow = false;
      swallow_regex = "(foot|kitty|allacritty|Alacritty)";
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      new_window_takes_over_fullscreen = 2;
      allow_session_lock_restore = true;
      initial_workspace_tracking = false;
      focus_on_activate = true;
    };

    dwindle = {
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
    };

    decoration = {
      rounding = 10;

      blur = {
        enabled = true;
        xray = true;
        special = false;
        new_optimizations = true;
        size = 14;
        passes = 4;
        brightness = 1;
        noise = 0.01;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
      };

      shadow = {
        enabled = true;
        ignore_window = true;
        range = 20;
        offset = "0, 2";
        render_power = 4;
        color = "rgba(0000002A)";
      };

      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0;
    };
  };
}
