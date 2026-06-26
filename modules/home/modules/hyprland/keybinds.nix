{
  lib,
  ...
}:
let
  utils = import ./_utils.nix { inherit lib; };
  inherit (utils)
    mkBind
    mkBindFlags
    directions
    workspaces
    addModifier
    ;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = lib.flatten [
      # Window focus
      (
        directions
        |> (map (addModifier "SUPER"))
        |> (map ({ key, direction }: (mkBind "focus" key { inherit direction; })))
      )
      # Move window
      (
        directions
        |> (map (addModifier "SUPER + SHIFT"))
        |> (map ({ key, direction }: (mkBind "window.move" key { inherit direction; })))
      )
      # Close window
      (mkBind "window.close" "SUPER + Q" { })

      # Workspace focus
      (
        workspaces
        |> (map (addModifier "SUPER"))
        |> (map ({ key, workspace }: (mkBind "focus" key { inherit workspace; })))
      )
      (
        [
          {
            key = "l";
            direction = "r+1";
          }
          {
            key = "h";
            direction = "r-1";
          }
        ]
        |> (map (addModifier "SUPER + CTRL"))
        |> (map ({ key, direction }: (mkBind "focus" key { workspace = direction; })))
      )
      # Move window to workspace
      (
        workspaces
        |> (map (addModifier "SUPER + ALT"))
        |> (map (
          { key, workspace }:
          (mkBind "window.move" key {
            inherit workspace;
            follow = false;
          })
        ))
      )

      # Volume control
      (
        [
          {
            key = "XF86AudioRaiseVolume";
            command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          }
          {
            key = "XF86AudioLowerVolume";
            command = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          }
        ]
        |> (map ({ key, command }: (mkBindFlags "exec_cmd" key command { repeating = true; })))
      )
      # Audio play and mute button
      (
        [
          {
            key = "XF86AudioMute";
            command = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          }
          {
            key = "XF86AudioPlay";
            command = "playerctl play-pause";
          }
          {
            key = "XF86AudioNext";
            command = "playerctl next";
          }
          {
            key = "XF86AudioPrev";
            command = "playerctl previous";
          }
        ]
        |> (map ({ key, command }: (mkBindFlags "exec_cmd" key command { locked = true; })))
      )
      # Brightness control
      (
        [
          {
            key = "XF86MonBrightnessUp";
            command = "brightnessctl set '5%+'";
          }
          {
            key = "XF86MonBrightnessDown";
            command = "brightnessctl set --min-value=1 '5%-'";
          }
        ]
        |> (map ({ key, command }: (mkBindFlags "exec_cmd" key command { repeating = true; })))
      )
      # Move and resize window with mouse
      (mkBindFlags "window.drag" "SUPER + mouse:272" null { mouse = true; })
      (mkBindFlags "window.resize" "SUPER + mouse:273" null { mouse = true; })

      # Screenshot
      (mkBind "exec_cmd" "SUPER + SHIFT + S" "grimblast copy area")
      (mkBind "exec_cmd" "Print" "grimblast copy area")

      # Fullscreen toggle
      (mkBind "window.fullscreen" "SUPER + F" {
        mode = "fullscreen";
        action = "toggle";
      })
      (mkBind "window.fullscreen" "SUPER + D" {
        mode = "maximized";
        action = "toggle";
      })
      (mkBind "window.fullscreen_state" "SUPER + ALT + F" {
        internal = 0;
        client = 3;
        action = "toggle";
      })
      (mkBind "window.float" "SUPER + ALT + SPACE" {
        action = "toggle";
      })

      # Scratchpad toggle
      (mkBind "workspace.toggle_special" "SUPER + S" "scratchpad")
      (mkBind "window.move" "SUPER + ALT + S" {
        workspace = "special:scratchpad";
        follow = false;
      })
    ];
  };
}
