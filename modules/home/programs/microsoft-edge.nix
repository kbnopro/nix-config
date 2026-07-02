{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.programs.edge;

  colors = config.background.colors;

  edgeFlags = [
    "--ozone-platform-hint=x11"
    "--ozone-platform=x11"
    "--gtk-version=4"
    "--enable-features=TouchPadOverscrollHistoryNavigation,UseOzonePlatform"
    "--enable-wayland-ime"
    "--disable-features=WaylandWpColorManager"
  ];

  edge = pkgs.microsoft-edge.override {
    commandLineArgs = builtins.concatStringsSep " " edgeFlags;
  };

  # Browser need a bit more opacity as we use it quite often, and it looks too transparent with the same opacity as other windows.
  opacity = 1 - (1 - colors.opacity) / 2;

in
{
  options.programs.edge = {
    enable = mkEnableOption "Microsoft Edge";
  };

  config = mkIf cfg.enable {
    home.packages = [
      edge
    ];
    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + E"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('microsoft-edge')")
          ];
        }
      ];
    };
    wayland.windowManager.hyprland.settings.window_rule = [
      {
        match = {
          class = "microsoft-edge";
        };
        opacity = toString opacity;
      }
      # Edge randomly spawn a client with basically no info, so this is to avoid layout shifiting
      # We can remove this when the issue is fixed, or remove the browser :skull:
      # "float on, match:initial_title ^$" fixed by overlay
    ];
  };
}
