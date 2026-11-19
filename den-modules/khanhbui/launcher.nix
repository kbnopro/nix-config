{ lib, ... }: {
  users.khanhbui.home.gui = hmArgs: {
    wayland.windowManager.hyprland.settings = {
      bind = [
        {
          _args = [
            "SUPER + SPACE"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd('pkill fuzzel || fuzzel')")
          ];
        }
      ];
    };
    programs.fuzzel = {
      enable = true;
      settings.colors = with hmArgs.config.colors; {
        background = "${surfaceContainerHigh}E6"; # E6 for 90% opacity
        text = "${onSurface}ff";
        placeholder = "${term3}ff";
        prompt = "${onSurface}ff";
        input = "${onSurface}ff";
        match = "${term10}ff";
        selection = "${primary}ff";
        selection-text = "${onPrimary}ff";
        selection-match = "${onPrimary}ff";
        counter = "${term6}ff";
        border = "${primary}ff";
      };
    };
  };
}
