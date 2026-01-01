# Inspired by: https://github.com/end-4/dots-hyprland/blob/main/.config/hypr/hyprland/keybinds.conf
# We will have special syntax to be able to parse this for cheat sheet (in the future I hope)
# Lines ending with `# [hidden]` won't be shown on cheatsheet
# Lines starting with #! and ##! are section headings and sub headings
# Lines starting with #/# are only for cheatsheet
{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      ##! Window management
      # Focusing
      #/# bind = Super, ←/↑/→/↓,, # Move focus in direction
      "Super, h, movefocus, l" # [hidden]
      "Super, l, movefocus, r" # [hidden]
      "Super, k, movefocus, u" # [hidden]
      "Super, j, movefocus, d" # [hidden]
      "Super, Left, movefocus, l" # [hidden]
      "Super, Right, movefocus, r" # [hidden]
      "Super, Up, movefocus, u" # [hidden]
      "Super, Down, movefocus, d" # [hidden]
      "Super, BracketLeft, movefocus, l" # [hidden]
      "Super, BracketRight, movefocus, r" # [hidden]
      "Super, Q, killactive,"
      "Super+Shift+Alt, Q, exec, hyprctl kill" # Pick and kill a window

      ##! Window arrangement
      #/# bind = Super+Shift, ←/↑/→/↓,, # Window: move in direction
      "Super+Shift, h, movewindow, l" # [hidden]
      "Super+Shift, l, movewindow, r" # [hidden]
      "Super+Shift, k, movewindow, u" # [hidden]
      "Super+Shift, j, movewindow, d" # [hidden]
      "Super+Shift, Left, movewindow, l" # [hidden]
      "Super+Shift, Right, movewindow, r" # [hidden]
      "Super+Shift, Up, movewindow, u" # [hidden]
      "Super+Shift, Down, movewindow, d" # [hidden]

      # Window split ratio
      #/# binde = Super, +/-,, # Window: split ratio +/- 0.1
      "binde = Super, Minus, splitratio, -0.1" # [hidden]
      "binde = Super, Equal, splitratio, +0.1" # [hidden]
      "binde = Super, Semicolon, splitratio, -0.1" # [hidden]
      "binde = Super, Apostrophe, splitratio, +0.1" # [hidden]

      # Positioning mode
      "Super+Alt, Space, togglefloating,"
      "Super+Alt, F, fullscreenstate, 0 3" # Toggle fake fullscreen
      "Super, F, fullscreen, 0"
      "Super, D, fullscreen, 1"

      ##! Workspace navigation
      # Switching
      #/# bind = Super, Hash,, # Focus workspace # (1, 2, 3, 4, ...)
      "Super, 1, workspace, 1" # [hidden]
      "Super, 2, workspace, 2" # [hidden]
      "Super, 3, workspace, 3" # [hidden]
      "Super, 4, workspace, 4" # [hidden]
      "Super, 5, workspace, 5" # [hidden]
      "Super, 6, workspace, 6" # [hidden]
      "Super, 7, workspace, 7" # [hidden]
      "Super, 8, workspace, 8" # [hidden]
      "Super, 9, workspace, 9" # [hidden]
      "Super, 0, workspace, 10" # [hidden]

      ##! Workspace management
      # Move window to workspace Super + Alt + [0-9]
      #/# bind = Super+Alt, Hash,, # Window: move to workspace # (1, 2, 3, 4, ...)
      "Super+Alt, 1, movetoworkspacesilent, 1" # [hidden]
      "Super+Alt, 2, movetoworkspacesilent, 2" # [hidden]
      "Super+Alt, 3, movetoworkspacesilent, 3" # [hidden]
      "Super+Alt, 4, movetoworkspacesilent, 4" # [hidden]
      "Super+Alt, 5, movetoworkspacesilent, 5" # [hidden]
      "Super+Alt, 6, movetoworkspacesilent, 6" # [hidden]
      "Super+Alt, 7, movetoworkspacesilent, 7" # [hidden]
      "Super+Alt, 8, movetoworkspacesilent, 8" # [hidden]
      "Super+Alt, 9, movetoworkspacesilent, 9" # [hidden]
      "Super+Alt, 0, movetoworkspacesilent, 10" # [hidden]
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" # [hidden]
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" # [hidden]
      ", XF86MonBrightnessUp, exec, brightnessctl set '5%+'" # [hidden]
      ", XF86MonBrightnessDown, exec, brightnessctl set --min-value=1 '5%-'" # [hidden]
    ];

    bindl = [
      ", XF86AudioPlay, exec, playerctl play-pause" # [hidden]
      ", XF86AudioPause, exec, playerctl play-pause" # [hidden]
      ", XF86AudioNext, exec, playerctl next" # [hidden]
      ", XF86AudioPrev, exec, playerctl previous" # [hidden]
    ];

    bindm = [
      "bindm = Super, mouse:272, movewindow"
      "bindm = Super, mouse:273, resizewindow"
    ];
  };
}
