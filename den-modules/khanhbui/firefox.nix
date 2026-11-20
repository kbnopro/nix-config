{ lib, ... }: {
  users.khanhbui.home.gui = hmArgs: {
    programs.firefox = {
      enable = true;
      configPath = "${hmArgs.config.xdg.configHome}/mozilla/firefox";
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
