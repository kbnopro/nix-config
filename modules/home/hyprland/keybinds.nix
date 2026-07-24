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
        |> (map ({ key, direction }: (mkBind key "focus" { inherit direction; })))
      )
      # Move window
      (
        directions
        |> (map (addModifier "SUPER + SHIFT"))
        |> (map ({ key, direction }: (mkBind key "window.move" { inherit direction; })))
      )
      # Close window
      (mkBind "SUPER + Q" "window.close" { })

      # Workspace focus
      (
        workspaces
        |> (map (addModifier "SUPER"))
        |> (map ({ key, workspace }: (mkBind key "focus" { inherit workspace; })))
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
        |> (map (
          { key, direction }:
          {
            _args = [
              key
              (lib.generators.mkLuaInline ''
                function()
                  local ws = hl.get_active_workspace()
                  if ws ~= nil and ws.name:sub(1,#"permanent") ~= "permanent" then
                    hl.dispatch(hl.dsp.focus({ workspace = "${direction}" }))
                  end
                end
              '')
            ];
          }
        ))
      )
      # Move window to workspace
      (
        workspaces
        |> (map (addModifier "SUPER + ALT"))
        |> (map (
          { key, workspace }:
          (mkBind key "window.move" {
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
        |> (map ({ key, command }: (mkBindFlags key "exec_cmd" command { repeating = true; })))
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
        |> (map ({ key, command }: (mkBindFlags key "exec_cmd" command { locked = true; })))
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
        |> (map ({ key, command }: (mkBindFlags key "exec_cmd" command { repeating = true; })))
      )
      # Move and resize window with mouse
      (mkBindFlags "SUPER + mouse:272" "window.drag" null { mouse = true; })
      (mkBindFlags "SUPER + mouse:273" "window.resize" null { mouse = true; })

      # Screenshot
      (mkBind "SUPER + SHIFT + S" "exec_cmd" "grimblast copy area")
      (mkBind "Print" "exec_cmd" "grimblast copy area")

      # Fullscreen toggle
      (mkBind "SUPER + F" "window.fullscreen" {
        mode = "fullscreen";
        action = "toggle";
      })
      (mkBind "SUPER + D" "window.fullscreen" {
        mode = "maximized";
        action = "toggle";
      })
      (mkBind "SUPER + ALT + F" "window.fullscreen_state" {
        internal = 0;
        client = 3;
        action = "toggle";
      })
      (mkBind "SUPER + ALT + SPACE" "window.float" {
        action = "toggle";
      })

      # Scratchpad toggle
      (mkBind "SUPER + S" "workspace.toggle_special" "scratchpad")
      (mkBind "SUPER + ALT + S" "window.move" {
        workspace = "special:scratchpad";
        follow = false;
      })
    ];
  };
}
