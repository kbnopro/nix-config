# Inspired by: https://github.com/end-4/dots-hyprland/blob/main/.config/hypr/hyprland/keybinds.conf
# We will have special syntax to be able to parse this for cheat sheet (in the future I hope)
# Lines ending with `# [hidden]` won't be shown on cheatsheet
# Lines starting with #! and #!! are section headings and sub headings
# Lines starting with #/# are only for cheatsheet
{
  ...
}:

{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, T, exec, kitty" # Temporary terminal

    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+" # [hidden]
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" # [hidden]
      ", XF86MonBrightnessUp, exec, brightnessctl set '5%+'" # [hidden]
      ", XF86MonBrightnessDown, exec, brightnessctl set --min-value=1 '5%-'" # [hidden]
    ];

    bindl = [
      ",XF86AudioPlay, exec, playerctl play-pause" # [hidden]
      ",XF86AudioPause, exec, playerctl play-pause" # [hidden]
      ",XF86AudioNext, exec, playerctl next" # [hidden]
      ",XF86AudioPrev, exec, playerctl previous" # [hidden]
    ];
  };
}
