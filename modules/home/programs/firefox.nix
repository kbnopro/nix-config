{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.firefox;
in
{
  # TODO: addons, color from stylix, etc
  config = lib.mkIf cfg.enable {
    programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

    xdg.mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + E"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('firefox')")
          ];
        }
      ];
    };
  };
}
